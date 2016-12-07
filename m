Received: from eggs.gnu.org ([2001:4830:134:3::10]:48746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cEckt-0005vY-8d
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cEckk-0003Nl-7O
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 08:59:26 -0500
Date: Wed, 7 Dec 2016 11:59:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161207135917.GI4027@thinpad.lan.raisama.net>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206191952.GD4027@thinpad.lan.raisama.net>
	<20161206193159.GE4027@thinpad.lan.raisama.net>
	<20161207143925.7b3a54f2@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161207143925.7b3a54f2@bahia>
Subject: Re: [Qemu-devel] [RFC for-2.8] machine: Convert abstract typename
 on compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Dec 07, 2016 at 02:39:25PM +0100, Greg Kurz wrote:
> On Tue, 6 Dec 2016 17:31:59 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Tue, Dec 06, 2016 at 05:19:52PM -0200, Eduardo Habkost wrote:
> > > On Tue, Dec 06, 2016 at 06:50:47PM +0100, Greg Kurz wrote:  
> > > > Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour", passing
> > > > -device virtio-blk-pci.disable-modern=off has no effect on 2.6 machine
> > > > types because the internal virtio-pci.disable-modern=on compat property
> > > > always prevail.
> > > > 
> > > > This should ideally be fixed in the qdev properties core code, but it is
> > > > too late in the QEMU 2.8 schedule. So this patch fixes the issue by setting
> > > > the compat properties for every virtio-*-pci subtypes instead of the base
> > > > virtio-pci type.
> > > > 
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>  
> > > 
> > > So, it looks like the bug is present in many other cases...
> > > 
> > > I have hacked QEMU to print a warning in case the driver name in
> > > compat_props refer to an abstract class or a class that have any
> > > subclasses. The results are below:
> > > 
> > >  apic-common.legacy-instance-id set for abstract class
> > >  apic-common.vapic set for abstract class
> > >  i386-cpu.arat set for abstract class
> > >  i386-cpu.check set for abstract class
> > >  i386-cpu.cpuid-0xb set for abstract class
> > >  i386-cpu.fill-mtrr-mask set for abstract class
> > >  i386-cpu.full-cpuid-auto-level set for abstract class
> > >  i386-cpu.l3-cache set for abstract class
> > >  i386-cpu.pmu set for abstract class
> > >  pci-device.command_serr_enable set for abstract class
> > >  pci-device.rombar set for abstract class
> > >  pci-device.x-pcie-lnksta-dllla set for abstract class
> > >  powerpc64-cpu.pre-2.8-migration set for abstract class
> > >  s390-skeys.migration-enabled set for abstract class
> > >  spapr-pci-host-bridge.ddw set for superclass
> > >  spapr-pci-host-bridge.dynamic-reconfiguration set for superclass
> > >  spapr-pci-host-bridge.mem64_win_size set for superclass
> > >  spapr-pci-host-bridge.mem_win_size set for superclass
> > >  spapr-pci-host-bridge.pre-2.8-migration set for superclass
> > >  usb-device.full-path set for abstract class
> > >  usb-device.msos-desc set for abstract class
> > >  virtio-pci.disable-legacy set for abstract class
> > >  virtio-pci.disable-modern set for abstract class
> > >  virtio-pci.migrate-extra set for abstract class
> > >  virtio-pci.page-per-vq set for abstract class
> > >  virtio-pci.virtio-pci-bus-master-bug-migration set for abstract class
> > >  virtio-pci.x-disable-pcie set for abstract class
> > >  x86_64-cpu.arat set for abstract class
> > >  x86_64-cpu.check set for abstract class
> > >  x86_64-cpu.cpuid-0xb set for abstract class
> > >  x86_64-cpu.fill-mtrr-mask set for abstract class
> > >  x86_64-cpu.full-cpuid-auto-level set for abstract class
> > >  x86_64-cpu.l3-cache set for abstract class
> > >  x86_64-cpu.pmu set for abstract class
> > > 
> > > I believe the cases where we are likely to cause real-world bugs
> > > are virtio-pci and the *-cpu classes (because -cpu is translated
> > > to -global).
> > > 
> > > I'm not sure what should be the right fix in 2.8. I am
> > > considering a temporary hack to translate abstract class names in
> > > compat_props to global properties for all subclasses, in case
> > > they refer to an abstract class. This way we fix the bug where
> > > -global doesn't override compat_props properly, but keep the
> > > rules for -global untouched.  
> > 
> > What about this?
> > 
> 
> Indeed that would have been a clever workaround but it is too late anyway. :)
> 
> BTW, that makes me think about Halil's comment in another mail, even if it
> is not strictly related to the comapt issue (but rather because I mentioned
> it in the changelog of my first patch):
> 
> "So I can't even tell if -global virtio-pci.disable-modern=off is even legit
> on the command line."
> 
> And indeed, -device doesn't accept abstract classes... shouldn't -global
> prohibit setting properties for them ?

I'm not sure. Setting disable-modern for all virtio-pci devices
with a single -global option sounds very useful, for example.

Also, if we start rejecting it we risk breaking existing
configurations. We would need to deprecate it first (making it
print a warning) and reject it a few releases later.

-- 
Eduardo
