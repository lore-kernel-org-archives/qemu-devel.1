Received: from eggs.gnu.org ([2001:4830:134:3::10]:36589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d4Ffk-0007Pk-8S
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 19:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d4Ffg-0007Kr-UD
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 19:51:36 -0400
Received: from mail.kernel.org ([198.145.29.136]:35268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d4Ffg-0007KX-KO
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 19:51:32 -0400
Date: Fri, 28 Apr 2017 16:51:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <58EF1102.2080802@huawei.com>
Message-ID: <alpine.DEB.2.10.1704281651200.2895@sstabellini-ThinkPad-X260>
References: <CADZi59zNxk-Yr4rpN1E49s=AdsdW-W9YfhpCvpJeBz7oigyFSg@mail.gmail.com>
	<CADZi59xe6OcCasvtkPBjP7nTsgDA5r_E_Rt7W88BszYdJhuxGQ@mail.gmail.com>
	<CADZi59xEg0SvScgo=Jg0MxTbGYY=nTX18Qo-4GMkfayThDU9zw@mail.gmail.com>
	<alpine.DEB.2.10.1704101159340.2759@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1704101243270.2759@sstabellini-ThinkPad-X260>
	<CADZi59yC4m+wFS+iJUrV9Y59X96cQVMnrCNLvcd5o2kdjmqQdA@mail.gmail.com>
	<alpine.DEB.2.10.1704111509350.2759@sstabellini-ThinkPad-X260>
	<58EDE1E4.2090003@huawei.com>
	<alpine.DEB.2.10.1704121645470.2759@sstabellini-ThinkPad-X260>
	<58EF1102.2080802@huawei.com>
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
To: "Herongguang (Stephen)" <herongguang.he@huawei.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, hrg <hrgstephen@gmail.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xensource.com, qemu-devel@nongnu.org, Jun Nakajima <jun.nakajima@intel.com>, Alexander Graf <agraf@suse.de>, xen-devel@lists.xenproject.org, xen-devel@lists.xen.org, wangxinxin.wang@huawei.com

On Thu, 13 Apr 2017, Herongguang (Stephen) wrote:
> On 2017/4/13 7:51, Stefano Stabellini wrote:
> > On Wed, 12 Apr 2017, Herongguang (Stephen) wrote:
> > > On 2017/4/12 6:32, Stefano Stabellini wrote:
> > > > On Tue, 11 Apr 2017, hrg wrote:
> > > > > On Tue, Apr 11, 2017 at 3:50 AM, Stefano Stabellini
> > > > > <sstabellini@kernel.org> wrote:
> > > > > > On Mon, 10 Apr 2017, Stefano Stabellini wrote:
> > > > > > > On Mon, 10 Apr 2017, hrg wrote:
> > > > > > > > On Sun, Apr 9, 2017 at 11:55 PM, hrg <hrgstephen@gmail.co=
m>
> > > > > > > > wrote:
> > > > > > > > > On Sun, Apr 9, 2017 at 11:52 PM, hrg <hrgstephen@gmail.=
com>
> > > > > > > > > wrote:
> > > > > > > > > > Hi,
> > > > > > > > > >=20
> > > > > > > > > > In xen_map_cache_unlocked(), map to guest memory mayb=
e in
> > > > > > > > > > entry->next
> > > > > > > > > > instead of first level entry (if map to rom other tha=
n guest
> > > > > > > > > > memory
> > > > > > > > > > comes first), while in xen_invalidate_map_cache(), wh=
en VM
> > > > > > > > > > ballooned
> > > > > > > > > > out memory, qemu did not invalidate cache entries in =
linked
> > > > > > > > > > list(entry->next), so when VM balloon back in memory,=
 gfns
> > > > > > > > > > probably
> > > > > > > > > > mapped to different mfns, thus if guest asks device t=
o DMA
> > > > > > > > > > to
> > > > > > > > > > these
> > > > > > > > > > GPA, qemu may DMA to stale MFNs.
> > > > > > > > > >=20
> > > > > > > > > > So I think in xen_invalidate_map_cache() linked lists=
 should
> > > > > > > > > > also be
> > > > > > > > > > checked and invalidated.
> > > > > > > > > >=20
> > > > > > > > > > What=E2=80=99s your opinion? Is this a bug? Is my ana=
lyze correct?
> > > > > > > Yes, you are right. We need to go through the list for each
> > > > > > > element of
> > > > > > > the array in xen_invalidate_map_cache. Can you come up with=
 a
> > > > > > > patch?
> > > > > > I spoke too soon. In the regular case there should be no lock=
ed
> > > > > > mappings
> > > > > > when xen_invalidate_map_cache is called (see the DPRINTF warn=
ing at
> > > > > > the
> > > > > > beginning of the functions). Without locked mappings, there s=
hould
> > > > > > never
> > > > > > be more than one element in each list (see xen_map_cache_unlo=
cked:
> > > > > > entry->lock =3D=3D true is a necessary condition to append a =
new entry
> > > > > > to
> > > > > > the list, otherwise it is just remapped).
> > > > > >=20
> > > > > > Can you confirm that what you are seeing are locked mappings
> > > > > > when xen_invalidate_map_cache is called? To find out, enable =
the
> > > > > > DPRINTK
> > > > > > by turning it into a printf or by defininig MAPCACHE_DEBUG.
> > > > > In fact, I think the DPRINTF above is incorrect too. In
> > > > > pci_add_option_rom(), rtl8139 rom is locked mapped in
> > > > > pci_add_option_rom->memory_region_get_ram_ptr (after
> > > > > memory_region_init_ram). So actually I think we should remove t=
he
> > > > > DPRINTF warning as it is normal.
> > > > Let me explain why the DPRINTF warning is there: emulated dma ope=
rations
> > > > can involve locked mappings. Once a dma operation completes, the =
related
> > > > mapping is unlocked and can be safely destroyed. But if we destro=
y a
> > > > locked mapping in xen_invalidate_map_cache, while a dma is still
> > > > ongoing, QEMU will crash. We cannot handle that case.
> > > >=20
> > > > However, the scenario you described is different. It has nothing =
to do
> > > > with DMA. It looks like pci_add_option_rom calls
> > > > memory_region_get_ram_ptr to map the rtl8139 rom. The mapping is =
a
> > > > locked mapping and it is never unlocked or destroyed.
> > > >=20
> > > > It looks like "ptr" is not used after pci_add_option_rom returns.=
 Does
> > > > the append patch fix the problem you are seeing? For the proper f=
ix, I
> > > > think we probably need some sort of memory_region_unmap wrapper o=
r maybe
> > > > a call to address_space_unmap.
> > >=20
> > > Yes, I think so, maybe this is the proper way to fix this.
> >=20
> > Would you be up for sending a proper patch and testing it? We cannot =
call
> > xen_invalidate_map_cache_entry directly from pci.c though, it would n=
eed
> > to be one of the other functions like address_space_unmap for example=
.
> >=20
>=20
>=20
> Yes, I will look into this.

Any updates?


> > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > index e6b08e1..04f98b7 100644
> > > > --- a/hw/pci/pci.c
> > > > +++ b/hw/pci/pci.c
> > > > @@ -2242,6 +2242,7 @@ static void pci_add_option_rom(PCIDevice *p=
dev,
> > > > bool
> > > > is_default_rom,
> > > >        }
> > > >          pci_register_bar(pdev, PCI_ROM_SLOT, 0, &pdev->rom);
> > > > +    xen_invalidate_map_cache_entry(ptr);
> > > >    }
> > > >      static void pci_del_option_rom(PCIDevice *pdev)
>=20
