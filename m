Received: from eggs.gnu.org ([2001:4830:134:3::10]:51009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJb3-0007EW-JM
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJb1-0004bP-1K
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:37 -0400
Date: Wed, 23 Aug 2017 10:24:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823002414.GB5379@umbus.fritz.box>
References: <20170815202846.24749-1-danielhb@linux.vnet.ibm.com>
	<20170817075236.GI5509@umbus.fritz.box>
	<bfc6e0bb-af59-f5b4-f50b-66feab7dc301@linux.vnet.ibm.com>
	<20170818041429.GP5509@umbus.fritz.box>
	<9ba2f12d-ee6d-419e-28e9-15143ee33e1e@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <9ba2f12d-ee6d-419e-28e9-15143ee33e1e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc: disable hotplug before
 CAS is completed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2017 at 08:50:44PM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 08/18/2017 01:14 AM, David Gibson wrote:
> > On Thu, Aug 17, 2017 at 06:31:28PM -0300, Daniel Henrique Barboza wrote:
> > >=20
> > > On 08/17/2017 04:52 AM, David Gibson wrote:
> > > > On Tue, Aug 15, 2017 at 05:28:46PM -0300, Daniel Henrique Barboza w=
rote:
> > > > > This patch is a follow up on the discussions that started with
> > > > > Laurent's patch series "spapr: disable hotplugging without OS" [1]
> > > > > and discussions made at patch "spapr: reset DRCs on migration
> > > > > pre_load" [2].
> > > > >=20
> > > > > At this moment, we do not support CPU/memory hotplug in early
> > > > > boot stages, before CAS. The reason is that the hotplug event
> > > > > can't be handled at SLOF level (or even in PRELAUNCH runstate) and
> > > > > at the same time can't be canceled. This leads to devices being
> > > > > unable to be hot unplugged and, in some cases, guest kernel Ooops.
> > > > > After CAS, with the FDT in place, the guest can handle the hotplug
> > > > > events and everything works as usual.
> > > > >=20
> > > > > An attempt to try to support hotplug before CAS was made, but not
> > > > > successful. The key difference in the current code flow between a
> > > > > coldplugged and a hotplugged device, in the PRELAUNCH state, is t=
hat
> > > > > the coldplugged device is registered at the base FDT, allowing its
> > > > > DRC to go straight to CONFIGURED state. In theory, this can also =
be
> > > > > done with a hotplugged device if we can add it to the base of the
> > > > > existing FDT. However, tampering with the FDT after writing in the
> > > > > guest memory, besides being a dubitable idea, is also not
> > > > > possible. The FDT is written in ppc_spapr_reset and there is no
> > > > > way to retrieve it - we can calculate the fdt_address but the
> > > > > fdt_size isn't stored. Storing the fdt_size to allow for
> > > > > later retrieval is yet another state that would need to be
> > > > > migrated. In short, it is not worth the trouble.
> > > > >=20
> > > > > All this said, this patch opted to disable CPU/mem hotplug at ear=
ly
> > > > > boot stages. CAS detection is made by checking if there are
> > > > > any bits set in ov5_cas to avoid adding an extra state that
> > > > > would need tracking/migration. The patch also makes sure that
> > > > > it doesn't interfere with hotplug in the INMIGRATE state.
> > > > >=20
> > > > > [1] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg0522=
6.html
> > > > > [2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg0198=
9.html
> > > > >=20
> > > > > Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.c=
om>
> > > > I don't think this is a good idea.
> > > >=20
> > > > 1) After my DRC cleanups, early hotplug works just fine for me.  I'm
> > > > not sure why it isn't for you: we need to understand that before
> > > > proceeding.
> > > >=20
> > > > 2) libvirt actually uses early hotplug fairly often (before even
> > > > starting the firmware).  At the moment this works - at least in some
> > > > cases (see above), though there are some wrinkles to work out.  This
> > > > will break it completely and require an entirely different approach=
 to
