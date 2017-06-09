Received: from eggs.gnu.org ([2001:4830:134:3::10]:34040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJLXT-0004PJ-Fz
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJLXN-0002PO-EC
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:09:27 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:58455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dJLXN-0002Or-4f
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:09:21 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 9516F3895F
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 17:09:19 +0200 (CEST)
Date: Fri, 9 Jun 2017 17:09:13 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170609170913.2e6526c3@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170609102832.GL26521@umbus.fritz.box>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<20170609022813.GF26521@umbus.fritz.box>
	<20170609113631.229dd346@bahia.ttt.fr.ibm.com>
	<20170609102832.GL26521@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/c.PIZY9=8FDXSCjI2zyK7zo";
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

--Sig_/c.PIZY9=8FDXSCjI2zyK7zo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Jun 2017 20:28:32 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jun 09, 2017 at 11:36:31AM +0200, Greg Kurz wrote:
> > On Fri, 9 Jun 2017 12:28:13 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Thu, Jun 08, 2017 at 03:42:32PM +0200, Greg Kurz wrote: =20
> > > > I've provided answers for all comments from the v3 review that I de=
liberately
> > > > don't address in v4.   =20
> > >=20
> > > I've merged patches 1-4.  5 & 6 I'm still reviewing.
> > >  =20
> >=20
> > Cool. FYI, I forgot to mention that I only tested with KVM.
> >=20
> > I'm now trying with TCG and I hit various guest crash on
> > the destination (using your ppc-for-2.10 branch WITHOUT
> > my patches): =20
>=20
> Drat.  What's your reproducer for this crash?
>=20

1) start guest

qemu-system-ppc64 \
 -nodefaults -nographic -snapshot -no-shutdown -serial mon:stdio \
 -device virtio-net,netdev=3Dnetdev0,id=3Dnet0 \
 -netdev bridge,id=3Dnetdev0,br=3Dvirbr0,helper=3D/usr/libexec/qemu-bridge-=
helper \
 -device virtio-blk,drive=3Ddrive0,id=3Dblk0 \
 -drive file=3D/home/greg/images/sle12-sp1-ppc64le.qcow2,id=3Ddrive0,if=3Dn=
one \
 -machine type=3Dpseries,accel=3Dtcg -cpu POWER8

2) migrate

3) destination crashes (immediately or after very short delay) or hangs

> >=20
> > cpu 0x0: Vector: 700 (Program Check) at [c0000000787ebae0]
> >     pc: c0000000002803c4: __fput+0x284/0x310
> >     lr: c000000000280258: __fput+0x118/0x310
> >     sp: c0000000787ebd60
> >    msr: 8000000000029033
> >   current =3D 0xc00000007cbab640
> >   paca    =3D 0xc000000007b80000   softe: 0        irq_happened: 0x01
> >     pid   =3D 1812, comm =3D gawk
> > kernel BUG at ../include/linux/fs.h:2399!
> > enter ? for help
> > [c0000000787ebdb0] c0000000000d7d84 task_work_run+0xe4/0x160
> > [c0000000787ebe00] c000000000018054 do_notify_resume+0xb4/0xc0
> > [c0000000787ebe30] c00000000000a730 ret_from_except_lite+0x5c/0x60
> > --- Exception: c00 (System Call) at 00003fff9026dd90
> > SP (3fffcb37b790) is in userspace =20
> > 0:mon>  =20
> >=20
> > or
> >=20
> > cpu 0x0: Vector: 300 (Data Access) at [c00000007fff7490]
> >     pc: c0000000001ef768: free_pcppages_bulk+0x2b8/0x500
> >     lr: c0000000001ef524: free_pcppages_bulk+0x74/0x500
> >     sp: c00000007fff7710
> >    msr: 8000000000009033
> >    dar: c0000000807afc70
> >  dsisr: 40000000
> >   current =3D 0xc00000007c609190
> >   paca    =3D 0xc000000007b80000   softe: 0        irq_happened: 0x01
> >     pid   =3D 1631, comm =3D systemctl
> > enter ? for help
> > [c00000007fff77c0] c0000000001eff24 free_hot_cold_page+0x204/0x270
> > [c00000007fff7810] c0000000001f5848 __put_single_page+0x48/0x60
> > [c00000007fff7840] c00000000059ac50 skb_release_data+0xb0/0x180
> > [c00000007fff7880] c00000000059ae38 kfree_skb+0x58/0x130
> > [c00000007fff78c0] c00000000063f604 __udp4_lib_mcast_deliver+0x3d4/0x460
> > [c00000007fff7a50] c00000000063fb0c __udp4_lib_rcv+0x47c/0x770
> > [c00000007fff7b00] c0000000006023a8 ip_local_deliver_finish+0x148/0x310
> > [c00000007fff7b50] c0000000006026c4 ip_rcv_finish+0x154/0x420
> > [c00000007fff7bd0] c0000000005b1154 __netif_receive_skb_core+0x874/0xac0
> > [c00000007fff7cc0] c0000000005b30d4 netif_receive_skb+0x34/0xd0
> > [c00000007fff7d00] d000000000ef3c74 virtnet_poll+0x514/0x8a0 [virtio_ne=
t]
> > [c00000007fff7e10] c0000000005b3668 net_rx_action+0x1d8/0x310
> > [c00000007fff7ea0] c0000000000b0cc4 __do_softirq+0x154/0x330
> > [c00000007fff7f90] c0000000000251ac call_do_softirq+0x14/0x24
> > [c00000007fff3ef0] c000000000011be0 do_softirq+0xe0/0x110
> > [c00000007fff3f30] c0000000000b10e8 irq_exit+0xc8/0x110
> > [c00000007fff3f60] c0000000000117e8 __do_irq+0xb8/0x1c0
> > [c00000007fff3f90] c0000000000251d0 call_do_irq+0x14/0x24
> > [c00000007a94bac0] c000000000011990 do_IRQ+0xa0/0x120
> > [c00000007a94bb20] c00000000000a8b0 restore_check_irq_replay+0x2c/0x5c
> > --- Exception: 501 (Hardware Interrupt) at c000000000010f84 arch_local_=
irq_restore+0x74/0x90
> > [c00000007a94be10] 000000000000000c (unreliable)
> > [c00000007a94be30] c00000000000a704 ret_from_except_lite+0x30/0x60
> > --- Exception: 501 (Hardware Interrupt) at 00003fffa04a2c28
> > SP (3ffff7f1bf60) is in userspace =20
> > 0:mon>  =20
> >=20
> > These doesn't seem to occur with QEMU master. I'll try to
> > investigate. =20
>=20

Bisect leads to:

f0b0685d6694a28c66018f438e822596243b1250 is the first bad commit
commit f0b0685d6694a28c66018f438e822596243b1250
Author: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date:   Thu Apr 27 10:48:23 2017 +0530

    tcg: enable MTTCG by default for PPC64 on x86

I guess we're still not completely ready to support MTTCG...

Cc'ing Nikunj for insights.

> Thanks.  I'm going to be in China for the next couple of weeks.  I'll
> still be working, but my time will be divided.
>=20

Hey, have a good trip! :)

Cheers,

--
Greg

--Sig_/c.PIZY9=8FDXSCjI2zyK7zo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk6uhkACgkQAvw66wEB28KyMgCcCigot/Capkz7M8vlwZmuRNRo
XMIAoJfEL6o9gFJf0GQ3/sl5uqODN/rw
=0vlk
-----END PGP SIGNATURE-----

--Sig_/c.PIZY9=8FDXSCjI2zyK7zo--
