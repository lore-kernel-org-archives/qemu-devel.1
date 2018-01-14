Received: from eggs.gnu.org ([2001:4830:134:3::10]:47379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eajOX-0004xm-Df
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 09:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eajOT-0005l7-Gu
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 09:36:21 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1512742402-31669-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA8-5Rgt82tfDFkh3niUYsvSUKmHeTsk7e+Mzq3HJMBbpA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aabb3f02-30ee-2bd1-f214-2469ce3e7cad@amsat.org>
Date: Sun, 14 Jan 2018 11:36:09 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-5Rgt82tfDFkh3niUYsvSUKmHeTsk7e+Mzq3HJMBbpA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="hyqlyFeHWzQKpcxPlNDZTMMOu50Ii93tj"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] get_phys_addr_pmsav7: Support
 AP=0b111 for v7M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andy Gross <andy.gross@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hyqlyFeHWzQKpcxPlNDZTMMOu50Ii93tj
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>,
 Andy Gross <andy.gross@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "patches@linaro.org" <patches@linaro.org>
Message-ID: <aabb3f02-30ee-2bd1-f214-2469ce3e7cad@amsat.org>
Subject: Re: [Qemu-arm] [Qemu-devel] [PATCH] get_phys_addr_pmsav7: Support
 AP=0b111 for v7M
References: <1512742402-31669-1-git-send-email-peter.maydell@linaro.org>
 <CAFEAcA8-5Rgt82tfDFkh3niUYsvSUKmHeTsk7e+Mzq3HJMBbpA@mail.gmail.com>
In-Reply-To: <CAFEAcA8-5Rgt82tfDFkh3niUYsvSUKmHeTsk7e+Mzq3HJMBbpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter, Andy,

> On 8 December 2017 at 14:13, Peter Maydell <peter.maydell@linaro.org> w=
rote:
>> For PMSAv7, the v7A/R Arm ARM defines that setting AP to 0b111
>> is an UNPREDICTABLE reserved combination. However, for v7M
>> this value is documented as having the same behaviour as 0b110:
>> read-only for both privileged and unprivileged. Accept this
>> value on an M profile core rather than treating it as a guest
>> error and a no-access page.

So, checking "Access permission checking":

v7-AR:
 case perms.ap of
   when =E2=80=98000=E2=80=99 abort =3D TRUE;
   when =E2=80=98001=E2=80=99 abort =3D !ispriv;
   when =E2=80=98010=E2=80=99 abort =3D !ispriv && iswrite;
   when =E2=80=98011=E2=80=99 abort =3D FALSE;
   when =E2=80=98100=E2=80=99 UNPREDICTABLE;
   when =E2=80=98101=E2=80=99 abort =3D !ispriv || iswrite;
   when =E2=80=98110=E2=80=99 abort =3D iswrite;
   when =E2=80=98111=E2=80=99
     if MemorySystemArchitecture() =3D=3D MemArch_VMSA then
       abort =3D iswrite
     else
       UNPREDICTABLE;

v7-M:
 case perms.ap of
   when =E2=80=98000=E2=80=99 fault =3D TRUE;
   when =E2=80=98001=E2=80=99 fault =3D !ispriv;
   when =E2=80=98010=E2=80=99 fault =3D !ispriv && iswrite;
   when =E2=80=98011=E2=80=99 fault =3D FALSE;
   when =E2=80=98100=E2=80=99 UNPREDICTABLE;
   when =E2=80=98101=E2=80=99 fault =3D !ispriv || iswrite;
   when =E2=80=98110=E2=80=99 fault =3D iswrite;
   when =E2=80=98111=E2=80=99 fault =3D iswrite;
   otherwise UNPREDICTABLE;

You are indeed correct.

Having a 3bits perms.ap, I wonder how you can reach the 'otherwise'
case... :)

// Access permissions descriptor
type Permissions is (
 bits(3) ap, // Access Permission bits
 bit xn // Execute Never bit
)

This appears in the "Access permissions field encoding" table:

```
The AP bits, AP[2:0], are used for access permissions.
=2E..
110 Read-only Read-only Privileged and unprivileged read-only
111 Read-only Read-only Privileged and unprivileged read-only
```

However I think this v7-M PMSAv7 behaviour is not obviously
differentiated in the  Architecture Reference Manual:

