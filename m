Received: from eggs.gnu.org ([2001:4830:134:3::10]:36501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6JOD-00089x-I7
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 13:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f6JO8-0004F5-Rk
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 13:18:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f6JO8-0004ED-M1
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 13:18:28 -0400
Date: Wed, 11 Apr 2018 18:18:18 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180411171818.GJ2667@work-vm>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
	<1523089594-1422-3-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523089594-1422-3-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: add the interface to set
 get_return_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>, berrange@redhat.com
Cc: quintela@redhat.com, qemu-devel@nongnu.org, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> The default get_return_path function of iochannel does not work for
> RDMA live migration. So add the interface to set get_return_path.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

Lets see how Dan wants this done, he knows the channel/file stuff;
to me this feels like it should be adding a member to QIOChannelClass
that gets used by QEMUFile's get_return_path.

(Dan and see next patch)

Dave
> ---
>  migration/qemu-file-channel.c | 12 ++++++++----
>  migration/qemu-file.c         | 10 ++++++++--
>  migration/qemu-file.h         |  2 +-
>  3 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-channel.c
> index e202d73..d4dd8c4 100644
> --- a/migration/qemu-file-channel.c
> +++ b/migration/qemu-file-channel.c
> @@ -156,7 +156,6 @@ static const QEMUFileOps channel_input_ops = {
>      .close = channel_close,
>      .shut_down = channel_shutdown,
>      .set_blocking = channel_set_blocking,
> -    .get_return_path = channel_get_input_return_path,
>  };
>  
>  
> @@ -165,18 +164,23 @@ static const QEMUFileOps channel_output_ops = {
>      .close = channel_close,
>      .shut_down = channel_shutdown,
>      .set_blocking = channel_set_blocking,
> -    .get_return_path = channel_get_output_return_path,
>  };
>  
>  
>  QEMUFile *qemu_fopen_channel_input(QIOChannel *ioc)
>  {
> +    QEMUFile *f;
>      object_ref(OBJECT(ioc));
> -    return qemu_fopen_ops(ioc, &channel_input_ops);
> +    f = qemu_fopen_ops(ioc, &channel_input_ops);
> +    qemu_file_set_return_path(f, channel_get_input_return_path);
> +    return f;
>  }
>  
>  QEMUFile *qemu_fopen_channel_output(QIOChannel *ioc)
>  {
> +    QEMUFile *f;
>      object_ref(OBJECT(ioc));
> -    return qemu_fopen_ops(ioc, &channel_output_ops);
> +    f = qemu_fopen_ops(ioc, &channel_output_ops);
> +    qemu_file_set_return_path(f, channel_get_output_return_path);
> +    return f;
>  }
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index bb63c77..8acb574 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -36,6 +36,7 @@
>  struct QEMUFile {
>      const QEMUFileOps *ops;
>      const QEMUFileHooks *hooks;
> +    QEMURetPathFunc *get_return_path;
>      void *opaque;
>  
>      int64_t bytes_xfer;
> @@ -72,10 +73,15 @@ int qemu_file_shutdown(QEMUFile *f)
>   */
>  QEMUFile *qemu_file_get_return_path(QEMUFile *f)
>  {
> -    if (!f->ops->get_return_path) {
> +    if (!f->get_return_path) {
>          return NULL;
>      }
> -    return f->ops->get_return_path(f->opaque);
> +    return f->get_return_path(f->opaque);
> +}
> +
> +void qemu_file_set_return_path(QEMUFile *f, QEMURetPathFunc *get_return_path)
> +{
> +    f->get_return_path = get_return_path;
>  }
>  
>  bool qemu_file_mode_is_not_valid(const char *mode)
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index f4f356a..74210b7 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -102,7 +102,6 @@ typedef struct QEMUFileOps {
>      QEMUFileCloseFunc *close;
>      QEMUFileSetBlocking *set_blocking;
>      QEMUFileWritevBufferFunc *writev_buffer;
> -    QEMURetPathFunc *get_return_path;
>      QEMUFileShutdownFunc *shut_down;
>  } QEMUFileOps;
>  
> @@ -114,6 +113,7 @@ typedef struct QEMUFileHooks {
>  } QEMUFileHooks;
>  
>  QEMUFile *qemu_fopen_ops(void *opaque, const QEMUFileOps *ops);
> +void qemu_file_set_return_path(QEMUFile *f, QEMURetPathFunc *get_return_path);
>  void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks);
>  int qemu_get_fd(QEMUFile *f);
>  int qemu_fclose(QEMUFile *f);
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
