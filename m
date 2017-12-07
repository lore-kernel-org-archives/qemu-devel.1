Received: from eggs.gnu.org ([2001:4830:134:3::10]:45913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1eN5Ac-0005La-7Z
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:01:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1eN5Aa-0002zF-Nz
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:01:34 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1eN5Aa-0002yq-Hq
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:01:32 -0500
Received: by mail-qt0-x244.google.com with SMTP id 33so21924591qtv.1
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 15:01:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3f70d49d-30ff-384f-c942-8f1dbc2cd53c@linaro.org>
References: <20171203063548.10297-1-doug16k@gmail.com>
	<3f70d49d-30ff-384f-c942-8f1dbc2cd53c@linaro.org>
From: Doug Gale <doug16k@gmail.com>
Date: Thu, 7 Dec 2017 18:01:29 -0500
Message-ID: <CAEfK_445X=o=pkJRMhwknOcBvEwoA7kQhDRJ6ULhmiV6hVJqew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Add AVX, AVX-512,
 MPX support to x86_cpu_dump_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Dec 7, 2017 at 5:37 PM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 12/02/2017 10:35 PM, Doug Gale wrote:
> > Signed-off-by: Doug Gale <doug16k@gmail.com>
> > ---
> > Fix MSB LSB showing when SSE is disabled
> >  target/i386/helper.c | 95 ++++++++++++++++++++++++++++++
> +++++++++++++++-------
> >  1 file changed, 83 insertions(+), 12 deletions(-)
> >
> > diff --git a/target/i386/helper.c b/target/i386/helper.c
> > index f63eb3d3f4..03812b6e87 100644
> > --- a/target/i386/helper.c
> > +++ b/target/i386/helper.c
> > @@ -543,6 +543,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f,
> fprintf_function cpu_fprintf,
> >          }
> >      }
> >      cpu_fprintf(f, "EFER=3D%016" PRIx64 "\n", env->efer);
> > +    cpu_fprintf(f, "XCR0=3D%016" PRIx64 "\n", env->xcr0);
> >      if (flags & CPU_DUMP_FPU) {
> >          int fptag;
> >          fptag =3D 0;
> > @@ -565,21 +566,91 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f,
> fprintf_function cpu_fprintf,
> >              else
> >                  cpu_fprintf(f, " ");
> >          }
> > -        if (env->hflags & HF_CS64_MASK)
> > -            nb =3D 16;
> > -        else
> > +
> > +        if (env->hflags & HF_CS64_MASK) {
> > +            if (env->xcr0 & XSTATE_Hi16_ZMM_MASK) {
> > +                /* AVX-512 32 registers enabled */
> > +                nb =3D 32;
> > +            } else {
> > +                /* 64-bit mode, 16 registers */
> > +                nb =3D 16;
> > +            }
> > +        } else {
> > +            /* 32 bit mode, 8 registers */
> >              nb =3D 8;
> > -        for(i=3D0;i<nb;i++) {
> > -            cpu_fprintf(f, "XMM%02d=3D%08x%08x%08x%08x",
> > -                        i,
> > -                        env->xmm_regs[i].ZMM_L(3),
> > -                        env->xmm_regs[i].ZMM_L(2),
> > -                        env->xmm_regs[i].ZMM_L(1),
> > -                        env->xmm_regs[i].ZMM_L(0));
> > -            if ((i & 1) =3D=3D 1)
> > +        }
> > +
> > +        /* sse register width in units of 64 bits */
> > +        int zmm_width;
> > +        char zmm_name;
> > +        if (env->xcr0 & XSTATE_ZMM_Hi256_MASK) {
> > +            /* 512-bit "ZMM" - AVX-512 registers enabled */
> > +            zmm_width =3D 8;
> > +            zmm_name =3D 'Z';
> > +        } else if (env->xcr0 & XSTATE_YMM_MASK) {
> > +            /* 256-bit "YMM" - AVX enabled */
> > +            zmm_width =3D 4;
> > +            zmm_name =3D 'Y';
> > +        } else if (env->cr[4] & CR4_OSFXSR_MASK) {
> > +            /* 128-bit "XMM" - SSE enabled */
> > +            zmm_width =3D 2;
> > +            zmm_name =3D 'X';
> > +        } else {
> > +            /* SSE not enabled */
> > +            zmm_width =3D 0;
> > +            zmm_name =3D 0;
>
> You should exit the function here ...
>
> > +        }
> > +
> > +        if (zmm_width > 0) {
> > +            cpu_fprintf(f, "      MSB%*sLSB\n",
> > +                        -(zmm_width * 16 + zmm_width - 7), "");
> > +        }
> > +
> > +        for (i =3D 0; i < nb; i++) {
> > +            if (zmm_width =3D=3D 0) {
> > +                cpu_fprintf(f, "SSE not enabled\n");
> > +                break;
> > +            }
>
> ... rather than performing this test in a loop.
> Or indeed, printing anything at all.
>
> I assume this is in order to examine registers in the monitor under kvm?
>
>
> r~
>

=E2=80=8B
Yes, to examine the registers in the monitor and improve the output of
things like -d int. I ran into an issue with
=E2=80=8B guest=E2=80=8B
code and I wanted to check XCR0 to see if AVX was enabled, and I didn't see
any AVX registers
=E2=80=8B, which was very misleading=E2=80=8B
.
=E2=80=8B I couldn't check XCR0 to see if it was enabled either.=E2=80=8B
I investigated and found that AVX was enabled, and the monitor output was
false. I added XCR0 and the entire AVX
=E2=80=8B/AVX-512=E2=80=8B
and MPX state to the
=E2=80=8Bqemu =E2=80=8B
output.

Why would it exit the function there? Are you sure the other states I
further down won't be enabled? It prints the MPX state further down. I put
the test in the loop so I wouldn't have to indent that whole `for` loop
another level, to improve readability. Is the performance of that loop
really relevant? The fprintf's will take at least thousands of times more
CPU time than that predictable branch.=E2=80=8B
