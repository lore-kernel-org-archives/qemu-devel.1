Received: from eggs.gnu.org ([2001:4830:134:3::10]:40924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cy4Kg-0008EE-Nt
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cy4Kc-0005X1-Ni
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:32:18 -0400
Received: from mail.kernel.org ([198.145.29.136]:48872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cy4Kc-0005Wu-E6
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:32:14 -0400
Date: Tue, 11 Apr 2017 15:32:09 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CADZi59yC4m+wFS+iJUrV9Y59X96cQVMnrCNLvcd5o2kdjmqQdA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1704111509350.2759@sstabellini-ThinkPad-X260>
References: <CADZi59zNxk-Yr4rpN1E49s=AdsdW-W9YfhpCvpJeBz7oigyFSg@mail.gmail.com>
	<CADZi59xe6OcCasvtkPBjP7nTsgDA5r_E_Rt7W88BszYdJhuxGQ@mail.gmail.com>
	<CADZi59xEg0SvScgo=Jg0MxTbGYY=nTX18Qo-4GMkfayThDU9zw@mail.gmail.com>
	<alpine.DEB.2.10.1704101159340.2759@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1704101243270.2759@sstabellini-ThinkPad-X260>
	<CADZi59yC4m+wFS+iJUrV9Y59X96cQVMnrCNLvcd5o2kdjmqQdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC/BUG] xen-mapcache: buggy invalidate map cache?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hrg <hrgstephen@gmail.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xensource.com, qemu-devel@nongnu.org, Jun Nakajima <jun.nakajima@intel.com>, Alexander Graf <agraf@suse.de>, xen-devel@lists.xenproject.org, xen-devel@lists.xen.org, "Herongguang (Stephen)" <herongguang.he@huawei.com>, wangxinxin.wang@huawei.com

On Tue, 11 Apr 2017, hrg wrote:
> On Tue, Apr 11, 2017 at 3:50 AM, Stefano Stabellini
> <sstabellini@kernel.org> wrote:
> > On Mon, 10 Apr 2017, Stefano Stabellini wrote:
> >> On Mon, 10 Apr 2017, hrg wrote:
> >> > On Sun, Apr 9, 2017 at 11:55 PM, hrg <hrgstephen@gmail.com> wrote:
> >> > > On Sun, Apr 9, 2017 at 11:52 PM, hrg <hrgstephen@gmail.com> wrot=
e:
> >> > >> Hi,
> >> > >>
> >> > >> In xen_map_cache_unlocked(), map to guest memory maybe in entry=
->next
> >> > >> instead of first level entry (if map to rom other than guest me=
mory
> >> > >> comes first), while in xen_invalidate_map_cache(), when VM ball=
ooned
> >> > >> out memory, qemu did not invalidate cache entries in linked
> >> > >> list(entry->next), so when VM balloon back in memory, gfns prob=
ably
> >> > >> mapped to different mfns, thus if guest asks device to DMA to t=
hese
> >> > >> GPA, qemu may DMA to stale MFNs.
> >> > >>
> >> > >> So I think in xen_invalidate_map_cache() linked lists should al=
so be
> >> > >> checked and invalidated.
> >> > >>
> >> > >> What=E2=80=99s your opinion? Is this a bug? Is my analyze corre=
ct?
> >>
> >> Yes, you are right. We need to go through the list for each element =
of
> >> the array in xen_invalidate_map_cache. Can you come up with a patch?
> >
> > I spoke too soon. In the regular case there should be no locked mappi=
ngs
> > when xen_invalidate_map_cache is called (see the DPRINTF warning at t=
he
> > beginning of the functions). Without locked mappings, there should ne=
ver
> > be more than one element in each list (see xen_map_cache_unlocked:
> > entry->lock =3D=3D true is a necessary condition to append a new entr=
y to
> > the list, otherwise it is just remapped).
> >
> > Can you confirm that what you are seeing are locked mappings
> > when xen_invalidate_map_cache is called? To find out, enable the DPRI=
NTK
> > by turning it into a printf or by defininig MAPCACHE_DEBUG.
>=20
> In fact, I think the DPRINTF above is incorrect too. In
> pci_add_option_rom(), rtl8139 rom is locked mapped in
> pci_add_option_rom->memory_region_get_ram_ptr (after
> memory_region_init_ram). So actually I think we should remove the
> DPRINTF warning as it is normal.

Let me explain why the DPRINTF warning is there: emulated dma operations
can involve locked mappings. Once a dma operation completes, the related
mapping is unlocked and can be safely destroyed. But if we destroy a
locked mapping in xen_invalidate_map_cache, while a dma is still
ongoing, QEMU will crash. We cannot handle that case.

However, the scenario you described is different. It has nothing to do
with DMA. It looks like pci_add_option_rom calls
memory_region_get_ram_ptr to map the rtl8139 rom. The mapping is a
locked mapping and it is never unlocked or destroyed.

It looks like "ptr" is not used after pci_add_option_rom returns. Does
the append patch fix the problem you are seeing? For the proper fix, I
think we probably need some sort of memory_region_unmap wrapper or maybe
a call to address_space_unmap.


diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e6b08e1..04f98b7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2242,6 +2242,7 @@ static void pci_add_option_rom(PCIDevice *pdev, boo=
l is_default_rom,
     }
=20
     pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
+    xen_invalidate_map_cache_entry(ptr);
 }
=20
 static void pci_del_option_rom(PCIDevice *pdev)
