Received: from eggs.gnu.org ([2001:4830:134:3::10]:54461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ec30A-0006f0-Jt
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ec307-00023K-Er
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:44:38 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ec307-00022Z-87
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 00:44:35 -0500
Received: by mail-io0-x241.google.com with SMTP id c17so23553691iod.1
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 21:44:35 -0800 (PST)
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-7-sjitindarsingh@gmail.com>
	<20180118052029.GR30352@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <0cdab21f-0f70-f705-9ae3-e95eea69f65e@ozlabs.ru>
Date: Thu, 18 Jan 2018 16:44:28 +1100
MIME-Version: 1.0
In-Reply-To: <20180118052029.GR30352@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="17bnbD61oBn53hL2OFCDzMSIIV66P9CZ8"
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
To: David Gibson <david@gibson.dropbear.id.au>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--17bnbD61oBn53hL2OFCDzMSIIV66P9CZ8
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Message-ID: <0cdab21f-0f70-f705-9ae3-e95eea69f65e@ozlabs.ru>
Subject: Re: [Qemu-ppc] [QEMU-PPC] [PATCH V3 6/6] target/ppc/spapr: Add H-Call
 H_GET_CPU_CHARACTERISTICS
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
 <20180115063235.7518-7-sjitindarsingh@gmail.com>
 <20180118052029.GR30352@umbus.fritz.box>
In-Reply-To: <20180118052029.GR30352@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18/01/18 16:20, David Gibson wrote:
> On Mon, Jan 15, 2018 at 05:32:35PM +1100, Suraj Jitindar Singh wrote:
>> The new H-Call H_GET_CPU_CHARACTERISTICS is used by the guest to query=

>> behaviours and available characteristics of the cpu.
>>
>> Implement the handler for this new H-Call which formulates its respons=
e
>> based on the setting of the spapr_caps cap-cfpc, cap-sbbc and cap-ibs.=

>>
>> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>> ---
>>  hw/ppc/spapr_hcall.c   | 66 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/ppc/spapr.h |  1 +
>>  2 files changed, 67 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 51eba52e86..a693d3b852 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1654,6 +1654,69 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
>>      return H_SUCCESS;
>>  }
>> =20
>> +static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>> +                                              sPAPRMachineState *spap=
r,
>> +                                              target_ulong opcode,
>> +                                              target_ulong *args)
>> +{
>> +    uint64_t characteristics =3D H_CPU_CHAR_HON_BRANCH_HINTS &
>> +			       ~H_CPU_CHAR_THR_RECONF_TRIG;
>> +    uint64_t behaviour =3D H_CPU_BEHAV_FAVOUR_SECURITY;
>> +    uint8_t safe_cache =3D spapr_get_cap(spapr, SPAPR_CAP_CFPC);
>> +    uint8_t safe_bounds_check =3D spapr_get_cap(spapr, SPAPR_CAP_SBBC=
);
>> +    uint8_t safe_indirect_branch =3D spapr_get_cap(spapr, SPAPR_CAP_I=
BS);
>> +
>> +    switch (safe_cache) {
>> +    case SPAPR_CAP_WORKAROUND:
>> +        characteristics |=3D H_CPU_CHAR_L1D_FLUSH_ORI30;
>> +        characteristics |=3D H_CPU_CHAR_L1D_FLUSH_TRIG2;
>> +        characteristics |=3D H_CPU_CHAR_L1D_THREAD_PRIV;
>> +        behaviour |=3D H_CPU_BEHAV_L1D_FLUSH_PR;
>> +        break;
>> +    case SPAPR_CAP_FIXED:
>> +        break;
>> +    default: /* broken */
>> +        if (safe_cache !=3D SPAPR_CAP_BROKEN) {
>=20
> I think you just assert() for this.  The only way these could get a
> different value is if there's a bug elsewhere.


Why not return H_HARDWARE or other error?



--=20
Alexey


--17bnbD61oBn53hL2OFCDzMSIIV66P9CZ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEZSrPibrORRTHQ99dhhM92CvBILkFAlpgNDwOHGFpa0Bvemxh
YnMucnUACgkQhhM92CvBILlzlRAAr4trxrFNvoq5/3aokZDnh0PreXbX83aGsas0
x1WXjssFeMB+Qq8p2o5DeFn2PzbuNtNCIRXp/xgrPEeUgCJZlbGfuZUXaTxFNMwQ
sCbUwm8Iz2FhPosjbV+4hcUnhEF5oPOJ1KiYwqykFffunHjhbjx0jfxbgxPZ2+SZ
BUv5yejtOd7tv/bc0XhU3JfflEofJdP0nAHL3TR+Lb2UaI5zW0frhdd6kQgepVVh
24K+Wpi+gjjGOYfhBR9WchXzaKtgjCkp8WY3cNXrg9ARyCM9IWk63EFs2CLj+ttm
aG0serEY+RaNc2Y7UibVqyF+p+cFIB2Qek1hpbqzjLErk9e60+B46hW2O3ieEwX7
+1SZJfRNspo4akpR6XgZSx2DBUCNHYdqdZPlbsbGGn0qO86QSNcaJT0VAhMM52gP
t19eJ7ko2xhsBGfxEQTS2FD/jreHx2cmc9AhZbO1e+TdscJ15G7wsThBJK8CvU+0
EPTF1clGcTHrkzwHNWgXa5B0IlDVx3WRGE0UK/QjhSJ5KeH1cpHoK5TjJbKKit7x
WeQG5b7qukvyyaaV9SxInmmJkLCJRCsjl6tOjkSdV+Pozn9OrhRXHnW8M+eBsxUK
r2SFNKZJ6kQlV83kVMFeFuMIW/BtaDddtUk9KlqTwkWHjX6k31fb/0dIP41M+tNI
nDnUv1Y=
=Lj21
-----END PGP SIGNATURE-----

--17bnbD61oBn53hL2OFCDzMSIIV66P9CZ8--
