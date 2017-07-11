Received: from eggs.gnu.org ([2001:4830:134:3::10]:50603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUvQK-00060u-B5
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUvQH-0005mP-Ax
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:41:56 -0400
Date: Tue, 11 Jul 2017 23:41:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170711134143.GK4083@umbus.fritz.box>
References: <20170707212037.24642-1-danielhb@linux.vnet.ibm.com>
	<20170710063910.GB4083@umbus.fritz.box>
	<eeb7b4a2-ebe4-be28-6efd-071e7ab53625@linux.vnet.ibm.com>
	<20170711130047.GI4083@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wIc/V6YLA2QdyfT4"
Content-Disposition: inline
In-Reply-To: <20170711130047.GI4083@umbus.fritz.box>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC drcVI PATCH] spapr: reset DRCs on
 migration pre_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com


--wIc/V6YLA2QdyfT4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2017 at 11:00:47PM +1000, David Gibson wrote:
> On Mon, Jul 10, 2017 at 05:37:31PM -0300, Daniel Henrique Barboza wrote:
> >=20
> >=20
> > On 07/10/2017 03:39 AM, David Gibson wrote:
> > > On Fri, Jul 07, 2017 at 06:20:37PM -0300, Daniel Henrique Barboza wro=
te:
> > > > "spapr: Remove 'awaiting_allocation' DRC flag" removed the flag that
> > > > was originally was being used to prevent a race condition between
> > > > hot unplug and hotplug. The DRC code base got simplified and more
> > > > robust over time, eliminating the conditions that led to this race.
> > > > Thus the awaiting_allocation existence wasn't justifiable anymore.
> > > >=20
> > > > A side effect of the flag removal was seen when testing the Libvirt
> > > > hotplug-migration-unplug scenario, where a device is hotplugged in =
both
> > > > source and target using device_add prior to the migration, then the
> > > > device is removed after migration in the target. Before that cleanu=
p, the
> > > > hot unplug at the target fails in both QEMU and guest kernel because
> > > > the DRC state at the target is inconsistent. After removing that fl=
ag,
> > > > the hot unplug works at QEMU but the guest kernel hungs on the midd=
le
> > > > of the unplug process.
> > > >=20
> > > > It turns out that the awaiting_allocation logic was preventing the =
hot
> > > > unplug from happening at the target because the DRC state, at this =
specific
> > > > hot unplug scenario, was matching the race condition the flag was
> > > > originally designed to avoid. Removing the flag allowed the device
> > > > to be removed from QEMU, leading to this new behavior.
> > > >=20
> > > > The root cause of those problems is, in fact, the inconsistent stat=
e of the
> > > > target DRCs after migration is completed. Doing device_add in the
> > > > INMIGRATE status leaves the DRC in a state that isn't recognized as=
 a
> > > > valid hotplugged device in the guest OS.
> > > >=20
> > > > This patch fixes the problem by using the recently modified 'drc_re=
set'
> > > > function, that now forces the DRC to a known state by checking its =
device
> > > > status, to reset all DRCs in the pre_load hook of the migration. Re=
setting
> > > > the DRCs in pre_load allows the DRCs to be in a predictable state w=
hen
> > > > we load the migration at the target, allowing for hot unplugs to wo=
rk
> > > > as expected.
> > > >=20
> > > > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > > Ok, so the fact this works is pretty promising.  However, I'm still
> > > trying to fully understand what's going on here.  I have a suspicion
> > > that this is only necessary because something isn't quite right with
> > > the reset / inmigrate sequencing in the generic code, which we should
> > > fix instead of hacking around.
> >=20
> > Agreed.
> >=20
> > >=20
> > > IIUC, in the problem case, on the source the hotplug has fully
> > > completed, so the DRC will be in CONFIGURED state.  Since the device
> > > is CONFIGURED and attached, no DRC info is sent in the migration
> > > stream.  On the destination what seems to be happening is:
> > >=20
> > > 1. qemu is started with "-incoming defer", and cpu *not* present
> > >=20
> > >      DRC is uninitialized
> > >=20
> > > 2. qemu_system_reset() is called in vl.c
> > >=20
> > >      DRC is in UNALLOCATED / detached state
> > >=20
> > > 3. libvirt device_adds the cpu
> > >=20
> > >      DRC is in UNALLOCATED / attached state
> > >=20
> > > 4. libvirt initiates incoming migration
> > >=20
> > >      DRC remains in UNALLOCATED / attached state
> > >=20
> > > 5. Guest resumes on the destination
> > >=20
> > >      DRC still in UNALLOCATED / attached state
> > >=20
> > > Which mismatches what we had on the source so =3D> bug.
> > >=20
> > > BUT, AFAIK the libvirt coldplug case below *is* working.  Which
> > > tracing through the code I'd expect:
> > >=20
> > > 1. qemu is started with -S and cpu not present
> > >=20
> > >     DRC is uninitialized
> > >=20
> > > 2. qemu_system_reset() is called in vl.c
> > >=20
> > >     DRC is in UNALLOCATED / detached state
> > >=20
> > > 3. libvirt device_adds in prelaunch phase
> > >=20
> > >     DRC is in UNALLOCATED / attached state
> > >=20
> > > 4. Guest is started
> > >=20
> > >     DRC is in UNALLOCATED / attached state
> > >=20
> > > Which is also incorrect: the device was present when the guest
> > > started, so it should be in CONFIGURED state.  IIUC this case is
> > > working, so I think it is must actually be in CONFIGURED state.
> >=20
> > Just did a test here and the device isn't present when the guest starts=
 in