```
ARMv7-M supports the standard PMSAv7 of the ARMv7-R architecture
profile, with the following extensions:

=E2=80=A2 An optimized two register update model, where software can sele=
ct the
region to update by writing to the
MPU Region Base Address Register. This optimization applies to the first
sixteen memory regions (0 =E2=89=A4
RegionNumber =E2=89=A4 0xF) only.

=E2=80=A2 The MPU Region Base Address Register and the MPU Region Attribu=
te and
Size Register pairs are aliased
in three consecutive dual-word locations. Using the two register update
model, software can modify up to
four regions by writing the appropriate even number of words using a
single STM multi-word store instruction.
```

They might add smth such:

"and with the following differences/restrictions: ..."

>>
>> Reported-by: Andy Gross <andy.gross@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>> ---
>>  target/arm/helper.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 91a9300..2f53dd8 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -9229,6 +9229,13 @@ static bool get_phys_addr_pmsav7(CPUARMState *e=
nv, uint32_t address,
>>                  case 6:
>>                      *prot |=3D PAGE_READ | PAGE_EXEC;
>>                      break;
>> +                case 7:
>> +                    /* for v7M, same as 6; for R profile a reserved v=
alue */
>> +                    if (arm_feature(env, ARM_FEATURE_M)) {
>> +                        *prot |=3D PAGE_READ | PAGE_EXEC;
>> +                        break;
>> +                    }
>> +                    /* fall through */
>>                  default:
>>                      qemu_log_mask(LOG_GUEST_ERROR,
>>                                    "DRACR[%d]: Bad value for AP bits: =
0x%"
>> @@ -9247,6 +9254,13 @@ static bool get_phys_addr_pmsav7(CPUARMState *e=
nv, uint32_t address,
>>                  case 6:
>>                      *prot |=3D PAGE_READ | PAGE_EXEC;
>>                      break;
>> +                case 7:
>> +                    /* for v7M, same as 6; for R profile a reserved v=
alue */
>> +                    if (arm_feature(env, ARM_FEATURE_M)) {
>> +                        *prot |=3D PAGE_READ | PAGE_EXEC;
>> +                        break;
>> +                    }
>> +                    /* fall through */
>>                  default:
>>                      qemu_log_mask(LOG_GUEST_ERROR,
>>                                    "DRACR[%d]: Bad value for AP bits: =
0x%"
>> --
>> 2.7.4
>=20


--hyqlyFeHWzQKpcxPlNDZTMMOu50Ii93tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpbatkACgkQ4+MsLN6t
wN4WBRAAw05gUeRI/jWz07vF7FyIeMXrYzt/j8iTXSDI/6LVF0wTHmKB53UBzSKz
Dd86HiNSRmPAjgXHyYxfVY8RUKb4xhaAtPd99pxNZ7YOS96zxMDr6CHyL3twyh8g
V2UtfcCrOolcnmOxVBW7kYVo3VHUub1SJwEg8E8XMUvTUu3gspZbwWFDdbo+DeUo
yJIo5o5JXyiiUXRT1N6kwptmmEjt6OzjfTKyKwEthIhOCIdSyEuqznK0gjb4Z9dF
sXcIdcy0N6EFFxMQ9khRPo2KG5T39VJH6alTpqaGBSqE3XCo+p7HjEn642wKBNor
kUe+WlvRrA7l5XCIqmlean854y1RXDGLy5evOdnBjjAYrjdp2f3uc6kiLGWRbdpt
m++nXIBdhDDVU8mEbRFrTxIvLLCbKaTbukJZf/CSn8M+c9oIGdKGvPoUJnWg6OSJ
8C/7J0m+YDZBpkEafoMRm4YqxF15BgR/WdB9/S64L7WPv0iph50mOFi1k4xsV3BS
2tApIM2erzo6ANGQiVJIJJI3PLTiuiK24tG//8H9CbvlOYMBV7ctirhGiL6NPF15
W2dv//xuo8LDk7kQrrV0XKiLjhUu1c/A/DosFVOZMb4pdku7uaRQEfI9d2yyN054
UNgwLBBB5BKY9Noi06iPRfjt0dKTPjtYNBMqeHj4GTZ4CjKhoVQ=
=1OxS
-----END PGP SIGNATURE-----

--hyqlyFeHWzQKpcxPlNDZTMMOu50Ii93tj--
