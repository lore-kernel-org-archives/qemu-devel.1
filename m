Received: from eggs.gnu.org ([2001:4830:134:3::10]:56785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPQq9-0005qF-Ev
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gPQq5-0005rJ-GG
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:38:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gPQq5-0005qb-AS
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:38:37 -0500
Date: Wed, 21 Nov 2018 11:38:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181121113832.GB6103@work-vm>
References: <20181114190912.7242-1-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114190912.7242-1-chen.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH] migration/migration.c: Add COLO dependency
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> Current COLO mode(independent disk mode) need replication module work
> together. Suggested by Dr. David Alan Gilbert <dgilbert@redhat.com>.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>

Queued

> ---
>  migration/migration.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b261c1e4ce..49ffb9997a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -918,6 +918,15 @@ static bool migrate_caps_check(bool *cap_list,
>      }
>  #endif
>  
> +#ifndef CONFIG_REPLICATION
> +    if (cap_list[MIGRATION_CAPABILITY_X_COLO]) {
> +        error_setg(errp, "QEMU compiled without replication module"
> +                   " can't enable COLO");
> +        error_append_hint(errp, "Please enable replication before COLO.\n");
> +        return false;
> +    }
> +#endif
> +
>      if (cap_list[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
>          if (cap_list[MIGRATION_CAPABILITY_COMPRESS]) {
>              /* The decompression threads asynchronously write into RAM
> -- 
> 2.17.GIT
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