> > the second
> > example you mentioned,  Tested with current qemu master. QEMU shows the
> > extra
> > CPU as 'halted' always, even after the guest starts and OS boots up:
> >=20
> > danielhb@louis:~/qemu/build/ppc64-softmmu$ sudo ./qemu-system-ppc64 -na=
me
> > migrate_qemu -boot strict=3Don --enable-kvm -device
> > nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0xf -device
> > spapr-vscsi,id=3Dscsi0,reg=3D0x2000 -smp 1,maxcpus=3D4,sockets=3D4,core=
s=3D1,threads=3D1
> > --machine pseries,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m
> > 4G,slots=3D32,maxmem=3D32G -drive file=3D/home/danielhb/vm_imgs/ubuntu1=
704.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone
> > -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x2,drive=3Ddrive-=
virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
> > -nographic -S
> > QEMU 2.9.50 monitor - type 'help' for more information
> >=20
> > <<<<< at this point qemu_system_reset is called, as expected >>>>>
> >=20
> > (qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
> > (qemu) info cpus
> > * CPU #0: nip=3D0x0000000000000100 thread_id=3D16523
> >   CPU #1: nip=3D0x0000000000000000 (halted) thread_id=3D16598
> > (qemu) cont
> >=20
> > --- guest boots up ----
> >=20
> > (qemu) info cpus
> > * CPU #0: nip=3D0xc0000000000a3e0c thread_id=3D16523
> >   CPU #1: nip=3D0x0000000000000000 (halted) thread_id=3D16598
> >=20
> > danielhb@ubuntu1704:~$ lscpu
> > Architecture:          ppc64le
> > Byte Order:            Little Endian
> > CPU(s):                1
> > On-line CPU(s) list:   0
> > Thread(s) per core:    1
> > Core(s) per socket:    1
> > Socket(s):             1
> > NUMA node(s):          1
> > Model:                 2.1 (pvr 004b 0201)
> > Model name:            POWER8E (raw), altivec supported
> > Hypervisor vendor:     horizontal
> > Virtualization type:   full
> > L1d cache:             64K
> > L1i cache:             32K
> > NUMA node0 CPU(s):     0
> > danielhb@ubuntu1704:~$ (qemu)
> > (qemu) device_del core1
> > (qemu) info cpus
> > * CPU #0: nip=3D0xc0000000000a3e0c thread_id=3D16523
> >   CPU #1: nip=3D0x0000000000000000 (halted) thread_id=3D16598
> >=20
> > danielhb@ubuntu1704:~$ lscpu
> > Architecture:          ppc64le
> > Byte Order:            Little Endian
> > CPU(s):                1
> > On-line CPU(s) list:   0
> > Thread(s) per core:    1
> > Core(s) per socket:    1
> > Socket(s):             1
> > NUMA node(s):          1
> > Model:                 2.1 (pvr 004b 0201)
> > Model name:            POWER8E (raw), altivec supported
> > Hypervisor vendor:     horizontal
> > Virtualization type:   full
> > L1d cache:             64K
> > L1i cache:             32K
> > NUMA node0 CPU(s):     0
> > danielhb@ubuntu1704:~$ dmesg | tail -n 5
> > [    6.307988] audit: type=3D1400 audit(1499705034.060:10): apparmor=3D=
"STATUS"
> > operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin/lxc-=
start"
> > pid=3D2212 comm=3D"apparmor_parser"
> > [    6.318556] audit: type=3D1400 audit(1499705034.068:11): apparmor=3D=
"STATUS"
> > operation=3D"profile_load" profile=3D"unconfined"
> > name=3D"/usr/lib/snapd/snap-confine" pid=3D2213 comm=3D"apparmor_parser"
> > [    7.087170] cgroup: new mount options do not match the existing
> > superblock, will be ignored
> > [   88.093598] pseries-hotplug-cpu: Failed to acquire DRC, rc: -22, drc
> > index: 10000008
> > [   88.093606] pseries-hotplug-cpu: Cannot find CPU (drc index 10000008=
) to
> > remove
> > danielhb@ubuntu1704:~$
> >=20
> >=20
> > Debugging it a little I see that device_adding a CPU while the VM isn't
> > started yet is being considered
> > "hotplugged" by spapr_core_plug (dev->hotplugged is True). Also, there =
is a
> > note in 'spapr_cpu_reset'
> > saying:
> >=20
> >     /* All CPUs start halted.  CPU0 is unhalted from the machine level
> >      * reset code and the rest are explicitly started up by the guest
> >      * using an RTAS call */
> >     cs->halted =3D 1;
> >=20
> > And yeah, the guest isn't calling 'start-cpu' and the CPU remains halte=
d.
> > When comparing to
> > a scenario where I start the VM with 2 cpus in the command line, the fi=
rst
> > one is started by the
> > machine reset and the other one by the RTAS call 'start-cpu', as expect=
ed
> > I'll investigate why this
> > is happening - starting with 2 coldplugged CPUs versus one coldplugged =
CPU
> > and a second one
> > attached with device_add with while on -S should yield the same outcome.
> >=20
> >=20
> > All this said, I am not sure if this behavior has the same root cause a=
s the
> > migration problem
> > this patch solves with the reset on pre_load though. Hopefully I'll know
> > more in these next days.
>=20
> Ah! So it's broken for the prelaunch case as well, though in a
> slightly different way.  Actually for me the breakage is less obvious
> - if I plug the cpu at prelaunch, I *do* get 2 cpus appearing in the
> running system.  But tracing through, that's because the hotplug
> message was queued and gets processed during boot.  That gets to the
> right place in the end, but it's kind of silly going through the
> hotplug logic.
>=20
> I thought there was a system reset after the prelaunch phase, but I
> was mistaken.
>=20
> I can see two ways to address this:
>   1) add in a DRC reset before starting up the machine, for both the
>      prelaunch and inmigrate cases.  Your draft patch does the second,
>      but I don't see an obvious place to put a hook for the first
>=20
>   2) Change the plug (and unplug) paths to skip the notification and
>      gradual state change, and just immediately jump to the completed
>      state when called in the prelaunch or inmigrate. (Easiest way
>      would be just to call the drc reset function instead of queueing
>      an event).
>=20
> (2) is basically the approach Laurent proposed in a patch a little
> while ago, defining an spapr_hotplugged() function that always
> returned false in prelaunch or inmigrate states.
>=20
> At the time I was dubious about that approach, because I thought we
> had a natural reset point after that.  After more careful
> investigation, I think that's not the case however, so I'm inclined to
> go with approach (2), polish up Laurent's patch and apply that.


