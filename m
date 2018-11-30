Received: from eggs.gnu.org ([2001:4830:134:3::10]:41741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gSfQr-00007o-1k
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gSfQn-0002fO-S7
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:49:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gSfQn-0002f6-Ly
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:49:53 -0500
Date: Fri, 30 Nov 2018 09:49:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181130094949.GB2603@work-vm>
References: <20181129100340.13823-1-fli@suse.com>
	<20181129100340.13823-6-fli@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129100340.13823-6-fli@suse.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 5/5] migration: add more error
 handling for postcopy_ram_enable_notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org

* Fei Li (fli@suse.com) wrote:
> Call postcopy_ram_incoming_cleanup() to do the cleanup when
> postcopy_ram_enable_notify fails. Besides, report the error
> message when qemu_ram_foreach_migratable_block() fails.
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Fei Li <fli@suse.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/postcopy-ram.c | 1 +
>  migration/savevm.c       | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index e5c02a32c5..fa09dba534 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1117,6 +1117,7 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
>  
>      /* Mark so that we get notified of accesses to unwritten areas */
>      if (qemu_ram_foreach_migratable_block(ram_block_enable_notify, mis)) {
> +        error_report("ram_block_enable_notify failed");
>          return -1;
>      }
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 9e45fb4f3f..d784e8aa40 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1729,6 +1729,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>       */
>      if (migrate_postcopy_ram()) {
>          if (postcopy_ram_enable_notify(mis)) {
> +            postcopy_ram_incoming_cleanup(mis);
>              return -1;
>          }
>      }
> -- 
> 2.13.7
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
