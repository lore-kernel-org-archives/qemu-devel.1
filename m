Received: from eggs.gnu.org ([2001:4830:134:3::10]:49737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dL9H6-0005uc-Br
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dL9H2-00021V-EA
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:28:00 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:34986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dL9H2-000216-9u
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:27:56 -0400
Received: by mail-ua0-x244.google.com with SMTP id b10so215248uaa.2
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:27:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170614052311.13785-1-rth@twiddle.net>
	<20170614052311.13785-10-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7bcb68c3-e1d3-40bf-6db8-85b7e8a4aa14@amsat.org>
Date: Wed, 14 Jun 2017 11:27:52 -0300
MIME-Version: 1.0
In-Reply-To: <20170614052311.13785-10-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 09/10] Revert "target/aarch64: optimize
 indirect branches"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Can this pull wait you test last series sent by Alex Bennée with the 
following patch?

I dont have Alpha images to test on.

"tcg-runtime: short-circuit lookup_tb_ptr on IRQs"

On 06/14/2017 02:23 AM, Richard Henderson wrote:
> This reverts commit e75449a346bf558296966a44277bfd93412c6da6.
>
> This patch appears to induce lockups, or maybe livelocks, while
> booting a Linux kernel.  The assumption is that there is a bug
> elsewhere within QEMU, but reverting the patch allows normal work
> to continue in the meantime.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/arm/translate-a64.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 860e279..ab61d96 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11367,7 +11367,8 @@ void gen_intermediate_code_a64(ARMCPU *cpu, TranslationBlock *tb)
>              gen_a64_set_pc_im(dc->pc);
>              /* fall through */
>          case DISAS_JUMP:
> -            tcg_gen_lookup_and_goto_ptr(cpu_pc);
> +            /* indicate that the hash table must be used to find the next TB */
> +            tcg_gen_exit_tb(0);
>              break;
>          case DISAS_TB_JUMP:
>          case DISAS_EXC:
>
