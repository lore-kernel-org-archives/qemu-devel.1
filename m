Received: from eggs.gnu.org ([2001:4830:134:3::10]:53929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fXZtN-0000sO-Tz
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fXZtK-0001rz-ON
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 18:23:25 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFXwXrk+X_heyWnwAzLQ6E9+j5=AxJ-Dh+nM5e7zuQcJCEAsyg@mail.gmail.com>
Date: Mon, 25 Jun 2018 18:23:16 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <6918D473-064B-4356-B8B0-EE20ED05544F@gmail.com>
References: <20180623022258.22158-1-programmingkidx@gmail.com>
	<ecf44486-09a4-9c9a-b96e-1db2d6a1bcbe@linaro.org>
	<1E63C3B2-7668-4D05-BC43-02E478FB493B@gmail.com>
	<bc3cd25b-bdd1-3bc7-8d2d-5c351f2c30d5@linaro.org>
	<4CC477CD-237F-480D-B9B5-B35FF507BD3C@gmail.com>
	<c6d132e2-b2e0-5bbb-7b71-9bd13253aa22@linaro.org>
	<2CAC99CF-A717-4A94-A68C-EEB76C727F87@gmail.com>
	<dbbebf00-9b32-4639-1e26-a888c48f6203@linaro.org>
	<CDA6AAA3-1452-4CBA-93A9-94CD83705E1A@gmail.com>
	<CAFXwXrk+X_heyWnwAzLQ6E9+j5=AxJ-Dh+nM5e7zuQcJCEAsyg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] fix fdiv instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>


> On Jun 25, 2018, at 5:08 PM, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On Mon, Jun 25, 2018, 08:23 G 3 <programmingkidx@gmail.com> wrote:
> >
> > Try
> >
> >     uint64_t expected_answer =3D 0xffff0000deadbeef;
> >     ...
> >     c.i =3D expected_answer;
> >     asm volatile("fdiv %0, %1, %2" : "+f"(c.d) : "f"(1.0), =
"f"(0.0));
> >
> > to avoid depending on uninitialized data.  (This expected value is
> > an SNaN with a deadbeef marker Just to be Sure.)
> >
> >
> > r~
>=20
>=20
> Ok I made this program and tried it on my iMac G5 (PowerPC 970).
>=20
> #include <stdio.h>
> #include <stdint.h>
> #include <inttypes.h>
>=20
> // Used to convert unsigned integer <--> double
> union Converter
> {
>      double d;
>      uint64_t i;
> };
> typedef union Converter Converter;
>=20
> int main (int argc, const char * argv[]) {
>      Converter answer;
>      answer.i =3D 0xffff0000deadbeef;
>      //asm volatile("mtfsb1 27"); /* Set ZE bit */
>      asm volatile("fdiv %0, %1, %2" : "=3Df"(answer.d) : "f"(1.0), =20
> "f"(0.0));
>=20
> Need +f for inout operand.
> This didn't test what you expected.

What do you mean by inout operand?

If you could send me some sample code I will test it out.=
