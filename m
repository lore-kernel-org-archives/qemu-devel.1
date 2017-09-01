Received: from eggs.gnu.org ([2001:4830:134:3::10]:34637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnmyR-0003OY-J4
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnmyN-00036k-Li
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:31:07 -0400
Date: Fri, 1 Sep 2017 11:30:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170901143016.GK7570@localhost.localdomain>
References: <20170901110332.32650-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901110332.32650-1-otubo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, mst@redhat.com, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

i82374 is compiled in only on ppc and sh4, so I'm CCing the
maintainers for those architectures.

On Fri, Sep 01, 2017 at 01:03:32PM +0200, Eduardo Otubo wrote:
> When used with the following command line:
> 
>  ./ppc64-softmmu/qemu-system-ppc64 -S -machine 40p,accel=tcg -device i82374
> 
> QEMU with machine type 40p already creates the device i82374. If
> specified in the command line, it will try to create it again, hence
> generating the error.

Which error?


>                       One way to avoid this problem is to set
> user_creatable=false.
> 
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>

The patch does more than just avoiding double creation: it
prevents usage of "-device i82374" completely.

Maybe nobody needs it to work with -device today (would the
device even work?) and it is OK to set user_creatable=false until
we fix the crash.  But we need to be sure of that.

> ---
>  hw/dma/i82374.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/dma/i82374.c b/hw/dma/i82374.c
> index 6c0f975df0..5275d822e0 100644
> --- a/hw/dma/i82374.c
> +++ b/hw/dma/i82374.c
> @@ -139,6 +139,7 @@ static void i82374_class_init(ObjectClass *klass, void *data)
>      dc->realize = i82374_realize;
>      dc->vmsd = &vmstate_i82374;
>      dc->props = i82374_properties;
> +    dc->user_creatable = false;

A "Reason:" comment explaining why user_creatable=false is
mandatory.  See the comment above user_creatable declaration in
qdev-core.h for reference.

I suggest the following:

    /*
     * Reason: i82374_realize() crashes (assertion failure inside isa_bus_dma()
     *         if the device is instantiated twice.
     */

-- 
Eduardo
