Received: from eggs.gnu.org ([2001:4830:134:3::10]:42942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0Y3C-0006qt-FM
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:40:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0Y39-0006DQ-Ct
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:40:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d0Y39-0006DB-60
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 14:40:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E282BC054900
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 18:40:25 +0000 (UTC)
Date: Tue, 18 Apr 2017 19:40:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170418184022.GO2205@work-vm>
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417200041.2451-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/19] migration: They are called
 vmstate_foo, move them to vmstate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/savevm.c  | 17 -----------------
>  migration/vmstate.c | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 17 deletions(-)

OK, but it's a little odd, savevm.c still has the vmstate_register_with_alias_id
and vmstate-unregister,  so this is just the simple ram cases.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> diff --git a/migration/savevm.c b/migration/savevm.c
> index cc9c086..c47b209 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -45,7 +45,6 @@
>  #include "qemu/sockets.h"
>  #include "qemu/queue.h"
>  #include "sysemu/cpus.h"
> -#include "exec/memory.h"
>  #include "qmp-commands.h"
>  #include "trace.h"
>  #include "qemu/bitops.h"
> @@ -2465,19 +2464,3 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
>      g_free(global_snapshots);
>  
>  }
> -
> -void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
> -{
> -    qemu_ram_set_idstr(mr->ram_block,
> -                       memory_region_name(mr), dev);
> -}
> -
> -void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
> -{
> -    qemu_ram_unset_idstr(mr->ram_block);
> -}
> -
> -void vmstate_register_ram_global(MemoryRegion *mr)
> -{
> -    vmstate_register_ram(mr, NULL);
> -}
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 8a71349..174c490 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -1,5 +1,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "exec/memory.h"
>  #include "migration/migration.h"
>  #include "migration/qemu-file.h"
>  #include "migration/vmstate.h"
> @@ -1127,3 +1128,18 @@ bool vmstate_device_is_migratable(const VMStateDescription *vmsd)
>      return true;
>  }
>  
> +void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
> +{
> +    qemu_ram_set_idstr(mr->ram_block,
> +                       memory_region_name(mr), dev);
> +}
> +
> +void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
> +{
> +    qemu_ram_unset_idstr(mr->ram_block);
> +}
> +
> +void vmstate_register_ram_global(MemoryRegion *mr)
> +{
> +    vmstate_register_ram(mr, NULL);
> +}
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
