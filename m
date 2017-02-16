Received: from eggs.gnu.org ([2001:4830:134:3::10]:43578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceBoQ-0006iX-1E
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ceBoM-0005sD-U5
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:28:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ceBoM-0005s6-Ii
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 21:28:46 -0500
Date: Thu, 16 Feb 2017 10:28:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170216022839.GC15985@pxdev.xzpeter.org>
References: <20170208031216.GA5151@pxdev.xzpeter.org>
	<CAHyh4xg7NVPjXu3c+xGWNzQqwLgFqFJTPo4SgN-X+FNuHjGihQ@mail.gmail.com>
	<CAHyh4xhOPmfLoU_fvtbBF1Wqbzji9q6rp_bRN38qfnwvhQq+9A@mail.gmail.com>
	<20170209035250.GB22153@pxdev.xzpeter.org>
	<CAHyh4xi9KZm13mJnE3-EyYkkyN4YDKKwbeJ68AumCBM7kgr+MQ@mail.gmail.com>
	<20170214073551.GA9055@pxdev.xzpeter.org>
	<CAHyh4xiATAV801U7zjK1F_B+7e2bDWhH1-gpFKF3U1jNmCfScw@mail.gmail.com>
	<20170215025243.GA3988@pxdev.xzpeter.org>
	<20170215033452.GB3988@pxdev.xzpeter.org>
	<20170215111552.5405418a@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170215111552.5405418a@t450s.home>
Subject: Re: [Qemu-devel] iommu emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Jintack Lim <jintack@cs.columbia.edu>, mst@redhat.com, QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Wed, Feb 15, 2017 at 11:15:52AM -0700, Alex Williamson wrote:

[...]

> > Alex, do you like something like below to fix above issue that Jintack
> > has encountered?
> > 
> > (note: this code is not for compile, only trying show what I mean...)
> > 
> > ------8<-------
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 332f41d..4dca631 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -1877,25 +1877,6 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> >       */
> >      config = g_memdup(pdev->config, vdev->config_size);
> > 
> > -    /*
> > -     * Extended capabilities are chained with each pointing to the next, so we
> > -     * can drop anything other than the head of the chain simply by modifying
> > -     * the previous next pointer.  For the head of the chain, we can modify the
> > -     * capability ID to something that cannot match a valid capability.  ID
> > -     * 0 is reserved for this since absence of capabilities is indicated by
> > -     * 0 for the ID, version, AND next pointer.  However, pcie_add_capability()
> > -     * uses ID 0 as reserved for list management and will incorrectly match and
> > -     * assert if we attempt to pre-load the head of the chain with this ID.
> > -     * Use ID 0xFFFF temporarily since it is also seems to be reserved in
> > -     * part for identifying absence of capabilities in a root complex register
> > -     * block.  If the ID still exists after adding capabilities, switch back to
> > -     * zero.  We'll mark this entire first dword as emulated for this purpose.
> > -     */
> > -    pci_set_long(pdev->config + PCI_CONFIG_SPACE_SIZE,
> > -                 PCI_EXT_CAP(0xFFFF, 0, 0));
> > -    pci_set_long(pdev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
> > -    pci_set_long(vdev->emulated_config_bits + PCI_CONFIG_SPACE_SIZE, ~0);
> > -
> >      for (next = PCI_CONFIG_SPACE_SIZE; next;
> >           next = PCI_EXT_CAP_NEXT(pci_get_long(config + next))) {
> >          header = pci_get_long(config + next);
> > @@ -1917,6 +1898,8 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> >          switch (cap_id) {
> >          case PCI_EXT_CAP_ID_SRIOV: /* Read-only VF BARs confuse OVMF */
> >          case PCI_EXT_CAP_ID_ARI: /* XXX Needs next function virtualization */
> > +            /* keep this ecap header (4 bytes), but mask cap_id to 0xffff */
> > +            ...
> >              trace_vfio_add_ext_cap_dropped(vdev->vbasedev.name, cap_id, next);
> >              break;
> >          default:
> > @@ -1925,11 +1908,6 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> > 
> >      }
> > 
> > -    /* Cleanup chain head ID if necessary */
> > -    if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) == 0xFFFF) {
> > -        pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
> > -    }
> > -
> >      g_free(config);
> >      return;
> >  }
> > ----->8-----  
> > 
> > Since after all we need the assumption that 0xffff is reserved for
> > cap_id. Then, we can just remove the "first 0xffff then 0x0" hack,
> > which is imho error-prone and hacky.
> 
> This doesn't fix the bug, which is that pcie_add_capability() uses a
> valid capability ID for it's own internal tracking.  It's only doing
> this to find the end of the capability chain, which we could do in a
> spec complaint way by looking for a zero next pointer.  Fix that and
> then vfio doesn't need to do this set to 0xffff then back to zero
> nonsense at all.  Capability ID zero is valid.  Thanks,

Yeah I see Michael's fix on the capability list stuff. However, imho
these are two different issues? Or say, even if with that patch, we
should still need this hack (first 0x0, then 0xffff) right? Since
looks like that patch didn't solve the problem if the first pcie ecap
is masked at 0x100.

Please correct me if I missed anything. Thanks,

-- peterx
