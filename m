Received: from eggs.gnu.org ([2001:4830:134:3::10]:59599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJUwQ-0002cs-VD
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fJUwP-0000ga-KW
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:16:22 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:39246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fJUwP-0000gK-Dd
	for qemu-devel@nongnu.org; Thu, 17 May 2018 22:16:21 -0400
Received: by mail-ot0-x234.google.com with SMTP id l12-v6so7366404oth.6
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 19:16:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <33e61f63-e2d4-de07-4fef-2c3037d384e7@amsat.org>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
	<20180511035240.4016-6-richard.henderson@linaro.org>
	<33e61f63-e2d4-de07-4fef-2c3037d384e7@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 18 May 2018 14:16:20 +1200
Message-ID: <CAHNT7NuSpMiW8YXbmET7TgFjzDpgswoBX-a4OFQJXOxX+7boaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/9] target/riscv: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Sun, May 13, 2018 at 12:52 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org>
wrote:

> On 05/11/2018 12:52 AM, Richard Henderson wrote:
> > Cc: Michael Clark <mjc@sifive.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> > Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


Reviewed-by: Michael Clark <mjc@sifive.com>


> > ---
> >  target/riscv/cpu.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index 4e5a56d4e3..4612f324c9 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -199,6 +199,10 @@ static void riscv_cpu_dump_state(CPUState *cs, FIL=
E
> *f,
> >      int i;
> >
> >      cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
> > +    if (flags & CPU_DUMP_FPU) {
> > +        cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "fcsr    ",
> > +                    cpu_riscv_get_fcsr(env));
> > +    }
> >  #ifndef CONFIG_USER_ONLY
> >      cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid=
);
> >      cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus=
);
> > @@ -219,11 +223,13 @@ static void riscv_cpu_dump_state(CPUState *cs,
> FILE *f,
> >              cpu_fprintf(f, "\n");
> >          }
> >      }
> > -    for (i =3D 0; i < 32; i++) {
> > -        cpu_fprintf(f, " %s %016" PRIx64,
> > -            riscv_fpr_regnames[i], env->fpr[i]);
> > -        if ((i & 3) =3D=3D 3) {
> > -            cpu_fprintf(f, "\n");
> > +    if (flags & CPU_DUMP_FPU) {
> > +        for (i =3D 0; i < 32; i++) {
> > +            cpu_fprintf(f, " %s %016" PRIx64,
> > +                riscv_fpr_regnames[i], env->fpr[i]);
> > +            if ((i & 3) =3D=3D 3) {
> > +                cpu_fprintf(f, "\n");
> > +            }
> >          }
> >      }
> >  }
> >
>
