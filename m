Received: from eggs.gnu.org ([2001:4830:134:3::10]:34130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSNly-0008LU-Qm
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gSNe1-0005t9-7Z
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:50:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gSNdz-0005bd-3D
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:50:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so2531835wmc.5
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 06:50:11 -0800 (PST)
References: <20181129100340.13823-1-fli@suse.com>
	<20181129100340.13823-5-fli@suse.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <35413c93-dd69-83bd-e144-444a7e94c001@redhat.com>
Date: Thu, 29 Nov 2018 15:50:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181129100340.13823-5-fli@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/5] migration: remove unused
 &local_err parameter in multifd_save_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>, qemu-devel@nongnu.org

On 29/11/18 11:03, Fei Li wrote:
> Always call migrate_set_error() to set the error state without relying
> on whether multifd_save_cleanup() succeeds.  As the passed &local_err
> is never used in multifd_save_cleanup(), remove it. And make the
> function be: void multifd_save_cleanup(void).

Reading this after your patch 1/5, maybe multifd_save_cleanup() lacks
error reporting on failure. So the actual prototype is correct, we just
need to use **errp in that function (like reporting invalid thread
instead of calling qemu_thread_join()).

> 
> Signed-off-by: Fei Li <fli@suse.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c |  5 +----
>  migration/ram.c       | 11 ++++-------
>  migration/ram.h       |  2 +-
>  3 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 72106bddf0..0537fc0c26 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1386,7 +1386,6 @@ static void migrate_fd_cleanup(void *opaque)
>      qemu_savevm_state_cleanup();
>  
>      if (s->to_dst_file) {
> -        Error *local_err = NULL;
>          QEMUFile *tmp;
>  
>          trace_migrate_fd_cleanup();
> @@ -1397,9 +1396,7 @@ static void migrate_fd_cleanup(void *opaque)
>          }
>          qemu_mutex_lock_iothread();
>  
> -        if (multifd_save_cleanup(&local_err) != 0) {
> -            error_report_err(local_err);
> -        }
> +        multifd_save_cleanup();
>          qemu_mutex_lock(&s->qemu_file_lock);
>          tmp = s->to_dst_file;
>          s->to_dst_file = NULL;
> diff --git a/migration/ram.c b/migration/ram.c
> index e13b9349d0..c44cb6f56d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -917,13 +917,12 @@ static void multifd_send_terminate_threads(Error *err)
>      }
>  }
>  
> -int multifd_save_cleanup(Error **errp)
> +void multifd_save_cleanup(void)
>  {
>      int i;
> -    int ret = 0;
>  
>      if (!migrate_use_multifd()) {
> -        return 0;
> +        return;
>      }
>      multifd_send_terminate_threads(NULL);
>      for (i = 0; i < migrate_multifd_channels(); i++) {
> @@ -953,7 +952,6 @@ int multifd_save_cleanup(Error **errp)
>      multifd_send_state->pages = NULL;
>      g_free(multifd_send_state);
>      multifd_send_state = NULL;
> -    return ret;
>  }
>  
>  static void multifd_send_sync_main(void)
> @@ -1071,9 +1069,8 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>      Error *local_err = NULL;
>  
>      if (qio_task_propagate_error(task, &local_err)) {
> -        if (multifd_save_cleanup(&local_err) != 0) {
> -            migrate_set_error(migrate_get_current(), local_err);
> -        }
> +        migrate_set_error(migrate_get_current(), local_err);
> +        multifd_save_cleanup();
>      } else {
>          p->c = QIO_CHANNEL(sioc);
>          qio_channel_set_delay(p->c, false);
> diff --git a/migration/ram.h b/migration/ram.h
> index 046d3074be..936177b3e9 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -43,7 +43,7 @@ uint64_t ram_bytes_remaining(void);
>  uint64_t ram_bytes_total(void);
>  
>  int multifd_save_setup(void);
> -int multifd_save_cleanup(Error **errp);
> +void multifd_save_cleanup(void);
>  int multifd_load_setup(void);
>  int multifd_load_cleanup(Error **errp);
>  bool multifd_recv_all_channels_created(void);
> 
