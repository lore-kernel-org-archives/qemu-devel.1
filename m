Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVUme-0002Ih-6k
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:55:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVUmZ-00052k-83
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:55:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVUmZ-00052V-03
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:54:59 -0500
Date: Mon, 23 Jan 2017 10:54:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170123025449.GE26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-16-git-send-email-peterx@redhat.com>
	<f2cceaa6-b3cf-9ed1-2c9c-f9222a0ab7ce@redhat.com>
	<20170122085118.GA26526@pxdev.xzpeter.org>
	<c7265d9c-54e9-f4a2-003d-85c4416c1651@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c7265d9c-54e9-f4a2-003d-85c4416c1651@redhat.com>
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

On Mon, Jan 23, 2017 at 09:48:48AM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8822=E6=97=A5 16:51, Peter Xu wrote:
> >On Sun, Jan 22, 2017 at 03:56:10PM +0800, Jason Wang wrote:
> >
> >[...]
> >
> >>>+/**
> >>>+ * vtd_page_walk_level - walk over specific level for IOVA range
> >>>+ *
> >>>+ * @addr: base GPA addr to start the walk
> >>>+ * @start: IOVA range start address
> >>>+ * @end: IOVA range end address (start <=3D addr < end)
> >>>+ * @hook_fn: hook func to be called when detected page
> >>>+ * @private: private data to be passed into hook func
> >>>+ * @read: whether parent level has read permission
> >>>+ * @write: whether parent level has write permission
> >>>+ * @skipped: accumulated skipped ranges
> >>What's the usage for this parameter? Looks like it was never used in =
this
> >>series.
> >This was for debugging purpose before, and I kept it in case one day
> >it can be used again, considering that will not affect much on the
> >overall performance.
>=20
> I think we usually do not keep debugging codes outside debug macros.

I'll remove it.

>=20
> >
> >>>+ * @notify_unmap: whether we should notify invalid entries
> >>>+ */
> >>>+static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
> >>>+                               uint64_t end, vtd_page_walk_hook hoo=
k_fn,
> >>>+                               void *private, uint32_t level,
> >>>+                               bool read, bool write, uint64_t *ski=
pped,
> >>>+                               bool notify_unmap)
> >>>+{
> >>>+    bool read_cur, write_cur, entry_valid;
> >>>+    uint32_t offset;
> >>>+    uint64_t slpte;
> >>>+    uint64_t subpage_size, subpage_mask;
> >>>+    IOMMUTLBEntry entry;
> >>>+    uint64_t iova =3D start;
> >>>+    uint64_t iova_next;
> >>>+    uint64_t skipped_local =3D 0;
> >>>+    int ret =3D 0;
> >>>+
> >>>+    trace_vtd_page_walk_level(addr, level, start, end);
> >>>+
> >>>+    subpage_size =3D 1ULL << vtd_slpt_level_shift(level);
> >>>+    subpage_mask =3D vtd_slpt_level_page_mask(level);
> >>>+
> >>>+    while (iova < end) {
> >>>+        iova_next =3D (iova & subpage_mask) + subpage_size;
> >>>+
> >>>+        offset =3D vtd_iova_level_offset(iova, level);
> >>>+        slpte =3D vtd_get_slpte(addr, offset);
> >>>+
> >>>+        /*
> >>>+         * When one of the following case happens, we assume the wh=
ole
> >>>+         * range is invalid:
> >>>+         *
> >>>+         * 1. read block failed
> >>Don't get the meaning (and don't see any code relate to this comment)=
.
> >I took above vtd_get_slpte() a "read", so I was trying to mean that we
> >failed to read the SLPTE due to some reason, we assume the range is
> >invalid.
>=20
> I see, so we'd better move the comment above of vtd_get_slpte().

Let me remove the whole comment block... I think the codes explained
it clearly even without any comment. (when people see the code check
slpte against -1, it'll think about above function naturally)

>=20
> >
> >>>+         * 3. reserved area non-zero
> >>>+         * 2. both read & write flag are not set
> >>Should be 1,2,3? And the above comment is conflict with the code at l=
east
> >>when notify_unmap is true.
> >Yes, okay I don't know why 3 jumped. :(
> >
> >And yes, I should mention that "both read & write flag not set" only
> >suites for page tables here.
> >
> >>>+         */
> >>>+
> >>>+        if (slpte =3D=3D (uint64_t)-1) {
> >>If this is true, vtd_slpte_nonzero_rsvd(slpte) should be true too I t=
hink?
> >Yes, but we are doing two checks here:
> >
> >- checking against -1 to make sure slpte read success
> >- checking against nonzero reserved fields to make sure it follows spe=
c
> >
> >Imho we should not skip the first check here, only if one day removing
> >this may really matter (e.g., for performance reason? I cannot think
> >of one yet).
>=20
> Ok. (return -1 seems not good, but we can address this in the future).

Thanks.

>=20
> >
> >>>+            trace_vtd_page_walk_skip_read(iova, iova_next);
> >>>+            skipped_local++;
> >>>+            goto next;
> >>>+        }
> >>>+
> >>>+        if (vtd_slpte_nonzero_rsvd(slpte, level)) {
> >>>+            trace_vtd_page_walk_skip_reserve(iova, iova_next);
> >>>+            skipped_local++;
> >>>+            goto next;
> >>>+        }
> >>>+
> >>>+        /* Permissions are stacked with parents' */
> >>>+        read_cur =3D read && (slpte & VTD_SL_R);
> >>>+        write_cur =3D write && (slpte & VTD_SL_W);
> >>>+
> >>>+        /*
> >>>+         * As long as we have either read/write permission, this is
> >>>+         * a valid entry. The rule works for both page or page tabl=
es.
> >>>+         */
> >>>+        entry_valid =3D read_cur | write_cur;
> >>>+
> >>>+        if (vtd_is_last_slpte(slpte, level)) {
> >>>+            entry.target_as =3D &address_space_memory;
> >>>+            entry.iova =3D iova & subpage_mask;
> >>>+            /*
> >>>+             * This might be meaningless addr if (!read_cur &&
> >>>+             * !write_cur), but after all this field will be
> >>>+             * meaningless in that case, so let's share the code to
> >>>+             * generate the IOTLBs no matter it's an MAP or UNMAP
> >>>+             */
> >>>+            entry.translated_addr =3D vtd_get_slpte_addr(slpte);
> >>>+            entry.addr_mask =3D ~subpage_mask;
> >>>+            entry.perm =3D IOMMU_ACCESS_FLAG(read_cur, write_cur);
> >>>+            if (!entry_valid && !notify_unmap) {
> >>>+                trace_vtd_page_walk_skip_perm(iova, iova_next);
> >>>+                skipped_local++;
> >>>+                goto next;
> >>>+            }
> >>Under which case should we care about unmap here (better with a comme=
nt I
> >>think)?
> >When PSIs are for invalidation, rather than newly mapped entries. In
> >that case, notify_unmap will be true, and here we need to notify
> >IOMMU_NONE to do the cache flush or unmap.
> >
> >(this page walk is not only for replaying, it is for cache flushing as
> >  well)
> >
> >Do you have suggestion on the comments?
>=20
> I think then we'd better move this to patch 18 which will use notify_un=
map.

Do you mean to add some more comment on patch 18?

>=20
> >
> >>>+            trace_vtd_page_walk_one(level, entry.iova, entry.transl=
ated_addr,
> >>>+                                    entry.addr_mask, entry.perm);
> >>>+            if (hook_fn) {
> >>>+                ret =3D hook_fn(&entry, private);
> >>For better performance, we could try to merge adjacent mappings here.=
 I
> >>think both vfio and vhost support this and it can save a lot of ioctl=
s.
> >Looks so, and this is in my todo list.
> >
> >Do you mind I do it later after this series merged? I would really
> >appreciate if we can have this codes settled down first (considering
> >that this series has been dangling for half a year, or more, startint
> >from Aviv's series), and I am just afraid this will led to
> >unconvergence of this series (and I believe there are other places
> >that can be enhanced in the future as well).
>=20
> Yes, let's do it on top.

Thanks.

>=20
> >
> >>>+                if (ret < 0) {
> >>>+                    error_report("Detected error in page walk hook =
"
> >>>+                                 "function, stop walk.");
> >>>+                    return ret;
> >>>+                }
> >>>+            }
> >>>+        } else {
> >>>+            if (!entry_valid) {
> >>>+                trace_vtd_page_walk_skip_perm(iova, iova_next);
> >>>+                skipped_local++;
> >>>+                goto next;
> >>>+            }
> >>>+            trace_vtd_page_walk_level(vtd_get_slpte_addr(slpte), le=
vel - 1,
> >>>+                                      iova, MIN(iova_next, end));
> >>This looks duplicated?
> >I suppose not. The level is different.
>=20
> Seem not? level - 1 was passed to vtd_page_walk_level() as level which =
did:
>=20
> trace_vtd_page_walk_level(addr, level, start, end);

Hmm yes I didn't notice that I had one at the entry. :(

Let me only keep that one.

Thanks,

-- peterx