> > > > fix again.
> > > Now that you mentioned I remember having this same discussion with yo=
u,
> > > about the same topic. Back then we decided to leave it alone, since y=
ou
> > > couldn't
> > > reproduce the behavior but I could.
> > >=20
> > > I still can reproduce this bug and ended up investigating a bit more =
today:
> > >=20
> > >=20
> > > - one difference in QEMU between hotplugging before and after CAS is =
here:
> > >=20
> > > hw/ppc/spapr_events.c - rtas_event_log_to_source
> > >=20
> > >      switch (log_type) {
> > >      case RTAS_LOG_TYPE_HOTPLUG:
> > >          source =3D spapr_event_sources_get_source(spapr->event_sourc=
es,
> > > EVENT_CLASS_HOT_PLUG);
> > >          if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
> > >              g_assert(source->enabled);
> > >              break;
> > >          }
> > >          /* fall back to epow for legacy hotplug interrupt source */
> > >      case RTAS_LOG_TYPE_EPOW:
> > >          source =3D spapr_event_sources_get_source(spapr->event_sourc=
es,
> > >                                                  EVENT_CLASS_EPOW);
> > >          break;
> > >      default:
> > >=20
> > >=20
> > > Note the ovec_test for OV5_HP_EVT. When hotplugging a CPU In early bo=
ot,
> > > ov5_cas
> > > doesn't have anything set, making this check fails and due to the 'br=
eak'
> > > position there
> > > (that I believe it is intended), it falls back to log the event as EP=
OW
> > > instead of HOT_PLUG.
> > Ah.. I'm not sure if this is the cause of the problem you're seeing,
> > but it's a good point regardless.  We're queuing an event before we
> > know how to queue events, which is definitely wrong.
> >=20
> > Urgh.. how to fix this.  Banning hotplug until after CAS seems
> > logically sound, but will break the libvirt use case.  So we could..
> >=20
> > 1) Queue events internally, but only deliver them to the right actual
> > RTAS queue after CAS.  Blech.
> >=20
> > 2) At CAS time, reset all the DRCs, and emit extra DT information for
> > anything hotplugged since init.  I've suggested this before, but
> > dropped it when early hotplug seemed to be working for me.
>=20
> Update: I've been trying to do the (2) solution here by adding extra
> DT info of the hotplugged CPU, while resetting its DRC. The problem I am
> facing is that the kernel panics at parse_numa_properties when trying to
> find the node id of the added CPU. This is intriguing because the extra DT
> info is enough to make the kernel start the added CPU at smp_release_cpus=
().
>=20
> The DT information is being added at the CAS response, in
> spapr_fixup_cpu_dt,
> and it's the same information that is added for the coldplugged CPUs. I h=
ave
> a
> theory that the guest (SLOF?) isn't prepared to handle a new CPU being ad=
ded
> at
> this point, which might be leading to this kernel bug I am seeing. I
> appreciate if
> anyone with good CAS/SLOF knowledge can weight in here - there is a good
> chance
> that adding a new CPU element at this point in the DT isn't supported at
> all.
>=20
>=20
> Now, in other news ....
>=20
> >=20
> > 3) Work around in libvirt by having it issue a system_reset after the
> > hotplugs.
>=20
> ... talking with Mike about this bug he proposed a similar solution to (3=
),
> but with
> a CAS induced reset. If there are hotplugged devs at that point, set
> spapr->cas_reboot
> to true. Doing that, QEMU reboots automatically and the hotplugged devs a=
re
> considered
> coldplugged. It works.
>=20
> I am mentioning this because this is a simpler solution than relying on
> libvirt issuing a system_reset. This is also solution that I would like to
> avoid though - I
> am not looking forward to see people bugs complaining about the machine
> rebooting in
> the middle of the boot. I will exhaust my attempts at (2) before proposing
> going
> with this CAS reboot solution.

Ah!  Actually I think that's a great idea.  I mean, it's an ugly hack,
but it should also get us something that more or less works with
*much* less work than other approaches.  So I think it's a good
interim solution.

Do you have a patch?  It's probably too late for qemu 2.10, but if we
can get it in as soon as 2.11 opens, then we should be able to get it
into the RH releases at least, which will be very helpful.

>=20
>=20
> Thanks,
>=20
>=20
> Daniel
>=20
>=20
>=20
>=20
>=20
> >=20
> > In the short to medium term at least, I think (2) is probably our
> > best option.
> >=20
> >=20
> > > I tried to hack this code by adding another break and ensure that the=
 event
> > > got logged
> > > as HOT_PLUG (like it happens in the post-CAS) but then I got a kernel=
 panic
