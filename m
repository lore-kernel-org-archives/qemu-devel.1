Received: from eggs.gnu.org ([2001:4830:134:3::10]:39127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d9Eij-0004Tv-Jc
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d9Eif-0006ld-NW
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:51:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d9Eif-0006hU-F2
	for qemu-devel@nongnu.org; Fri, 12 May 2017 13:51:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9974B81255
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 17:51:11 +0000 (UTC)
Date: Fri, 12 May 2017 18:51:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170512175105.GI2069@work-vm>
References: <20170512160055.9081-1-quintela@redhat.com>
	<20170512160055.9081-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170512160055.9081-6-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/12] migration: Move colo.h to migration/
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
> There are functions only used by migration code.

That's only mostly true; see the current 'integrate colo frame with
block replication and net compare' series (posted 22nd April).
That adds colo_handle_shutdown to this header and calls it from vl.c
( https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03901.html )
where should that go?

There's also a net/colo.h as well, so using the
  #include "colo.h" in migration is correct but that's
really scary when there are two files of the same name.

Dave

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  MAINTAINERS                             | 2 +-
>  migration/colo-comm.c                   | 2 +-
>  migration/colo-failover.c               | 2 +-
>  {include/migration => migration}/colo.h | 0
>  migration/migration.c                   | 2 +-
>  migration/ram.c                         | 2 +-
>  6 files changed, 5 insertions(+), 5 deletions(-)
>  rename {include/migration => migration}/colo.h (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e8d731..e834876 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1537,7 +1537,7 @@ COLO Framework
>  M: zhanghailiang <zhang.zhanghailiang@huawei.com>
>  S: Maintained
>  F: migration/colo*
> -F: include/migration/colo.h
> +F: migration/colo.h
>  F: include/migration/failover.h
>  F: docs/COLO-FT.txt
>  
> diff --git a/migration/colo-comm.c b/migration/colo-comm.c
> index 3d91798..9b35027 100644
> --- a/migration/colo-comm.c
> +++ b/migration/colo-comm.c
> @@ -13,7 +13,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "migration/migration.h"
> -#include "migration/colo.h"
> +#include "colo.h"
>  #include "trace.h"
>  
>  typedef struct {
> diff --git a/migration/colo-failover.c b/migration/colo-failover.c
> index cc229f5..29b8d63 100644
> --- a/migration/colo-failover.c
> +++ b/migration/colo-failover.c
> @@ -11,7 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "migration/colo.h"
> +#include "colo.h"
>  #include "migration/failover.h"
>  #include "qmp-commands.h"
>  #include "qapi/qmp/qerror.h"
> diff --git a/include/migration/colo.h b/migration/colo.h
> similarity index 100%
> rename from include/migration/colo.h
> rename to migration/colo.h
> diff --git a/migration/migration.c b/migration/migration.c
> index ad5ed14..a5a17fe 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -38,7 +38,7 @@
>  #include "exec/address-spaces.h"
>  #include "io/channel-buffer.h"
>  #include "io/channel-tls.h"
> -#include "migration/colo.h"
> +#include "colo.h"
>  
>  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 2564c00..7a5f5fa 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -44,7 +44,7 @@
>  #include "trace.h"
>  #include "exec/ram_addr.h"
>  #include "qemu/rcu_queue.h"
> -#include "migration/colo.h"
> +#include "colo.h"
>  
>  /***********************************************************/
>  /* ram save/restore */
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
