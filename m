Received: from eggs.gnu.org ([2001:4830:134:3::10]:59223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1cyBaj-0004Ur-9M
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 02:17:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1cyBag-0008AO-43
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 02:17:21 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:34476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1cyBaf-00089v-Oj
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 02:17:18 -0400
Received: by mail-lf0-x241.google.com with SMTP id x72so1901958lfb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 23:17:15 -0700 (PDT)
Date: Wed, 12 Apr 2017 16:17:04 +1000
From: Alexey G <x1917x@gmail.com>
Message-ID: <20170412161704.00003875@gmail.com>
In-Reply-To: <alpine.DEB.2.10.1704111509350.2759@sstabellini-ThinkPad-X260>
References: <CADZi59zNxk-Yr4rpN1E49s=AdsdW-W9YfhpCvpJeBz7oigyFSg@mail.gmail.com>
	<CADZi59xe6OcCasvtkPBjP7nTsgDA5r_E_Rt7W88BszYdJhuxGQ@mail.gmail.com>
	<CADZi59xEg0SvScgo=Jg0MxTbGYY=nTX18Qo-4GMkfayThDU9zw@mail.gmail.com>
	<alpine.DEB.2.10.1704101159340.2759@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1704101243270.2759@sstabellini-ThinkPad-X260>
	<CADZi59yC4m+wFS+iJUrV9Y59X96cQVMnrCNLvcd5o2kdjmqQdA@mail.gmail.com>
	<alpine.DEB.2.10.1704111509350.2759@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Xen-devel] [RFC/BUG] xen-mapcache: buggy
 invalidate map cache?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: hrg <hrgstephen@gmail.com>, wangxinxin.wang@huawei.com, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, xen-devel@lists.xensource.com, Jun Nakajima <jun.nakajima@intel.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, xen-devel@lists.xen.org, "Herongguang (Stephen)" <herongguang.he@huawei.com>

On Tue, 11 Apr 2017 15:32:09 -0700 (PDT)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Tue, 11 Apr 2017, hrg wrote:
> > On Tue, Apr 11, 2017 at 3:50 AM, Stefano Stabellini
> > <sstabellini@kernel.org> wrote: =20
> > > On Mon, 10 Apr 2017, Stefano Stabellini wrote: =20
> > >> On Mon, 10 Apr 2017, hrg wrote: =20
> > >> > On Sun, Apr 9, 2017 at 11:55 PM, hrg <hrgstephen@gmail.com> wrote:=
 =20
> > >> > > On Sun, Apr 9, 2017 at 11:52 PM, hrg <hrgstephen@gmail.com> wrot=
e: =20
> > >> > >> Hi,
> > >> > >>
> > >> > >> In xen_map_cache_unlocked(), map to guest memory maybe in
> > >> > >> entry->next instead of first level entry (if map to rom other t=
han
> > >> > >> guest memory comes first), while in xen_invalidate_map_cache(),
> > >> > >> when VM ballooned out memory, qemu did not invalidate cache ent=
ries
> > >> > >> in linked list(entry->next), so when VM balloon back in memory,
> > >> > >> gfns probably mapped to different mfns, thus if guest asks devi=
ce
> > >> > >> to DMA to these GPA, qemu may DMA to stale MFNs.
> > >> > >>
> > >> > >> So I think in xen_invalidate_map_cache() linked lists should al=
so be
> > >> > >> checked and invalidated.
> > >> > >>
> > >> > >> What=E2=80=99s your opinion? Is this a bug? Is my analyze corre=
ct? =20
> > >>
> > >> Yes, you are right. We need to go through the list for each element =
of
> > >> the array in xen_invalidate_map_cache. Can you come up with a patch?=
 =20
> > >
> > > I spoke too soon. In the regular case there should be no locked mappi=
ngs
> > > when xen_invalidate_map_cache is called (see the DPRINTF warning at t=
he
> > > beginning of the functions). Without locked mappings, there should ne=
ver
> > > be more than one element in each list (see xen_map_cache_unlocked:
> > > entry->lock =3D=3D true is a necessary condition to append a new entr=
y to
> > > the list, otherwise it is just remapped).
> > >
> > > Can you confirm that what you are seeing are locked mappings
> > > when xen_invalidate_map_cache is called? To find out, enable the DPRI=
NTK
> > > by turning it into a printf or by defininig MAPCACHE_DEBUG. =20
> >=20
> > In fact, I think the DPRINTF above is incorrect too. In
> > pci_add_option_rom(), rtl8139 rom is locked mapped in
> > pci_add_option_rom->memory_region_get_ram_ptr (after
> > memory_region_init_ram). So actually I think we should remove the
> > DPRINTF warning as it is normal. =20
>=20
> Let me explain why the DPRINTF warning is there: emulated dma operations
> can involve locked mappings. Once a dma operation completes, the related
> mapping is unlocked and can be safely destroyed. But if we destroy a
> locked mapping in xen_invalidate_map_cache, while a dma is still
> ongoing, QEMU will crash. We cannot handle that case.
>=20
> However, the scenario you described is different. It has nothing to do
> with DMA. It looks like pci_add_option_rom calls
> memory_region_get_ram_ptr to map the rtl8139 rom. The mapping is a
> locked mapping and it is never unlocked or destroyed.
>=20
> It looks like "ptr" is not used after pci_add_option_rom returns. Does
> the append patch fix the problem you are seeing? For the proper fix, I
> think we probably need some sort of memory_region_unmap wrapper or maybe
> a call to address_space_unmap.

Hmm, for some reason my message to the Xen-devel list got rejected but was =
sent
to Qemu-devel instead, without any notice. Sorry if I'm missing something
obvious as a list newbie.

Stefano, hrg,

There is an issue with inconsistency between the list of normal MapCacheEnt=
ry's
and their 'reverse' counterparts - MapCacheRev's in locked_entries.
When bad situation happens, there are multiple (locked) MapCacheEntry
entries in the bucket's linked list along with a number of MapCacheRev's. A=
nd
when it comes to a reverse lookup, xen-mapcache picks the wrong entry from =
the
first list and calculates a wrong pointer from it which may then be caught =
with
the "Bad RAM offset" check (or not). Mapcache invalidation might be related=
 to
this issue as well I think.

I'll try to provide a test code which can reproduce the issue from the
guest side using an emulated IDE controller, though it's much simpler to ac=
hieve
this result with an AHCI controller using multiple NCQ I/O commands. So far=
 I've
seen this issue only with Windows 7 (and above) guest on AHCI, but any bloc=
k I/O
DMA should be enough I think.
