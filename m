Received: from eggs.gnu.org ([2001:4830:134:3::10]:57446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVVOz-0001Vg-Ux
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 22:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVVOw-00057x-Nl
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 22:34:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVVOw-000576-GJ
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 22:34:38 -0500
Date: Mon, 23 Jan 2017 11:34:29 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170123033429.GF26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-19-git-send-email-peterx@redhat.com>
	<490bbb84-213b-1b2a-5a1b-fa42a5c6a359@redhat.com>
	<20170122090425.GB26526@pxdev.xzpeter.org>
	<1dd223d1-dc02-bddc-02ea-78d267dd40a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1dd223d1-dc02-bddc-02ea-78d267dd40a4@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 18/20] intel_iommu: enable vfio
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Mon, Jan 23, 2017 at 09:55:39AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8822=E6=97=A5 17:04, Peter Xu wrote:
> >On Sun, Jan 22, 2017 at 04:08:04PM +0800, Jason Wang wrote:
> >
> >[...]
> >
> >>>+static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
> >>>+                                           uint16_t domain_id, hwad=
dr addr,
> >>>+                                           uint8_t am)
> >>>+{
> >>>+    IntelIOMMUNotifierNode *node;
> >>>+    VTDContextEntry ce;
> >>>+    int ret;
> >>>+
> >>>+    QLIST_FOREACH(node, &(s->notifiers_list), next) {
> >>>+        VTDAddressSpace *vtd_as =3D node->vtd_as;
> >>>+        ret =3D vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus=
),
> >>>+                                       vtd_as->devfn, &ce);
> >>>+        if (!ret && domain_id =3D=3D VTD_CONTEXT_ENTRY_DID(ce.hi)) =
{
> >>>+            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_SI=
ZE,
> >>>+                          vtd_page_invalidate_notify_hook,
> >>>+                          (void *)&vtd_as->iommu, true);
> >>Why not simply trigger the notifier here? (or is this vfio required?)
> >Because we may only want to notify part of the region - we are with
> >mask here, but not exact size.
> >
> >Consider this: guest (with caching mode) maps 12K memory (4K*3 pages),
> >the mask will be extended to 16K in the guest. In that case, we need
> >to explicitly go over the page entry to know that the 4th page should
> >not be notified.
>=20
> I see. Then it was required by vfio only, I think we can add a fast pat=
h for
> !CM in this case by triggering the notifier directly.

I noted this down (to be further investigated in my todo), but I don't
know whether this can work, due to the fact that I think it is still
legal that guest merge more than one PSIs into one. For example, I
don't know whether below is legal:

- guest invalidate page (0, 4k)
- guest map new page (4k, 8k)
- guest send single PSI of (0, 8k)

In that case, it contains both map/unmap, and looks like it didn't
disobay the spec as well?

>=20
> Another possible issue is, consider (with CM) a 16K contiguous iova wit=
h the
> last page has already been mapped. In this case, if we want to map firs=
t
> three pages, when handling IOTLB invalidation, am would be 16K, then th=
e
> last page will be mapped twice. Can this lead some issue?

I don't know whether guest has special handling of this kind of
request.

Besides, imho to completely solve this problem, we still need that
per-domain tree. Considering that currently the tree is inside vfio, I
see this not a big issue as well. In that case, the last page mapping
request will fail (we might see one error line from QEMU stderr),
however that'll not affect too much since currently vfio allows that
failure to happen (ioctl fail, but that page is still mapped, which is
what we wanted).

(But of course above error message can be used by an in-guest attacker
 as well just like general error_report() issues reported before,
 though again I will appreciate if we can have this series
 functionally work first :)

And, I should be able to emulate this behavior in guest with a tiny C
program to make sure of it, possibly after this series if allowed.

Thanks,

-- peterx
