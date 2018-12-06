Received: from eggs.gnu.org ([2001:4830:134:3::10]:60618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUw5R-0006pW-Q5
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gUw5N-0001hi-Hf
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:01:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gUw5N-0001d6-6i
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 11:01:09 -0500
Date: Thu, 6 Dec 2018 09:00:44 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181206090044.7f22a365@x1.home>
In-Reply-To: <f8971f03-82bc-3207-c6c7-d816aa0d6052@redhat.com>
References: <154393964026.28192.13536237934563059985.stgit@gimli.home>
	<154394079441.28192.15583995529917119293.stgit@gimli.home>
	<f8971f03-82bc-3207-c6c7-d816aa0d6052@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [for-4.0 PATCH v3 5/9] pcie: Fill PCIESlot link
 fields to support higher speeds and widths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Geoffrey McRae <geoff@hostfission.com>, "Michael
	S. Tsirkin" <mst@redhat.com>

On Thu, 6 Dec 2018 12:08:09 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 12/4/18 5:26 PM, Alex Williamson wrote:
> > Make use of the PCIESlot speed and width fields to update link
> > information beyond those configured in pcie_cap_v1_fill().  This is
> > only called for devices supporting a version 2 capability and
> > automatically skips any non-PCIESlot devices.  Only devices with
> > increased link values generate any visible config space differences.
> > 
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Tested-by: Geoffrey McRae <geoff@hostfission.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  hw/pci/pcie.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> > 
> > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > index 61b7b96c52cd..556ec19925b9 100644
> > --- a/hw/pci/pcie.c
> > +++ b/hw/pci/pcie.c
> > @@ -27,6 +27,7 @@
> >  #include "hw/pci/msi.h"
> >  #include "hw/pci/pci_bus.h"
> >  #include "hw/pci/pcie_regs.h"
> > +#include "hw/pci/pcie_port.h"
> >  #include "qemu/range.h"
> >  
> >  //#define DEBUG_PCIE
> > @@ -87,6 +88,74 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
> >      pci_set_word(cmask + PCI_EXP_LNKSTA, 0);
> >  }
> >  
> > +static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
> > +{
> > +    PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
> > +    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
> > +
> > +    /* Skip anything that isn't a PCIESlot */
> > +    if (!s) {
> > +        return;
> > +    }
> > +
> > +    /* Clear and fill LNKCAP from what was configured above */
> > +    pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
> > +                                 PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
> > +    pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
> > +                               QEMU_PCI_EXP_LNKCAP_MLW(s->width) |
> > +                               QEMU_PCI_EXP_LNKCAP_MLS(s->speed));
> > +
> > +    /*
> > +     * Link bandwidth notification is required for all root ports and
> > +     * downstream ports supporting links wider than x1.  
> 
> 
> > +     */
> > +    if (s->width > QEMU_PCI_EXP_LNK_X1) {
> > +        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
> > +                                   PCI_EXP_LNKCAP_LBNC);  
> spec also says "This capability is required for all Root
> Ports and Switch Downstream Ports supporting Links wider than
> x1 and/or multiple Link speeds."
> 
> I see below you are likely to report several speed vectors if speed >
> 5GT/s so you may also add a test on the speed.

Good catch, so I'll change the above test to:

    if (s->width > QEMU_PCI_EXP_LNK_X1 ||
        s->speed > QEMU_PCI_EXP_LNK_2_5GT) {

> How are the device types checked?

Via the object_dynamic_cast() at the top of the function, we'll drop
anything that isn't a descendant of TYPE_PCIE_SLOT.

> > +    }
> > +
> > +    if (s->speed > QEMU_PCI_EXP_LNK_2_5GT) {
> > +        /*
> > +         * Hot-plug capable downstream ports and downstream ports supporting
> > +         * link speeds greater than 5GT/s must hardwire PCI_EXP_LNKCAP_DLLLARC
> > +         * to 1b.  PCI_EXP_LNKCAP_DLLLARC implies PCI_EXP_LNKSTA_DLLLA, which
> > +         * we also hardwire to 1b here.  2.5GT/s hot-plug slots should also
> > +         * technically implement this, but it's not done here for compatibility.
> > +         */
> > +        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP,
> > +                                   PCI_EXP_LNKCAP_DLLLARC);
> > +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
> > +                                   PCI_EXP_LNKSTA_DLLLA);
> > +
> > +        /*
> > +         * Target Link Speed defaults to the highest link speed supported by
> > +         * the component.  2.5GT/s devices are permitted to hardwire to zero.
> > +         */
> > +        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKCTL2,
> > +                                     PCI_EXP_LNKCTL2_TLS);
> > +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKCTL2,
> > +                                   QEMU_PCI_EXP_LNKCAP_MLS(s->speed) &
> > +                                   PCI_EXP_LNKCTL2_TLS);
> > +    }
> > +
> > +    /*
> > +     * 2.5 & 5.0GT/s can be fully described by LNKCAP, but 8.0GT/s is
> > +     * actually a reference to the highest bit supported in this register.
> > +     * We assume the device supports all link speeds.
> > +     */
> > +    if (s->speed > QEMU_PCI_EXP_LNK_5GT) {
> > +        pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP2, ~0U);
> > +        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
> > +                                   PCI_EXP_LNKCAP2_SLS_2_5GB |
> > +                                   PCI_EXP_LNKCAP2_SLS_5_0GB |
> > +                                   PCI_EXP_LNKCAP2_SLS_8_0GB);
> > +        if (s->speed > QEMU_PCI_EXP_LNK_8GT) {
> > +            pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKCAP2,
> > +                                       PCI_EXP_LNKCAP2_SLS_16_0GB);  
> I fail to understand why for 5GB you don't see both 2.5 and 5 as well.

Because there was a bit of a glitch in the PCIe 2.0 spec where lnkcap2
is listed as a placeholder, so a strictly gen2 device doesn't need to
implement lnkcap2.  In gen1, lnkcap supported link speeds (SLS) vector
defined 0001b for 2.5GT/s, gen2 came along and defined 0010b for
2.5GT/s AND 5GT/s, then in the 3.0 spec they decided to slightly
re-purpose this and SLS became MLS (max link speed), and introduced
lnkcap2 to indicate which speeds were supported.  So the original spec
definition of SLS didn't really give hardware the flexibility if they
should decide they don't want to validate intermediate link speeds.
Thanks,

Alex

> > +        }
> > +    }
> > +}
> > +
> >  int pcie_cap_init(PCIDevice *dev, uint8_t offset,
> >                    uint8_t type, uint8_t port,
> >                    Error **errp)
> > @@ -108,6 +177,9 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
> >      /* Filling values common with v1 */
> >      pcie_cap_v1_fill(dev, port, type, PCI_EXP_FLAGS_VER2);
> >  
> > +    /* Fill link speed and width options */
> > +    pcie_cap_fill_slot_lnk(dev);
> > +
> >      /* Filling v2 specific values */
> >      pci_set_long(exp_cap + PCI_EXP_DEVCAP2,
> >                   PCI_EXP_DEVCAP2_EFF | PCI_EXP_DEVCAP2_EETLPP);
> > 
> >   
> 
> Thanks
> 
> Eric
