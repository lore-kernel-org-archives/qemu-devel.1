Received: from eggs.gnu.org ([2001:4830:134:3::10]:38451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cgNIa-0000N2-32
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cgNIW-0001FA-RQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cgNIW-0001F6-JY
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:08:56 -0500
Date: Wed, 22 Feb 2017 11:08:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170222030851.GA17314@pxdev.xzpeter.org>
References: <20170221214228.12515.79751.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170221214228.12515.79751.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH] vfio/pci: Improve extended capability
 comments, skip masked caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

[cc Jintack]

On Tue, Feb 21, 2017 at 02:43:03PM -0700, Alex Williamson wrote:
> Since commit 4bb571d857d9 ("pci/pcie: don't assume cap id 0 is
> reserved") removes the internal use of extended capability ID 0, the
> comment here becomes invalid.  However, peeling back the onion, the
> code is still correct and we still can't seed the capability chain
> with ID 0, unless we want to muck with using the version number to
> force the header to be non-zero, which is much uglier to deal with.
> The comment also now covers some of the subtleties of using cap ID 0,
> such as transparently indicating absence of capabilities if none are
> added.  This doesn't detract from the correctness of the referenced
> commit as vfio in the kernel also uses capability ID zero to mask
> capabilties.  In fact, we should skip zero capabilities precisely
> because the kernel might also expose such a capability at the head
> position and re-introduce the problem.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/vfio/pci.c |   31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index f2ba9b6cfafc..03a3d0154976 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1880,16 +1880,26 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>      /*
>       * Extended capabilities are chained with each pointing to the next, so we
>       * can drop anything other than the head of the chain simply by modifying
> -     * the previous next pointer.  For the head of the chain, we can modify the
> -     * capability ID to something that cannot match a valid capability.  ID
> -     * 0 is reserved for this since absence of capabilities is indicated by
> -     * 0 for the ID, version, AND next pointer.  However, pcie_add_capability()
> -     * uses ID 0 as reserved for list management and will incorrectly match and
> -     * assert if we attempt to pre-load the head of the chain with this ID.
> -     * Use ID 0xFFFF temporarily since it is also seems to be reserved in
> -     * part for identifying absence of capabilities in a root complex register
> -     * block.  If the ID still exists after adding capabilities, switch back to
> -     * zero.  We'll mark this entire first dword as emulated for this purpose.
> +     * the previous next pointer.  Seed the head of the chain here such that
> +     * we can simply skip any capabilities we want to drop below, regardless
> +     * of their position in the chain.  If this stub capability still exists
> +     * after we add the capabilities we want to expose, update the capability
> +     * ID to zero.  Note that we cannot seed with the capability header being
> +     * zero as this conflicts with definition of an absent capability chain
> +     * and prevents capabilities beyond the head of the list from being added.
> +     * By replacing the dummy capability ID with zero after walking the device
> +     * chain, we also transparently mark extended capabilities as absent if
> +     * no capabilities were added.  Note that the PCIe spec defines an absence
> +     * of extended capabilities to be determined by a value of zero for the
> +     * capability ID, version, AND next pointer.  A non-zero next pointer
> +     * should be sufficient to indicate additional capabilities are present,
> +     * which will occur if we call pcie_add_capability() below.  The entire
> +     * first dword is emulated to support this.
> +     *
> +     * NB. The kernel side does similar masking, so be prepared that our
> +     * view of the device may also contain a capability ID zero in the head
> +     * of the chain.  Skip it for the same reason that we cannot seed the
> +     * chain with a zero capability.
>       */
>      pci_set_long(pdev->config + PCI_CONFIG_SPACE_SIZE,
>                   PCI_EXT_CAP(0xFFFF, 0, 0));
> @@ -1915,6 +1925,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>                                     PCI_EXT_CAP_NEXT_MASK);
>  
>          switch (cap_id) {
> +        case 0: /* kernel masked capability */
>          case PCI_EXT_CAP_ID_SRIOV: /* Read-only VF BARs confuse OVMF */
>          case PCI_EXT_CAP_ID_ARI: /* XXX Needs next function virtualization */
>              trace_vfio_add_ext_cap_dropped(vdev->vbasedev.name, cap_id, next);
> 

Reviewed-by: Peter Xu <peterx@redhat.com>

Since this bug is originally reported by Jintack, maybe we can also
add:

Reported-by: Jintack Lim <jintack@cs.columbia.edu>

Jintack, if you want to test it and provide your tested-by, it would
be nice as well. ;)

