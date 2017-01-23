Received: from eggs.gnu.org ([2001:4830:134:3::10]:57946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVVPn-0001wa-33
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 22:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVVPj-0005Ts-Vl
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 22:35:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVVPj-0005TZ-N0
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 22:35:27 -0500
Date: Mon, 23 Jan 2017 11:35:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170123033521.GG26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-16-git-send-email-peterx@redhat.com>
	<f2cceaa6-b3cf-9ed1-2c9c-f9222a0ab7ce@redhat.com>
	<20170122085118.GA26526@pxdev.xzpeter.org>
	<c7265d9c-54e9-f4a2-003d-85c4416c1651@redhat.com>
	<20170123025449.GE26526@pxdev.xzpeter.org>
	<fcdd4b74-9ad0-d9d4-31f4-3129d4a11233@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fcdd4b74-9ad0-d9d4-31f4-3129d4a11233@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Mon, Jan 23, 2017 at 11:12:27AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8823=E6=97=A5 10:54, Peter Xu wrote:
> >>>>>+            trace_vtd_page_walk_skip_read(iova, iova_next);
> >>>>>+            skipped_local++;
> >>>>>+            goto next;
> >>>>>+        }
> >>>>>+
> >>>>>+        if (vtd_slpte_nonzero_rsvd(slpte, level)) {
> >>>>>+            trace_vtd_page_walk_skip_reserve(iova, iova_next);
> >>>>>+            skipped_local++;
> >>>>>+            goto next;
> >>>>>+        }
> >>>>>+
> >>>>>+        /* Permissions are stacked with parents' */
> >>>>>+        read_cur =3D read && (slpte & VTD_SL_R);
> >>>>>+        write_cur =3D write && (slpte & VTD_SL_W);
> >>>>>+
> >>>>>+        /*
> >>>>>+         * As long as we have either read/write permission, this =
is
> >>>>>+         * a valid entry. The rule works for both page or page ta=
bles.
> >>>>>+         */
> >>>>>+        entry_valid =3D read_cur | write_cur;
> >>>>>+
> >>>>>+        if (vtd_is_last_slpte(slpte, level)) {
> >>>>>+            entry.target_as =3D &address_space_memory;
> >>>>>+            entry.iova =3D iova & subpage_mask;
> >>>>>+            /*
> >>>>>+             * This might be meaningless addr if (!read_cur &&
> >>>>>+             * !write_cur), but after all this field will be
> >>>>>+             * meaningless in that case, so let's share the code =
to
> >>>>>+             * generate the IOTLBs no matter it's an MAP or UNMAP
> >>>>>+             */
> >>>>>+            entry.translated_addr =3D vtd_get_slpte_addr(slpte);
> >>>>>+            entry.addr_mask =3D ~subpage_mask;
> >>>>>+            entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur)=
;
> >>>>>+            if (!entry_valid && !notify_unmap) {
> >>>>>+                trace_vtd_page_walk_skip_perm(iova, iova_next);
> >>>>>+                skipped_local++;
> >>>>>+                goto next;
> >>>>>+            }
> >>>>Under which case should we care about unmap here (better with a com=
ment I
> >>>>think)?
> >>>When PSIs are for invalidation, rather than newly mapped entries. In
> >>>that case, notify_unmap will be true, and here we need to notify
> >>>IOMMU_NONE to do the cache flush or unmap.
> >>>
> >>>(this page walk is not only for replaying, it is for cache flushing =
as
> >>>  well)
> >>>
> >>>Do you have suggestion on the comments?
> >>I think then we'd better move this to patch 18 which will use notify_=
unmap.
> >Do you mean to add some more comment on patch 18?
> >
>=20
> I mean move the unmap_nofity and its comment to patch 18 (real user). B=
ut if
> you want to keep it in the patch, I'm also fine.

(Since we discussed in IRC for this :)

So I'll keep it for this time. Thanks,

-- peterx
