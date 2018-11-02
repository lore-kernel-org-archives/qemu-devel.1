Received: from eggs.gnu.org ([2001:4830:134:3::10]:34624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gIPSB-0007SN-Pk
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gIPFo-0006M5-RS
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:32:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gIPFo-0006Lb-JB
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 22:32:08 -0400
Date: Fri, 2 Nov 2018 10:31:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181102023158.GC7804@xz-x1>
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-5-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181101101715.9443-5-fli@suse.com>
Subject: Re: [Qemu-devel] [PATCH RFC v7 4/9] migration: fix some
 segmentation faults when using multifd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, dgilbert@redhat.com, famz@redhat.com, quintela@redhat.com

On Thu, Nov 01, 2018 at 06:17:10PM +0800, Fei Li wrote:
> When multifd is used during migration, a segmentaion fault will
> occur in the source when multifd_save_cleanup() is called again if
> the multifd_send_state has been freed in earlier error handling. This
> can happen when migrate_fd_connect() fails and multifd_fd_cleanup()
> is called, and then multifd_new_send_channel_async() fails and
> multifd_save_cleanup() is called again.
> 
> If the QIOChannel *c of multifd_recv_state->params[i] (p->c) is not
> initialized, there is no need to close the channel. Or else a
> segmentation fault will occur in multifd_recv_terminate_threads()
> when multifd_recv_initial_packet() fails.

It's a bit odd to me when I see that multifd_send_thread() calls
multifd_send_terminate_threads().  Is that the reason that you
encountered the problem?

Instead of checking all these null pointers, IMHO we should just let
multifd_send_terminate_threads() be called only in the main thread...

> 
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  migration/ram.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 7e7deec4d8..4db3b3e8f4 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -907,6 +907,11 @@ static void multifd_send_terminate_threads(Error *err)
>          }
>      }
>  
> +    /* in case multifd_send_state has been freed earlier */
> +    if (!multifd_send_state) {
> +        return;
> +    }
> +
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> @@ -922,7 +927,7 @@ int multifd_save_cleanup(Error **errp)
>      int i;
>      int ret = 0;
>  
> -    if (!migrate_use_multifd()) {
> +    if (!migrate_use_multifd() || !multifd_send_state) {
>          return 0;
>      }
>      multifd_send_terminate_threads(NULL);
> @@ -960,7 +965,7 @@ static void multifd_send_sync_main(void)
>  {
>      int i;
>  
> -    if (!migrate_use_multifd()) {
> +    if (!migrate_use_multifd() || !multifd_send_state) {
>          return;
>      }
>      if (multifd_send_state->pages->used) {
> @@ -1070,6 +1075,10 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>      QIOChannel *sioc = QIO_CHANNEL(qio_task_get_source(task));
>      Error *local_err = NULL;
>  
> +    if (!multifd_send_state) {
> +        return;
> +    }
> +
>      if (qio_task_propagate_error(task, &local_err)) {
>          if (multifd_save_cleanup(&local_err) != 0) {
>              migrate_set_error(migrate_get_current(), local_err);
> @@ -1131,7 +1140,7 @@ struct {
>      uint64_t packet_num;
>  } *multifd_recv_state;
>  
> -static void multifd_recv_terminate_threads(Error *err)
> +static void multifd_recv_terminate_threads(Error *err, bool channel)
>  {
>      int i;
>  
> @@ -1145,6 +1154,11 @@ static void multifd_recv_terminate_threads(Error *err)
>          }
>      }
>  
> +    /* in case p->c is not initialized */
> +    if (!channel) {
> +        return;
> +    }
> +
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
> @@ -1166,7 +1180,7 @@ int multifd_load_cleanup(Error **errp)
>      if (!migrate_use_multifd()) {
>          return 0;
>      }
> -    multifd_recv_terminate_threads(NULL);
> +    multifd_recv_terminate_threads(NULL, true);
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
> @@ -1269,7 +1283,7 @@ static void *multifd_recv_thread(void *opaque)
>      }
>  
>      if (local_err) {
> -        multifd_recv_terminate_threads(local_err);
> +        multifd_recv_terminate_threads(local_err, true);
>      }
>      qemu_mutex_lock(&p->mutex);
>      p->running = false;
> @@ -1331,7 +1345,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>  
>      id = multifd_recv_initial_packet(ioc, &local_err);
>      if (id < 0) {
> -        multifd_recv_terminate_threads(local_err);
> +        multifd_recv_terminate_threads(local_err, false);
>          return false;
>      }
>  
> @@ -1339,7 +1353,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>      if (p->c != NULL) {
>          error_setg(&local_err, "multifd: received id '%d' already setup'",
>                     id);
> -        multifd_recv_terminate_threads(local_err);
> +        multifd_recv_terminate_threads(local_err, true);
>          return false;
>      }
>      p->c = ioc;
> -- 
> 2.13.7
> 

Regards,

-- 
Peter Xu
