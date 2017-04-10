Received: from eggs.gnu.org ([2001:4830:134:3::10]:38497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cxfLB-0000lw-Ft
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 15:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cxfL7-0004QW-Fs
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 15:51:09 -0400
Received: from mail.kernel.org ([198.145.29.136]:33688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cxfL7-0004Ns-9d
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 15:51:05 -0400
Date: Mon, 10 Apr 2017 12:50:58 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <alpine.DEB.2.10.1704101159340.2759@sstabellini-ThinkPad-X260>
Message-ID: <alpine.DEB.2.10.1704101243270.2759@sstabellini-ThinkPad-X260>
References: <CADZi59zNxk-Yr4rpN1E49s=AdsdW-W9YfhpCvpJeBz7oigyFSg@mail.gmail.com>
	<CADZi59xe6OcCasvtkPBjP7nTsgDA5r_E_Rt7W88BszYdJhuxGQ@mail.gmail.com>
	<CADZi59xEg0SvScgo=Jg0MxTbGYY=nTX18Qo-4GMkfayThDU9zw@mail.gmail.com>
	<alpine.DEB.2.10.1704101159340.2759@sstabellini-ThinkPad-X260>
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
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: hrg <hrgstephen@gmail.com>, anthony.perard@citrix.com, xen-devel@lists.xensource.com, qemu-devel@nongnu.org, jun.nakajima@intel.com, agraf@suse.de, xen-devel@lists.xenproject.org, xen-devel@lists.xen.org, "Herongguang (Stephen)" <herongguang.he@huawei.com>, wangxinxin.wang@huawei.com

On Mon, 10 Apr 2017, Stefano Stabellini wrote:
> On Mon, 10 Apr 2017, hrg wrote:
> > On Sun, Apr 9, 2017 at 11:55 PM, hrg <hrgstephen@gmail.com> wrote:
> > > On Sun, Apr 9, 2017 at 11:52 PM, hrg <hrgstephen@gmail.com> wrote:
> > >> Hi,
> > >>
> > >> In xen_map_cache_unlocked(), map to guest memory maybe in entry->n=
ext
> > >> instead of first level entry (if map to rom other than guest memor=
y
> > >> comes first), while in xen_invalidate_map_cache(), when VM balloon=
ed
> > >> out memory, qemu did not invalidate cache entries in linked
> > >> list(entry->next), so when VM balloon back in memory, gfns probabl=
y
> > >> mapped to different mfns, thus if guest asks device to DMA to thes=
e
> > >> GPA, qemu may DMA to stale MFNs.
> > >>
> > >> So I think in xen_invalidate_map_cache() linked lists should also =
be
> > >> checked and invalidated.
> > >>
> > >> What=E2=80=99s your opinion? Is this a bug? Is my analyze correct?
>=20
> Yes, you are right. We need to go through the list for each element of
> the array in xen_invalidate_map_cache. Can you come up with a patch?

I spoke too soon. In the regular case there should be no locked mappings
when xen_invalidate_map_cache is called (see the DPRINTF warning at the
beginning of the functions). Without locked mappings, there should never
be more than one element in each list (see xen_map_cache_unlocked:
entry->lock =3D=3D true is a necessary condition to append a new entry to
the list, otherwise it is just remapped).

Can you confirm that what you are seeing are locked mappings
when xen_invalidate_map_cache is called? To find out, enable the DPRINTK
by turning it into a printf or by defininig MAPCACHE_DEBUG.
