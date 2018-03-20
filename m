Received: from eggs.gnu.org ([2001:4830:134:3::10]:58492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyFnv-0001SI-TW
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyFnu-0001iB-T0
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:51:47 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyFnu-0001hN-Ns
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:51:46 -0400
Received: by mail-ot0-x244.google.com with SMTP id i28-v6so1346857otf.8
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 04:51:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1521494329-19546-27-git-send-email-mjc@sifive.com>
References: <1521494329-19546-1-git-send-email-mjc@sifive.com>
	<1521494329-19546-27-git-send-email-mjc@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 11:51:25 +0000
Message-ID: <CAFEAcA8b+Py_=zf+GWYTzZAUpbfF7B6Hi5m8d0JnX6Z7nY4Cuw@mail.gmail.com>
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
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>

On 19 March 2018 at 21:18, Michael Clark <mjc@sifive.com> wrote:
> This version uses a constant size memory buffer sized for
> the maximum possible ISA string length. It also uses g_new
> instead of g_new0, uses more efficient logic to append
> extensions and adds manual zero termination of the string.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/riscv/cpu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1f25968..c82359f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -360,16 +360,16 @@ static void riscv_cpu_class_init(ObjectClass *c, vo=
id *data)
>  char *riscv_isa_string(RISCVCPU *cpu)
>  {
>      int i;
> -    size_t maxlen =3D 5 + ctz32(cpu->env.misa);
> -    char *isa_string =3D g_new0(char, maxlen);
> -    snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
> +    const size_t maxlen =3D sizeof("rv128") + sizeof(riscv_exts) + 1;
> +    char *isa_str =3D g_new(char, maxlen);
> +    char *p =3D isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_=
BITS);
>      for (i =3D 0; i < sizeof(riscv_exts); i++) {
>          if (cpu->env.misa & RV(riscv_exts[i])) {
> -            isa_string[strlen(isa_string)] =3D riscv_exts[i] - 'A' + 'a'=
;
> -
> +            *p++ =3D tolower(riscv_exts[i]);

This should be qemu_tolower(). Plain tolower() has an awkward problem
where if the 'char' type is signed and you hand tolower() a char that
happens to be a negative value you get undefined behaviour. This means
you need to cast the argument to 'unsigned char', which is what our
wrapper does. In this specific case the inputs are known constant
ASCII, so tolower() happens to be safe, but for consistency with
the rest of the codebase we should use our wrapper function.

>          }
>      }
> -    return isa_string;
> +    *p =3D '\0';
> +    return isa_str;
>  }
>
>  typedef struct RISCVCPUListState {

Since this bug is causing the build tests to intermittently fail,
I'm going to apply this patch directly to master, with tolower()
replaced with qemu_tolower().

thanks
-- PMM
