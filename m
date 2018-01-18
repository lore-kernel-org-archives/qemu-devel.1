Received: from eggs.gnu.org ([2001:4830:134:3::10]:50734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ec5If-000645-VB
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ec5Ia-0005xl-Se
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:11:53 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:38494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ec5Ia-0005wv-Jg
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:11:48 -0500
Received: by mail-io0-x241.google.com with SMTP id d11so23934758iog.5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 00:11:48 -0800 (PST)
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-7-sjitindarsingh@gmail.com>
	<20180118052029.GR30352@umbus.fritz.box>
	<0cdab21f-0f70-f705-9ae3-e95eea69f65e@ozlabs.ru>
	<20180118055348.GU30352@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <3680b2ae-def7-9b00-81d8-eb66ec0bea4e@ozlabs.ru>
Date: Thu, 18 Jan 2018 19:11:41 +1100
MIME-Version: 1.0
In-Reply-To: <20180118055348.GU30352@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aEHc9cdHjVTqP56K4FtBy3Zxn1SmMblZW"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aEHc9cdHjVTqP56K4FtBy3Zxn1SmMblZW
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <3680b2ae-def7-9b00-81d8-eb66ec0bea4e@ozlabs.ru>
Subject: Re: [Qemu-ppc] [QEMU-PPC] [PATCH V3 6/6] target/ppc/spapr: Add H-Call
 H_GET_CPU_CHARACTERISTICS
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
 <20180115063235.7518-7-sjitindarsingh@gmail.com>
 <20180118052029.GR30352@umbus.fritz.box>
 <0cdab21f-0f70-f705-9ae3-e95eea69f65e@ozlabs.ru>
 <20180118055348.GU30352@umbus.fritz.box>
In-Reply-To: <20180118055348.GU30352@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18/01/18 16:53, David Gibson wrote:
> On Thu, Jan 18, 2018 at 04:44:28PM +1100, Alexey Kardashevskiy wrote:
>> On 18/01/18 16:20, David Gibson wrote:
>>> On Mon, Jan 15, 2018 at 05:32:35PM +1100, Suraj Jitindar Singh wrote:=

>>>> The new H-Call H_GET_CPU_CHARACTERISTICS is used by the guest to que=
ry
>>>> behaviours and available characteristics of the cpu.
>>>>
>>>> Implement the handler for this new H-Call which formulates its respo=
nse
>>>> based on the setting of the spapr_caps cap-cfpc, cap-sbbc and cap-ib=
s.
>>>>
>>>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>>>> ---
>>>>  hw/ppc/spapr_hcall.c   | 66 +++++++++++++++++++++++++++++++++++++++=
+++++++++++
>>>>  include/hw/ppc/spapr.h |  1 +
>>>>  2 files changed, 67 insertions(+)
>>>>
>>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>>>> index 51eba52e86..a693d3b852 100644
>>>> --- a/hw/ppc/spapr_hcall.c
>>>> +++ b/hw/ppc/spapr_hcall.c
>>>> @@ -1654,6 +1654,69 @@ static target_ulong h_client_architecture_sup=
port(PowerPCCPU *cpu,
>>>>      return H_SUCCESS;
>>>>  }
>>>> =20
>>>> +static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>>>> +                                              sPAPRMachineState *sp=
apr,
>>>> +                                              target_ulong opcode,
>>>> +                                              target_ulong *args)
>>>> +{
>>>> +    uint64_t characteristics =3D H_CPU_CHAR_HON_BRANCH_HINTS &
>>>> +			       ~H_CPU_CHAR_THR_RECONF_TRIG;
>>>> +    uint64_t behaviour =3D H_CPU_BEHAV_FAVOUR_SECURITY;
>>>> +    uint8_t safe_cache =3D spapr_get_cap(spapr, SPAPR_CAP_CFPC);
>>>> +    uint8_t safe_bounds_check =3D spapr_get_cap(spapr, SPAPR_CAP_SB=
BC);
>>>> +    uint8_t safe_indirect_branch =3D spapr_get_cap(spapr, SPAPR_CAP=
_IBS);
>>>> +
>>>> +    switch (safe_cache) {
>>>> +    case SPAPR_CAP_WORKAROUND:
>>>> +        characteristics |=3D H_CPU_CHAR_L1D_FLUSH_ORI30;
>>>> +        characteristics |=3D H_CPU_CHAR_L1D_FLUSH_TRIG2;
>>>> +        characteristics |=3D H_CPU_CHAR_L1D_THREAD_PRIV;
>>>> +        behaviour |=3D H_CPU_BEHAV_L1D_FLUSH_PR;
>>>> +        break;
>>>> +    case SPAPR_CAP_FIXED:
>>>> +        break;
>>>> +    default: /* broken */
>>>> +        if (safe_cache !=3D SPAPR_CAP_BROKEN) {
>>>
>>> I think you just assert() for this.  The only way these could get a
>>> different value is if there's a bug elsewhere.
>>
>>
>> Why not return H_HARDWARE or other error?
>=20
> Because what's the guest supposed to do with it.=20

"oops"

> This is an internal
> qemu problem, so it should be dealt with via an internal qemu
> mechanism.

Do we have assert() enabled in production? If not, then assert =3D=3D noo=
p,
error_report is just a noise.



--=20
Alexey


--aEHc9cdHjVTqP56K4FtBy3Zxn1SmMblZW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlpgVr0OHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILn2kQ/+IZ9c6yOtRd5Z109cTcOcZrYuPHyIHXI4QNbS
kOPEUK5Lsjk7hBxSTh++2bkJQ/MUTNGq943xxa7QJB0fums5kCvasvqB2Q2OLYLo
5OcaQtOTiG3j2dttfZBPFANRDpGmP57PDhQZrCm/At3jH+t56SfHGaxSXQdzVaE6
rcHPlkILmPvL56WuqG3/oaHV4lPL8Zv3fg28munOKxI7pDjyLazKa3g+Tqyyfhdd
YlTooZkW0u2GQ6OL1V7t4h31+xK9Vl+aRyX+0rPa79s00tvSvyrPM02Z6KmOHjpR
JSM72KyTJ9oelygM/EdmIw9UuT3zdPubIGSNAYqGIrX4yrNysrbb90NbCAq9CjEr
YpgPJMrxBnAZD1GSByVzMKt0Mhk0P7FlNkMhApClxb5UBU4aGJiddldMmdErB8g7
nIWlw2OeA6nh+mdq8xtjUkZaWnnPWHwB2NQq2Wbf+e0lEOmyByz7sKaUi3dvAeLu
0vAR2lCwrjsEjv0Sl7IQHUBTue2ssV182er92Qv2L0V1/8gHq3i2lHwWBjNU3VTU
J8GmMtYvClumrXUZWo+Wmz5/QRtf72garZNPPK25eCJ8sjk+8Y+ZLmM5RelEqKJ4
1LcwNtIQyaPjHaIeLm9V2zaMA/KWosTFHv0rfF6z8+X7fhfrga2dZxS64/efntB1
CuwhYes=
=DhkX
-----END PGP SIGNATURE-----

--aEHc9cdHjVTqP56K4FtBy3Zxn1SmMblZW--
