Received: from eggs.gnu.org ([2001:4830:134:3::10]:42729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dak4i-0000d1-JJ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:47:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dak4e-0000gE-Kd
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:47:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dak4e-0000fr-Ef
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:47:36 -0400
Date: Thu, 27 Jul 2017 08:47:33 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170727084733.43038922@w520.home>
In-Reply-To: <20170727105348.GG7970@umbus.fritz.box>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<CAFEAcA_t8EDNnWTeRzuHEcdfq3DJFTN3ug=DHnGvWef3=wyFzA@mail.gmail.com>
	<20170727105348.GG7970@umbus.fritz.box>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 27 Jul 2017 20:53:48 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jul 27, 2017 at 10:11:48AM +0100, Peter Maydell wrote:
> > On 27 July 2017 at 02:30, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:  
> > > In particular, Mellanox CX4 adapters on PowerNV hosts might not be fully
> > > quiesced by vfio-pci's finalize() routine until up to 6s after the
> > > DEVICE_DELETED was emitted, leading to detach-device on the libvirt side pretty
> > > much always crashing the host.  
> > 
> > My initial naive thought is that if the host kernel can crash then
> > this is a host kernel bug... shouldn't the host kernel refuse
> > the subsequent libvirt rebind if it would cause a crash ?  
> 
> I think so too, but I haven't been able to convince Alex.  Nor
> find time to fix it in the kernel myself.

It's not me you need to convince, it's GregKH[1].  That interpretation
is that the user bind request is a mandate and we'll fall over
ourselves to try to do as they ask.  I think the best I might be able
to do is to kill the QEMU process to avoid compromising the kernel
rather than killing the kernel after the isolation compromise has
occurred.  Messing with driver binding is a privileged operation, and
the kernel believes you get to keep all the pieces when it fails.
Sorry.  Thanks,

Alex

[1] https://lkml.org/lkml/2017/7/10/728
