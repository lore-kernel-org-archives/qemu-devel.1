Received: from eggs.gnu.org ([2001:4830:134:3::10]:35798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVsLy-0002sO-1B
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVsLu-0002TF-RI
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:05:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVsLu-0002Sz-M1
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:05:02 -0500
Date: Tue, 24 Jan 2017 12:04:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170124040457.GK26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-16-git-send-email-peterx@redhat.com>
	<f2cceaa6-b3cf-9ed1-2c9c-f9222a0ab7ce@redhat.com>
	<20170122085118.GA26526@pxdev.xzpeter.org>
	<c7265d9c-54e9-f4a2-003d-85c4416c1651@redhat.com>
	<20170123025449.GE26526@pxdev.xzpeter.org>
	<20170123123429.1a07f156@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170123123429.1a07f156@t450s.home>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 15/20] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org

On Mon, Jan 23, 2017 at 12:34:29PM -0700, Alex Williamson wrote:
> On Mon, 23 Jan 2017 10:54:49 +0800
> Peter Xu <peterx@redhat.com> wrote:
>=20
> > On Mon, Jan 23, 2017 at 09:48:48AM +0800, Jason Wang wrote:
> > >=20
> > >=20
> > > On 2017=E5=B9=B401=E6=9C=8822=E6=97=A5 16:51, Peter Xu wrote: =20
> > > >On Sun, Jan 22, 2017 at 03:56:10PM +0800, Jason Wang wrote:
> > > >
> > > >[...]
> > > > =20
> > > >>>+/**
> > > >>>+ * vtd_page_walk_level - walk over specific level for IOVA rang=
e
> > > >>>+ *
> > > >>>+ * @addr: base GPA addr to start the walk
> > > >>>+ * @start: IOVA range start address
> > > >>>+ * @end: IOVA range end address (start <=3D addr < end)
> > > >>>+ * @hook_fn: hook func to be called when detected page
> > > >>>+ * @private: private data to be passed into hook func
> > > >>>+ * @read: whether parent level has read permission
> > > >>>+ * @write: whether parent level has write permission
> > > >>>+ * @skipped: accumulated skipped ranges =20
> > > >>What's the usage for this parameter? Looks like it was never used=
 in this
> > > >>series. =20
> > > >This was for debugging purpose before, and I kept it in case one d=
ay
> > > >it can be used again, considering that will not affect much on the
> > > >overall performance. =20
> > >=20
> > > I think we usually do not keep debugging codes outside debug macros=
. =20
> >=20
> > I'll remove it.
>=20
> While you're at it, what's the value in using a void* private rather
> than just passing around an IOMMUNotifier*.  Seems like unnecessary
> abstraction.  Thanks,

When handling PSIs (in continuous patches, not this one), we were
passing in MemoryRegion* rather than IOMMUNotifier*:

        vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SIZE,
                        vtd_page_invalidate_notify_hook,
                        (void *)&vtd_as->iommu, true);

So a void* might still be required. Thanks,

-- peterx
