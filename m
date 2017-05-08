Received: from eggs.gnu.org ([2001:4830:134:3::10]:35399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7qty-0006xq-MB
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d7qtx-00055a-HZ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:13:10 -0400
Date: Tue, 9 May 2017 00:13:04 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170508221304.y36owezwla7sc6ss@aurel32.net>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
Subject: Re: [Qemu-devel] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 2017-05-07 17:48, G 3 wrote:
> I made a diagnostic program for the floating point unit. It will test
> various PowerPC floating point instructions for compatibility with the
> PowerPC G3 processor. It was tested on a PowerPC G3 and G5 system. The
> results of the program in qemu-system-ppc were pretty bad. About every
> instruction tested is not implemented correctly.
>=20
> Here is the download link to the program: http://www.mediafire.com/file/6=
j9tqubvk73lkw1/floating_point_test_program.zip

Some comments on the code.
>=20
>     /* Check if everything is alright */
>     uint32_t fpscr;
>     asm volatile("mffs f0");
>     asm volatile("stfd f0, 40(r1)");
>     asm volatile("lwz %0, 44(r1)" : "=3Dr"(fpscr));
>     if (fpscr !=3D 0) {
>         printf("Warning: fpscr not equal to zero: 0x%x\n", fpscr);
>     }

This is overly complicated and just doesn't compile with recent GCC
versions. What about something like:

    Converter c;
    asm volatile("mffs %0" : "=3Df"(c.d));
    fpscr =3D (uint32_t)c.i;


> /*
>  * The action to take if a test fails
>  * Input one: message string
>  * Input two: actual fpscr value
>  * Input three: expected fpscr value
>  * Input four: actual answer
>  * Input five: expected answer
>  */
>  void test_failed(const char *message, uint32_t actual_fpscr, uint32_t
> expected_fpscr,
>                   uint64_t actual_answer, uint64_t expected_answer)
>  {
>     printf("%s\n", message);
>     printf("expected answer: 0x%" PRIx64 "\n", expected_answer);
>     printf("  actual answer: 0x%" PRIx64 "\n", actual_fpscr);

This is wrong. It should be actual_answer instead of actual_fpscr. That
is why all the instructions seems totally wrongly implemented. Note that
compiling with -Wall would give you a warning:

| main.c: In function =E2=80=98test_failed=E2=80=99:
| main.c:146:5: warning: format =E2=80=98%llx=E2=80=99 expects argument of =
type =E2=80=98long long unsigned int=E2=80=99, but argument 2 has type =E2=
=80=98uint32_t=E2=80=99 [-Wformat=3D]
|      printf("  actual answer: 0x%" PRIx64 "\n", actual_fpscr);
|=C2=A0     ^

So I think the cone needs to be improved a bit before we can conclude
anything.

Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
