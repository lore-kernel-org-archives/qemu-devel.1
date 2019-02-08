Received: from eggs.gnu.org ([209.51.188.92]:55059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gsDGU-0005G6-DD
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gsDGS-0001cv-SY
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:00:50 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:47370
	helo=ns207790.ip-94-23-215.eu) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remi@remlab.net>) id 1gsDGQ-0001a4-Ho
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:00:48 -0500
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Date: Fri, 08 Feb 2019 20:32:34 +0200
Message-ID: <2034657.8N3RCfXzMK@basile.remlab.net>
In-Reply-To: <8f51cf7f-ba18-a123-e31d-a95d18918cb8@linaro.org>
References: <20190208163727.13733-1-remi@remlab.net>
	<8f51cf7f-ba18-a123-e31d-a95d18918cb8@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: assert last byte is in guest space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

Le perjantaina 8. helmikuuta 2019, 20.12.13 EET Richard Henderson a =C3=A9c=
rit :
> On 2/8/19 8:37 AM, R=C3=A9mi Denis-Courmont wrote:
> > Rather than assert that the first byte of a checked range is within the
> > guest address space, assert that the last byte is. The assertion is
> > moved past the overflow check to ensure that the last byte is actually
> > the one with the highest address.
> >=20
> > Signed-off-by: R=C3=A9mi Denis-Courmont <remi@remlab.net>
> > ---
> >=20
> >  accel/tcg/translate-all.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> What are you trying to fix here?

As far as I can tell, the following code assumes that the entire range of=20
checked addresses falls within the guest address range. So it makes sense t=
o=20
fail the assertion if the any byte is out of range, rather than only the fi=
rst=20
one.

> You've moved the assert past some returns, so that some cases that should
> not be handled by this function no longer get checked.  As the comment
> says, the address should already have been filtered by h2g_valid.

I find it generally hard to argue what an assertion should or should not do=
=20
insofar as an assertion failure is supposed to be impossible. I am not in a=
=20
position to decide if the assertion should fail in error cases that would b=
e=20
handled properly with a safe failure anyway - namely 0 bytes ranges and=20
wrapping-around ranges.

However, it seems odd to live some undefined cases not failing the assertio=
n,=20
and I would not dare to add an extra assertion, so I replaced the one.

=2D-=20
R=C3=A9mi Denis-Courmont
http://www.remlab.net/
