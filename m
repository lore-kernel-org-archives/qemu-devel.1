Received: from eggs.gnu.org ([2001:4830:134:3::10]:55346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAb1X-0005ow-V1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gAb1T-0007jv-Vl
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gAb1T-0007jj-Nu
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:29:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181010120841.13214-1-fli@suse.com>
	<20181010120841.13214-6-fli@suse.com>
Date: Thu, 11 Oct 2018 15:28:53 +0200
In-Reply-To: <20181010120841.13214-6-fli@suse.com> (Fei Li's message of "Wed,
	10 Oct 2018 20:08:39 +0800")
Message-ID: <874lds4noq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v5 5/7] migration: fix the multifd code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, famz@redhat.com

Fei Li <fli@suse.com> writes:

> When multifd is used during migration, if there is an error before
> the destination receives all new channels, the destination does not
> exit but keeps waiting in our current code. However, a segmentaion

segmentation

> fault will occur in the source when multifd_save_cleanup() is called
> again as the multifd_send_state has been freed earlier in the first
> error handling.  This can happen when migrate_fd_connect() fails and
> multifd_fd_cleanup() is called, and then multifd_new_send_channel_
> async() fails and multifd_save_cleanup() is called again.
>
> If the QIOChannel *c of multifd_recv_state->params[i] (p->c) is not
> initialized, there is no need to close the channel. Or else a
> segmentation fault will occur in multifd_recv_terminate_threads()
> when multifd_recv_initial_packet() fails.
>
> Signed-off-by: Fei Li <fli@suse.com>
> ---
>  migration/ram.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index bc38d98cc3..41dc94c059 100644
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
> @@ -1131,7 +1136,7 @@ struct {
>      uint64_t packet_num;
>  } *multifd_recv_state;
>  
> -static void multifd_recv_terminate_threads(Error *err)
> +static void multifd_recv_terminate_threads(Error *err, bool channel)
>  {
>      int i;
>  
> @@ -1145,6 +1150,11 @@ static void multifd_recv_terminate_threads(Error *err)
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

The function does one thing always, another thing only when its
argument @channel is true, and ...

> @@ -1166,7 +1176,7 @@ int multifd_load_cleanup(Error **errp)
>      if (!migrate_use_multifd()) {
>          return 0;
>      }
> -    multifd_recv_terminate_threads(NULL);
> +    multifd_recv_terminate_threads(NULL, true);
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
> @@ -1269,7 +1279,7 @@ static void *multifd_recv_thread(void *opaque)
>      }
>  
>      if (local_err) {
> -        multifd_recv_terminate_threads(local_err);
> +        multifd_recv_terminate_threads(local_err, true);
>      }
>      qemu_mutex_lock(&p->mutex);
>      p->running = false;
> @@ -1331,7 +1341,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>  
>      id = multifd_recv_initial_packet(ioc, &local_err);
>      if (id < 0) {
> -        multifd_recv_terminate_threads(local_err);
> +        multifd_recv_terminate_threads(local_err, false);
>          return false;
>      }
>  
> @@ -1339,7 +1349,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc)
>      if (p->c != NULL) {
>          error_setg(&local_err, "multifd: received id '%d' already setup'",
>                     id);
> -        multifd_recv_terminate_threads(local_err);
> +        multifd_recv_terminate_threads(local_err, true);
>          return false;
>      }
>      p->c = ioc;

... all callers pass literal true or false.  Should we split the
function into its two parts, and call the second half only in the places
where its needed?  Matter of taste, I guess.  The maintainers may have
an opinion.
