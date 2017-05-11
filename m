Received: from eggs.gnu.org ([2001:4830:134:3::10]:53973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8jln-00012t-Gp
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8jlj-0006fz-Fn
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:48:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8jlj-0006fS-8E
	for qemu-devel@nongnu.org; Thu, 11 May 2017 04:48:19 -0400
Date: Thu, 11 May 2017 16:48:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170511084805.GH28293@pxdev.xzpeter.org>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
	<1494403315-12760-11-git-send-email-peterx@redhat.com>
	<7d770f21-636e-dc96-99b9-923f5d5a14aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d770f21-636e-dc96-99b9-923f5d5a14aa@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/12] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>, yi.l.liu@intel.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Thu, May 11, 2017 at 04:31:40PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8810=E6=97=A5 16:01, Peter Xu wrote:
> >Hardware support for VT-d device passthrough. Although current Linux c=
an
> >live with iommu=3Dpt even without this, but this is faster than when u=
sing
> >software passthrough.
> >
> >Signed-off-by: Peter Xu <peterx@redhat.com>
> >---
> >  hw/i386/intel_iommu.c          | 210 +++++++++++++++++++++++++++++++=
+---------
> >  hw/i386/intel_iommu_internal.h |   1 +
> >  hw/i386/trace-events           |   2 +
> >  hw/i386/x86-iommu.c            |   1 +
> >  include/hw/i386/x86-iommu.h    |   1 +
> >  5 files changed, 171 insertions(+), 44 deletions(-)
> >
> >diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >index 1a7eba2..1d034f9 100644
> >--- a/hw/i386/intel_iommu.c
> >+++ b/hw/i386/intel_iommu.c
> >@@ -640,6 +640,29 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte=
, uint32_t level)
> >      }
> >  }
> >+/* Find the VTD address space associated with a given bus number */
> >+static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t b=
us_num)
> >+{
> >+    VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
> >+    if (!vtd_bus) {
> >+        /*
> >+         * Iterate over the registered buses to find the one which
> >+         * currently hold this bus number, and update the bus_num
> >+         * lookup table:
> >+         */
> >+        GHashTableIter iter;
> >+
> >+        g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> >+        while (g_hash_table_iter_next (&iter, NULL, (void**)&vtd_bus)=
) {
> >+            if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
> >+                s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
> >+                return vtd_bus;
> >+            }
> >+        }
> >+    }
> >+    return vtd_bus;
> >+}
> >+
> >  /* Given the @iova, get relevant @slptep. @slpte_level will be the l=
ast level
> >   * of the translation, can be used for deciding the size of large pa=
ge.
> >   */
> >@@ -881,6 +904,11 @@ static int vtd_dev_to_context_entry(IntelIOMMUSta=
te *s, uint8_t bus_num,
> >                  type_fail =3D true;
> >              }
> >              break;
> >+        case VTD_CONTEXT_TT_PASS_THROUGH:
> >+            if (!x86_iommu->pt_supported) {
> >+                type_fail =3D true;
> >+            }
> >+            break;
> >          default:
> >              /* Unknwon type */
> >              type_fail =3D true;
> >@@ -894,6 +922,84 @@ static int vtd_dev_to_context_entry(IntelIOMMUSta=
te *s, uint8_t bus_num,
> >      return 0;
> >  }
> >+/*
> >+ * Fetch translation type for specific device. Returns <0 if error
> >+ * happens, otherwise return the shifted type to check against
> >+ * VTD_CONTEXT_TT_*.
> >+ */
> >+static int vtd_dev_get_trans_type(VTDAddressSpace *as)
> >+{
> >+    IntelIOMMUState *s;
> >+    VTDContextEntry ce;
> >+    int ret;
> >+
> >+    s =3D as->iommu_state;
> >+
> >+    ret =3D vtd_dev_to_context_entry(s, pci_bus_num(as->bus),
> >+                                   as->devfn, &ce);
> >+    if (ret) {
> >+        return ret;
> >+    }
> >+
> >+    return vtd_ce_get_type(&ce);
> >+}
> >+
> >+static bool vtd_dev_pt_enabled(VTDAddressSpace *as)
> >+{
> >+    int ret;
> >+
> >+    assert(as);
> >+
> >+    ret =3D vtd_dev_get_trans_type(as);
> >+    if (ret < 0) {
> >+        /*
> >+         * Possibly failed to parse the context entry for some reason
> >+         * (e.g., during init, or any guest configuration errors on
> >+         * context entries). We should assume PT not enabled for
> >+         * safety.
> >+         */
> >+        return false;
> >+    }
> >+
> >+    return ret =3D=3D VTD_CONTEXT_TT_PASS_THROUGH;
> >+}
> >+
> >+/*
> >+ * When we are during init phase (device realizations, global
> >+ * enable/disable of translations), we should not detect PT
> >+ * (passthrough) when switching address spaces. In that cases, we
> >+ * should set `detect_pt' to false.
> >+ *
> >+ * Return whether the device is using IOMMU translation.
> >+ */
> >+static bool vtd_switch_address_space(VTDAddressSpace *as, bool detect=
_pt)
> >+{
>=20
> The detect_pt looks suspicious. E.g if the context entry does not exist=
,
> vtd_dev_pt_enabled() will return false.

I forgot why I added that even after reading the comments I wrote. I
blame too much context switches recently in my brain. :(

(this is an excuse of mine :)

I did some test and I see nothing wrong to not hack on this bit. I
will remove that in next version, until one day I remembered
something.

And I will try to add more detailed comments in the future.

>=20
> >+    bool use_iommu;
> >+
> >+    assert(as);
> >+
> >+    use_iommu =3D as->iommu_state->dmar_enabled;
> >+    if (detect_pt) {
> >+        use_iommu &=3D !vtd_dev_pt_enabled(as);
> >+    }
> >+
> >+    trace_vtd_switch_address_space(pci_bus_num(as->bus),
> >+                                   VTD_PCI_SLOT(as->devfn),
> >+                                   VTD_PCI_FUNC(as->devfn),
> >+                                   use_iommu);
> >+
> >+    /* Turn off first then on the other */
> >+    if (use_iommu) {
> >+        memory_region_set_enabled(&as->sys_alias, false);
> >+        memory_region_set_enabled(&as->iommu, true);
> >+    } else {
> >+        memory_region_set_enabled(&as->iommu, false);
> >+        memory_region_set_enabled(&as->sys_alias, true);
> >+    }
> >+
> >+    return use_iommu;
> >+}
> >+
> >  static inline uint16_t vtd_make_source_id(uint8_t bus_num, uint8_t d=
evfn)
> >  {
> >      return ((bus_num & 0xffUL) << 8) | (devfn & 0xffUL);
> >@@ -931,6 +1037,31 @@ static inline bool vtd_is_interrupt_addr(hwaddr =
addr)
> >      return VTD_INTERRUPT_ADDR_FIRST <=3D addr && addr <=3D VTD_INTER=
RUPT_ADDR_LAST;
> >  }
> >+static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t sour=
ce_id)
> >+{
> >+    VTDBus *vtd_bus;
> >+    VTDAddressSpace *vtd_as;
> >+    const char *msg =3D "FAIL";
> >+
> >+    vtd_bus =3D vtd_find_as_from_bus_num(s, VTD_SID_TO_BUS(source_id)=
);
> >+    if (!vtd_bus) {
> >+        goto out;
> >+    }
> >+
> >+    vtd_as =3D vtd_bus->dev_as[VTD_SID_TO_DEVFN(source_id)];
> >+    if (!vtd_as) {
> >+        goto out;
> >+    }
> >+
> >+    if (vtd_switch_address_space(vtd_as, true) =3D=3D false) {
> >+        /* We switched off IOMMU region successfully. */
> >+        msg =3D "SUCCESS";
> >+    }
> >+
> >+out:
> >+    trace_vtd_pt_enable_fast_path(source_id, msg);
>=20
> Looks like using a boolean is better here.

Sure.

>=20
> >+}
> >+
> >  /* Map dev to context-entry then do a paging-structures walk to do a=
 iommu
> >   * translation.
> >   *
> >@@ -1002,6 +1133,30 @@ static void vtd_do_iommu_translate(VTDAddressSp=
ace *vtd_as, PCIBus *bus,
> >          cc_entry->context_cache_gen =3D s->context_cache_gen;
> >      }
> >+    /*
> >+     * We don't need to translate for pass-through context entries.
> >+     * Also, let's ignore IOTLB caching as well for PT devices.
> >+     */
> >+    if (vtd_ce_get_type(&ce) =3D=3D VTD_CONTEXT_TT_PASS_THROUGH) {
> >+        entry->translated_addr =3D entry->iova;
> >+        entry->addr_mask =3D VTD_PAGE_SIZE - 1;
> >+        entry->perm =3D IOMMU_RW;
> >+        trace_vtd_translate_pt(source_id, entry->iova);
> >+
> >+        /*
> >+         * When this happens, it means firstly caching-mode is not
> >+         * enabled, and this is the first passthrough translation for
> >+         * the device. Let's enable the fast path for passthrough.
> >+         *
> >+         * When passthrough is disabled again for the device, we can
> >+         * capture it via the context entry invalidation, then the
> >+         * IOMMU region can be swapped back.
> >+         */
> >+        vtd_pt_enable_fast_path(s, source_id);
> >+
> >+        return;
> >+    }
> >+
> >      ret_fr =3D vtd_iova_to_slpte(&ce, addr, is_write, &slpte, &level=
,
> >                                 &reads, &writes);
> >      if (ret_fr) {
> >@@ -1081,29 +1236,6 @@ static void vtd_context_global_invalidate(Intel=
IOMMUState *s)
> >      vtd_iommu_replay_all(s);
> >  }
> >-
> >-/* Find the VTD address space currently associated with a given bus n=
umber,
> >- */
> >-static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t b=
us_num)
> >-{
> >-    VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
> >-    if (!vtd_bus) {
> >-        /* Iterate over the registered buses to find the one
> >-         * which currently hold this bus number, and update the bus_n=
um lookup table:
> >-         */
> >-        GHashTableIter iter;
> >-
> >-        g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> >-        while (g_hash_table_iter_next (&iter, NULL, (void**)&vtd_bus)=
) {
> >-            if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
> >-                s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
> >-                return vtd_bus;
> >-            }
> >-        }
> >-    }
> >-    return vtd_bus;
> >-}
> >-
> >  /* Do a context-cache device-selective invalidation.
> >   * @func_mask: FM field after shifting
> >   */
> >@@ -1146,6 +1278,11 @@ static void vtd_context_device_invalidate(Intel=
IOMMUState *s,
> >                                               VTD_PCI_FUNC(devfn_it))=
;
> >                  vtd_as->context_cache_entry.context_cache_gen =3D 0;
> >                  /*
> >+                 * Do switch address space when needed, in case if th=
e
> >+                 * device passthrough bit is switched.
> >+                 */
> >+                vtd_switch_address_space(vtd_as, true);
>=20
> Do we need to do this also in DSI and GLOBAL invalidation?

Yes. Though this should be optional at least for Linux, but I will add
that later.

Thanks!

--=20
Peter Xu
