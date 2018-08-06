Received: from eggs.gnu.org ([2001:4830:134:3::10]:57304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fmbTj-00064C-Up
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 05:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fmbTh-0001vC-QH
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 05:07:03 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:52485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fmbTh-0001v5-KZ
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 05:07:01 -0400
Received: by mail-it0-x244.google.com with SMTP id d9-v6so16438491itf.2
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 02:07:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1533287630-4221-4-git-send-email-lidongchen@tencent.com>
References: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
	<1533287630-4221-4-git-send-email-lidongchen@tencent.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 6 Aug 2018 17:07:00 +0800
Message-ID: <CAOGPPbc5rT_3HS-HcJEYLjr-cbLFQpZHtfZsgy9_C6XcCa1WhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 03/12] migration: avoid concurrent
 invoke channel_close by different threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, Juan Quintela <quintela@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

This patch causes compile error when make check.

  LINK    tests/test-qdist
migration/qemu-file.o: In function `qemu_fclose':
/tmp/qemu-test/src/migration/qemu-file.c:331: undefined reference to
`migrate_get_current'
/tmp/qemu-test/src/migration/qemu-file.c:333: undefined reference to
`migrate_get_current'
collect2: error: ld returned 1 exit status
make: *** [tests/test-vmstate] Error 1

but I don't find an efficient way to fix it.
so I prefer to remove this patch from this series.
maybe it's not the best way to protect by
migrate_get_current()->qemu_file_close_lock.


On Fri, Aug 3, 2018 at 5:13 PM, Lidong Chen <jemmy858585@gmail.com> wrote:
> From: Lidong Chen <jemmy858585@gmail.com>
>
> The channel_close maybe invoked by different threads. For example, source
> qemu invokes qemu_fclose in main thread, migration thread and return path
> thread. Destination qemu invokes qemu_fclose in main thread, listen threa=
d
> and COLO incoming thread.
>
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  migration/migration.c | 2 ++
>  migration/migration.h | 7 +++++++
>  migration/qemu-file.c | 6 ++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index b7d9854..a3a0756 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3200,6 +3200,7 @@ static void migration_instance_finalize(Object *obj=
)
>      qemu_sem_destroy(&ms->postcopy_pause_sem);
>      qemu_sem_destroy(&ms->postcopy_pause_rp_sem);
>      qemu_sem_destroy(&ms->rp_state.rp_sem);
> +    qemu_mutex_destroy(&ms->qemu_file_close_lock);
>      error_free(ms->error);
>  }
>
> @@ -3236,6 +3237,7 @@ static void migration_instance_init(Object *obj)
>      qemu_sem_init(&ms->rp_state.rp_sem, 0);
>      qemu_sem_init(&ms->rate_limit_sem, 0);
>      qemu_mutex_init(&ms->qemu_file_lock);
> +    qemu_mutex_init(&ms->qemu_file_close_lock);
>  }
>
>  /*
> diff --git a/migration/migration.h b/migration/migration.h
> index 64a7b33..a50c2de 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -122,6 +122,13 @@ struct MigrationState
>      QemuMutex qemu_file_lock;
>
>      /*
> +     * The to_src_file and from_dst_file point to one QIOChannelRDMA,
> +     * And qemu_fclose maybe invoked by different threads. use this lock
> +     * to avoid concurrent invoke channel_close by different threads.
> +     */
> +    QemuMutex qemu_file_close_lock;
> +
> +    /*
>       * Used to allow urgent requests to override rate limiting.
>       */
>      QemuSemaphore rate_limit_sem;
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 977b9ae..74c48e0 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -323,12 +323,14 @@ void qemu_update_position(QEMUFile *f, size_t size)
>   */
>  int qemu_fclose(QEMUFile *f)
>  {
> -    int ret;
> +    int ret, ret2;
>      qemu_fflush(f);
>      ret =3D qemu_file_get_error(f);
>
>      if (f->ops->close) {
> -        int ret2 =3D f->ops->close(f->opaque);
> +        qemu_mutex_lock(&migrate_get_current()->qemu_file_close_lock);
> +        ret2 =3D f->ops->close(f->opaque);
> +        qemu_mutex_unlock(&migrate_get_current()->qemu_file_close_lock);
>          if (ret >=3D 0) {
>              ret =3D ret2;
>          }
> --
> 1.8.3.1
>
