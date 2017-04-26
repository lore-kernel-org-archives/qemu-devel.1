Received: from eggs.gnu.org ([2001:4830:134:3::10]:59151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d3ATu-0002Dx-RL
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 20:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d3ATq-0002V4-PA
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 20:06:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d3ATq-0002Tb-FR
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 20:06:50 -0400
Date: Tue, 25 Apr 2017 18:06:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170425180645.3aa72ec6@w520.home>
In-Reply-To: <20170425230516-mutt-send-email-mst@kernel.org>
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1490260163-6157-4-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161224.270f334e@t450s.home>
	<58DA69DD.2060203@cn.fujitsu.com>
	<20170328101225.5772b33a@t450s.home>
	<20170329025512-mutt-send-email-mst@kernel.org>
	<20170328205504.1277d460@t450s.home>
	<20170425230516-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] vfio-pci: process non fatal error
 of AER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: izumi.taku@jp.fujitsu.com, Cao jin <caoj.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, Dou Liyang <douly.fnst@cn.fujitsu.com>

On Tue, 25 Apr 2017 23:32:52 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Mar 28, 2017 at 08:55:04PM -0600, Alex Williamson wrote:
> > On Wed, 29 Mar 2017 02:59:34 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Tue, Mar 28, 2017 at 10:12:25AM -0600, Alex Williamson wrote:  
> > > > On Tue, 28 Mar 2017 21:49:17 +0800
> > > > Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> > > >     
> > > > > On 03/25/2017 06:12 AM, Alex Williamson wrote:    
> > > > > > On Thu, 23 Mar 2017 17:09:23 +0800
> > > > > > Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> > > > > >       
> > > > > >> Make use of the non fatal error eventfd that the kernel module provide
> > > > > >> to process the AER non fatal error. Fatal error still goes into the
> > > > > >> legacy way which results in VM stop.
> > > > > >>
> > > > > >> Register the handler, wait for notification. Construct aer message and
> > > > > >> pass it to root port on notification. Root port will trigger an interrupt
> > > > > >> to signal guest, then guest driver will do the recovery.      
> > > > > > 
> > > > > > Can we guarantee this is the better solution in all cases or could
> > > > > > there be guests without AER support where the VM stop is the better
> > > > > > solution?
> > > > > >       
> > > > > 
> > > > > Currently, we only have VM stop on errors, that looks the same as a
> > > > > sudden power down to me.  With this solution, we have about
> > > > > 50%(non-fatal) chance to reduce the sudden power-down risk.    
> > > > 
> > > > If half of all faults are expected to be non-fatal, then you must have
> > > > some real examples of devices triggering non-fatal errors which can be
> > > > corrected in the guest driver that you can share to justify why it's a
> > > > good thing to enable this behavior.
> > > >     
> > > > > What if a guest doesn't support AER?  It looks the same as a host
> > > > > without AER support. Now I only can speculate the worst condition: guest
> > > > > crash, would that be quite different from a sudden power-down?    
> > > > 
> > > > Yes, it's very different.  In one case we contain the fault by stopping
> > > > the guest, in the other case we allow the guest to continue operating
> > > > with a known fault in the device which may allow the fault to propagate
> > > > and perhaps go unnoticed.  We have established with the current
> > > > behavior that QEMU will prevent further propagation of a fault by
> > > > halting the VM.  To change QEMU's behavior here risks that a VM relying
> > > > on that behavior no longer has that protection.  So it seems we either
> > > > need to detect whether the VM is handling AER or we need to require the
> > > > VM administrator to opt-in to this new feature.    
> > > 
> > > An opt-in flag sounds very reasonable. It can also specify whether
> > > to log the errors. We have a similar flag for disk errors.  
> > 
> > An opt-in works, but is rather burdensome to the user.
> >    
> > > >  Real hardware has
> > > > these same issues and I believe there are handshakes that can be done
> > > > through ACPI to allow the guest to take over error handling from the
> > > > system.    
> > > 
> > > No, that's only for error reporting IIUC. Driver needs to be
> > > aware of a chance for errors to trigger and be able to
> > > handle them.  
> > 
> > See drivers/acpi/pci_root.c:negotiate_os_control(), it seems that the
> > OSPM uses an _OSC to tell ACPI via OSC_PCI_EXPRESS_AER_CONTROL.  Would
> > that not be a reasonable mechanism for the guest to indicate AER
> > support?  
> 
> I'm not sure - it seems to be designed for firmware that can drive
> AER natively. E.g. if we ever set FIRMWARE_FIRST then linux
> will not set this bit.
> 
> It's also global so doesn't really indicate a given driver
> supports AER.
> 
> Still - would this remove some or all of your concern?

