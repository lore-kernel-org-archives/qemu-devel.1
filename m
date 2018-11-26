Received: from eggs.gnu.org ([2001:4830:134:3::10]:57948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gR6EN-00062O-Bh
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 21:02:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1gR6EJ-00071V-AO
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 21:02:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:14139)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1gR6EJ-0006zD-1J
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 21:02:31 -0500
Date: Sun, 25 Nov 2018 20:58:07 -0500
From: Zhao Yan <yan.y.zhao@intel.com>
Message-ID: <20181126015807.GA17765@joy-OptiPlex-7040>
References: <20181016021439.6212-1-yan.y.zhao@intel.com>
	<F22B14EC3CFBB843AD3E03B6B78F2C6A4ACFD80C@SHSMSX104.ccr.corp.intel.com>
	<20181018145636.k6ptvn4iszabjhxw@mac.bytemobile.com>
	<20181122131110.GA31906@joy-OptiPlex-7040>
	<20181122141805.vyqywi4ep65loye3@mac>
	<20181123050451.GC31906@joy-OptiPlex-7040>
	<20181123101919.twxrmehljvyhuii6@mac>
	<5BF7D5E402000078001FF501@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5BF7D5E402000078001FF501@prv1-mh.provo.novell.com>
Subject: Re: [Qemu-devel] [PATCH] Xen PCI passthrough: fix passthrough
 failure when irq map failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Beulich <JBeulich@suse.com>
Cc: Roger Pau Monne <roger.pau@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, qemu-devel@nongnu.org

Hi Roger and Jan,
Thanks for your review. You are right.
I'll try the way to report PCI_INTERRUPT_PIN as 0 to the guest.

Thanks
Yan

On Fri, Nov 23, 2018 at 03:26:44AM -0700, Jan Beulich wrote:
> >>> On 23.11.18 at 11:19, <roger.pau@citrix.com> wrote:
> > Adding Jan in case he has an opinion on my reply below.
> 
> I agree, fwiw.
> 
> Jan
> 
> > On Fri, Nov 23, 2018 at 12:04:51AM -0500, Zhao Yan wrote:
> >> On Thu, Nov 22, 2018 at 03:18:05PM +0100, Roger Pau Monné wrote:
> >> > On Thu, Nov 22, 2018 at 08:11:20AM -0500, Zhao Yan wrote:
> >> > > On Thu, Oct 18, 2018 at 03:56:36PM +0100, Roger Pau Monné wrote:
> >> > > > On Thu, Oct 18, 2018 at 08:22:41AM +0000, Zhao, Yan Y wrote:
> >> > > > > Hi
> >> > > > > The background for this patch is that: for some pci device, even it's PCI_INTERRUPT_PIN is not 0, it
> actually does not support INTx mode, so we should just report error, disable INTx mode and continue the passthrough.
> >> > > > > However, the commit 5a11d0f7 regards this as error condition and let qemu quit passthrough, which is too
> rigorous.
> >> > > > > 
> >> > > > > Error message is below:
> >> > > > > libxl: error: libxl_qmp.c:287:qmp_handle_error_response: Domain 2:received an error message from QMP server:
> Mapping machine irq 0 to pirq -1 failed: Operation not permitted
> >> > > > 
> >> > > > I'm having issues figuring out what's happening here.
> >> > > > s->real_device.irq is 0, yet the PCI config space read of
> >> > > > PCI_INTERRUPT_PIN returns something different than 0.
> >> > > > 
> >> > > > AFAICT this is due to some kind of error in Linux, so that even when
> >> > > > the device is supposed to have a valid IRQ the sysfs node it is set to
> >> > > > 0, do you know the actual underlying cause of this?
> >> > > > 
> >> > > > Thanks, Roger.
> >> > > Hi Roger
> >> > > Sorry for the later reply, I just missed this mail...
> >> > > On my side, it's because the hardware actually does not support INTx mode,
> >> > > but its configuration space does not report PCI_INTERRUPT_PIN to 0. It's a
> >> > > hardware bug, but previous version of qemu can tolerate it, switch to MSI
> >> > > and make passthrough work.
> >> > 
> >> > Then I think it would be better to check both PCI_INTERRUPT_PIN and
> >> > s->real_device.irq before attempting to map the IRQ.
> >> > 
> >> > Making the error non-fatal would mean that a device with a valid IRQ
> >> > could fail to be setup correctly but the guest will still be created,
> >> > and things won't go as expected when the guest attempts to use it.
> >> > 
> >> > Thanks, Roger.
> >> hi roger
> >> thanks for your sugguestion. it's right that "s->real_device.irq" is needed to be checked before mapping, like if
> it's 0.
> >> but on the other hand, maybe xc_physdev_map_pirq() itself can serve as a checking of "s->real_device.irq" ?
> >> like in our case, it will fail and return -EPERM.
> >> then error hanling is still conducted ==>set INTX_DISABLE flag, eventhrough the error is not fatal.
> >> 
> >>     machine_irq = s->real_device.irq;
> >>     rc = xc_physdev_map_pirq(xen_xc, xen_domid, machine_irq, &pirq);
> >>     if (rc < 0) {
> >>         error_setg_errno(errp, errno, "Mapping machine irq %u to"
> >>                          " pirq %i failed", machine_irq, pirq);
> >> 
> >>         /* Disable PCI intx assertion (turn on bit10 of devctl) */
> >>         cmd |= PCI_COMMAND_INTX_DISABLE;
> >>         machine_irq = 0;
> >>         s->machine_irq = 0;
> >> So, do you think it's all right just converting fatal error to non-fatal?
> > 
> > As I said above, I think it would be better to leave the error as
> > fatal and avoid attempting a xc_physdev_map_pirq with a machine_irq ==
> > 0, which will fail.
> > 
> > If we really want to go down the route of making the error non-fatal,
> > I think you will also have to report PCI_INTERRUPT_PIN as 0 to the
> > guest, so that it's clear to the guest that the device doesn't have
> > legacy interrupt support.
> > 
> > Exposing a device with PCI_INTERRUPT_PIN != 0 but then not allowing
> > the guest to clear PCI_COMMAND_INTX_DISABLE is likely bogus.
> > 
> > Thanks, Roger.
> 
> 
> 
