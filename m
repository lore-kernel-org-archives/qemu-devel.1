Received: from eggs.gnu.org ([2001:4830:134:3::10]:44676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cDB-0006xA-VP
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cD7-0007GR-2k
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:33:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9cD6-0007Fr-Ck
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:33:01 -0400
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bcd7e170-8728-f691-f357-b0f8f6d811ed@redhat.com>
Date: Mon, 8 Oct 2018 15:32:56 -0500
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/31] Use error_fatal to simplify obvious
 fatal errors (again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>

On 10/8/18 12:30 PM, Markus Armbruster wrote:
> Add a slight improvement of the Coccinelle semantic patch from commit
> 07d04a0219b,

which shares the same commit title, but does not actually have a 
semantic patch, but rather defers to the even older 007b065.  But I'm 
not too worried about either the duplicated commit title nor the chain 
of references to follow - as this is a no-semantic-change patch rather 
than a bugfix, it's less likely to cause confusion to any downstream 
backport efforts.

> and use it to clean up.  It leaves dead Error * variables
> behind, cleaned up manually.

Coccinelle can handle that too, if we want to make the .cocci file 
longer (but off-hand, I don't remember the exact semantic patch formula 
to express a variable that is initialized but then never used, as a 
result of applying earlier semantic patches). So the manual cleanup for 
now still seems tractable.

> 
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/intc/xics_kvm.c                       |  7 +------
>   qemu-nbd.c                               |  6 +-----
>   scripts/coccinelle/use-error_fatal.cocci | 20 ++++++++++++++++++++
>   vl.c                                     |  7 +------
>   4 files changed, 23 insertions(+), 17 deletions(-)
>   create mode 100644 scripts/coccinelle/use-error_fatal.cocci
> 

> +++ b/scripts/coccinelle/use-error_fatal.cocci
> @@ -0,0 +1,20 @@
> +@@
> +type T;
> +identifier FUN, RET;
> +expression list ARGS;
> +expression ERR, EC, FAIL;

The slight improvement from the original git commit log script is the 
addition of FAIL,

> +@@
> +(
> +-    T RET = FUN(ARGS, &ERR);
> ++    T RET = FUN(ARGS, &error_fatal);
> +|
> +-    RET = FUN(ARGS, &ERR);
> ++    RET = FUN(ARGS, &error_fatal);
> +|
> +-    FUN(ARGS, &ERR);
> ++    FUN(ARGS, &error_fatal);
> +)
> +-    if (FAIL) {

and a check for arbitrary condition FAIL rather than a more specific ERR 
!= NULL.  Makes sense.

> +-        error_report_err(ERR);
> +-        exit(EC);
> +-    }

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
