Received: from eggs.gnu.org ([209.51.188.92]:36851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJedu-0003jo-TV
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJedt-0007bb-Pq
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:42:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJedt-0007aQ-Hz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:42:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id z6so1724213wmi.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:42:25 -0700 (PDT)
References: <20190408182748.1238-1-jan.bobek@gmail.com>
	<20190408182748.1238-4-jan.bobek@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190408182748.1238-4-jan.bobek@gmail.com>
Date: Thu, 25 Apr 2019 14:42:22 +0100
Message-ID: <871s1qw69t.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH 3/5] risu_reginfo_i386: implement
 arch-specific reginfo interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Bobek <jan.bobek@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>


Jan Bobek <jan.bobek@gmail.com> writes:

> CPU-specific code in risu_reginfo_* is expected to define and export
> the following symbols:
>
> - arch_long_opts, arch_extra_help, process_arch_opt
> - reginfo_size
> - reginfo_init
> - reginfo_is_eq
> - reginfo_dump, reginfo_dump_mismatch
>
> Make risu_reginfo_i386.c implement this interface.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risu_reginfo_i386.c | 48 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
> index e8d671f..3882261 100644
> --- a/risu_reginfo_i386.c
> +++ b/risu_reginfo_i386.c
> @@ -10,12 +10,28 @@
>   ***********************************************************************=
*******/
>
>  #include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
>  #include <ucontext.h>
>
>  #include "risu.h"
>  #include "risu_reginfo_i386.h"
>
> -static void fill_reginfo(struct reginfo *ri, ucontext_t * uc)
> +const struct option * const arch_long_opts;
> +const char * const arch_extra_help;
> +
> +void process_arch_opt(int opt, const char *arg)
> +{
> +    abort();
> +}
> +
> +const int reginfo_size(void)
> +{
> +    return sizeof(struct reginfo);
> +}
> +
> +/* reginfo_init: initialize with a ucontext */
> +void reginfo_init(struct reginfo *ri, ucontext_t *uc)
>  {
>      int i;
>      for (i =3D 0; i < NGREG; i++) {
> @@ -51,18 +67,38 @@ static void fill_reginfo(struct reginfo *ri, ucontext=
_t * uc)
>      ri->faulting_insn =3D *((uint32_t *) uc->uc_mcontext.gregs[REG_EIP]);
>  }
>
> -static char *regname[] =3D {
> +/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal =
*/
> +int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
> +{
> +    return 0 =3D=3D memcmp(m, a, sizeof(*m));
> +}
> +
> +static const char *const regname[NGREG] =3D {
>      "GS", "FS", "ES", "DS", "EDI", "ESI", "EBP", "ESP",
>      "EBX", "EDX", "ECX", "EAX", "TRAPNO", "ERR", "EIP",
> -    "CS", "EFL", "UESP", "SS", 0
> +    "CS", "EFL", "UESP", "SS"
>  };
>
> -static void dump_reginfo(struct reginfo *ri)
> +/* reginfo_dump: print state to a stream, returns nonzero on success */
> +int reginfo_dump(struct reginfo *ri, FILE *f)
>  {
>      int i;
> -    fprintf(stderr, "  faulting insn %x\n", ri->faulting_insn);
> +    fprintf(f, "  faulting insn %x\n", ri->faulting_insn);
>      for (i =3D 0; i < NGREG; i++) {
> -        fprintf(stderr, "  %s: %x\n", regname[i] ? regname[i] : "???",
> +        fprintf(f, "  %s: %x\n", regname[i] ? regname[i] : "???",
>                  ri->gregs[i]);
>      }
> +    return !ferror(f);
> +}
> +
> +int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
> +{
> +    int i;
> +    for (i =3D 0; i < NGREG; i++) {
> +        if (m->gregs[i] !=3D a->gregs[i]) {
> +            fprintf(f, "Mismatch: Register %s\n", regname[i] ? regname[i=
] : "???");
> +            fprintf(f, "m: [%x] !=3D a: [%x]\n", m->gregs[i], a->gregs[i=
]);
> +        }
> +    }
> +    return !ferror(f);
>  }


--
Alex Benn=C3=A9e
