Received: from eggs.gnu.org ([2001:4830:134:3::10]:38606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duuzJ-000473-Tg
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duuzI-00063h-Cq
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:29:29 -0400
Date: Thu, 21 Sep 2017 15:31:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170921053107.GD4998@umbus.fritz.box>
References: <20170919082421.GU27153@umbus>
	<871sn2hugn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920045524.GH5520@umbus.fritz.box>
	<87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2017 at 09:24:46AM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Wed, Sep 20, 2017 at 12:48:55PM +0530, Nikunj A Dadhania wrote:
> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >>=20
> >> > On Wed, Sep 20, 2017 at 12:10:48PM +0530, Nikunj A Dadhania wrote:
> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >>=20
> >> >> > On Wed, Sep 20, 2017 at 10:43:19AM +0530, Nikunj A Dadhania wrote:
> >> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >> >>=20
> >> >> >> > On Wed, Sep 20, 2017 at 09:50:24AM +0530, Nikunj A Dadhania wr=
ote:
> >> >> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >> >> >>=20
> >> >> >> >> > On Fri, Sep 15, 2017 at 02:39:16PM +0530, Nikunj A Dadhania=
 wrote:
> >> >> >> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >> >> >> >>=20
> >> >> >> >> >> > On Fri, Sep 15, 2017 at 01:53:15PM +0530, Nikunj A Dadha=
nia wrote:
> >> >> >> >> >> >> David Gibson <david@gibson.dropbear.id.au> writes:
> >> >> >> >> >> >>=20
> >> >> >> >> >> >> >>=20
> >> >> >> >> >> >> >> I thought, I am doing the same here for PowerNV, num=
ber of online cores
> >> >> >> >> >> >> >> is equal to initial online vcpus / threads per core
> >> >> >> >> >> >> >>=20
> >> >> >> >> >> >> >>    int boot_cores_nr =3D smp_cpus / smp_threads;
> >> >> >> >> >> >> >>=20
> >> >> >> >> >> >> >> Only difference that I see in PowerNV is that we hav=
e multiple chips
> >> >> >> >> >> >> >> (max 2, at the moment)
> >> >> >> >> >> >> >>=20
> >> >> >> >> >> >> >>         cores_per_chip =3D smp_cpus / (smp_threads *=
 pnv->num_chips);
> >> >> >> >> >> >> >
> >> >> >> >> >> >> > This doesn't make sense to me.  Cores per chip should=
 *always* equal
> >> >> >> >> >> >> > smp_cores, you shouldn't need another calculation for=
 it.
> >> >> >> >> >> >> >
> >> >> >> >> >> >> >> And in case user has provided sane smp_cores, we use=
 it.
> >> >> >> >> >> >> >
> >> >> >> >> >> >> > If smp_cores isn't sane, you should simply reject it,=
 not try to fix
> >> >> >> >> >> >> > it.  That's just asking for confusion.
> >> >> >> >> >> >>=20
> >> >> >> >> >> >> This is the case where the user does not provide a topo=
logy(which is a
> >> >> >> >> >> >> valid scenario), not sure we should reject it. So qemu =
defaults
> >> >> >> >> >> >> smp_cores/smt_threads to 1. I think it makes sense to o=
ver-ride.
> >> >> >> >> >> >
> >> >> >> >> >> > If you can find a way to override it by altering smp_cor=
es when it's
> >> >> >> >> >> > not explicitly specified, then ok.
> >> >> >> >> >>=20
> >> >> >> >> >> Should I change the global smp_cores here as well ?
> >> >> >> >> >
> >> >> >> >> > I'm pretty uneasy with that option.
> >> >> >> >>=20
> >> >> >> >> Me too.
> >> >> >> >>=20
> >> >> >> >> > It would take a fair bit of checking to ensure that changin=
g smp_cores
> >> >> >> >> > is safe here. An easier to verify option would be to make t=
he generic
> >> >> >> >> > logic which splits up an unspecified -smp N into cores and =
sockets
> >> >> >> >> > more flexible, possibly based on machine options for max va=
lues.
> >> >> >> >> >
> >> >> >> >> > That might still be more trouble than its worth.
> >> >> >> >>=20
> >> >> >> >> I think the current approach is the simplest and less intrusi=
ve, as we
> >> >> >> >> are handling a case where user has not bothered to provide a =
detailed
> >> >> >> >> topology, the best we can do is create single threaded cores =
equal to
> >> >> >> >> number of cores.
> >> >> >> >
> >> >> >> > No, sorry.  Having smp_cores not correspond to the number of c=
ores per
> >> >> >> > chip in all cases is just not ok.  Add an error message if the
> >> >> >> > topology isn't workable for powernv by all means.  But users h=
aving to
> >> >> >> > use a longer command line is better than breaking basic assump=
tions
> >> >> >> > about what numbers reflect what topology.
> >> >> >>=20
> >> >> >> Sorry to ask again, as I am still not convinced, we do similar
> >> >> >> adjustment in spapr where the user did not provide the number of=
 cores,
> >> >> >> but qemu assumes them as single threaded cores and created
> >> >> >> cores(boot_cores_nr) that were not same as smp_cores ?
> >> >> >
> >> >> > What?  boot_cores_nr has absolutely nothing to do with adjusting =
the
> >> >> > topology, and it certainly doesn't assume they're single threaded.
> >> >>=20
> >> >> When we start a TCG guest and user provides following commandline, =
e.g.
> >> >> "-smp 4", smt_threads is set to 1 by default in vl.c. So the guest =
boots
> >> >> with 4 cores, each having 1 thread.
> >> >
> >> > Ok.. and what's the problem with that behaviour on powernv?
> >>=20
> >> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has the
> >> default value of 1 in vl.c. In powernv, we were setting nr-cores like
> >> this:
> >>=20
> >>         object_property_set_int(chip, smp_cores, "nr-cores", &error_fa=
tal);
> >>=20
> >> Even when there were multiple cpus (-smp 4), when the guest boots up, =
we
> >> just get one core (i.e. smp_cores was 1) with single thread(smp_threads
> >> was 1), which is wrong as per the command-line that was provided.
> >
> > Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
> > thread.  If you can't supply 4 sockets you should error, but you
> > shouldn't go and change the number of cores per socket.
>=20
> OK, that makes sense now. And I do see that smp_cpus is 4 in the above
> case. Now looking more into it, i see that powernv has something called
> "num_chips", isnt this same as sockets ? Do we need num_chips separately?

Ah, yes, I see.  It's probably still reasonable to keep num_chips as
an internal variable, rather than using (smp_cpus / smp_cores /
smp_threads) everywhere.  But we shouldn't have it as a direct
user-settable property, instead setting it from the -smp command line
option.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnDTpkACgkQbDjKyiDZ
s5K3ShAAsDce4TFB/VQepUl8ajx9Yvlgh2MwFppGoXGvotbWzR5t65OOAM2LFgWR
U1u1v0wbh5f/oCn/NdC8VW23TlCPxDDvKTdiy7kKQIaRBOYhMCnqENY5TMns4Qmo
INU3X4XFlG6Q6z4A+MkAtstiR8oSOYRrbNUx0seNB0G9EIMqmNHx/pylhy7dHX5v
ncNjAeqGkRF16qSBmm3SUAPhMV5ImOQOLDV9s1sbuEKJyt2M6d9cbO0LK/9N4zXE
YPsfvFIPMDyFGniu8RpJjGjPfhcXtm+0nmBhkAp9FyPPa4IjY9O82ShfL1GgHx7W
P+dkBM38kxwMRBuoFTS2eIdPOAUyHfaQYhm/kaf2Wm2US/emspzqD6a8HODsEr9m
VJsrXLbXC20boHg9f7RcXz0C8V/pFFohIzrKqb9ixs/MDYxSA/2rttvN2YppDKBk
HOvr+OzMWxE8brexq72x4zb0lodPloAUCoGrUNSmG9begZ+wPjlEYnud5iDtz8BS
C+LNoATnBPCMeu+ksNHC6w1BS19rb4BFS2EmdBP/EXYw7y/pc44ZwqjFjFLK5oeE
K/RPTlGwaZPN0B46NsATs7xOMV9x2lhC0F1b0DSI2TwJGd+xkB4FOAFB44fyp8ds
bm+jJF9JALrDu2lC3zxA2IUWZe07yoOUEYOkAG+t0rHjiGOHnsA=
=+akz
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
