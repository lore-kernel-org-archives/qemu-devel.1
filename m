Received: from eggs.gnu.org ([2001:4830:134:3::10]:56542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cljIu-0000eU-Lj
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:39:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cljIr-0001im-JI
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:39:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cljIr-0001iW-Dl
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:39:25 -0500
Date: Wed, 8 Mar 2017 18:32:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170308213224.GS4694@thinpad.lan.raisama.net>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
	<148900648332.27090.14562192041474683540.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148900648332.27090.14562192041474683540.stgit@brijesh-build-machine>
Subject: Re: [Qemu-devel] [RFC PATCH v4 20/20] migration: disable
 save/restore and migration when SEV is active
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net, Thomas.Lendacky@amd.com

On Wed, Mar 08, 2017 at 03:54:43PM -0500, Brijesh Singh wrote:
> Snapshot, Restore and Migration is not implemented yet. Return error when
> user tries to perform any of these operations.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  migration/migration.c |    7 +++++++
>  migration/savevm.c    |   11 +++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dab684..287c72b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -37,6 +37,7 @@
>  #include "io/channel-buffer.h"
>  #include "io/channel-tls.h"
>  #include "migration/colo.h"
> +#include "sysemu/sev.h"
>  
>  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
>  
> @@ -1221,6 +1222,12 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>          error_setg(errp, QERR_MIGRATION_ACTIVE);
>          return;
>      }
> +
> +    if (sev_enabled()) {
> +        error_setg(errp, "Migration is not implemented");
> +        return;
> +    }
> +

You can do this more easily by registering a migration blocker
using migrate_add_blocker() when initializing SEV.

-- 
Eduardo
