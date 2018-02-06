Received: from eggs.gnu.org ([2001:4830:134:3::10]:34296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej1Ps-0003zL-HF
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej1Pp-0001Kq-BR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:28:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej1Pp-0001KS-1x
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:27:57 -0500
Date: Tue, 6 Feb 2018 11:27:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180206112752.GD2462@work-vm>
References: <151791621042.19120.3103118434734245776.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151791621042.19120.3103118434734245776.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v3] migration: incoming postcopy advise
 sanity checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

* Greg Kurz (groug@kaod.org) wrote:
> If postcopy-ram was set on the source but not on the destination,
> migration doesn't occur, the destination prints an error and boots
> the guest:
> 
> qemu-system-ppc64: Expected vmdescription section, but got 0
> 
> We end up with two running instances.
> 
> This behaviour was introduced in 2.11 by commit 58110f0acb1a "migration:
> split common postcopy out of ram postcopy" to prepare ground for the
> upcoming dirty bitmap postcopy support. It adds a new case where the
> source may send an empty postcopy advise because dirty bitmap doesn't
> need to check page sizes like RAM postcopy does.
> 
> If the source has enabled postcopy-ram, then it sends an advise with
> the page size values. If the destination hasn't enabled postcopy-ram,
> then loadvm_postcopy_handle_advise() leaves the page size values on
> the stream and returns. This confuses qemu_loadvm_state() later on
> and causes the destination to start execution.
> 
> As discussed several times, postcopy-ram should be enabled both sides
> to be functional. This patch changes the destination to perform some
> extra checks on the advise length to ensure this is the case. Otherwise
> an error is returned and migration is aborted.
> 
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

and queued to replace v2.

Dave

> ---
> v3: - s/warn_report/error_report
> 
> v2: - error out if postcopy-ram is enabled but the source hasn't sent the
>       expected 16 byte advise
>     - more descriptive message if postcopy-ram is disabled but the source
>       has sent a 16 byte advise
> ---
>  migration/savevm.c |   21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b7908f62be3c..c74b18dcf317 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1376,7 +1376,8 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>   * *might* happen - it might be skipped if precopy transferred everything
>   * quickly.
>   */
> -static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
> +static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> +                                         uint16_t len)
>  {
>      PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
>      uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
> @@ -1387,8 +1388,22 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
>          return -1;
>      }
>  
> -    if (!migrate_postcopy_ram()) {
> +    switch (len) {
> +    case 0:
> +        if (migrate_postcopy_ram()) {
> +            error_report("RAM postcopy is enabled but have 0 byte advise");
> +            return -EINVAL;
> +        }
>          return 0;
> +    case 8 + 8:
> +        if (!migrate_postcopy_ram()) {
> +            error_report("RAM postcopy is disabled but have 16 byte advise");
> +            return -EINVAL;
> +        }
> +        break;
> +    default:
> +        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
> +        return -EINVAL;
>      }
>  
>      if (!postcopy_ram_supported_by_host(mis)) {
> @@ -1807,7 +1822,7 @@ static int loadvm_process_command(QEMUFile *f)
>          return loadvm_handle_cmd_packaged(mis);
>  
>      case MIG_CMD_POSTCOPY_ADVISE:
> -        return loadvm_postcopy_handle_advise(mis);
> +        return loadvm_postcopy_handle_advise(mis, len);
>  
>      case MIG_CMD_POSTCOPY_LISTEN:
>          return loadvm_postcopy_handle_listen(mis);
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