> > > at boot. So
> > > I am not sure if this code needs any change or afterthought.
> > >=20
> > > - hotplugging the CPU at early stage gives me a warning message in SL=
OF:
> > >=20
> > > --------------
> > >=20
> > > Calling ibm,client-architecture-support...Node not supported
> > > Node not supported
> > >   not implemented
> > > memory layout at init:
> > > ---------------
> > >=20
> > > The code that gives the 'Node not supported' message is related to the
> > > fdt-create-cas-node
> > > function of board-qemu/slof/fdt.fs . The code is looking for either
> > > "memory@" or
> > > "ibm,dynamic-reconfiguration-memory" nodes, giving this error when fi=
nding a
> > > CPU node.
> > >=20
> > >=20
> > > - if I hotplug another CPU after the guest completes the boot, the
> > > previously added
> > > CPU suddenly turns online too:
> > Right the interrupt from the new event is unjamming the queue, so the
> > guest kernel / drmgr is then able to add the earlier cpu as well.
> >=20
> > > [ started VM with -S ]
> > >=20
> > > (qemu) device_add host-spapr-cpu-core,id=3Dcore1,core-id=3D1
> > > (qemu) cont
> > >=20
> > > [ guest finishes boot ]
> > >=20
> > > danielhb@ubuntu1710:~$ lscpu
> > > Architecture:        ppc64le
> > > Byte Order:          Little Endian
> > > CPU(s):              1
> > > On-line CPU(s) list: 0
> > > Thread(s) per core:  1
> > > Core(s) per socket:  1
> > > Socket(s):           1
> > > NUMA node(s):        1
> > > Model:               2.1 (pvr 004b 0201)
> > > Model name:          POWER8E (raw), altivec supported
> > > Hypervisor vendor:   KVM
> > > Virtualization type: para
> > > L1d cache:           64K
> > > L1i cache:           32K
> > > NUMA node0 CPU(s):   0
> > > danielhb@ubuntu1710:~$
> > > danielhb@ubuntu1710:~$
> > > danielhb@ubuntu1710:~$ (qemu)
> > > (qemu) info cpus
> > > * CPU #0: nip=3D0xc0000000000a464c thread_id=3D131946
> > >    CPU #1: nip=3D0x0000000000000000 (halted) thread_id=3D131954
> > > (qemu)
> > > (qemu) device_add host-spapr-cpu-core,id=3Dcore2,core-id=3D2
> > > (qemu)
> > > (qemu) info cpus
> > > * CPU #0: nip=3D0xc0000000000a464c thread_id=3D131946
> > >    CPU #1: nip=3D0xc0000000000a464c thread_id=3D131954
> > >    CPU #2: nip=3D0xc0000000000a464c thread_id=3D132144
> > > (qemu)
> > >=20
> > > danielhb@ubuntu1710:~$ lscpu
> > > Architecture:        ppc64le
> > > Byte Order:          Little Endian
> > > CPU(s):              3
> > > On-line CPU(s) list: 0-2
> > > Thread(s) per core:  1
> > > Core(s) per socket:  3
> > > Socket(s):           1
> > > NUMA node(s):        1
> > > Model:               2.1 (pvr 004b 0201)
> > > Model name:          POWER8E (raw), altivec supported
> > > Hypervisor vendor:   KVM
> > > Virtualization type: para
> > > L1d cache:           64K
> > > L1i cache:           32K
> > > NUMA node0 CPU(s):   0-2
> > > danielhb@ubuntu1710:~$
> > >=20
> > >=20
> > > This makes me believe that the issue is that the guest isn't aware of=
 the
> > > CPU
> > > presence, making me wonder whether this has something to do with the
> > > qemu_irq_pulse
> > > in the end of spapr_hotplug_req_event being lost. In the second hotpl=
ug, we
> > > re-assert the IRQ in the end of check-exception and the guest is made=
 aware
> > > of
> > > the queued hotplug event that was ignored at first.
> > Yeah, I think that's it.
> >=20
> >=20
> > >=20
> > >=20
> > > Daniel
> > > > 3) There's no fundamental reason early hotplug shouldn't work - the
> > > > event will just be queued until the OS boots and processes it.
> > > >=20
> > > > I know I suggested disabling early hotplug earlier, but that was
> > > > before I'd dug into the DRC layer and properly understood what was
> > > > going on here.
> > > >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmcyy4ACgkQbDjKyiDZ
s5LWZg//XRXcj3uTLE2lld/SGVDGPPLJqAVVPE+C5MWtf1HXzaaQuMvYxaTPLS7k
B34XEkoxIKa3YLjipmjxE/GPAkdJSjtVAbM9UxDgg261zfoZuKUmtEPdcXHUuaBo
0Ag3RGOLCnByOATfN52wyx4JW4+Y1os4359D5StDNGvBmeJ9muAKMXl3Y7xdK3vW
RdvVotgFK0aT6Lgkmb9qj0QYkYNtHOQg8deqIVlUJJ/0BX233rmlg35EUxDkHLy6
KmMg0HnmyNVvQ4V05aA/e+17lCwT4FB+S3DtFichBEZLXEUo7IDgRFvHGss90snp
OETm64QMPMqfrw9Z0ncR+vA+72W9doARJlS7ASYHttwOJiqN37mUTUpjw8T97gPz
qoO8PIP+zxqLCWyoXg9V3TIMzLcHElncLEIIC4Ot/iYYdiSOdFDP0E5UiF3hKqt0
f8D2TwotxOhSRTKft6GMndphLhEiW4uHp6T4h5sGHmCkwnMJelkJUNSrHJJPe2SA
7C6m/OoLvvH2r2qKZwYZ3WwpFUwWJRFfN36DSKmIQ9qT6Q6kxr8mIcktAFiSFHf1
0WtlZvdPiv0beohmkLWrjZlYrfWqJxc05IHYfieoLaMgrV91AibSI9fHwT37h+O2
SL59tho4nwQ9r9NRIM2860H1TF+AkcJc1AmVQWgvsh/q+XOMT+0=
=hvYp
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
