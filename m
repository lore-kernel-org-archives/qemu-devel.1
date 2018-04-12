Received: from eggs.gnu.org ([2001:4830:134:3::10]:39014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1f6a3q-0005iI-44
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:06:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1f6a3l-00043D-6X
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:06:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:63492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1f6a3k-0003oj-Rf
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:06:33 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Thu, 12 Apr 2018 11:06:20 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BCD441@SHSMSX104.ccr.corp.intel.com>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-6-git-send-email-yi.l.liu@linux.intel.com>
	<20180306103352.GB3158@sky-dev> <20180412023602.GF9425@umbus.fritz.box>
In-Reply-To: <20180412023602.GF9425@umbus.fritz.box>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 05/12] hw/pci: introduce PCISVAOps to
 PCIDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>

Hi David,

> From: David Gibson [mailto:david@gibson.dropbear.id.au]
> Sent: Thursday, April 12, 2018 10:36 AM
> On Tue, Mar 06, 2018 at 06:33:52PM +0800, Liu, Yi L wrote:
> > On Mon, Mar 05, 2018 at 02:31:44PM +1100, David Gibson wrote:
> > > On Thu, Mar 01, 2018 at 06:31:55PM +0800, Liu, Yi L wrote:
> > > > This patch intoduces PCISVAOps for virt-SVA.
> > > >
> > > > So far, to setup virt-SVA for assigned SVA capable device, needs to
> > > > config host translation structures. e.g. for VT-d, needs to set the
> > > > guest pasid table to host and enable nested translation. Besides,
> > > > vIOMMU emulator needs to forward guest's cache invalidation to host=
.
> > > > On VT-d, it is guest's invalidation to 1st level translation relate=
d
> > > > cache, such invalidation should be forwarded to host.
> > > >
> > > > Proposed PCISVAOps are:
> > > > * sva_bind_guest_pasid_table: set the guest pasid table to host, an=
d
> > > >                               enable nested translation in host
> > > > * sva_register_notifier: register sva_notifier to forward guest's
> > > >                          cache invalidation to host
> > > > * sva_unregister_notifier: unregister sva_notifier
> > > >
> > > > The PCISVAOps should be provided by vfio or modules alike. Mainly f=
or
> > > > assigned SVA capable devices.
> > > >
> > > > Take virt-SVA on VT-d as an exmaple:
> > > > If a guest wants to setup virt-SVA for an assigned SVA capable devi=
ce,
> > > > it programs its context entry. vIOMMU emulator captures guest's con=
text
> > > > entry programming, and figure out the target device. vIOMMU emulato=
r
> > > > use the pci_device_sva_bind_pasid_table() API to bind the guest pas=
id
> > > > table to host.
> > > >
> > > > Guest would also program its pasid table. vIOMMU emulator captures
> > > > guest's pasid entry programming. In Qemu, needs to allocate an
> > > > AddressSpace to stand for the pasid tagged address space and Qemu a=
lso
> > > > needs to register sva_notifier to forward future cache invalidation
> > > > request to host.
> > > >
> > > > Allocating AddressSpace to stand for the pasid tagged address space=
 is
> > > > for the emulation of emulated SVA capable devices. Emulated SVA cap=
able
> > > > devices may issue SVA aware DMAs, Qemu needs to emulate read/write =
to a
> > > > pasid tagged AddressSpace. Thus needs an abstraction for such addre=
ss
> > > > space in Qemu.
> > > >
> > > > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > >
> > > So PCISVAOps is roughly equivalent to the cluster-of-PASIDs context I
> > > was suggesting in my earlier comments,
> >
> > yes, it is. The purpose is to expose pasid table bind and sva notfier
> > registration/unregistration to vIOMMU emulators.
> >
> > > however it's only an ops
> > > structure.  That means you can't easily share a context between
> > > multiple PCI devices which is unfortunate because:
> > >     * The simplest use case for SVA I can see would just put the
> > >       same set of PASIDs into place for every SVA capable device
> >
> > Do you mean for emulated SVA capable device?
>=20
> Not necessarily.  I'd expect that model could be useful for both
> emulated and passthrough SVA capable devices.
>=20
> > >     * Sometimes the IOMMU can't determine exactly what device a DMA
> > >       came from.  Now the bridge cases where this applies are probabl=
y
> > >       unlikely with SVA devices, but I wouldn't want to bet on it.  I=
n
> > >       addition, the chances some manufacturer will eventually put out
> > >       a buggy multifunction SVA capable device that use the wrong RID=
s
> > >       for the secondary functions is pretty darn high.
> >
> > I'm not sure I 100% got your point here. Do yu mean physical device?
> > In PCIE TLP, DMA packet should have a RID field?
>=20
> Yes, but that RID isn't accurate in all cases.
>=20
> One case is if you have a PCIe device behind both a PCIe->PCI and
> PCI->PCIe bridge.  Now obviously SVA won't work in that case, but it
> would be good to at least detect it and refuse to attempt SVA.
>=20
> Another case is with a buggy device that just sends the wrong RID.  In
> particular there are some multifunction devices that use function 0's
> RID for all functions.  Obviously that's a hardware bug and we can't
> expect everything to work in this case.  But forcing all the functions
> to share an SVAContext in this case - like we alreayd force them to
> share an IOMMU group - allows us to reason about what will and won't work

