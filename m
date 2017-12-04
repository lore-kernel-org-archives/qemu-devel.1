Received: from eggs.gnu.org ([2001:4830:134:3::10]:54669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLmLT-0001Z7-4o
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLmLR-0003eJ-V8
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:43:23 -0500
Date: Mon, 4 Dec 2017 19:40:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204084040.GW2130@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-18-clg@kaod.org>
	<20171130055542.GG3023@umbus.fritz.box>
	<2cee93ff-060a-aa04-852c-d3585dba0c7f@kaod.org>
	<20171201041423.GF30161@umbus.fritz.box>
	<8d2e92cc-a305-d9d4-b28c-873acd76ee6a@kaod.org>
	<20171204015918.GK2130@umbus.fritz.box>
	<747d3b64-a068-6476-02e1-8a89161d4101@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="js+/jT5SQQin5+Fm"
Content-Disposition: inline
In-Reply-To: <747d3b64-a068-6476-02e1-8a89161d4101@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 17/25] spapr: add a sPAPRXive object to the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--js+/jT5SQQin5+Fm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2017 at 09:32:00AM +0100, C=E9dric Le Goater wrote:
> On 12/04/2017 02:59 AM, David Gibson wrote:
> > On Fri, Dec 01, 2017 at 09:10:24AM +0100, C=E9dric Le Goater wrote:
> >> On 12/01/2017 05:14 AM, David Gibson wrote:
> >>> On Thu, Nov 30, 2017 at 03:15:09PM +0000, C=E9dric Le Goater wrote:
> >>>> On 11/30/2017 05:55 AM, David Gibson wrote:
> >>>>> On Thu, Nov 23, 2017 at 02:29:47PM +0100, C=E9dric Le Goater wrote:
> >>>>>> The XIVE object is designed to be always available, so it is creat=
ed
> >>>>>> unconditionally on newer machines.
> >>>>>
> >>>>> There doesn't actually seem to be anything dependent on machine
> >>>>> version here.
> >>>>
> >>>> No. I thought that was too early in the patchset. This is handled=20
> >>>> in the last patch with a 'xive_exploitation' bool which is set to=20
> >>>> false on older machines.=20
> >>>>
> >>>> But, nevertheless, the XIVE objects are always created even if not
> >>>> used. Something to discuss.
> >>>
> >>> That'll definitely break backwards migration, since the destination
> >>> won't understand the (unused but still present) xive state it
> >>> receives.=20
> >>
> >> no because it's not sent. the vmstate 'needed' op of the sPAPRXive
> >> object discards it :
> >>
> >>     static bool vmstate_spapr_xive_needed(void *opaque)
> >>     {
> >>         sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >> =20
> >>         return spapr->xive_exploitation;
> >>     }
> >=20
> > Ah, sorry, missed that.  Once we have negotiation we'll need to make
> > sure the xive_exploitation bit is sent first, of course, but I'm
> > pretty sure the machine state is already sent first.
> >=20
> >>> So xives can only be created on new machine types.=20
> >>
> >> That would be better I agree. I can probably use the 'xive_exploitatio=
n'
> >> bool to condition its creation.
> >=20
> > Hrm.  I'm less sure about that - I'm not sure the lifetimes line up.
> > But I'd like to avoid creating them on earlier machine types, even if
> > xive_exploitation can't do the trick.
>=20
> Yes. I agree. I think we can work something out without introducing
> too much complexity. The XIVE object is directly used by the
> machine only to set/unset IRQ numbers. Otherwise, it is always=20
> conditioned by :
>=20
>     spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)
>=20
> I think adding a couple of more tests on the 'xive_exploitation'
> bool should work out for older machines.

Ok.  If not you can always add a "xive_possible" flag to the MachineClass.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--js+/jT5SQQin5+Fm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlolCgUACgkQbDjKyiDZ
s5IZUw//XCXtbxZPO8/8VkDtpesA2AshLcnZnZDVkVPtgorOB+zDwikU7PUbZ9g3
QsfKMZKS+m3+VfmPgnBtSkyMV58WK3Vd1n/m1dga98uGw9n8ltvfyWj1x/UOVIUX
KfUbtg//UsK6TP2KjgNPeR70JpECbnTSz6x6H0clY7NyrMEQ/TWIhNJG77/YNf5h
NBO2mVYqcNiabFSzUObyJiETCua5eAe9ABtQaSkUyiVL0erdPI8CfGnN5I1aVsC9
POndPWDpR4otopy7RqNmSuimrfqcIfgYQ4G3hMMEPbWzeRjow2LNHs0mccBVDMIe
xvls0OVmiTySrCSfajtqxleRbmUbg1kGldEW9fcO19meQ6TbxAZ/FDu50sZUBYIq
v5krupWuFdEoHotdyQ21+yj6A+wmLctnPctyc0X/D5ec3LwJY//cBsEUBVIrrtSh
h4x5Yy2Mwhkt+hHl7ANjMOG67x07dJEZl9ALker4qHL68KKS3vVJsLuE98fzSir3
d0NldkRSnOS0RWDqRg1qPDIOZKhZ1/JJOicmVeWKQ/rq9asNFYEuuBROoR7+DGqx
PGcQLa3ft3Cbulb/Xo/CybxKxygvjX/9tmHqdfhKwRcAm9/YM9Rq8nJU3WCdd75n
hd1/lAaDjcUb6YkTGJ/IORJe0zGNvB7fTbbue6B4lXE91T6LyU0=
=Q2wO
-----END PGP SIGNATURE-----

--js+/jT5SQQin5+Fm--
