Received: from eggs.gnu.org ([2001:4830:134:3::10]:52555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcFPY-0004z5-FW
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcFPU-0008Oc-GU
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:27:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcFPU-0008O2-AO
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:27:20 -0400
Date: Mon, 31 Jul 2017 19:27:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170731182713.GH2122@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-7-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-7-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 06/29] migration: dump str in
 migrate_set_state trace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> Strings are more readable for debugging.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c  | 3 ++-
>  migration/trace-events | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 6803187..bdc4445 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -914,8 +914,9 @@ void qmp_migrate_start_postcopy(Error **errp)
>  
>  void migrate_set_state(int *state, int old_state, int new_state)
>  {
> +    assert(new_state < MIGRATION_STATUS__MAX);
>      if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
> -        trace_migrate_set_state(new_state);
> +        trace_migrate_set_state(MigrationStatus_lookup[new_state]);
>          migrate_generate_event(new_state);
>      }
>  }
> diff --git a/migration/trace-events b/migration/trace-events
> index cb2c4b5..08d00fa 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -80,7 +80,7 @@ ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %
>  # migration/migration.c
>  await_return_path_close_on_source_close(void) ""
>  await_return_path_close_on_source_joining(void) ""
> -migrate_set_state(int new_state) "new state %d"
> +migrate_set_state(const char *new_state) "new state %s"
>  migrate_fd_cleanup(void) ""
>  migrate_fd_error(const char *error_desc) "error=%s"
>  migrate_fd_cancel(void) ""
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
