Received: from eggs.gnu.org ([2001:4830:134:3::10]:57862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOz6n-0001oe-Gj
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 22:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cOz6i-000289-KK
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 22:52:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cOz6i-000271-Bd
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 22:52:52 -0500
Date: Thu, 5 Jan 2017 11:52:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170105035244.GO22664@pxdev.xzpeter.org>
References: <1482400096-23078-1-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190BF810D@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190BF810D@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: allow dynamic switch of
 IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>

Hi, Kevin,

On Thu, Jan 05, 2017 at 03:30:28AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Thursday, December 22, 2016 5:48 PM
> > 
> > This is preparation work to finally enabled dynamic switching ON/OFF for
> > VT-d protection. The old VT-d codes is using static IOMMU region, and
> > that won't satisfy vfio-pci device listeners.
> 
> Is "IOMMU address space" more accurate than "IOMMU region" here,
> based on following description and actual code?

Sounds reasonable. Will fix.

(I have merged this patch with the VT-d vfio enablement series, so
 will change there rather than sending another standalone patch for
 this one)

> 
> > 
> > Let me explain.
> > 
> > vfio-pci devices depend on the memory region listener and IOMMU replay
> > mechanism to make sure the device mapping is coherent with the guest
> > even if there are domain switches. And there are two kinds of domain
> > switches:
> > 
> >   (1) switch from domain A -> B
> >   (2) switch from domain A -> no domain (e.g., turn DMAR off)
> > 
> > Case (1) is handled by the context entry invalidation handling by the
> > VT-d replay logic. What the replay function should do here is to replay
> > the existing page mappings in domain B.
> > 
> > However for case (2), we don't want to replay any domain mappings - we
> > just need the default GPA->HPA mappings (the address_space_memory
> > mapping). And this patch helps on case (2) to build up the mapping
> > automatically by leveraging the vfio-pci memory listeners.
> > 
> > Another important thing that this patch does is to seperate
> > IR (Interrupt Remapping) from DMAR (DMA Remapping). IR region should not
> > depend on the DMAR region (like before this patch). It should be a
> > standalone region, and it should be able to be activated without
> > DMAR (which is a common behavior of Linux kernel - by default it enables
> > IR while disabled DMAR).
> 
> Not just because Linux kernel behavior. It's the spec behavior - IR
> and DMAR can be enabled/disabled separately. :-)

Thanks to point out. I wasn't meant to emphasize on "that's specific
for Linux" - I was trying to say "the old code won't work even with
default Linux parameters". So I see no conflicts. :)

[...]

> >  /* Handle Translation Enable/Disable */
> >  static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> >  {
> > +    if (s->dmar_enabled == en) {
> > +        return;
> > +    }
> > +
> >      VTD_DPRINTF(CSR, "Translation Enable %s", (en ? "on" : "off"));
> > 
> >      if (en) {
> > @@ -1196,6 +1237,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
> >          /* Ok - report back to driver */
> >          vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0);
> >      }
> > +
> > +    vtd_switch_address_space_all(s, en);
> >  }
> 
> A context entry can be configured as pass-through, meaning no addr
> translation for DMAs from this device when IOMMU is globally enabled.
> There is no translation structure per se, so 'sys_alias" is also required
> in such configuration.

Right. But current vt-d emulation still doesn't support per-device
pass-through. See vtd_dev_to_context_entry():

    ...
    } else if (ce->lo & VTD_CONTEXT_ENTRY_TT) {
        VTD_DPRINTF(GENERAL, "error: unsupported Translation Type in "
                    "context-entry hi 0x%"PRIx64 " lo 0x%"PRIx64,
                    ce->hi, ce->lo);
        return -VTD_FR_CONTEXT_ENTRY_INV;
    }
    ...

And:

    #define VTD_CONTEXT_ENTRY_TT        (3ULL << 2) /* Translation Type */
    #define VTD_CONTEXT_TT_PASS_THROUGH 2

IMO we can add it when we support device passthrough.

Thanks,

-- peterx
