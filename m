Received: from eggs.gnu.org ([2001:4830:134:3::10]:54636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ebjUz-0000Rv-Q3
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1ebjUu-0002Lk-0G
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 03:55:09 -0500
Message-ID: <1516179297.3278.6.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 17 Jan 2018 09:54:57 +0100
In-Reply-To: <62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
	<1516113980.3278.1.camel@redhat.com>
	<20180116223413.GQ30352@umbus.fritz.box>
	<62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

On Wed, 2018-01-17 at 10:26 +1100, Alexey Kardashevskiy wrote:
> On 17/01/18 09:34, David Gibson wrote:
> > On Tue, Jan 16, 2018 at 03:46:20PM +0100, Andrea Bolognani wrote:
> > > On Wed, 2018-01-17 at 00:54 +1100, David Gibson wrote:
> > > > > Correct me if I'm wrong, but it seems to me like there's no way
> > > > > to figure out through QMP whether these new machine options can be
> > > > > used for a given QEMU binary.
> > > > 
> > > > Uh, I don't think so.  These are machine options like any other (just
> > > > constructed a bit differently).  So they'll appear in qemu -machine
> > > > pseries,? and I believe that info can also be retrieved with QMP.
> > > 
> > > Yes, they will indeed show up in the output of -machine pseries,?
> > > but there's AFAICT no way to retrieve them via QMP.
> > 
> > Really!?  I thought introspecting object properties was QMP's bread
> > and butter.
> 
> On a guest started with '-S':
> {"execute": "qom-list", "arguments": {"path": "/machine"}}
> 
> returns:
> {   'return': [   {'name': 'graphics', 'type': 'bool'},
[...]
>                   {'name': 'cap-dfp', 'type': 'bool'},
>                   {'name': 'cap-htm', 'type': 'bool'},
>                   {'name': 'cap-vsx', 'type': 'bool'},
>                   {'name': 'vfio-no-msix-emulation', 'type': 'bool'},
>                   {'name': 'kvm-type', 'type': 'string'},
>                   {'name': 'max-cpu-compat', 'type': 'string'},
[...]
>                   {'name': 'resize-hpt', 'type': 'string'}]}
> 
> but still requires a running qemu, yes.

That's not a problem in itself; however, AFAICT the guest in
question also needs to be started with -machine pseries in order
for the above to work, which means it's not usable due to the
scalability issues mentioned earlier in the thread. We run QEMU
with -machine none, a single time, to probe for capabilities.

I looked further and device-list-properties looks like it would
do the trick; however it doesn't seem to work for machines:

  {"execute": "device-list-properties",
   "arguments": {"typename": "spapr-2.11-machine"}}
  {"error": {"class": "GenericError",
             "desc": "Parameter 'typename' expects device"}}

It works fine for the likes of virtio-scsi-pci and even
power9_v2.0-powerpc64-cpu, though. Any ideas? :)

-- 
Andrea Bolognani / Red Hat / Virtualization
