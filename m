Received: from eggs.gnu.org ([2001:4830:134:3::10]:52810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSQNb-0001gt-Ql
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSQNY-00024Q-Hh
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:13:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSQNY-000241-DL
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF5B84023131
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 17:13:15 +0000 (UTC)
Date: Mon, 11 Jun 2018 18:13:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180611171311.GK2661@work-vm>
References: <20180523111817.1463-1-quintela@redhat.com>
	<20180523111817.1463-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523111817.1463-6-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 05/12] migration: Multifd channels
 always wait on the sem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Either for quit, sync or packet, we first wake them.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Again, I'd prefer if this was merged in with later stuff that
changes it heavily; but I realise it's difficult to split, and those
do clean it up, so:


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index ab715cc148..90f62144e2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -868,6 +868,7 @@ static void *multifd_send_thread(void *opaque)
>      p->num_packets = 1;
>  
>      while (true) {
> +        qemu_sem_wait(&p->sem);
>          qemu_mutex_lock(&p->mutex);
>          multifd_send_fill_packet(p);
>          if (p->quit) {
> @@ -875,7 +876,9 @@ static void *multifd_send_thread(void *opaque)
>              break;
>          }
>          qemu_mutex_unlock(&p->mutex);
> -        qemu_sem_wait(&p->sem);
> +        /* this is impossible */
> +        error_setg(&local_err, "multifd_send_thread: Unknown command");
> +        break;
>      }
>  
>  out:
> @@ -1019,6 +1022,7 @@ static void *multifd_recv_thread(void *opaque)
>      trace_multifd_recv_thread_start(p->id);
>  
>      while (true) {
> +        qemu_sem_wait(&p->sem);
>          qemu_mutex_lock(&p->mutex);
>          if (false)  {
>              /* ToDo: Packet reception goes here */
> @@ -1033,9 +1037,14 @@ static void *multifd_recv_thread(void *opaque)
>              break;
>          }
>          qemu_mutex_unlock(&p->mutex);
> -        qemu_sem_wait(&p->sem);
> +        /* this is impossible */
> +        error_setg(&local_err, "multifd_recv_thread: Unknown command");
> +        break;
>      }
>  
> +    if (local_err) {
> +        multifd_recv_terminate_threads(local_err);
> +    }
>      qemu_mutex_lock(&p->mutex);
>      p->running = false;
>      qemu_mutex_unlock(&p->mutex);
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