Certainly not all, I have rather deep concerns about where we're going
here.

> Could you outline a set of requirements that can be satisfied
> to make you consider the feature for inclusion?

Like any enhancement, show me that it's useful, show me that we've done
due diligence in researching the problem and solution, show me that
we're not painting ourselves into a corner by only addressing a subset
of the problem, show me that it's been thoroughly tested and reviewed.
Currently, I have little confidence in any of this.  We seem to just be
tossing AER spitballs at the wall hoping one of them sticks.
 
> I tried by writing up
> 	vfio/pci: guest error recovery proposal
> back in December and there didn't seem to be any objections, so I am
> quite surprised to see patches implementing that proposal more or less
> verbatim getting rejected.

Are the concerns from the patch review not valid?  I think this is
indicative of the problems we've had throughout this 2+ year
development process, a suggestion is made and it's implemented without
a thorough analysis of the surrounding issues (or even testing), patches
are sent out, issues are found, further suggestions are made, and a new
revision comes out with the same lack of insight.  Rinse, repeat.  It's
effectively writing patches by proxy.
 
> Could you write up a proposal of your own? It shouldn't take
> long but I don't believe progress can be made otherwise.

Why do you make it sound like this should be an easy task?  Clearly the
problem is hard and a cursory proposal only feeds into the process I
mention above.  If someone wants to make a legitimate attempt at
improving this space, I feel like they really need to own the problem
themselves, invest in the research to figure out all the nuances.

> Please note that at least in Linux most driver developers
> test using software error injection. Documentation/PCI/pcieaer-howto.txt
> actually says:
> 
> 	4. Software error injection
> 
> 	Debugging PCIe AER error recovery code is quite difficult because it
> 	is hard to trigger real hardware errors. Software based error
> 	injection can be used to fake various kinds of PCIe errors.
> 
> it might be that even though yes, we'd prefer real testing
> we just might have to be satisfied with software injection.

Of course artificial AER injection is the way to go for testing.  I
don't expect someone to stick a wet finger into a system to try to
generate transient hardware failures, but I do expect more testing than
we've seen in the past.

Really, to make progress in this space I think we need to first
determine the actual problem we're trying to solve.  Are non-fatal
errors really a significant problem to tackle on their own or are we
just trying to appease the patch submitter by helping to get anything
AER related upstream?  I don't think that really helps anyone long
term.  So what if we return to full AER support?  We were stuck on bus
resets and how to coordinate host recovery resets vs guest resets. It's
clearly a hard problem and your approach was to avoid it by handling a
sub-class of errors for which bus resets are perhaps unnecessary.  What
if instead of a sub-class of errors, we pick a sub-class of devices for
which there's no such thing as a bus reset.  Aren't SR-IOV VFs really
designed for this use case?  I think with RAS features we're really
targeting the enterprise use cases, where VFs are (or should be) the
predominant class of device.  Would this work?  I don't know, and I
really don't want this to be just another idea that gets caught in the
cyclic rut we're stuck in so far.  If someone wants to pursue this I'd
expect to see some research into how errors are propagated from PF to
VF and certainly testing on relevant hardware.  Thanks,

Alex
