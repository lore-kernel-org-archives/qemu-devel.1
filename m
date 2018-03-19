Received: from eggs.gnu.org ([2001:4830:134:3::10]:50059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1exzdT-0003d6-1O
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1exzdR-0000CT-7b
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:35:55 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:33906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1exzdQ-0000CD-W4
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:35:53 -0400
Received: by mail-oi0-x22e.google.com with SMTP id u141so3274540oif.1
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 11:35:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dec4f79c-a46e-f341-ef17-7ba85086bc9a@amsat.org>
References: <1521221171-47213-1-git-send-email-mjc@sifive.com>
	<dec4f79c-a46e-f341-ef17-7ba85086bc9a@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 19 Mar 2018 11:35:51 -0700
Message-ID: <CAHNT7Nuv9G+e3-m-356HZDoiLju=vPCucfWhXLJ0QHPGM7NSQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Fix riscv_isa_string memory
 size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>, "Richard W.M. Jones" <rjones@redhat.com>

On Sun, Mar 18, 2018 at 4:22 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> On 03/16/2018 06:26 PM, Michael Clark wrote:
> > This version uses a constant size memory buffer sized for
> > the maximum possible ISA string length. It also uses g_new
> > instead of g_new0, uses more efficient logic to append
> > extensions and adds manual zero termination of the string.
> >
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
> >  target/riscv/cpu.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 4851890..298abbd 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -391,16 +391,16 @@ static const TypeInfo riscv_cpu_type_info =3D {
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
> > +            *p++ =3D riscv_exts[i] - 'A' + 'a';
>                                                  /* tolower() */
>
> I prefer unobfuscated code (think newcomers and reviewers) :|
>

Thanks! Done.

I think i'll add the riscv_isa_string fix onto the RISC-V post-merge spec
conformance and cleanup series, and send I'll send out a (hopefully final)
version of it today, so we can merge all of the spec conformance, bug fixes
and cleanups in one PR.

The RISC-V post-merge spec conformance and cleanup series has had a lot of
testing. I've been using it to compile QEMU inside of QEMU using the RISC-V
Fedora Image and its native RISC-V GCC toolchain running inside SMP Linux
4.16-rc2. It appears to be pretty rock-solid. The rcu lock fix would likely
only affect users who are ballooning memory while a guest is under load.
The page walker changes have also been tested under load (including
performance tests).

FYI - I also have an experimental branch containing a RISC-V TCG back-end
that I started on during the RISC-V Hackathon in Portland last week:

- https://github.com/michaeljclark/riscv-qemu/tree/wip-riscv-tcg-backend

I'm able to run a very simple x86_64 hello world program on RISC-V,
avoiding all of the usual libc startup. However, it may be some time before
I submit a patch series for this branch. So far the RISC-V TCG backend
doesn't implement softmmu, have bigendian byteswapping in its load/store
implementation or 64-bit on 32-bit support (brcond2/setcond2). This will
come, however, at present I'm still testing the basic codegen. That being
said, it has meant that i've been using the RISC-V QEMU Fedora image pretty
extensively as my main development machine, with the  RISC-V post-merge
spec conformance and cleanup series applied, performing a lot of parallel
makes on a quad-core i7. The only thing I am really missing is gdb. The
current RISC-V GDB port seems to be missing user-space debugging support as
I believe the focus has been on the JTAG remote debugging use case.

[mclark@stage4 riscv-qemu]$ uname -a
Linux stage4.fedoraproject.org 4.16.0-rc2-00328-gebea62367bc4 #4 SMP Mon
Feb 26 16:05:16 GMT 2018 riscv64 riscv64 riscv64 GNU/Linux
[mclark@stage4 riscv-qemu]$ ./riscv64-linux-user/qemu-riscv64 hello.riscv64
Hello World
[mclark@stage4 riscv-qemu]$ ./x86_64-linux-user/qemu-x86_64 hello.x86_64
Hello World

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> >          }
> >      }
> > -    return isa_string;
> > +    *p =3D '\0';
> > +    return isa_str;
> >  }
> >
> >  void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> >
>
