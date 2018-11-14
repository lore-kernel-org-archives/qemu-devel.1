Received: from eggs.gnu.org ([2001:4830:134:3::10]:52036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMx14-000274-96
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMx0x-0002Hu-OD
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:23:41 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55304)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMx0o-00024k-CW
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:23:29 -0500
Received: by mail-wm1-x342.google.com with SMTP id i73-v6so10569137wmd.5
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 07:23:25 -0800 (PST)
References: <20181114071611.5352-1-peterx@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181114071611.5352-1-peterx@redhat.com>
Date: Wed, 14 Nov 2018 15:23:23 +0000
Message-ID: <87wopfd6ok.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] replication: Make --disable-replication
 compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Yanan Fu <yfu@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com, Markus Armbruster <armbru@redhat.com>


Peter Xu <peterx@redhat.com> writes:

> We've fixed it before like 38bb54f323 ("replication: Make
> --disable-replication compile again", 2017-04-28) but it's failing
> again.  So fix it again.

If replication builds by default and you want to defend it not building
then it would probably be worth adding it to the disabled configs in
.travis.yml:

 - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-attr --disable-=
brlapi --disable-uuid --disable-libusb --disable-user"

>
> There could be even cleaner way to fix this but current way is the
> simplest.  Let's start from simple.
>
> CC: zhanghailiang <zhang.zhanghailiang@huawei.com>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Yanan Fu <yfu@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> Reported-by: Yanan Fu <yfu@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/colo.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index 956ac236b7..78b64ef0cb 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -33,8 +33,10 @@
>  #include "sysemu/cpus.h"
>  #include "net/filter.h"
>
> +#ifdef CONFIG_REPLICATION
>  static bool vmstate_loading;
>  static Notifier packets_compare_notifier;
> +#endif
>
>  #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
>
> @@ -59,6 +61,7 @@ static bool colo_runstate_is_stopped(void)
>
>  static void secondary_vm_do_failover(void)
>  {
> +#ifdef CONFIG_REPLICATION
>      int old_state;
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      Error *local_err =3D NULL;
> @@ -121,10 +124,14 @@ static void secondary_vm_do_failover(void)
>      if (mis->migration_incoming_co) {
>          qemu_coroutine_enter(mis->migration_incoming_co);
>      }
> +#else
> +    abort();
> +#endif
>  }
>
>  static void primary_vm_do_failover(void)
>  {
> +#ifdef CONFIG_REPLICATION
>      MigrationState *s =3D migrate_get_current();
>      int old_state;
>      Error *local_err =3D NULL;
> @@ -165,6 +172,9 @@ static void primary_vm_do_failover(void)
>
>      /* Notify COLO thread that failover work is finished */
>      qemu_sem_post(&s->colo_exit_sem);
> +#else
> +    abort();
> +#endif
>  }
>
>  COLOMode get_colo_mode(void)
> @@ -271,6 +281,8 @@ COLOStatus *qmp_query_colo_status(Error **errp)
>      return s;
>  }
>
> +#ifdef CONFIG_REPLICATION
> +
>  static void colo_send_message(QEMUFile *f, COLOMessage msg,
>                                Error **errp)
>  {
> @@ -489,9 +501,11 @@ static void colo_compare_notify_checkpoint(Notifier =
*notifier, void *data)
>  {
>      colo_checkpoint_notify(data);
>  }
> +#endif
>
>  static void colo_process_checkpoint(MigrationState *s)
>  {
> +#ifdef CONFIG_REPLICATION
>      QIOChannelBuffer *bioc;
>      QEMUFile *fb =3D NULL;
>      int64_t current_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
> @@ -603,6 +617,9 @@ out:
>      if (s->rp_state.from_dst_file) {
>          qemu_fclose(s->rp_state.from_dst_file);
>      }
> +#else
> +    abort();
> +#endif
>  }
>
>  void colo_checkpoint_notify(void *opaque)
> @@ -631,6 +648,7 @@ void migrate_start_colo_process(MigrationState *s)
>      qemu_mutex_lock_iothread();
>  }
>
> +#ifdef CONFIG_REPLICATION
>  static void colo_wait_handle_message(QEMUFile *f, int *checkpoint_reques=
t,
>                                       Error **errp)
>  {
> @@ -653,9 +671,11 @@ static void colo_wait_handle_message(QEMUFile *f, in=
t *checkpoint_request,
>          break;
>      }
>  }
> +#endif
>
>  void *colo_process_incoming_thread(void *opaque)
>  {
> +#ifdef CONFIG_REPLICATION
>      MigrationIncomingState *mis =3D opaque;
>      QEMUFile *fb =3D NULL;
>      QIOChannelBuffer *bioc =3D NULL; /* Cache incoming device state */
> @@ -859,4 +879,7 @@ out:
>
>      rcu_unregister_thread();
>      return NULL;
> +#else
> +    abort();
> +#endif
>  }


--
Alex Benn=C3=A9e
