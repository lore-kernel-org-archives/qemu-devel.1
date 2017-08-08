Received: from eggs.gnu.org ([2001:4830:134:3::10]:58919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dfAMS-00032D-27
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dfAMO-0001eR-4f
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:40:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dfAMN-0001de-RD
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:40:12 -0400
Date: Tue, 8 Aug 2017 13:40:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170808134008.0648ab2e@w520.home>
In-Reply-To: <20170727115042.GL2555@redhat.com>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<CAFEAcA_t8EDNnWTeRzuHEcdfq3DJFTN3ug=DHnGvWef3=wyFzA@mail.gmail.com>
	<20170727105348.GG7970@umbus.fritz.box>
	<20170727115042.GL2555@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL
 to avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Greg Kurz <groug@kaod.org>, Markus Armbruster <armbru@redhat.com>

On Thu, 27 Jul 2017 12:50:42 +0100
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Thu, Jul 27, 2017 at 08:53:48PM +1000, David Gibson wrote:
> > On Thu, Jul 27, 2017 at 10:11:48AM +0100, Peter Maydell wrote:  
> > > On 27 July 2017 at 02:30, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:  
> > > > In particular, Mellanox CX4 adapters on PowerNV hosts might not be fully
> > > > quiesced by vfio-pci's finalize() routine until up to 6s after the
> > > > DEVICE_DELETED was emitted, leading to detach-device on the libvirt side pretty
> > > > much always crashing the host.  
> > > 
> > > My initial naive thought is that if the host kernel can crash then
> > > this is a host kernel bug... shouldn't the host kernel refuse
> > > the subsequent libvirt rebind if it would cause a crash ?  
> > 
> > I think so too, but I haven't been able to convince Alex.  Nor
> > find time to fix it in the kernel myself.  
> 
> I think we need to fix both the QEMU premature sending of DEVICE_DELETED
> and the kernel bug that allowed the crash.


Where do we stand on this for v2.10?  I'd like to see it get in.  There
may be things to fix in the kernel, some of them may already be fixed
in the latest development kernel, but ultimately the kernel considers
driver binding to be a trusted operation and if userspace doesn't
understand all the dependencies, they shouldn't be doing it.  In this
case libvirt is using the DEVICE_DELETED signal with the assumption
that the device has been fully released by QEMU, which is of course not
accurate (libvirt could test this, but chooses not to).  libvirt
therefore begins trying to unbind a device that is still in use, we try
to handle it, but see official kernel stance that userspace is
responsible for understanding device dependencies, so we can only do so
much.

IMO, the next step along those lines would be that libvirt needs to
understand that even once a device is fully released from QEMU, it's
not necessarily safe to re-bind the device to a host driver.  If the
device is a member of a group where other devices are still in use by
userspace, this will violate user/host device isolation and the kernel
will crash to protect itself.  At best I may be able to improve this to
killing the userspace process making use of the conflicting device, but
the kernel view is that userspace (libvirt) has mandated to bind the
device to the host driver and we must make it so, the user is
responsible for the consequences.  Thanks,

Alex
