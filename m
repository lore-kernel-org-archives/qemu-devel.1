Received: from eggs.gnu.org ([2001:4830:134:3::10]:58103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1eddyL-0008De-7Q
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:25:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1eddyK-0002Or-Dv
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:25:21 -0500
References: <20180119145756.7629-1-luc.michel@greensocs.com>
	<20180119145756.7629-6-luc.michel@greensocs.com>
	<CAFEAcA8VJAfksRenr_CJauTc2wpfN1fUchixrfGbvjBkeoR-Vg@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <dbfbc395-48f1-9f0d-cfc4-29ca41076c01@greensocs.com>
Date: Mon, 22 Jan 2018 16:25:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8VJAfksRenr_CJauTc2wpfN1fUchixrfGbvjBkeoR-Vg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c7UddyyFRxcnPSq52kssngWhFQMyHOyO9"
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/intc/arm_gic: Fix the NS view of
 C_BPR when C_CTRL.CBPR is 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Luc MICHEL <luc.michel@git.antfield.fr>, QEMU Developers <qemu-devel@nongnu.org>Luc MICHEL <luc.michel@git.antfield.fr>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c7UddyyFRxcnPSq52kssngWhFQMyHOyO9
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Luc MICHEL <luc.michel@git.antfield.fr>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Luc MICHEL <luc.michel@git.antfield.fr>, qemu-arm <qemu-arm@nongnu.org>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <dbfbc395-48f1-9f0d-cfc4-29ca41076c01@greensocs.com>
Subject: Re: [PATCH 4/4] hw/intc/arm_gic: Fix the NS view of C_BPR when
 C_CTRL.CBPR is 1
References: <20180119145756.7629-1-luc.michel@greensocs.com>
 <20180119145756.7629-6-luc.michel@greensocs.com>
 <CAFEAcA8VJAfksRenr_CJauTc2wpfN1fUchixrfGbvjBkeoR-Vg@mail.gmail.com>
In-Reply-To: <CAFEAcA8VJAfksRenr_CJauTc2wpfN1fUchixrfGbvjBkeoR-Vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2018 04:19 PM, Peter Maydell wrote:
> On 19 January 2018 at 14:57,  <luc.michel@greensocs.com> wrote:
>> From: Luc MICHEL <luc.michel@git.antfield.fr>
>>
>> When C_CTRL.CBPR is 1, the Non-Secure view of C_BPR is altered:
>>   - A Non-Secure read of C_BPR should return the BPR value plus 1,
>>   saturated to 7,
>>   - A Non-Secure write should be ignored.
>>
>> Signed-off-by: Luc MICHEL <luc.michel@git.antfield.fr>
>> ---
>>  hw/intc/arm_gic.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
>> index d0a41a89ae..7418b7a082 100644
>> --- a/hw/intc/arm_gic.c
>> +++ b/hw/intc/arm_gic.c
>> @@ -1211,8 +1211,13 @@ static MemTxResult gic_cpu_read(GICState *s, in=
t cpu, int offset,
>>          break;
>>      case 0x08: /* Binary Point */
>>          if (s->security_extn && !attrs.secure) {
>> -            /* BPR is banked. Non-secure copy stored in ABPR. */
>> -            *data =3D s->abpr[cpu];
>> +            if (s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) {
>> +                /* NS view of BPR when CBPR is 1 */
>> +                *data =3D MIN(s->bpr[cpu] + 1, 7);
>> +            } else {
>> +                /* BPR is banked. Non-secure copy stored in ABPR. */
>> +                *data =3D s->abpr[cpu];
>> +            }
>>          } else {
>>              *data =3D s->bpr[cpu];
>>          }
>> @@ -1285,7 +1290,12 @@ static MemTxResult gic_cpu_write(GICState *s, i=
nt cpu, int offset,
>>          break;
>>      case 0x08: /* Binary Point */
>>          if (s->security_extn && !attrs.secure) {
>> -            s->abpr[cpu] =3D MAX(value & 0x7, GIC_MIN_ABPR);
>> +            if (s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) {
>> +                /* WI when CTLR is 1 */
>=20
> should be "CBPR", yes?
Oops yes, sorry.

>=20
>> +                return MEMTX_OK;
>> +            } else {
>> +                s->abpr[cpu] =3D MAX(value & 0x7, GIC_MIN_ABPR);
>> +            }
>>          } else {
>>              s->bpr[cpu] =3D MAX(value & 0x7, GIC_MIN_BPR);
>>          }
>> --
>=20
> thanks
> -- PMM
>=20


--c7UddyyFRxcnPSq52kssngWhFQMyHOyO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJNBAEBCAA3FiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlpmAkwZHGx1Yy5taWNo
ZWxAZ3JlZW5zb2NzLmNvbQAKCRB3ySdbdCdOvvpgD/9m2Trgk6iZnmkehTnEn+5d
FB7oMBaBga1zmaHdTWM/Eqw7X4Fh/n9O/lt555laDBMsxesB0mAEZXYiitUTnZqP
I66kpGMYJk0uwDwwiRSKUMzAhZUO4WAocaqxSqjimDnQaWcq35qv5/DtbUGSTPQz
X/0VJv5Wd+3tEsUYJVGE7NCtyeH54NMiSmHc7uNh6PSwajV3jK88o3TEziFd/Y/a
MYkVC7ZrFn8Dg1dtJijPq7I9xrcYnvqqw9SkJvzGDbo/3jdse/SHqSlj/df+hpj5
odW0SGb7tYvDSrOib+Tf5j+v2TIyw02shTGAVz9TYzhQ7xi7uit7gkrY7xUAe8ZL
wgHsvsrRRobH/F6L0qL80C6qJ4Sy5RY0gdst055rpiSV0LIEvgNMPakq7F80hYX5
/7r9ZB+GinkAhLDdVTqYPvx4hqM2M5TwycLmGWtw2JsWGkXT2IlDVuJKjLVsd8Ho
K0ZV6k1xZHDbMDlu8mfkQvhBsk/RSkDamcXctqGeLq6saqCZ8ds9WBcKwahLr37d
0ARCuVkNYAKcZUwDMQgZY6VqVyqG4z5qVym0wDAqc2GYZAnNm/j+5cPituaqJUJI
w39Mo8eAxVNx7IrIVxPYDlSXtJNv793Y9l1ub8c0IVQDAVLo8sOpo35dcemAyiWO
7b9G9dNGLxXFk4O6ivPdjg==
=M33q
-----END PGP SIGNATURE-----

--c7UddyyFRxcnPSq52kssngWhFQMyHOyO9--
