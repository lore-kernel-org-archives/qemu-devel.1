Received: from eggs.gnu.org ([2001:4830:134:3::10]:45053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUv6Q-0004R4-Oz
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUv6M-0005O1-JS
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:21:22 -0400
Date: Tue, 11 Jul 2017 23:00:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170711130047.GI4083@umbus.fritz.box>
References: <20170707212037.24642-1-danielhb@linux.vnet.ibm.com>
	<20170710063910.GB4083@umbus.fritz.box>
	<eeb7b4a2-ebe4-be28-6efd-071e7ab53625@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mXDO3udm/xYWQeMQ"
Content-Disposition: inline
In-Reply-To: <eeb7b4a2-ebe4-be28-6efd-071e7ab53625@linux.vnet.ibm.com>
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


--mXDO3udm/xYWQeMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2017 at 05:37:31PM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 07/10/2017 03:39 AM, David Gibson wrote:
> > On Fri, Jul 07, 2017 at 06:20:37PM -0300, Daniel Henrique Barboza wrote:
> > > "spapr: Remove 'awaiting_allocation' DRC flag" removed the flag that
> > > was originally was being used to prevent a race condition between
> > > hot unplug and hotplug. The DRC code base got simplified and more
> > > robust over time, eliminating the conditions that led to this race.
> > > Thus the awaiting_allocation existence wasn't justifiable anymore.
> > >=20
> > > A side effect of the flag removal was seen when testing the Libvirt
> > > hotplug-migration-unplug scenario, where a device is hotplugged in bo=
th
> > > source and target using device_add prior to the migration, then the
> > > device is removed after migration in the target. Before that cleanup,=
 the
> > > hot unplug at the target fails in both QEMU and guest kernel because
> > > the DRC state at the target is inconsistent. After removing that flag,
> > > the hot unplug works at QEMU but the guest kernel hungs on the middle
> > > of the unplug process.
> > >=20
> > > It turns out that the awaiting_allocation logic was preventing the hot
> > > unplug from happening at the target because the DRC state, at this sp=
ecific
> > > hot unplug scenario, was matching the race condition the flag was
> > > originally designed to avoid. Removing the flag allowed the device
> > > to be removed from QEMU, leading to this new behavior.
> > >=20
> > > The root cause of those problems is, in fact, the inconsistent state =
of the
> > > target DRCs after migration is completed. Doing device_add in the
> > > INMIGRATE status leaves the DRC in a state that isn't recognized as a
> > > valid hotplugged device in the guest OS.
> > >=20
> > > This patch fixes the problem by using the recently modified 'drc_rese=
t'
> > > function, that now forces the DRC to a known state by checking its de=
vice
> > > status, to reset all DRCs in the pre_load hook of the migration. Rese=
tting
> > > the DRCs in pre_load allows the DRCs to be in a predictable state when
> > > we load the migration at the target, allowing for hot unplugs to work
> > > as expected.
> > >=20
> > > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> > Ok, so the fact this works is pretty promising.  However, I'm still
> > trying to fully understand what's going on here.  I have a suspicion
> > that this is only necessary because something isn't quite right with
> > the reset / inmigrate sequencing in the generic code, which we should
> > fix instead of hacking around.
>=20
> Agreed.
>=20
> >=20
> > IIUC, in the problem case, on the source the hotplug has fully
> > completed, so the DRC will be in CONFIGURED state.  Since the device
> > is CONFIGURED and attached, no DRC info is sent in the migration
> > stream.  On the destination what seems to be happening is:
> >=20
> > 1. qemu is started with "-incoming defer", and cpu *not* present
> >=20
> >      DRC is uninitialized
> >=20
> > 2. qemu_system_reset() is called in vl.c
> >=20
> >      DRC is in UNALLOCATED / detached state
> >=20
> > 3. libvirt device_adds the cpu
> >=20
> >      DRC is in UNALLOCATED / attached state
> >=20
> > 4. libvirt initiates incoming migration
> >=20
> >      DRC remains in UNALLOCATED / attached state
> >=20
> > 5. Guest resumes on the destination
> >=20
> >      DRC still in UNALLOCATED / attached state
> >=20
> > Which mismatches what we had on the source so =3D> bug.
> >=20
> > BUT, AFAIK the libvirt coldplug case below *is* working.  Which
> > tracing through the code I'd expect:
> >=20
> > 1. qemu is started with -S and cpu not present
> >=20
> >     DRC is uninitialized
> >=20
> > 2. qemu_system_reset() is called in vl.c
> >=20
> >     DRC is in UNALLOCATED / detached state
> >=20
> > 3. libvirt device_adds in prelaunch phase
> >=20
> >     DRC is in UNALLOCATED / attached state
> >=20
> > 4. Guest is started
> >=20
> >     DRC is in UNALLOCATED / attached state
> >=20
> > Which is also incorrect: the device was present when the guest
> > started, so it should be in CONFIGURED state.  IIUC this case is
> > working, so I think it is must actually be in CONFIGURED state.
>=20
> Just did a test here and the device isn't present when the guest starts in
> the second
> example you mentioned,  Tested with current qemu master. QEMU shows the
> extra
> CPU as 'halted' always, even after the guest starts and OS boots up:
>=20
> danielhb@louis:~/qemu/build/ppc64-softmmu$ sudo ./qemu-system-ppc64 -name
> migrate_qemu -boot strict=3Don --enable-kvm -device
> nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0xf -device
> spapr-vscsi,id=3Dscsi0,reg=3D0x2000 -smp 1,maxcpus=3D4,sockets=3D4,cores=
=3D1,threads=3D1
> --machine pseries,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -m
> 4G,slots=3D32,maxmem=3D32G -drive file=3D/home/danielhb/vm_imgs/ubuntu170=
4.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,cache=3Dnone
> -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x2,drive=3Ddrive-vi=
rtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
> -nographic -S
> QEMU 2.9.50 monitor - type 'help' for more information
>=20
> <<<<< at this point qemu_system_reset is called, as expected >>>>>
>=20
> (qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
> (qemu) info cpus
> * CPU #0: nip=3D0x0000000000000100 thread_id=3D16523
>   CPU #1: nip=3D0x0000000000000000 (halted) thread_id=3D16598
> (qemu) cont
>=20
> --- guest boots up ----
>=20
> (qemu) info cpus
> * CPU #0: nip=3D0xc0000000000a3e0c thread_id=3D16523
>   CPU #1: nip=3D0x0000000000000000 (halted) thread_id=3D16598
>=20
> danielhb@ubuntu1704:~$ lscpu
> Architecture:          ppc64le
> Byte Order:            Little Endian
> CPU(s):                1
> On-line CPU(s) list:   0
> Thread(s) per core:    1
> Core(s) per socket:    1
> Socket(s):             1
> NUMA node(s):          1
> Model:                 2.1 (pvr 004b 0201)
> Model name:            POWER8E (raw), altivec supported
> Hypervisor vendor:     horizontal
> Virtualization type:   full
> L1d cache:             64K
> L1i cache:             32K
> NUMA node0 CPU(s):     0
> danielhb@ubuntu1704:~$ (qemu)
> (qemu) device_del core1
> (qemu) info cpus
> * CPU #0: nip=3D0xc0000000000a3e0c thread_id=3D16523
>   CPU #1: nip=3D0x0000000000000000 (halted) thread_id=3D16598
>=20
> danielhb@ubuntu1704:~$ lscpu
> Architecture:          ppc64le
> Byte Order:            Little Endian
> CPU(s):                1
> On-line CPU(s) list:   0
> Thread(s) per core:    1
> Core(s) per socket:    1
> Socket(s):             1
> NUMA node(s):          1
> Model:                 2.1 (pvr 004b 0201)
> Model name:            POWER8E (raw), altivec supported
> Hypervisor vendor:     horizontal
> Virtualization type:   full
> L1d cache:             64K
> L1i cache:             32K
> NUMA node0 CPU(s):     0
> danielhb@ubuntu1704:~$ dmesg | tail -n 5
> [    6.307988] audit: type=3D1400 audit(1499705034.060:10): apparmor=3D"S=
TATUS"
> operation=3D"profile_load" profile=3D"unconfined" name=3D"/usr/bin/lxc-st=
art"
> pid=3D2212 comm=3D"apparmor_parser"
> [    6.318556] audit: type=3D1400 audit(1499705034.068:11): apparmor=3D"S=
TATUS"
> operation=3D"profile_load" profile=3D"unconfined"
> name=3D"/usr/lib/snapd/snap-confine" pid=3D2213 comm=3D"apparmor_parser"
> [    7.087170] cgroup: new mount options do not match the existing
> superblock, will be ignored
> [   88.093598] pseries-hotplug-cpu: Failed to acquire DRC, rc: -22, drc
> index: 10000008
> [   88.093606] pseries-hotplug-cpu: Cannot find CPU (drc index 10000008) =
to
> remove
> danielhb@ubuntu1704:~$
>=20
>=20
> Debugging it a little I see that device_adding a CPU while the VM isn't
> started yet is being considered
> "hotplugged" by spapr_core_plug (dev->hotplugged is True). Also, there is=
 a
> note in 'spapr_cpu_reset'
> saying:
>=20
>     /* All CPUs start halted.  CPU0 is unhalted from the machine level
>      * reset code and the rest are explicitly started up by the guest
>      * using an RTAS call */
>     cs->halted =3D 1;
>=20
> And yeah, the guest isn't calling 'start-cpu' and the CPU remains halted.
> When comparing to
> a scenario where I start the VM with 2 cpus in the command line, the first
> one is started by the
> machine reset and the other one by the RTAS call 'start-cpu', as expected
> I'll investigate why this
> is happening - starting with 2 coldplugged CPUs versus one coldplugged CPU
> and a second one
> attached with device_add with while on -S should yield the same outcome.
>=20
>=20
> All this said, I am not sure if this behavior has the same root cause as =
the
> migration problem
> this patch solves with the reset on pre_load though. Hopefully I'll know
> more in these next days.

Ah! So it's broken for the prelaunch case as well, though in a
slightly different way.  Actually for me the breakage is less obvious
- if I plug the cpu at prelaunch, I *do* get 2 cpus appearing in the
running system.  But tracing through, that's because the hotplug
message was queued and gets processed during boot.  That gets to the
right place in the end, but it's kind of silly going through the
hotplug logic.

I thought there was a system reset after the prelaunch phase, but I
was mistaken.

I can see two ways to address this:
  1) add in a DRC reset before starting up the machine, for both the
     prelaunch and inmigrate cases.  Your draft patch does the second,
     but I don't see an obvious place to put a hook for the first

  2) Change the plug (and unplug) paths to skip the notification and
     gradual state change, and just immediately jump to the completed
     state when called in the prelaunch or inmigrate. (Easiest way
     would be just to call the drc reset function instead of queueing
     an event).

