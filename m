Received: from eggs.gnu.org ([2001:4830:134:3::10]:47866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dLsTq-0003PH-JB
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dLsTn-00082B-EX
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:44:10 -0400
Date: Fri, 16 Jun 2017 22:28:59 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170616142859.GG30484@umbus>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<20170609022813.GF26521@umbus.fritz.box>
	<20170609113631.229dd346@bahia.ttt.fr.ibm.com>
	<20170609102832.GL26521@umbus.fritz.box>
	<20170609170913.2e6526c3@bahia.ttt.fr.ibm.com>
	<20170611093842.GA13479@umbus>
	<20170613094302.1cb4012c@bahia.ttt.fr.ibm.com>
	<8760g01eae.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<87fuf0w6dp.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
Content-Disposition: inline
In-Reply-To: <87fuf0w6dp.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
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
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, rth@twiddle.net, alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 04:23:38PM +0530, Nikunj A Dadhania wrote:
> Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> writes:
>=20
> > Greg Kurz <groug@kaod.org> writes:
> >
> >> On Sun, 11 Jun 2017 17:38:42 +0800
> >> David Gibson <david@gibson.dropbear.id.au> wrote:
> >>
> >>> On Fri, Jun 09, 2017 at 05:09:13PM +0200, Greg Kurz wrote:
> >>> > On Fri, 9 Jun 2017 20:28:32 +1000
> >>> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >>> >  =20
> >>> > > On Fri, Jun 09, 2017 at 11:36:31AM +0200, Greg Kurz wrote: =20
> >>> > > > On Fri, 9 Jun 2017 12:28:13 +1000
> >>> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> >>> > > >    =20
> >>> > 1) start guest
> >>> >=20
> >>> > qemu-system-ppc64 \
> >>> >  -nodefaults -nographic -snapshot -no-shutdown -serial mon:stdio \
> >>> >  -device virtio-net,netdev=3Dnetdev0,id=3Dnet0 \
> >>> >  -netdev bridge,id=3Dnetdev0,br=3Dvirbr0,helper=3D/usr/libexec/qemu=
-bridge-helper \
> >>> >  -device virtio-blk,drive=3Ddrive0,id=3Dblk0 \
> >>> >  -drive file=3D/home/greg/images/sle12-sp1-ppc64le.qcow2,id=3Ddrive=
0,if=3Dnone \
> >>> >  -machine type=3Dpseries,accel=3Dtcg -cpu POWER8
> >
> > Strangely, your command line does not have multiple threads. Need to see
> > what is the side effect of enabling MTTCG by default here.
> >
> >>> >=20
> >>> > 2) migrate
> >>> >=20
> >>> > 3) destination crashes (immediately or after very short delay) or
> >>> > hangs =20
> >>>=20
> >>> Ok.  I'll bisect it when I can, but you might well get to it first.
> >>>=20
> >>>=20
> >>
> >> Heh, maybe you didn't see in my mail but I did bisect:
> >>
> >> f0b0685d6694a28c66018f438e822596243b1250 is the first bad commit
> >> commit f0b0685d6694a28c66018f438e822596243b1250
> >> Author: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >> Date:   Thu Apr 27 10:48:23 2017 +0530
> >>
> >>     tcg: enable MTTCG by default for PPC64 on x86
> >
> > Let me have a look at it.
>=20
> Interesting problem here, I see that when the migration is completed on
> source and there is a crash on destination:
>=20
> [   56.185314] Unable to handle kernel paging request for data at address=
 0x5deadbeef0000108
