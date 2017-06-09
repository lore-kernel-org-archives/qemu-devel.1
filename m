Received: from eggs.gnu.org ([2001:4830:134:3::10]:53020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbL-0007iO-G8
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbK-00061r-FO
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:11 -0400
Date: Fri, 9 Jun 2017 20:28:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609102832.GL26521@umbus.fritz.box>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<20170609022813.GF26521@umbus.fritz.box>
	<20170609113631.229dd346@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aYrjF+tKt+ApYAdb"
Content-Disposition: inline
In-Reply-To: <20170609113631.229dd346@bahia.ttt.fr.ibm.com>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--aYrjF+tKt+ApYAdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 11:36:31AM +0200, Greg Kurz wrote:
> On Fri, 9 Jun 2017 12:28:13 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jun 08, 2017 at 03:42:32PM +0200, Greg Kurz wrote:
> > > I've provided answers for all comments from the v3 review that I deli=
berately
> > > don't address in v4. =20
> >=20
> > I've merged patches 1-4.  5 & 6 I'm still reviewing.
> >=20
>=20
> Cool. FYI, I forgot to mention that I only tested with KVM.
>=20
> I'm now trying with TCG and I hit various guest crash on
> the destination (using your ppc-for-2.10 branch WITHOUT
> my patches):

Drat.  What's your reproducer for this crash?

>=20
> cpu 0x0: Vector: 700 (Program Check) at [c0000000787ebae0]
>     pc: c0000000002803c4: __fput+0x284/0x310
>     lr: c000000000280258: __fput+0x118/0x310
>     sp: c0000000787ebd60
>    msr: 8000000000029033
>   current =3D 0xc00000007cbab640
>   paca    =3D 0xc000000007b80000   softe: 0        irq_happened: 0x01
>     pid   =3D 1812, comm =3D gawk
> kernel BUG at ../include/linux/fs.h:2399!
> enter ? for help
> [c0000000787ebdb0] c0000000000d7d84 task_work_run+0xe4/0x160
> [c0000000787ebe00] c000000000018054 do_notify_resume+0xb4/0xc0
> [c0000000787ebe30] c00000000000a730 ret_from_except_lite+0x5c/0x60
> --- Exception: c00 (System Call) at 00003fff9026dd90
> SP (3fffcb37b790) is in userspace
> 0:mon>=20
>=20
> or
>=20
> cpu 0x0: Vector: 300 (Data Access) at [c00000007fff7490]
>     pc: c0000000001ef768: free_pcppages_bulk+0x2b8/0x500
>     lr: c0000000001ef524: free_pcppages_bulk+0x74/0x500
>     sp: c00000007fff7710
>    msr: 8000000000009033
>    dar: c0000000807afc70
>  dsisr: 40000000
>   current =3D 0xc00000007c609190
>   paca    =3D 0xc000000007b80000   softe: 0        irq_happened: 0x01
>     pid   =3D 1631, comm =3D systemctl
> enter ? for help
> [c00000007fff77c0] c0000000001eff24 free_hot_cold_page+0x204/0x270
> [c00000007fff7810] c0000000001f5848 __put_single_page+0x48/0x60
> [c00000007fff7840] c00000000059ac50 skb_release_data+0xb0/0x180
> [c00000007fff7880] c00000000059ae38 kfree_skb+0x58/0x130
> [c00000007fff78c0] c00000000063f604 __udp4_lib_mcast_deliver+0x3d4/0x460
> [c00000007fff7a50] c00000000063fb0c __udp4_lib_rcv+0x47c/0x770
> [c00000007fff7b00] c0000000006023a8 ip_local_deliver_finish+0x148/0x310
> [c00000007fff7b50] c0000000006026c4 ip_rcv_finish+0x154/0x420
> [c00000007fff7bd0] c0000000005b1154 __netif_receive_skb_core+0x874/0xac0
> [c00000007fff7cc0] c0000000005b30d4 netif_receive_skb+0x34/0xd0
> [c00000007fff7d00] d000000000ef3c74 virtnet_poll+0x514/0x8a0 [virtio_net]
> [c00000007fff7e10] c0000000005b3668 net_rx_action+0x1d8/0x310
> [c00000007fff7ea0] c0000000000b0cc4 __do_softirq+0x154/0x330
> [c00000007fff7f90] c0000000000251ac call_do_softirq+0x14/0x24
> [c00000007fff3ef0] c000000000011be0 do_softirq+0xe0/0x110
> [c00000007fff3f30] c0000000000b10e8 irq_exit+0xc8/0x110
> [c00000007fff3f60] c0000000000117e8 __do_irq+0xb8/0x1c0
> [c00000007fff3f90] c0000000000251d0 call_do_irq+0x14/0x24
> [c00000007a94bac0] c000000000011990 do_IRQ+0xa0/0x120
> [c00000007a94bb20] c00000000000a8b0 restore_check_irq_replay+0x2c/0x5c
> --- Exception: 501 (Hardware Interrupt) at c000000000010f84 arch_local_ir=
q_restore+0x74/0x90
> [c00000007a94be10] 000000000000000c (unreliable)
> [c00000007a94be30] c00000000000a704 ret_from_except_lite+0x30/0x60
> --- Exception: 501 (Hardware Interrupt) at 00003fffa04a2c28
> SP (3ffff7f1bf60) is in userspace
> 0:mon>=20
>=20
> These doesn't seem to occur with QEMU master. I'll try to
> investigate.

Thanks.  I'm going to be in China for the next couple of weeks.  I'll
still be working, but my time will be divided.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aYrjF+tKt+ApYAdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOnhQAAoJEGw4ysog2bOSbrwQAI41IHJQ7uotQRYiNnuvN+Aa
LOIxEbRhTcAtwcv84b7cpCpuJD0bJbMsPnzvuQtfxF47q7a7hCwE2pGacBCtRVxb
NQop5Evc/d9ZolVeTh6jKn3/lDtm6FoZakbLvCoOSwpgGWvevtL/Wm5fWqqdi1Iy
lgYQZpsumsfAuN96e5NBYRYSqQjupRfpoH45MLtZJegUq+iVKIe4EXrw64woDFsK
0QSxRltfjQ50pUqAiQDrZMFC08CwPpimh/1ZIeLCWVsPS2pIeh94/5pkIn7igIfT
9vewii6JJWZFV+miDdy2cNC3sOKRU2WxZ2Phqvbhb9OslbeA4z21STOAGDRSzmib
04CKgXeFdbhhWXoaQzNbdqqe5qNXDQKCRQYV1QcE71zOc1ue+HcvFkNQNox2MJCD
kfLtby7yaRkC59CgDJNsrjfGfhst96s1Du5P0nstcGEIRY7U7btYEI0W2YUoXDeu
UEnIym301Ikw4fKJ3dSWQrZ0aNdwGvWczLosSyiVZ9TXgBNCokcARCLsu8MYc+aA
pO/i5z++7XhmZHEKKeZw+boYlmgV1oqS4LLVfeA2dcTAZCE3SqGSvj1HA69J42e6
LEkuvZpaP2l92EC5MPPF5WEQOlaoEi4lZDRAGhI7VEsAZXO8/t+XbvTwclyeTHh7
IsY3UDeLsn4Ek0CXpJkr
=AXjQ
-----END PGP SIGNATURE-----

--aYrjF+tKt+ApYAdb--
