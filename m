Received: from eggs.gnu.org ([2001:4830:134:3::10]:44659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTSEa-00031w-6u
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTSEW-0004G4-UR
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:24:16 -0400
Date: Thu, 14 Jun 2018 15:24:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180614152409.2886dc65@redhat.com>
In-Reply-To: <bb0b033f-d048-06db-96d1-89085000d792@redhat.com>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-7-david@redhat.com>
	<20180613145624.3004935c@redhat.com>
	<bb0b033f-d048-06db-96d1-89085000d792@redhat.com>
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, 13 Jun 2018 16:03:35 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 13.06.2018 14:56, Igor Mammedov wrote:
> > On Mon, 11 Jun 2018 14:16:50 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> "size" should not be queried before the device was realized. Let' make
> >> that explicit.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>  
> > It's generic property getter, it should work even before realize is called.  
> 
> That's the point, as we can see in NVDIMM code , it is *not* a generic
> property getter.
it is added by 
    object_property_add(obj, PC_DIMM_SIZE_PROP, "uint64", pc_dimm_get_size,      
                        NULL, NULL, NULL, &error_abort); 
hence it's generic QOM property as opposed to memory device class specific callbacks.

> 
> > 
> > if issues described in 5/11 are properly fixed, this patch won't be needed.
> > 
> > So drop this patch
> > 
> >   
> >> ---
> >>  hw/mem/pc-dimm.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> >> index 86fbcf2d0c..5294734529 100644
> >> --- a/hw/mem/pc-dimm.c
> >> +++ b/hw/mem/pc-dimm.c
> >> @@ -166,6 +166,12 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, const char *name,
> >>      PCDIMMDevice *dimm = PC_DIMM(obj);
> >>      PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(obj);
> >>  
> >> +    if (!DEVICE(obj)->realized) {
> >> +        error_setg(errp, "Property \"%s\" not accessible before realized",
> >> +                   name);
> >> +        return;
> >> +    }
> >> +
> >>      mr = ddc->get_memory_region(dimm, errp);
just make ddc->get_memory_region return error if 'memdev' isn't set yet
and add local_error handling here as proper property assessor should do.

> >>      if (!mr) {
> >>          return;  
> >   
> 
> 
