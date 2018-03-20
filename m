Received: from eggs.gnu.org ([2001:4830:134:3::10]:46386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyOEI-0007OJ-JB
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyOEF-0000sV-DR
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:51:34 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:36768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eyOEF-0000rt-7k
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 16:51:31 -0400
Received: by mail-yb0-f178.google.com with SMTP id d13-v6so1032334ybc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 13:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <1521494329-19546-1-git-send-email-mjc@sifive.com>
	<1521494329-19546-27-git-send-email-mjc@sifive.com>
	<CAFEAcA8b+Py_=zf+GWYTzZAUpbfF7B6Hi5m8d0JnX6Z7nY4Cuw@mail.gmail.com>
In-Reply-To: <CAFEAcA8b+Py_=zf+GWYTzZAUpbfF7B6Hi5m8d0JnX6Z7nY4Cuw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 20 Mar 2018 20:51:19 +0000
Message-ID: <CAAdtpL4U11z9Oz0QkKFuAhoObnmK67cN0uzY8SsrcQCqtYWCKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 26/26] RISC-V: Fix riscv_isa_string
 memory size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Clark <mjc@sifive.com>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>

Le mar. 20 mars 2018 12:52, Peter Maydell <peter.maydell@linaro.org> a
=C3=A9crit :

> On 19 March 2018 at 21:18, Michael Clark <mjc@sifive.com> wrote:
> > This version uses a constant size memory buffer sized for
> > the maximum possible ISA string length. It also uses g_new
> > instead of g_new0, uses more efficient logic to append
> > extensions and adds manual zero termination of the string.
> >
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  target/riscv/cpu.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 1f25968..c82359f 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -360,16 +360,16 @@ static void riscv_cpu_class_init(ObjectClass *c,
> void *data)
> >  char *riscv_isa_string(RISCVCPU *cpu)
> >  {
> >      int i;
> > -    size_t maxlen =3D 5 + ctz32(cpu->env.misa);
> > -    char *isa_string =3D g_new0(char, maxlen);
> > -    snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
> > +    const size_t maxlen =3D sizeof("rv128") + sizeof(riscv_exts) + 1;
> > +    char *isa_str =3D g_new(char, maxlen);
> > +    char *p =3D isa_str + snprintf(isa_str, maxlen, "rv%d",
> TARGET_LONG_BITS);
> >      for (i =3D 0; i < sizeof(riscv_exts); i++) {
> >          if (cpu->env.misa & RV(riscv_exts[i])) {
> > -            isa_string[strlen(isa_string)] =3D riscv_exts[i] - 'A' + '=
a';
> > -
> > +            *p++ =3D tolower(riscv_exts[i]);
>
> This should be qemu_tolower(). Plain tolower() has an awkward problem
> where if the 'char' type is signed and you hand tolower() a char that
> happens to be a negative value you get undefined behaviour. This means
> you need to cast the argument to 'unsigned char', which is what our
>

Oh, good to know.

wrapper does. In this specific case the inputs are known constant
> ASCII, so tolower() happens to be safe,


Yep.

but for consistency with
> the rest of the codebase we should use our wrapper function.
>

Ok.


> >          }
> >      }
> > -    return isa_string;
> > +    *p =3D '\0';
> > +    return isa_str;
> >  }
> >
> >  typedef struct RISCVCPUListState {
>
> Since this bug is causing the build tests to intermittently fail,
> I'm going to apply this patch directly to master, with tolower()
> replaced with qemu_tolower().
>

Thanks Peter!


> thanks
> -- PMM
>
>