> [   56.185401] Faulting instruction address: 0xc000000000277bc8
>=20
>    0xc000000000277bb8 <+168>:	ld      r7,8(r4)
>    0xc000000000277bbc <+172>:	ld      r6,0(r4)                  <=3D=3D=
=3D=3D=3D=3D=3D=3D
>    0xc000000000277bc0 <+176>:	ori     r8,r8,56302
>    0xc000000000277bc4 <+180>:	rldicr  r8,r8,32,31
>    0xc000000000277bc8 <+184>:	std     r7,8(r6)
>=20
> r4 =3D 0xf0000000000107a0
> r6 =3D 0x5deadbeef0000100
>=20
> Code at 0xc000000000277bbc <+172>, gave junk value in r6, that leads to
> the guest crash. When I inspect the memory on source and destination in
> qemu monitor, I get the following differences:
>=20
> diff -u s.txt d.txt=20
> --- s.txt	2017-06-16 10:34:39.657221125 +0530
> +++ d.txt	2017-06-16 10:34:18.452238305 +0530
> @@ -8,8 +8,8 @@
>  f000000000010760: 0x20de0b00 0x000000f0 0x60040100 0x000000f0
>  f000000000010770: 0x00000000 0x00000000 0x0004036d 0x000000c0
>  f000000000010780: 0x6c000100 0xf8ff3f00 0x7817f977 0x000000c0
> -f000000000010790: 0x15000000 0x00000000 0xffffffff 0x01000000
> -f0000000000107a0: 0x3090a96d 0x000000c0 0x3090a96d 0x000000c0
> +f000000000010790: 0x01000000 0x00000000 0xffffffff 0x01000000
> +f0000000000107a0: 0x000100f0 0xeedbea5d 0x000200f0 0xeedbea5d
>  f0000000000107b0: 0x00000000 0x00000000 0x00d0a96d 0x000000c0
>  f0000000000107c0: 0x28000000 0xf8ff3f00 0x8852cc77 0x000000c0
>  f0000000000107d0: 0x00000000 0x00000000 0xffffffff 0x01000000
>=20
> Source had a valid address at 0xf0000000000107a0, while garbage on the
> destination.
>=20
> Some observations:
>=20
> * Source updates the memory location (probably atomic_cmpxchg), but the
>   updated page didnt get transferred to the destination
>  =20
> * Getting rid of atomic_cmpxchg tcg ops in ldarx/stdcx, makes migration
>   work fine. MTTCG running with 1 cpu.
>=20
> While I continue debugging, any hints would help.

My first guess would be that some or all of the new TCG atomic
primitives aren't updating the dirty page bitmap.

My second guess would be a race between the atomic TCG ops and the
migration / dirty map handling which means we can lost a memory update
and not transfer it to the destination.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQ+spAAoJEGw4ysog2bOS5h0P/3If52/P83yC2U5KH4EQmZIe
K9jp1ngeOQ4Yf48VQGsTEJpGk8B8oIMEoXZjVraK8AF30IKJ9Hq4ot6sUVEiKPSC
LGbBCzhnrucIGoAVLJ7OA5wD5K55VwAI9OG9VewgOda55orB1ddprgTxH+B2JB9Q
5doc5lAyP/76RlKomWu7e6EC351ajUL3/TiBduWF+5GCSaSFG0CxZNEr7swY58q+
Cdg4E9HhRSehUbmONpa8AeycPZnxNP/d/URAbcC+n/Ompn6rDzPL6kcp1Yltlpve
zsGS3BT5LtGcZ8ol9d/SJY3gtSc6W8Le962l1LCt9ccst8OapsIVGUmWOeUTDuOC
YP0+Z4xINLhFZfEHbXxUMPfou4NNSjhJDTFcChtRc4eo/6bf6P1X+ZVTqVerULCN
sbSSCJPXZWgfJ8Pu2TZIGKitBGZC8EzNgeFhQ+I98x8/ZD/5KC1fVz+xz1MQeIy2
ozQMLwPenRKHgRUTP+SwAWdDvQeU/4CDhmWZlBO/YENqUszZFqM1G+Q9tnleP3Aa
H34Q1DKOe/CkdPnjFfhQUT4qoY0M+HNDD5zkqQFyya3DYM39UhLOlaaphtc0s+DX
KQsjKSd3gjx+BYaodWedjz6U/6OvONVyCPVIiSOawlpXFakaOtchOU+OLoyvUIMg
VkVg90w1y4ZSVJIeO6L8
=0FR4
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--
