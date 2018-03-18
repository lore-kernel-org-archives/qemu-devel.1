Received: from eggs.gnu.org ([2001:4830:134:3::10]:45718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhdD-0007kq-F3
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhd9-0003Q1-7v
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:22:27 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhd9-0003PH-1f
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:22:23 -0400
Received: by mail-wr0-x243.google.com with SMTP id o1so16775228wro.10
	for <qemu-devel@nongnu.org>; Sun, 18 Mar 2018 16:22:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1521221171-47213-1-git-send-email-mjc@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dec4f79c-a46e-f341-ef17-7ba85086bc9a@amsat.org>
Date: Mon, 19 Mar 2018 00:22:20 +0100
MIME-Version: 1.0
In-Reply-To: <1521221171-47213-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>

On 03/16/2018 06:26 PM, Michael Clark wrote:
> This version uses a constant size memory buffer sized for
> the maximum possible ISA string length. It also uses g_new
> instead of g_new0, uses more efficient logic to append
> extensions and adds manual zero termination of the string.
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>  target/riscv/cpu.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4851890..298abbd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -391,16 +391,16 @@ static const TypeInfo riscv_cpu_type_info = {
>  char *riscv_isa_string(RISCVCPU *cpu)
>  {
>      int i;
> -    size_t maxlen = 5 + ctz32(cpu->env.misa);
> -    char *isa_string = g_new0(char, maxlen);
> -    snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
> +    const size_t maxlen = sizeof("rv128") + sizeof(riscv_exts) + 1;
> +    char *isa_str = g_new(char, maxlen);
> +    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
>      for (i = 0; i < sizeof(riscv_exts); i++) {
>          if (cpu->env.misa & RV(riscv_exts[i])) {
> -            isa_string[strlen(isa_string)] = riscv_exts[i] - 'A' + 'a';
> -
> +            *p++ = riscv_exts[i] - 'A' + 'a';
                                                 /* tolower() */

I prefer unobfuscated code (think newcomers and reviewers) :|

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>          }
>      }
> -    return isa_string;
> +    *p = '\0';
> +    return isa_str;
>  }
>  
>  void riscv_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> 
