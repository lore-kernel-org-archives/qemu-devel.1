Received: from eggs.gnu.org ([2001:4830:134:3::10]:43163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbhA1-0001dN-6e
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbh9y-0000eX-27
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:20:49 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbh9x-0000eN-Tx
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 00:20:45 -0500
Received: by mail-qk0-x242.google.com with SMTP id 11so20935014qkl.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 21:20:45 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170209045154.16868-1-rth@twiddle.net>
	<20170209045154.16868-21-rth@twiddle.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1a00de64-22d4-9284-b60f-09fcf36cb149@gmail.com>
Date: Thu, 9 Feb 2017 02:20:42 -0300
MIME-Version: 1.0
In-Reply-To: <20170209045154.16868-21-rth@twiddle.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 20/22] target/openrisc: Optimize l.jal to
 next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, shorne@gmail.com



On 02/09/2017 01:51 AM, Richard Henderson wrote:
> This allows the tcg optimizer to see, and fold, all of the
> constants involved in a GOT base register load sequence.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/openrisc/translate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 66064e1..cda84b6 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -198,7 +198,11 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
>          tcg_gen_movi_tl(jmp_pc, tmp_pc);
>          break;
>      case 0x01:     /* l.jal */
> -        tcg_gen_movi_tl(cpu_R[9], (dc->pc + 8));
> +        tcg_gen_movi_tl(cpu_R[9], dc->pc + 8);
> +        /* Optimize jal being used to load the PC for PIC.  */
> +        if (tmp_pc == dc->pc + 8) {
> +            return;
> +        }
>          tcg_gen_movi_tl(jmp_pc, tmp_pc);
>          break;
>      case 0x03:     /* l.bnf */
>
