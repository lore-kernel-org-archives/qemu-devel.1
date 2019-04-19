Received: from eggs.gnu.org ([209.51.188.92]:48310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHaXt-0007qV-97
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 16:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hHaXr-0000zz-Ow
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 16:55:41 -0400
MIME-Version: 1.0
References: <cover.1554937288.git.alistair.francis@wdc.com>
	<efb2140df508fc04be96c5dc0f989923bfcb7424.1554937288.git.alistair.francis@wdc.com>
	<20190416132337.GN31311@redhat.com>
In-Reply-To: <20190416132337.GN31311@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 19 Apr 2019 13:55:10 -0700
Message-ID: <CAKmqyKPNNVGuH4veQKLuNQ3PFAko9eDeqdmF-zHmDG_9Kp_tDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3 2/6] target/riscv: Fall back to
 generating a RISC-V CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@sifive.com" <palmer@sifive.com>, "ijc@hellion.org.uk" <ijc@hellion.org.uk>

On Tue, Apr 16, 2019 at 6:23 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Wed, Apr 10, 2019 at 11:10:25PM +0000, Alistair Francis wrote:
> > If a user specifies a CPU that we don't understand then we want to fall
> > back to a CPU generated from the ISA string.
> >
> > At the moment the generated CPU is assumed to be a privledge spec
> > version 1.10 CPU with an MMU. This can be changed in the future.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v3:
> >  - Ensure a minimal length so we don't run off the end of the string.
> >  - Don't parse the rv32/rv64 in the loop
> >  target/riscv/cpu.c | 101 ++++++++++++++++++++++++++++++++++++++++++++-
> >  target/riscv/cpu.h |   2 +
> >  2 files changed, 102 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index d61bce6d55..27be9e412a 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -19,6 +19,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "qemu/log.h"
> > +#include "qemu/error-report.h"
> >  #include "cpu.h"
> >  #include "exec/exec-all.h"
> >  #include "qapi/error.h"
> > @@ -103,6 +104,99 @@ static void set_resetvec(CPURISCVState *env, int r=
esetvec)
> >  #endif
> >  }
> >
> > +static void riscv_generate_cpu_init(Object *obj)
> > +{
> > +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> > +    CPURISCVState *env =3D &cpu->env;
> > +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cpu);
> > +    const char *riscv_cpu =3D mcc->isa_str;
> > +    target_ulong target_misa =3D 0;
> > +    target_ulong rvxlen =3D 0;
> > +    int i;
> > +    bool valid =3D false;
> > +
> > +    /*
> > +     * We need at least 5 charecters for the string to be valid. Check=
 that
> > +     * now so we can be lazier later.
> > +     */
> > +    if (strlen(riscv_cpu) < 5) {
> > +        error_report("'%s' does not appear to be a valid RISC-V ISA st=
ring",
> > +                     riscv_cpu);
> > +        exit(1);
> > +    }
> > +
> > +    if (riscv_cpu[0] =3D=3D 'r' && riscv_cpu[1] =3D=3D 'v') {
> > +        /* Starts with "rv" */
> > +        if (riscv_cpu[2] =3D=3D '3' && riscv_cpu[3] =3D=3D '2') {
> > +            valid =3D true;
> > +            rvxlen =3D RV32;
> > +        }
> > +        if (riscv_cpu[2] =3D=3D '6' && riscv_cpu[3] =3D=3D '4') {
> > +            valid =3D true;
> > +            rvxlen =3D RV64;
> > +        }
> > +    }
> > +
> > +    if (!valid) {
> > +        error_report("'%s' does not appear to be a valid RISC-V CPU",
> > +                     riscv_cpu);
> > +        exit(1);
> > +    }
> > +
> > +    for (i =3D 4; i < strlen(riscv_cpu); i++) {
> > +        switch (riscv_cpu[i]) {
> > +        case 'i':
> > +            if (target_misa & RVE) {
> > +                error_report("I and E extensions are incompatible");
> > +                exit(1);
> > +            }
> > +            target_misa |=3D RVI;
> > +            continue;
> > +        case 'e':
> > +            if (target_misa & RVI) {
> > +                error_report("I and E extensions are incompatible");
> > +                exit(1);
> > +            }
> > +            target_misa |=3D RVE;
> > +            continue;
> > +        case 'g':
> > +            target_misa |=3D RVI | RVM | RVA | RVF | RVD;
> > +            continue;
> > +        case 'm':
> > +            target_misa |=3D RVM;
> > +            continue;
> > +        case 'a':
> > +            target_misa |=3D RVA;
> > +            continue;
> > +        case 'f':
> > +            target_misa |=3D RVF;
> > +            continue;
> > +        case 'd':
> > +            target_misa |=3D RVD;
> > +            continue;
> > +        case 'c':
> > +            target_misa |=3D RVC;
> > +            continue;
> > +        case 's':
> > +            target_misa |=3D RVS;
> > +            continue;
> > +        case 'u':
> > +            target_misa |=3D RVU;
> > +            continue;
> > +        default:
> > +            warn_report("QEMU does not support the %c extension",
> > +                        riscv_cpu[i]);
> > +            continue;
> > +        }
> > +    }
> > +
> > +    set_misa(env, rvxlen | target_misa);
> > +    set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
> > +    set_resetvec(env, DEFAULT_RSTVEC);
> > +    set_feature(env, RISCV_FEATURE_MMU);
> > +    set_feature(env, RISCV_FEATURE_PMP);
> > +}
>
> This whole approach feels undesirable to me, as it is quite different to
> way CPUs are represented in the other architectures in QEMU and as a resu=
lt
> does not fit in the QAPI commands we've been building in QEMU for dealing
> with CPU model representation. This will make for increased maint burden
> in both QEMU and apps managing QEMU
>
> IIUC, this code is taking an arbitrary CPU model string and looking
> at individual characters in that string & turning on individual features
> according to what characters it sees. There's several problems with this
>
>  - There's no way to enumerate valid CPU model names
>
>  - There can be many different names that all result
>    in the same CPU model. eg "fdcs", "scdf", a"ffddccss"
>    all result in the same features getting enabled
>    by this loop above.
>
>  - There's no way to check compatibility between CPUs
>
>  - There will be no way to version the CPUs if we need
>    to tie them to machine types for back compatibility.
>
> If we have a base CPU model, with a bunch of features that can optionally
> be enabled, then IMHO we should represent that the same way was we do
> on x86, whre we have a CPU model name, and then a comma sepaprated list
> of features.
>
> If on the other hand we don't want to support the combinatorial matrix
> of all possible feature flags, then we should just list all the expected
> named CPU models that are required explicitly.

Ok, I'm about to send out a new series that is based on this series.
The new series is called "RISC-V: Add properties to the CPUs". It has
dropped the ISA string part (this patch) and just adds some standard
CPU properties. If everyone is happy with that approach I'll continue
to expand it to add the extensions as CPU properties.

Alistair

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
