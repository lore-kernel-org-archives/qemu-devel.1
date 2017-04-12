Received: from eggs.gnu.org ([2001:4830:134:3::10]:42501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cyS32-0002I1-VH
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cyS2z-00047W-Ry
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:51:41 -0400
Received: from mail.kernel.org ([198.145.29.136]:48084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cyS2z-00047G-Jk
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 19:51:37 -0400
Date: Wed, 12 Apr 2017 16:51:30 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170412161704.00003875@gmail.com>
Message-ID: <alpine.DEB.2.10.1704121647180.2759@sstabellini-ThinkPad-X260>
References: <CADZi59zNxk-Yr4rpN1E49s=AdsdW-W9YfhpCvpJeBz7oigyFSg@mail.gmail.com>
	<CADZi59xe6OcCasvtkPBjP7nTsgDA5r_E_Rt7W88BszYdJhuxGQ@mail.gmail.com>
	<CADZi59xEg0SvScgo=Jg0MxTbGYY=nTX18Qo-4GMkfayThDU9zw@mail.gmail.com>
	<alpine.DEB.2.10.1704101159340.2759@sstabellini-ThinkPad-X260>
	<alpine.DEB.2.10.1704101243270.2759@sstabellini-ThinkPad-X260>
	<CADZi59yC4m+wFS+iJUrV9Y59X96cQVMnrCNLvcd5o2kdjmqQdA@mail.gmail.com>
	<alpine.DEB.2.10.1704111509350.2759@sstabellini-ThinkPad-X260>
	<20170412161704.00003875@gmail.com>
MIME-Version: 1.0
Content-ID: <alpine.DEB.2.10.1704121650450.2759@sstabellini-ThinkPad-X260>
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
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
To: Alexey G <x1917x@gmail.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, hrg <hrgstephen@gmail.com>, wangxinxin.wang@huawei.com, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, xen-devel@lists.xensource.com, Jun Nakajima <jun.nakajima@intel.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, xen-devel@lists.xen.org, "Herongguang (Stephen)" <herongguang.he@huawei.com>

On Wed, 12 Apr 2017, Alexey G wrote:
> On Tue, 11 Apr 2017 15:32:09 -0700 (PDT)
> Stefano Stabellini <sstabellini@kernel.org> wrote:
>=20
> > On Tue, 11 Apr 2017, hrg wrote:
> > > On Tue, Apr 11, 2017 at 3:50 AM, Stefano Stabellini
> > > <sstabellini@kernel.org> wrote: =20
> > > > On Mon, 10 Apr 2017, Stefano Stabellini wrote: =20
> > > >> On Mon, 10 Apr 2017, hrg wrote: =20
> > > >> > On Sun, Apr 9, 2017 at 11:55 PM, hrg <hrgstephen@gmail.com> wr=
ote: =20
> > > >> > > On Sun, Apr 9, 2017 at 11:52 PM, hrg <hrgstephen@gmail.com> =
wrote: =20
> > > >> > >> Hi,
> > > >> > >>
> > > >> > >> In xen_map_cache_unlocked(), map to guest memory maybe in
> > > >> > >> entry->next instead of first level entry (if map to rom oth=
er than
> > > >> > >> guest memory comes first), while in xen_invalidate_map_cach=
e(),
> > > >> > >> when VM ballooned out memory, qemu did not invalidate cache=
 entries
> > > >> > >> in linked list(entry->next), so when VM balloon back in mem=
ory,
> > > >> > >> gfns probably mapped to different mfns, thus if guest asks =
device
> > > >> > >> to DMA to these GPA, qemu may DMA to stale MFNs.
> > > >> > >>
> > > >> > >> So I think in xen_invalidate_map_cache() linked lists shoul=
d also be
> > > >> > >> checked and invalidated.
> > > >> > >>
> > > >> > >> What=E2=80=99s your opinion? Is this a bug? Is my analyze c=
orrect? =20
> > > >>
> > > >> Yes, you are right. We need to go through the list for each elem=
ent of
> > > >> the array in xen_invalidate_map_cache. Can you come up with a pa=
tch? =20
> > > >
> > > > I spoke too soon. In the regular case there should be no locked m=
appings
> > > > when xen_invalidate_map_cache is called (see the DPRINTF warning =
at the
> > > > beginning of the functions). Without locked mappings, there shoul=
d never
> > > > be more than one element in each list (see xen_map_cache_unlocked=
:
> > > > entry->lock =3D=3D true is a necessary condition to append a new =
entry to
> > > > the list, otherwise it is just remapped).
> > > >
> > > > Can you confirm that what you are seeing are locked mappings
> > > > when xen_invalidate_map_cache is called? To find out, enable the =
DPRINTK
> > > > by turning it into a printf or by defininig MAPCACHE_DEBUG. =20
> > >=20
> > > In fact, I think the DPRINTF above is incorrect too. In
> > > pci_add_option_rom(), rtl8139 rom is locked mapped in
> > > pci_add_option_rom->memory_region_get_ram_ptr (after
> > > memory_region_init_ram). So actually I think we should remove the
> > > DPRINTF warning as it is normal. =20
> >=20
> > Let me explain why the DPRINTF warning is there: emulated dma operati=
ons
> > can involve locked mappings. Once a dma operation completes, the rela=
ted
> > mapping is unlocked and can be safely destroyed. But if we destroy a
> > locked mapping in xen_invalidate_map_cache, while a dma is still
> > ongoing, QEMU will crash. We cannot handle that case.
> >=20
> > However, the scenario you described is different. It has nothing to d=
o
> > with DMA. It looks like pci_add_option_rom calls
> > memory_region_get_ram_ptr to map the rtl8139 rom. The mapping is a
> > locked mapping and it is never unlocked or destroyed.
> >=20
> > It looks like "ptr" is not used after pci_add_option_rom returns. Doe=
s
> > the append patch fix the problem you are seeing? For the proper fix, =
I
> > think we probably need some sort of memory_region_unmap wrapper or ma=
ybe
> > a call to address_space_unmap.
>=20
> Hmm, for some reason my message to the Xen-devel list got rejected but =
was sent
> to Qemu-devel instead, without any notice. Sorry if I'm missing somethi=
ng
> obvious as a list newbie.
>=20
> Stefano, hrg,
>=20
> There is an issue with inconsistency between the list of normal MapCach=
eEntry's
> and their 'reverse' counterparts - MapCacheRev's in locked_entries.
> When bad situation happens, there are multiple (locked) MapCacheEntry
> entries in the bucket's linked list along with a number of MapCacheRev'=
s. And
> when it comes to a reverse lookup, xen-mapcache picks the wrong entry f=
rom the
> first list and calculates a wrong pointer from it which may then be cau=
ght with
> the "Bad RAM offset" check (or not). Mapcache invalidation might be rel=
ated to
> this issue as well I think.
>=20
> I'll try to provide a test code which can reproduce the issue from the
> guest side using an emulated IDE controller, though it's much simpler t=
o achieve
> this result with an AHCI controller using multiple NCQ I/O commands. So=
 far I've
> seen this issue only with Windows 7 (and above) guest on AHCI, but any =
block I/O
> DMA should be enough I think.

That would be helpful. Please see if you can reproduce it after fixing
the other issue (http://marc.info/?l=3Dqemu-devel&m=3D149195042500707&w=3D=
2).
