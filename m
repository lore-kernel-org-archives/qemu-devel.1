Received: from eggs.gnu.org ([2001:4830:134:3::10]:51823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djlWK-0005ou-1l
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1djlWG-0005AP-Mb
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:09:28 -0400
Date: Mon, 21 Aug 2017 14:09:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170821140919.585cdcc0.cohuck@redhat.com>
In-Reply-To: <20170821103524.22619-1-david@gibson.dropbear.id.au>
References: <20170821103524.22619-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Fix segfault when
 instantiating a 'pc-dimm' without 'memdev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, berrange@redhat.com, thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 21 Aug 2017 20:35:24 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> From: Thomas Huth <thuth@redhat.com>
> 
> QEMU currently crashes when trying to use a 'pc-dimm' on the pseries
> machine without specifying its 'memdev' property. This happens because
> pc_dimm_get_memory_region() does not check whether the 'memdev' property
> has properly been set by the user. Looking closer at this function, it's
> also obvious that it is using &error_abort to call another function - and
> this is bad in a function that is used in the hot-plugging calling chain
> since this can also cause QEMU to exit unexpectedly.
> 
> So let's fix these issues in a proper way now: Add a "Error **errp"
> parameter to pc_dimm_get_memory_region() which we use in case the 'memdev'
> property has not been set by the user, and which we can use instead of
> the &error_abort, and change the callers of get_memory_region() to make
> use of this "errp" parameter for proper error checking.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/i386/pc.c             | 14 ++++++++++++--
>  hw/mem/nvdimm.c          |  2 +-
>  hw/mem/pc-dimm.c         | 14 +++++++++++---
>  hw/ppc/spapr.c           | 42 ++++++++++++++++++++++++++++++------------
>  include/hw/mem/pc-dimm.h |  2 +-
>  5 files changed, 55 insertions(+), 19 deletions(-)

> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index ea67b461c2..bdf6649083 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -363,7 +363,10 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
>      PCDIMMDevice *dimm = PC_DIMM(obj);
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(obj);
>  
> -    mr = ddc->get_memory_region(dimm);
> +    mr = ddc->get_memory_region(dimm, errp);
> +    if (!mr) {
> +        return;

What happens if mr == NULL, but no error was set (backend memory not
inited case)?

> +    }
>      value = memory_region_size(mr);
>  
>      visit_type_uint64(v, name, &value, errp);
