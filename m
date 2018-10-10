Received: from eggs.gnu.org ([2001:4830:134:3::10]:42838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAJkK-0007Hd-Bj
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAJkG-000196-PY
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 15:02:12 -0400
Date: Wed, 10 Oct 2018 20:01:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181010190153.GC2411@work-vm>
References: <20181008160536.6332-1-i.maximets@samsung.com>
	<CGME20181008160325eucas1p23bd6b6ce112175d274db884fb2a83f54@eucas1p2.samsung.com>
	<20181008160536.6332-2-i.maximets@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008160536.6332-2-i.maximets@samsung.com>
Subject: Re: [Qemu-devel] [RFC 1/2] migration: Stop postcopy fault thread
 before notifying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, qemu-stable@nongnu.org

* Ilya Maximets (i.maximets@samsung.com) wrote:
> POSTCOPY_NOTIFY_INBOUND_END handlers will remove userfault fds
> from the postcopy_remote_fds array which could be still in
> use by the fault thread. Let's stop the thread before
> notification to avoid possible accessing wrong memory.

OK I think; since this is already in the cleanup we shouldn't
be getting faults anyway at that point.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Fixes: 46343570c06e ("vhost+postcopy: Wire up POSTCOPY_END notify")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> ---
>  migration/postcopy-ram.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 853d8b32ca..e5c02a32c5 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -533,6 +533,12 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>      if (mis->have_fault_thread) {
>          Error *local_err = NULL;
>  
> +        /* Let the fault thread quit */
> +        atomic_set(&mis->fault_thread_quit, 1);
> +        postcopy_fault_thread_notify(mis);
> +        trace_postcopy_ram_incoming_cleanup_join();
> +        qemu_thread_join(&mis->fault_thread);
> +
>          if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_END, &local_err)) {
>              error_report_err(local_err);
>              return -1;
> @@ -541,11 +547,6 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
>          if (qemu_ram_foreach_migratable_block(cleanup_range, mis)) {
>              return -1;
>          }
> -        /* Let the fault thread quit */
> -        atomic_set(&mis->fault_thread_quit, 1);
> -        postcopy_fault_thread_notify(mis);
> -        trace_postcopy_ram_incoming_cleanup_join();
> -        qemu_thread_join(&mis->fault_thread);
>  
>          trace_postcopy_ram_incoming_cleanup_closeuf();
>          close(mis->userfault_fd);
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
