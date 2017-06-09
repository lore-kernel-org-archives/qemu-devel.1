Received: from eggs.gnu.org ([2001:4830:134:3::10]:36144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJGLV-000806-Dk
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJGLQ-000218-I1
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:36:45 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:46812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dJGLQ-00020c-8p
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 05:36:40 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id BCF583EC0E
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 11:36:38 +0200 (CEST)
Date: Fri, 9 Jun 2017 11:36:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170609113631.229dd346@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170609022813.GF26521@umbus.fritz.box>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<20170609022813.GF26521@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/fImAmv7BqyEY7=U_1U9sQ+A";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v4 0/6] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>

--Sig_/fImAmv7BqyEY7=U_1U9sQ+A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jun 2017 12:28:13 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 08, 2017 at 03:42:32PM +0200, Greg Kurz wrote:
> > I've provided answers for all comments from the v3 review that I delibe=
rately
> > don't address in v4. =20
>=20
> I've merged patches 1-4.  5 & 6 I'm still reviewing.
>=20

Cool. FYI, I forgot to mention that I only tested with KVM.

I'm now trying with TCG and I hit various guest crash on
the destination (using your ppc-for-2.10 branch WITHOUT
my patches):

cpu 0x0: Vector: 700 (Program Check) at [c0000000787ebae0]
    pc: c0000000002803c4: __fput+0x284/0x310
    lr: c000000000280258: __fput+0x118/0x310
    sp: c0000000787ebd60
   msr: 8000000000029033
  current =3D 0xc00000007cbab640
  paca    =3D 0xc000000007b80000   softe: 0        irq_happened: 0x01
    pid   =3D 1812, comm =3D gawk
kernel BUG at ../include/linux/fs.h:2399!
enter ? for help
[c0000000787ebdb0] c0000000000d7d84 task_work_run+0xe4/0x160
[c0000000787ebe00] c000000000018054 do_notify_resume+0xb4/0xc0
[c0000000787ebe30] c00000000000a730 ret_from_except_lite+0x5c/0x60
--- Exception: c00 (System Call) at 00003fff9026dd90
SP (3fffcb37b790) is in userspace
0:mon>=20

or

cpu 0x0: Vector: 300 (Data Access) at [c00000007fff7490]
    pc: c0000000001ef768: free_pcppages_bulk+0x2b8/0x500
    lr: c0000000001ef524: free_pcppages_bulk+0x74/0x500
    sp: c00000007fff7710
   msr: 8000000000009033
   dar: c0000000807afc70
 dsisr: 40000000
  current =3D 0xc00000007c609190
  paca    =3D 0xc000000007b80000   softe: 0        irq_happened: 0x01
    pid   =3D 1631, comm =3D systemctl
enter ? for help
[c00000007fff77c0] c0000000001eff24 free_hot_cold_page+0x204/0x270
[c00000007fff7810] c0000000001f5848 __put_single_page+0x48/0x60
[c00000007fff7840] c00000000059ac50 skb_release_data+0xb0/0x180
[c00000007fff7880] c00000000059ae38 kfree_skb+0x58/0x130
[c00000007fff78c0] c00000000063f604 __udp4_lib_mcast_deliver+0x3d4/0x460
[c00000007fff7a50] c00000000063fb0c __udp4_lib_rcv+0x47c/0x770
[c00000007fff7b00] c0000000006023a8 ip_local_deliver_finish+0x148/0x310
[c00000007fff7b50] c0000000006026c4 ip_rcv_finish+0x154/0x420
[c00000007fff7bd0] c0000000005b1154 __netif_receive_skb_core+0x874/0xac0
[c00000007fff7cc0] c0000000005b30d4 netif_receive_skb+0x34/0xd0
[c00000007fff7d00] d000000000ef3c74 virtnet_poll+0x514/0x8a0 [virtio_net]
[c00000007fff7e10] c0000000005b3668 net_rx_action+0x1d8/0x310
[c00000007fff7ea0] c0000000000b0cc4 __do_softirq+0x154/0x330
[c00000007fff7f90] c0000000000251ac call_do_softirq+0x14/0x24
[c00000007fff3ef0] c000000000011be0 do_softirq+0xe0/0x110
[c00000007fff3f30] c0000000000b10e8 irq_exit+0xc8/0x110
[c00000007fff3f60] c0000000000117e8 __do_irq+0xb8/0x1c0
[c00000007fff3f90] c0000000000251d0 call_do_irq+0x14/0x24
[c00000007a94bac0] c000000000011990 do_IRQ+0xa0/0x120
[c00000007a94bb20] c00000000000a8b0 restore_check_irq_replay+0x2c/0x5c
--- Exception: 501 (Hardware Interrupt) at c000000000010f84 arch_local_irq_=
restore+0x74/0x90
[c00000007a94be10] 000000000000000c (unreliable)
[c00000007a94be30] c00000000000a704 ret_from_except_lite+0x30/0x60
--- Exception: 501 (Hardware Interrupt) at 00003fffa04a2c28
SP (3ffff7f1bf60) is in userspace
0:mon>=20

These doesn't seem to occur with QEMU master. I'll try to investigate.

> >=20
> > v4: - some patches from v3 got merged
> >     - added some more preparatory cleanup in xics (patches 1,2)
> >     - merge cpu_setup() handler into realize() (patch 4)
> >     - see individual changelog for patches 3 and 6
> >=20
> > v3: - preparatory cleanup in pnv (patch 1)
> >     - rework ICPState realization and vmstate registration (patches 2,3=
,4)
> >     - fix migration using dummy icp/server entries (patch 5)
> >=20
> > v2: - some patches from v1 are already merged in ppc-for-2.10
> >     - added a new fix to a potential memory leak (patch 1)
> >     - consolidate dt_id computation (patch 3)
> >     - see individual changelogs for patch 2 and 4
> >=20
> > I could successfully do the following on POWER8 host with full cores (S=
MT8):
> >=20
> > 1) start a pseries-2.9 machine with QEMU 2.9:
> >         -smp cores=3D1,threads=3D2,maxcpus=3D8
> > 2) hotplug a core:
> >         device_add host-spapr-cpu-core,core-id=3D4
> > 3) migrate to QEMU 2.10 configured with core-id 0,4
> > 4) hotplug another core:
> >         device_add host-spapr-cpu-core,core-id=3D2
> > 5) migrate back to QEMU 2.9 configured with core-id 0,4,2
> > 6) hotplug the core in the last available slot:
> >         device_add host-spapr-cpu-core,core-id=3D6
> > 7) migrate to QEMU 2.10 configured with core-id 0,4,2,6
> >=20
> > I could check that the guest is functional after each migration.
> >  =20
>=20


--Sig_/fImAmv7BqyEY7=U_1U9sQ+A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk6bB8ACgkQAvw66wEB28ImrACfUu5MQsVpa9pMxTgKUG6XGADc
tycAnjGehIMSgkrWyD6SDnr1UIpJTrAw
=yysd
-----END PGP SIGNATURE-----

--Sig_/fImAmv7BqyEY7=U_1U9sQ+A--
