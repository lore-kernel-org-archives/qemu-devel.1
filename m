Received: from eggs.gnu.org ([2001:4830:134:3::10]:41564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ecCXd-00053H-AE
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ecCXY-0004rc-9P
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:55:49 -0500
Message-ID: <1516290939.3278.22.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 18 Jan 2018 16:55:39 +0100
In-Reply-To: <20180118042713.GJ30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
	<1516113980.3278.1.camel@redhat.com>
	<20180116223413.GQ30352@umbus.fritz.box>
	<62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
	<1516179297.3278.6.camel@redhat.com>
	<20180118042713.GJ30352@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 0/6] target/ppc:
 Rework spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

On Thu, 2018-01-18 at 15:27 +1100, David Gibson wrote:
> > I looked further and device-list-properties looks like it would
> > do the trick; however it doesn't seem to work for machines:
> > 
> >   {"execute": "device-list-properties",
> >    "arguments": {"typename": "spapr-2.11-machine"}}
> >   {"error": {"class": "GenericError",
> >              "desc": "Parameter 'typename' expects device"}}
> > 
> > It works fine for the likes of virtio-scsi-pci and even
> > power9_v2.0-powerpc64-cpu, though. Any ideas? :)
> 
> I'm guessing it's because machines aren't descended from TYPE_DEVICE.
> 
> Dammit.  I really can't see a reasonable way of addressing this other
> than improving qapi in general to have a way of reporting machine
> class properties.  Adding something ad-hoc for just these properties
> of this machine seems like madness.
> 
> Nor can I think of a place to put these that would be both sensible
> and more discoverable with existing mechanisms.

The relationship between QOM/QAPI/QMP is not very clear in my mind,
as you might have guessed from my messages, so I don't think I can
offer much useful input. But if the properties are registered using
the same mechanism both for devices and machines, then maybe there
should be a QMP command that can list them regardless of the parent
type? object-list-properties or something like that.

I also noticed that the (AFAIK s390-specific) "loadparm" property
is detected by libvirt through the query-command-line-options QMP
command. Not sure what kind of trickery they employ to obtain that
result, though, and I'm not sure it's exactly an example of best
practices since it shows up on x86 and aarch64 too ;)

-- 
Andrea Bolognani / Red Hat / Virtualization
