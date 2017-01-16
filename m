Received: from eggs.gnu.org ([2001:4830:134:3::10]:33047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT2Cp-000592-40
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT2Cm-0006vq-1A
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:59:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cT2Cl-0006vf-Ot
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 02:59:51 -0500
Date: Mon, 16 Jan 2017 15:59:47 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170116075947.GF30108@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-12-git-send-email-peterx@redhat.com>
	<c5b536a1-1f7b-965d-04b6-4f6bde19733f@redhat.com>
	<20170116073116.GC30108@pxdev.xzpeter.org>
	<97339915-c8fb-cfd5-aa06-b795eab21428@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97339915-c8fb-cfd5-aa06-b795eab21428@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 11/14] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Mon, Jan 16, 2017 at 03:47:08PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 15:31, Peter Xu wrote:
> >On Fri, Jan 13, 2017 at 05:26:06PM +0800, Jason Wang wrote:
> >>
> >>On 2017=E5=B9=B401=E6=9C=8813=E6=97=A5 11:06, Peter Xu wrote:
> >>>The default replay() don't work for VT-d since vt-d will have a huge
> >>>default memory region which covers address range 0-(2^64-1). This wi=
ll
> >>>normally bring a dead loop when guest starts.
> >>I think it just takes too much time instead of dead loop?
> >Hmm, I can touch the commit message above to make it more precise.
> >
> >>>The solution is simple - we don't walk over all the regions. Instead=
, we
> >>>jump over the regions when we found that the page directories are em=
pty.
> >>>It'll greatly reduce the time to walk the whole region.
> >>Yes, the problem is memory_region_is_iommu_reply() not smart because:
> >>
> >>- It doesn't understand large page
> >>- try go over all possible iova
> >>
> >>So I'm thinking to introduce something like iommu_ops->iova_iterate()=
 which
> >>
> >>1) accept an start iova and return the next exist map
> >>2) understand large page
> >>3) skip unmapped iova
> >Though I haven't tested with huge pages yet, but this patch should
> >both solve above issue? I don't know whether you went over the page
> >walk logic - it should both support huge page, and it will skip
> >unmapped iova range (at least that's my goal to have this patch). In
> >that case, looks like this patch is solving the same problem? :)
> >(though without introducing iova_iterate() interface)
> >
> >Please correct me if I misunderstood it.
>=20
> Kind of :) I'm fine with this patch, but just want:
>=20
> - reuse most of the codes in the patch
> - current memory_region_iommu_replay() logic
>=20
> So what I'm suggesting is a just slight change of API which can let cal=
ler
> decide it need to do with each range of iova. So it could be reused for
> other things except for replaying.
>=20
> But if you like to keep this patch as is, I don't object it.

I see. Then I can understand your mean here. I had the same thought
before, that's why I exposed the vtd_page_walk with a hook. If you
check the page_walk function comment:

/**
 * vtd_page_walk - walk specific IOVA range, and call the hook
 *
 * @ce: context entry to walk upon
 * @start: IOVA address to start the walk
 * @end: IOVA range end address (start <=3D addr < end)
 * @hook_fn: the hook that to be called for each detected area
 * @private: private data for the hook function
 */

So I didn't implement the notification in page_walk at all - but in
the hook_fn. If any caller that is interested in doing something else
rather than the notification, we can just simply export the page walk
interface and provide his/her own "hook_fn", then it'll be triggered
for each valid page (no matter a huge/small one).

If we can have a more general interface in the future - no matter
whether we call it iova_iterate() or something else (I'll prefer the
hooker way to do it, so maybe a common page walker with a hook
function), we can do it simply (at least for Intel platform) based on
this vtd_page_walk thing.

Thanks,

-- peterx