Agree.

>=20
> > And it looks more like
> > a hardware layer trouble. For this series, it only provides necessary
> > software support to make sure guest's SVA operation is well prepared
> > before the SVA device issues the SVA aware DMA. e.g. link guest's pasid
> > table to host, and config iommu translation in nested mode.

yes, it is.

> >
> > >
> > > So I think instead you want a cluster-of-PASIDs object which has an
> > > ops table including both these and the per-PASID calls from the
> > > earlier patches (but the per-PASID calls would now take an explicit
> > > PASID value).
> >
> > I didn't quite get "including both these and the per-PASID calls".
> > What do you mean by "these"? Do you mean the PCISVAOps?
>=20
> I mean that I think PCISVAOps should become a full object including an
> ops table, not just an ops table.  That table would include the things
> currently in PCISVAOps.  It would also include callbacks for the
> things that are in your per-PASID object in this draft, but those
> callbacks would now need to take an explicit PASIC parameter.

Based on some comments from Peter Xu and your comments on the
" [PATCH v3 03/12] hw/core: introduce IOMMUSVAContext for virt-SVA"
I've considered a new approach which might be able to reuse the existing
translation logic based on MemoryRegion. I'm preparing some code to
show it. Before that, I'd like to see your opinion.

As we discussed, for assigned devices, we want to prepare the config before
the SVA device issues the SVA aware DMA. And this can be achieved by
PCISVAOps proposed as below:

struct PCISVAOps {
    void (*pasid_bind_table)(PCIBus *bus, int32_t devfn,
                    uint64_t pasidt_addr, uint32_t size);
    void (*pasid_invalidate_extend_iotlb)(PCIBus *bus,
                              int32_t devfn, void *data);
}
This is no more notifier based, for further extension, it could include mor=
e
callback in this ops. Previously, I thought notifier is better. However, Pe=
ter
corrected me in another thread.

While for emulated devices, we need to support address translation. So I
introduced IOMMUSVAContext and translate callback in this series. But it
duplicates much translation logic from MemoryRegion based logic. So I
reconsidered if it is ok to reuse MemoryRegion. And seems like possible.
Below is my thought. I took VT-d as example, you may check if works based
on your understanding.

1) add "pasid" and "pasid_allocated" field in the structure below. For each
PASID tagged address space, Qemu creates a VTDAddressSpace instance,
and set the pasid field. For PCI DMA address space, it won't init pasid and
pasid_allocated field.

struct VTDAddressSpace {
     PCIBus *bus;
     uint8_t devfn;
+    bool pasid_allocated;
+    uint32_t pasid;
     AddressSpace as;
     IOMMUMemoryRegion iommu;
     MemoryRegion root;
     ...
}

When emulated SVA capable devices issues SVA aware DMA, its device
model should be able to get a PASID, and then get correct AddressSpace.
The DMA emulation logic would finally call into imrc->translate() callback
which provided by IOMMU emulator. In the callback, it can get the
VTDAddressSpace and check if PASID is allocated. If yes, do translation wit=
h
corresponding 1st-level page table. If no, walk through the I/O page table(
2nd level-page table).

Another benefit of reusing MemoryRegion would be: if someone wants to
implement SVA with shadow solution, he or she could use the MAP/UNMAP
API to shadow SVA mapping to host iommu.

Thanks,
Yi Liu
