Received: from eggs.gnu.org ([2001:4830:134:3::10]:33214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecJiD-0004ix-Pn
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 18:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecJiC-0002Cc-9I
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 18:35:13 -0500
Date: Fri, 19 Jan 2018 10:33:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118233322.GZ30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-7-sjitindarsingh@gmail.com>
	<20180118052029.GR30352@umbus.fritz.box>
	<0cdab21f-0f70-f705-9ae3-e95eea69f65e@ozlabs.ru>
	<20180118055348.GU30352@umbus.fritz.box>
	<3680b2ae-def7-9b00-81d8-eb66ec0bea4e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oUI2l+Vq7ILP1REU"
Content-Disposition: inline
In-Reply-To: <3680b2ae-def7-9b00-81d8-eb66ec0bea4e@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 6/6]
 target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--oUI2l+Vq7ILP1REU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 07:11:41PM +1100, Alexey Kardashevskiy wrote:
> On 18/01/18 16:53, David Gibson wrote:
> > On Thu, Jan 18, 2018 at 04:44:28PM +1100, Alexey Kardashevskiy wrote:
> >> On 18/01/18 16:20, David Gibson wrote:
> >>> On Mon, Jan 15, 2018 at 05:32:35PM +1100, Suraj Jitindar Singh wrote:
> >>>> The new H-Call H_GET_CPU_CHARACTERISTICS is used by the guest to que=
ry
> >>>> behaviours and available characteristics of the cpu.
> >>>>
> >>>> Implement the handler for this new H-Call which formulates its respo=
nse
> >>>> based on the setting of the spapr_caps cap-cfpc, cap-sbbc and cap-ib=
s.
> >>>>
> >>>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> >>>> ---
> >>>>  hw/ppc/spapr_hcall.c   | 66 +++++++++++++++++++++++++++++++++++++++=
+++++++++++
> >>>>  include/hw/ppc/spapr.h |  1 +
> >>>>  2 files changed, 67 insertions(+)
> >>>>
> >>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >>>> index 51eba52e86..a693d3b852 100644
> >>>> --- a/hw/ppc/spapr_hcall.c
> >>>> +++ b/hw/ppc/spapr_hcall.c
> >>>> @@ -1654,6 +1654,69 @@ static target_ulong h_client_architecture_sup=
port(PowerPCCPU *cpu,
> >>>>      return H_SUCCESS;
> >>>>  }
> >>>> =20
> >>>> +static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
> >>>> +                                              sPAPRMachineState *sp=
apr,
> >>>> +                                              target_ulong opcode,
> >>>> +                                              target_ulong *args)
> >>>> +{
> >>>> +    uint64_t characteristics =3D H_CPU_CHAR_HON_BRANCH_HINTS &
> >>>> +			       ~H_CPU_CHAR_THR_RECONF_TRIG;
> >>>> +    uint64_t behaviour =3D H_CPU_BEHAV_FAVOUR_SECURITY;
> >>>> +    uint8_t safe_cache =3D spapr_get_cap(spapr, SPAPR_CAP_CFPC);
> >>>> +    uint8_t safe_bounds_check =3D spapr_get_cap(spapr, SPAPR_CAP_SB=
BC);
> >>>> +    uint8_t safe_indirect_branch =3D spapr_get_cap(spapr, SPAPR_CAP=
_IBS);
> >>>> +
> >>>> +    switch (safe_cache) {
> >>>> +    case SPAPR_CAP_WORKAROUND:
> >>>> +        characteristics |=3D H_CPU_CHAR_L1D_FLUSH_ORI30;
> >>>> +        characteristics |=3D H_CPU_CHAR_L1D_FLUSH_TRIG2;
> >>>> +        characteristics |=3D H_CPU_CHAR_L1D_THREAD_PRIV;
> >>>> +        behaviour |=3D H_CPU_BEHAV_L1D_FLUSH_PR;
> >>>> +        break;
> >>>> +    case SPAPR_CAP_FIXED:
> >>>> +        break;
> >>>> +    default: /* broken */
> >>>> +        if (safe_cache !=3D SPAPR_CAP_BROKEN) {
> >>>
> >>> I think you just assert() for this.  The only way these could get a
> >>> different value is if there's a bug elsewhere.
> >>
> >>
> >> Why not return H_HARDWARE or other error?
> >=20
> > Because what's the guest supposed to do with it.=20
>=20
> "oops"

Thereby making what is definitely a qemu bug appear to be a guest
problem.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oUI2l+Vq7ILP1REU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphLsIACgkQbDjKyiDZ
s5LdxxAAsEMShkcxak2PUiQKClLlQzgSKpt1SQjNLfiAznIipmja4seU0Bp1xLBe
7w5M3NjrhLgjPXu/ETM9jGjFEPdKlBOyGXEQnGf434DVKAkeNFAVwe8qyI7e/stp
1t1QboJyN47UmHlOh/3IOHVLsKMVwQMYyf/o/srw2vlIENCz+V04Jgr2JHOKkorV
ZnJN1CBN7sh04BxCjuYKs4dvT9e0bKquXmt1XNHx510IszMeH9gnGJtNgssFOVR/
rVz0Qp+n8ON3bdyLnS3d7n0+rNADUdxIMm+GfYcB+uPnHmawz1k2peIGh59gtyYj
0vQHZP9QNstRvrUnqwYqgN5n6GnUwlJgw1ynqDm+3p5coicmm0AI5v4WixO+E0Ho
I9vKuArKBGkS1/qPuSJzoXnetLXu7XAChexYRDUUFizgHf9lpQx2Hk2hVQ4pSfBw
yiU2vxA9KPn8oHY1Y3/csvBu/z7cUlGh/ch71F+Xfnl3ssfZms+FE2aueSooRcMx
bJKbXJ/AU0Exj2a63yUdBRNAyv+nTZ+T7vLDAv30B7VG1mEiuOlpcwypvFtPjdHc
aMCiftsrPfk9gcvLQoCpSv9FyzZh1NaMZ/IWUG6p+IoeAvQQKpHfTN/EJTAYmDj1
E+rfQxhMuHOolSzdAOfc2IMcvSkHj9SrCgZ6vX1MYPETjrxLIdQ=
=xKlh
-----END PGP SIGNATURE-----

--oUI2l+Vq7ILP1REU--