Actually I just found that the bug still exist after Michael's fix (I
thought it was fixed). So we definitely need this patch or equivalent.
However, I would still slightly prefer removing the wrapping hack
since after all we need to touch it (and I do feel like that's error
prone...). So, Alex, do you like below one instead?

--------8<----------
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 332f41d..6942c1d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1877,25 +1877,6 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
      */
     config = g_memdup(pdev->config, vdev->config_size);

-    /*
-     * Extended capabilities are chained with each pointing to the next, so we
-     * can drop anything other than the head of the chain simply by modifying
-     * the previous next pointer.  For the head of the chain, we can modify the
-     * capability ID to something that cannot match a valid capability.  ID
-     * 0 is reserved for this since absence of capabilities is indicated by
-     * 0 for the ID, version, AND next pointer.  However, pcie_add_capability()
-     * uses ID 0 as reserved for list management and will incorrectly match and
-     * assert if we attempt to pre-load the head of the chain with this ID.
-     * Use ID 0xFFFF temporarily since it is also seems to be reserved in
-     * part for identifying absence of capabilities in a root complex register
-     * block.  If the ID still exists after adding capabilities, switch back to
-     * zero.  We'll mark this entire first dword as emulated for this purpose.
-     */
-    pci_set_long(pdev->config + PCI_CONFIG_SPACE_SIZE,
-                 PCI_EXT_CAP(0xFFFF, 0, 0));
-    pci_set_long(pdev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
-    pci_set_long(vdev->emulated_config_bits + PCI_CONFIG_SPACE_SIZE, ~0);
-
     for (next = PCI_CONFIG_SPACE_SIZE; next;
          next = PCI_EXT_CAP_NEXT(pci_get_long(config + next))) {
         header = pci_get_long(config + next);
@@ -1910,24 +1891,33 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
          */
         size = vfio_ext_cap_max_size(config, next);

-        /* Use emulated next pointer to allow dropping extended caps */
-        pci_long_test_and_set_mask(vdev->emulated_config_bits + next,
-                                   PCI_EXT_CAP_NEXT_MASK);
+        /* Use emulated header to allow dropping extended caps */
+        pci_set_long(vdev->emulated_config_bits + next, 0xffffffffULL);

         switch (cap_id) {
         case PCI_EXT_CAP_ID_SRIOV: /* Read-only VF BARs confuse OVMF */
         case PCI_EXT_CAP_ID_ARI: /* XXX Needs next function virtualization */
+        case PCI_EXT_CAP_ID_VC:
+            /*
+             * For dropped capabilities, we keep their slot but
+             * replace them with a header containing cap_id=0 &&
+             * cap_ver=1. We do this reservation mostly to make sure
+             * the head ecap (at offset 0x100) will always be there.
+             * Anyway it won't hurt if we keep the rest of the dropped
+             * ones as well.
+             *
+             * Here we use non-zero cap_ver because we want to "mark"
+             * this ecap as "available" - from PCIe spec (chap 7.9.1),
+             * it marked out that cap_id=cap_ver=next=0 means empty
+             * ecap, and we really don't want it to be an "empty" slot
+             * especially for the head ecap (we need a head, always!).
+             */
+            pcie_add_capability(pdev, 0, 1, next, size);
             trace_vfio_add_ext_cap_dropped(vdev->vbasedev.name, cap_id, next);
             break;
         default:
             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
         }
-
-    }
-
-    /* Cleanup chain head ID if necessary */
-    if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
-        pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
     }

     g_free(config);
------->8--------

The new patch will keep all the dropped ecaps (so we may see more than
one cap_id=0x0000 field), which I don't know whether would be a
drawback. OTOH, it provides benefits like:

- we can remove the wrapping hack, so the code is much readable and
  less error prone imho

- we can avoid using the assumption that 0xffff cap_id is reserved

I can live with both patches though. :-)

Thanks!

-- peterx
