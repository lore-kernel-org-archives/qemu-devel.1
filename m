Received: from eggs.gnu.org ([2001:4830:134:3::10]:50609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT5KC-0002xe-Ua
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fT5K8-0005i9-Us
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:32 -0400
Date: Wed, 13 Jun 2018 14:56:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180613145624.3004935c@redhat.com>
In-Reply-To: <20180611121655.19616-7-david@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/11] pc-dimm: don't allow to access
 "size" before the device was realized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Mon, 11 Jun 2018 14:16:50 +0200
David Hildenbrand <david@redhat.com> wrote:

> "size" should not be queried before the device was realized. Let' make
> that explicit.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
It's generic property getter, it should work even before realize is called.

if issues described in 5/11 are properly fixed, this patch won't be needed.

So drop this patch


> ---
>  hw/mem/pc-dimm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 86fbcf2d0c..5294734529 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -166,6 +166,12 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
>      PCDIMMDevice *dimm = PC_DIMM(obj);
>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(obj);
>  
> +    if (!DEVICE(obj)->realized) {
> +        error_setg(errp, "Property \"%s\" not accessible before realized",
> +                   name);
> +        return;
> +    }
> +
>      mr = ddc->get_memory_region(dimm, errp);
>      if (!mr) {
>          return;
