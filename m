Received: from eggs.gnu.org ([2001:4830:134:3::10]:33928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dDTIx-0004Jx-Qj
	for qemu-devel@nongnu.org; Wed, 24 May 2017 06:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dDTIt-0000Vz-RK
	for qemu-devel@nongnu.org; Wed, 24 May 2017 06:14:11 -0400
Date: Wed, 24 May 2017 12:14:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170524121402.50e62a75@nial.brq.redhat.com>
In-Reply-To: <20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
	<20170524050754.GW30246@umbus.fritz.box>
	<20170524112857.31c3d8f9@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/4] spapr: disable hotplugging
 without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On Wed, 24 May 2017 11:28:57 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 24 May 2017 15:07:54 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote: =20
> > > If the OS is not started, QEMU sends an event to the OS
> > > that is lost and cannot be recovered. An unplug is not
> > > able to restore QEMU in a coherent state.
> > > So, while the OS is not started, disable CPU and memory hotplug.
> > > We use option vector 6 to know if the OS is started
> > >=20
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>   =20
> >=20
> > Urgh.. I'm not terribly confident that this is really correct.  As
> > discussed on the previous patch, you're essentially using OV6 as a
> > flag that CAS is complete.
> >=20
> > But while it undoubtedly makes the race window much smaller, I don't
> > see that there's any guarantee the guest OS will really be able to
> > handle hotplug events immediately after CAS.
> >=20
> > In particular if the CAS process completes partially but then needs to
> > trigger a reboot, I think that would end up setting the ov6 variable,
> > but the OS would definitely not be in a state to accept events.
wouldn't guest on reboot pick up updated fdt and online hotplugged
before crash cpu along with initial cpus?

> We never have any guarantee that the OS will process an event that
> we've sent actually (think of a kernel crash just after a successful
> CAS negotiation for example, or any failure with the various guest
> components involved in the process of hotplug).
>=20
> > Mike, I really think we need some input from someone familiar with how
> > these hotplug events are supposed to work.  What do we need to do to
> > handle lost or stale events, such as those delivered when an OS is not
> > booted.
> >  =20
>=20
> AFAIK, in the PowerVM world, the HMC exposes a user configurable timeout.
>=20
> https://www.ibm.com/support/knowledgecenter/POWER8/p8hat/p8hat_dlparprocp=
oweraddp6.htm
>=20
> I'm not sure we can do anything better than being able to "cancel" a prev=
ious
> hotplug attempt if it takes too long, but I'm not necessarily the expert =
you're
> looking for :)
=46rom x86/ACPI world:
 - if hotplug happens early at boot before guest OS is running
   hotplug notification (SCI interrupt) stays pending and once guest
   is up it will/should handle it and online CPU
 - if guest crashed and is rebooted it will pickup updated apci tables (fdt=
 equivalent)
   with all present cpus (including hotplugged one before crash) and online
   hotplugged cpu along with coldplugged ones
 - if guest looses SCI somehow, it's considered guest issue and such cpu
   stays unpluggable until guest picks it somehow (reboot, manually running=
 cpus scan
   method from ACPI or another cpu hotplug event) and explicitly ejects it.

Taking in account that CPUs don't support surprise removal and requires
guest cooperation it's fine to leave CPU plugged in until guest ejects it.
That's what I'd expect to happen on baremetal,=20
you hotplug CPU, hardware notifies OS about it and that's all,
cpu won't suddenly pop out if OS isn't able to online it.

More over that hotplugged cpu might be executing some code or one of
already present cpus might be executing initialization routines to online
it (think of host overcommit and arbitrary delays) so it is not really safe
to remove hotplugged but not onlined cpu without OS consent
(i.e. explicit eject by OS/firmware). I think the lost event handling shoul=
d be
fixed on guest side and not in QEMU.