(2) is basically the approach Laurent proposed in a patch a little
while ago, defining an spapr_hotplugged() function that always
returned false in prelaunch or inmigrate states.

At the time I was dubious about that approach, because I thought we
had a natural reset point after that.  After more careful
investigation, I think that's not the case however, so I'm inclined to
go with approach (2), polish up Laurent's patch and apply that.

> > So, I'm trying to understand why we get different results in these two
> > cases.
> >=20
> > [Aside:
> >=20
> > If we do need to manually trigger a reset, code like the below is
> > basically what we need.  Just putting a reset in each DRC's pre_load
> > looks neater, but won't work - the pre_load won't be called unless the
> > object actually appears in the migration stream, and IIUC the case
> > which isn't working is exactly the case where the object is omitted
> > from the migration stream.]
>=20
> Yeah, I have thought about it before sending this RFC patch and I couldn't
> find anywhere
> else to hook this reset code, given that the pre_load hook requires the
> object to
> be migrated. And, as you said, if the DRC is being migrated the problem
> doesn't
> happen anyway.
>=20
>=20
> Daniel
>=20
> >=20
> > > ---
> > >   hw/ppc/spapr.c             |  7 +++++++
> > >   hw/ppc/spapr_drc.c         | 17 +++++++++++++++++
> > >   include/hw/ppc/spapr_drc.h |  1 +
> > >   3 files changed, 25 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 089d41d..aea85b0 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1473,6 +1473,12 @@ static bool spapr_vga_init(PCIBus *pci_bus, Er=
ror **errp)
> > >       }
> > >   }
> > > +static int spapr_pre_load(void *opaque)
> > > +{
> > > +    spapr_reset_all_drcs();
> > > +    return 0;
> > > +}
> > > +
> > >   static int spapr_post_load(void *opaque, int version_id)
> > >   {
> > >       sPAPRMachineState *spapr =3D (sPAPRMachineState *)opaque;
> > > @@ -1598,6 +1604,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> > >       .name =3D "spapr",
> > >       .version_id =3D 3,
> > >       .minimum_version_id =3D 1,
> > > +    .pre_load =3D spapr_pre_load,
> > >       .post_load =3D spapr_post_load,
> > >       .fields =3D (VMStateField[]) {
> > >           /* used to be @next_irq */
> > > diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> > > index 63637d8..74f3957 100644
> > > --- a/hw/ppc/spapr_drc.c
> > > +++ b/hw/ppc/spapr_drc.c
> > > @@ -449,6 +449,23 @@ static void drc_reset(void *opaque)
> > >       drc->ccs_depth =3D -1;
> > >   }
> > > +void spapr_reset_all_drcs(void)
> > > +{
> > > +    Object *drc_container, *obj;
> > > +    ObjectProperty *prop;
> > > +    ObjectPropertyIterator iter;
> > > +
> > > +    drc_container =3D container_get(object_get_root(), DRC_CONTAINER=
_PATH);
> > > +    object_property_iter_init(&iter, drc_container);
> > > +    while ((prop =3D object_property_iter_next(&iter))) {
> > > +        if (!strstart(prop->type, "link<", NULL)) {
> > > +            continue;
> > > +        }
> > > +        obj =3D object_property_get_link(drc_container, prop->name, =
NULL);
> > > +        drc_reset(SPAPR_DR_CONNECTOR(obj));
> > > +    }
> > > +}
> > > +
> > >   static bool spapr_drc_needed(void *opaque)
> > >   {
> > >       sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
> > > diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
> > > index 4c54864..c7553e6 100644
> > > --- a/include/hw/ppc/spapr_drc.h
> > > +++ b/include/hw/ppc/spapr_drc.h
> > > @@ -250,4 +250,5 @@ static inline bool spapr_drc_unplug_requested(sPA=
PRDRConnector *drc)
> > >       return drc->unplug_requested;
> > >   }
> > > +void spapr_reset_all_drcs(void);
> > >   #endif /* HW_SPAPR_DRC_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mXDO3udm/xYWQeMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZMv7AAoJEGw4ysog2bOS0AcP/j8bjxz6eui4iqs6fCr4W4fh
2qPRqG28FUf3daJ21KnHPpPLvY2x2ozHxrK22Zxf1hotXtovse1s3GxKg0hC9WCl
pWS/tk0zvGAe/t++frOdIFn8tG27vuaFLbLqsLELFSMbOtxULkH+AtfJCETn2bbL
0+c7yMecfTOsLrN8ZZ8sXi2hDWpgk1u6+UBMANvIqqw/jgdb+w8nVpPLotPFzVoO
DzAWCcWEiNs/VYVq9iPV+je5n1W3CXmsoqQ4wTlcFN1bRAbn2bitfjTERwf3lr2W
/h9zzVnpMYm/Us/R663pYlMREceGLa7GKfQcJYD80yGIfSTni0C9zFy+EODmRZxp
HHNS2UisSJ94lL+tONUELJ+lGXvzQKn5jQ7fg5Y5GsbA4F4h082XOg1h4VC+QFz2
xufonQb07Vl+uXRcsNPgbZ1KY8eClpPZz2WMsMPJKfunYBSVdWB39wjg6JfbayLa
GYBC8ozrQKr9qyxqg99f2e1KiapmWwZDXZzfxzW0oERjKOZaEHmpDuEvnTK+hELL
4gLffsx37FD9dHlAJP+ROlgzpDd01IGvgsmuxI22hKbfvSTGrq+6syf/qhBagfOc
FZ6rHINjHKzTD7oIE25InOENf+pEDmq128nIv6wA1o7kuwKhuJklHDd6b4bsNu6M
MJS0VM10TI6Gezxp+o2t
=vqRG
-----END PGP SIGNATURE-----

--mXDO3udm/xYWQeMQ--
