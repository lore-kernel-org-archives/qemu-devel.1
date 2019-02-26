Received: from eggs.gnu.org ([209.51.188.92]:59545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gym0l-0002V3-HB
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:19:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gym0j-0000LN-LL
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:19:43 -0500
Date: Wed, 27 Feb 2019 10:19:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190226231920.GS6872@umbus.fritz.box>
References: <20190225162325.24008-1-maxiwell@linux.ibm.com>
	<20190225232009.GB30778@kermit.br.ibm.com>
	<20190226032103.GJ6872@umbus.fritz.box>
	<20190226142126.jxosththzad6h6dd@maxibm>
	<20190226170830.GA16569@kermit.br.ibm.com>
	<20190226191140.GA25467@kermit.br.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="96icqjDFsSi85SgI"
Content-Disposition: inline
In-Reply-To: <20190226191140.GA25467@kermit.br.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr-rtas: add ibm,
 get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, "open list:sPAPR" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org


--96icqjDFsSi85SgI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 04:11:40PM -0300, Murilo Opsfelder Araujo wrote:
> On Tue, Feb 26, 2019 at 02:08:30PM -0300, Murilo Opsfelder Araujo wrote:
> > Hi, Maxiwell.
> >
> > On Tue, Feb 26, 2019 at 11:21:26AM -0300, Maxiwell S. Garcia wrote:
> > > On Tue, Feb 26, 2019 at 02:21:03PM +1100, David Gibson wrote:
> > > > On Mon, Feb 25, 2019 at 08:20:09PM -0300, Murilo Opsfelder Araujo w=
rote:
> > > > > Hi, Maxiwell.
> > > > >
> > > > > On Mon, Feb 25, 2019 at 01:23:25PM -0300, Maxiwell S. Garcia wrot=
e:
> > > > > > This adds a handler for ibm,get-vpd RTAS calls, allowing pseries
> > > > > > guest to collect host information. It is disabled by default to
> > > > > > avoid unwanted information leakage. To enable it, use:
> > > > > > =E2=80=98-M pseries,vpd-export=3Don=E2=80=99
> > > > >
> > > > > The patch for setting host-serial and host-model already landed G=
ibson's
> > > > > ppc-for-4.0 branch:
> > > > >
> > > > >   commit 9e584f45868f6945c1282c938278038cba0e4af2
> > > > >   Author: Prasad J Pandit <pjp@fedoraproject.org>
> > > > >   Date:   Mon Feb 18 23:43:49 2019 +0530
> > > > >
> > > > >       ppc: add host-serial and host-model machine attributes (CVE=
-2019-8934)
> > > > >
> > > > >
> > > > > QEMU should only return host-serial and host-model from the host =
if the
> > > > > following combination of parameters are provided:
> > > > >
> > > > >   -M host-serial=3Dpassthrough,host-model=3Dpassthrough,vpd-expor=
t=3Don
> > > > >
> > > > > If host-serial or host-model are set with a user-string, ibm,get-=
vpd should
> > > > > honor these values and return them, not exposing host information=
 by accident.
> > > > >
> > > > > I'm not even sure if we need vpd-export=3D<bool> setting. Its log=
ic could be
> > > > > derived from the presence of host-serial=3Dpassthrough and host-m=
odel=3Dpassthrough
> > > > > options.
> > > > >
> > > > > What do you think?
> > > >
> > > > That's an excellent point - I hadn't thought through the fact that
> > > > this is the same information exposed by those properties.  I do ind=
eed
> > > > think that exposing the same information set in those properties - =
and
> > > > thereby avoiding the new machine option - would be a better plan.
> > > >
> > >
> > > I saw that the patch was applied. So I will work in another patch
> > > to use these properties and remove the export-vpd option.
> > >
> > > Another thing that I thought the fact that 'host-serial' and 'host-mo=
del'
> > > nodes in Device Tree are not in accordance with LoPAPR document. What
> > > you think in use only get-vpd to get these information and remove
> > > nodes from device tree?
> >
> > Both "system-id" and "model" properties are described in the section "3=
=2E3.2.1
> > Root Node Properties" of the "Device Tree Bindings: Linux on Power Arch=
itecture
> > Reference" document:
> >
> >   https://members.openpowerfoundation.org/wg/SYSSW/document/1455
>=20
> I replied too early. As Maxiwell explained to me (thanks Max!), guest can=
 end up
> having the following entries under /proc/device-tree/ (among other entrie=
s):
>=20
>   $ cat host-serial
>   12A3B4C
>=20
>   $ cat host-model
>   1234-56A
>=20
>   $ cat system-id
>   c7b62da9-3d0c-44f9-8edb-2318271f3c1a
>=20
>   $ cat model
>   IBM pSeries (emulated by qemu)
>=20
> Where:
>=20
>   - host-serial/host-model: depend on "-M host-serial" and "-M host-model"
>     machine options.
>=20
>   - system-id: created when "-uuid <val>" exists in qemu command line opt=
ions.
>=20
>   - model: hard-coded.
>=20
> With this patch, RTAS ibm,get-vpd call will return "system-id" and "model=
" from
> the host, not from the guest. I found this confusing.

Hrm.  I found the bit in LoPAPR describing how ibm,get-vpd operates,
but not something describing the actual data that appears within it.
Where's that described?  It'd be nice to check if those values are
supposed to be describing the host or the guest.


> Perhaps we can trick ibm,get-vpd call to return "host-serial" and "host-m=
odel"
> values from the guest, which will hold safe values after commit
> 9e584f45868f6945c1282c938278038cba0e4af2 "ppc: add host-serial and host-m=
odel
> machine attributes (CVE-2019-8934)".

Well, if it is supposed to be host values, then yes, absolutely, we
should be using the "host" values that the user supplies (if any).

> What do you think?
>=20
> As to removing "host-serial" and "host-model", I am not entirely sure for=
 what
> they are used. There should be a reason for them to exist.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--96icqjDFsSi85SgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx1yXgACgkQbDjKyiDZ
s5Iq1BAAh/E0M3t7rSHXS6/BkoAD8TeTmcvywWB436YayH7UzRnLRTzBrJytifnc
DoGVTHf1vIlKUsgf3WfV2jBimv46g4WXAazROd4cENpqcg/L7Z8h8Qa7RN2fIo/J
wZMqDmRln9dtW2nnFnyx7Rbvz6tgKI5nZi4RCUPibCmRLgu6tKUXu0cyjWJRfijW
61hjLzfCxVerxKCOrBO5vFEb4JMqzTLP1VWR3Aol0egGdPREVqV9Qm6PJUmQVz+e
E/RJznnKPP1Md5VibqCb/WFOU2kWlqrH90hQ7pOImeX8Fu2f0vCvbbc5tvgqrX1n
efUEut1wyrx/hpxra8nt9FIo1R7VVZw1M7eNqcF+5DD/yxNRXsu3GEiFiTcqsVgC
AEYHgDApbK7nczwEuFzQJIOnSleexr8rUVniNCF8PyhpBCqWWPNQpy0lRY9tO5AE
PT43VbHoLnqGS3Z3x0h4PS3RKd9L1l9Evn/3t044zA677E/xVhCL5DS2rMOP7AS/
Dd4g0Mng2KhnzhM1VaCcR8akWyH20oIpYng8kEzpRJrTRzoMZengmswxH8zL2Xev
FqeKwNbQf3Sa/ZP8LBE0WfWmpT6aP/jPk5isAMiaG6i0BhUmD1U+pKnyrHfNtVKQ
MXMD3IYcp2c8VhRnxsT7HrSimWk5JmUoygU4b8O5fKb4047ftlk=
=RLJ0
-----END PGP SIGNATURE-----

--96icqjDFsSi85SgI--
