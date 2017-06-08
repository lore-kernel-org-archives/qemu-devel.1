Received: from eggs.gnu.org ([2001:4830:134:3::10]:57880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIzbd-00025b-HP
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIzba-00036K-AC
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 11:44:17 -0400
Date: Thu, 8 Jun 2017 16:44:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170608154407.GC2700@work-vm>
References: <20170608144106.GG25805@umbus.fritz.box>
	<20170608151019.GB2700@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608151019.GB2700@work-vm>
Subject: Re: [Qemu-devel] unplug_request and migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, jdenemar@redhat.com
Cc: quintela@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * David Gibson (david@gibson.dropbear.id.au) wrote:
> > Hi Dave & Juan,
> > 
> > I'm hoping one of you can answer this.
> > 
> > I'm currently grappling with (amongst other things) a pseries machine
> > racing a hot unplug operation with a migrate.  There's various issues
> > with what interim state we need, and which bits of it need to be
> > migrated that I'm still investigating.  But, there's a more general
> > question that I'm guessing must have already been addressed for x86.
> > 
> > For any "soft" unplug device - i.e. using ->unplug_request, rather
> > than ->unplug, giving a device_del command will just ask the guest
> > nicely to release the device, with the completion of the unplug
> > happening only if and when the guest indicates it's ready for the
> > device to go away.  AFAICT, the device_del command will return as soon
> > as the request is made, but if the guest is busy, the completion of
> > the hot unplug could take arbitrarily long.
> > 
> > So, what happens if there's a migration in between the unplug_request
> > and the guest completing the unplug?  How does libvirt (or whatever)
> > know whether to include the device on the destination machine command
> > line?
> 
> No, I don't understand how that works. cc'ing in jdenemar for libvirt

I had a bit of a prod, I can see:
  a) There's a 'DEVICE_DELETED' qmp event sent by qemu
  b) I can also see an ACPI OST event that I think might be just for;
DIMMs


That's just poking around libvirt's src/qemu/qemu_process.c



Dave

> Dave
> 
> > -- 
> > David Gibson			| I'll have my music baroque, and my code
> > david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> > 				| _way_ _around_!
> > http://www.ozlabs.org/~dgibson
> 
> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
