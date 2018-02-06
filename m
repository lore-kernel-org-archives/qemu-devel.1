Received: from eggs.gnu.org ([2001:4830:134:3::10]:58661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej1Cx-0000LU-4c
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ej1Cs-0006mk-Qa
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:14:39 -0500
Received: from mail-eopbgr20116.outbound.protection.outlook.com
	([40.107.2.116]:61251
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ej1Cs-0006m1-0g
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 06:14:34 -0500
References: <151791154436.32601.15403203498591276038.stgit@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3766eaba-b437-d152-e7aa-b7dd5dd4e7c6@virtuozzo.com>
Date: Tue, 6 Feb 2018 14:14:23 +0300
MIME-Version: 1.0
In-Reply-To: <151791154436.32601.15403203498591276038.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] migration: incoming postcopy advise
 sanity checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

06.02.2018 13:05, Greg Kurz wrote:
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
> ---
> v2: - error out if postcopy-ram is enabled but the source hasn't sent the
>        expected 16 byte advise
>      - more descriptive message if postcopy-ram is disabled but the source
>        has sent a 16 byte advise
> ---
>   migration/savevm.c |   21 ++++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index b7908f62be3c..e97671c1f7bd 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1376,7 +1376,8 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>    * *might* happen - it might be skipped if precopy transferred everything
>    * quickly.
>    */
> -static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
> +static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
> +                                         uint16_t len)
>   {
>       PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
>       uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
> @@ -1387,8 +1388,22 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
>           return -1;
>       }
>   
> -    if (!migrate_postcopy_ram()) {
> +    switch (len) {
> +    case 0:
> +        if (migrate_postcopy_ram()) {
> +            warn_report("RAM postcopy is enabled but have 0 byte advise");
> +            return -EINVAL;

I think, if we return -EINVAL, it should be error_report, not 
warn_report. However, I don't insist, so with or without s/warn/error/,

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

And thank you for investigating this, it's actually my fault.

> +        }
>           return 0;
> +    case 8 + 8:
> +        if (!migrate_postcopy_ram()) {
> +            error_report("RAM postcopy is disabled but have 16 byte advise");
> +            return -EINVAL;
> +        }
> +        break;
> +    default:
> +        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
> +        return -EINVAL;
>       }
>   
>       if (!postcopy_ram_supported_by_host(mis)) {
> @@ -1807,7 +1822,7 @@ static int loadvm_process_command(QEMUFile *f)
>           return loadvm_handle_cmd_packaged(mis);
>   
>       case MIG_CMD_POSTCOPY_ADVISE:
> -        return loadvm_postcopy_handle_advise(mis);
> +        return loadvm_postcopy_handle_advise(mis, len);
>   
>       case MIG_CMD_POSTCOPY_LISTEN:
>           return loadvm_postcopy_handle_listen(mis);
>


-- 
Best regards,
Vladimir
