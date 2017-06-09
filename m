Received: from eggs.gnu.org ([2001:4830:134:3::10]:59053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dJFuw-0007jB-TZ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dJFus-0008WT-Nl
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:09:18 -0400
Date: Fri, 9 Jun 2017 11:09:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170609110748.00c8e419@nial.brq.redhat.com>
In-Reply-To: <20170608144106.GG25805@umbus.fritz.box>
References: <20170608144106.GG25805@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] unplug_request and migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, jdenemar@redhat.com

On Fri, 9 Jun 2017 00:41:06 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Hi Dave & Juan,
> 
> I'm hoping one of you can answer this.
> 
> I'm currently grappling with (amongst other things) a pseries machine
> racing a hot unplug operation with a migrate.  There's various issues
> with what interim state we need, and which bits of it need to be
> migrated that I'm still investigating.  But, there's a more general
> question that I'm guessing must have already been addressed for x86.
> 
> For any "soft" unplug device - i.e. using ->unplug_request, rather
> than ->unplug, giving a device_del command will just ask the guest
> nicely to release the device, with the completion of the unplug
> happening only if and when the guest indicates it's ready for the
> device to go away.  AFAICT, the device_del command will return as soon
> as the request is made, but if the guest is busy, the completion of
> the hot unplug could take arbitrarily long.
> 
> So, what happens if there's a migration in between the unplug_request
> and the guest completing the unplug?  How does libvirt (or whatever)
> know whether to include the device on the destination machine command
> line?
> 

looking at qdev_unplug():
    if (!migration_is_idle()) { 
        error_setg(errp, "device_del not allowed while migrating");
        return;
    }

so unplug request should fail if migration is in progress , it won't reach guest
and mgmt side will have to repeat request on migration completion.

But it's still possible to issue unplug request first and then start migration,
that's where race between DEVICE_DELETED and migration start (starting DST with
being unplugged device) occurs.

it could be possible:
 1: on unplug_request() set global flag that there is pending unplug and forbid
    migration until completion. But there is no guarantee that unplug will
    be completed nor a way to notice that it's failed/rejected by guest.
    I'm not sure how that could be solved.
 2: set per device pending_unplug flag and delay unplug event from guest
    until migration is completed if migration is in progress when unplug
    callback is called.
    mgmt will treat the case as usual migration, i.e. start dst with being
    unplugged device, and device will be removed on dst side on migration
    completion.
    (it should be generic solution as x86 is also affected), as place where
    to put this common logic I'd suggest hotplug_handler_unplug()