Uh.. wait, realised this approach is wrong for the non-migration
case.  For the hotplug-during-prelaunch, it's not sufficient to just
reset the DRCs.  For the device to be truly coldplugged - with the DRC
going straight to CONFIGURED state, it must also appear in the base
device tree, and that requires a full system reset.  Well... or CAS,
which complicates matters again.

Ok, now I'm torn between options (1) and (2) again - we basically have
a patch for each approach (yours for 1, and Laurent's for 2).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wIc/V6YLA2QdyfT4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZNWVAAoJEGw4ysog2bOS40cQANTTeANUFz1+puY2nfxcHhqT
hdhLOH9jW5FFQugxEAxMpUPZgTgQ7PSusnYAXwqtl27Vh1nJNXnuePIzEbFMQR0+
wCee+eqWSkYfKsP6Fs4aL4eKoP0aMy9aol5pEubL/ONd+fiZtLASkT8e6SmoTWTk
MTAaB+dG/vHz+mbGuezGb7YREAIvxQuCE4HBvRDoYHLFy2Tey3L1eKTXnSOCPkfa
iaLG4rxIEs5cdowTTpAdZ/vBjNz4qSv0ypb4qZVsAN3d7uYy4HACEzHgAe+5q/qc
s8DnZbHX7oriooVgVf+ngdcF0hBKpCd4EYfBcvqb+poFN3YI4XBYqEoLmg0jhsYo
czX0wqQyFASju2z/10b1OKMbUkd2u5buufzQktxg0yV06gINCsxCjJbEIDbfS5VK
QBh0+Ph1V/CKUl34f9wmQxT4bmkjyobQkSw933YHrXgRaOjEPS/eifS8bBxOdX1R
sfqlDh3/fLLrERw16g1Ne/HRZfhOJKlyMqjHFMQoVQ+kPI0wiF1lspO/XZfEmYq7
fNvM7gkiCG+UmUP8FuHRD5QoHvV/w7Mxd7PDwHtxF04rSXOuCjIGxKfdD0zsDPNs
3cglpBvYWMWCxttoOYXg2wh8qS9M2R3CH0xnZLIQ9M7qlX7geQWRvJN02sRokaFY
BL0eJXZTLcON6vleh1KC
=L/Lt
-----END PGP SIGNATURE-----

--wIc/V6YLA2QdyfT4--
