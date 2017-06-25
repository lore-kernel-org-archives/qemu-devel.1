Received: from eggs.gnu.org ([2001:4830:134:3::10]:58908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPEMR-0007Me-UK
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 16:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPEMN-0006aA-1D
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 16:42:23 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:34396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPEMM-0006Zn-Rg
	for qemu-devel@nongnu.org; Sun, 25 Jun 2017 16:42:18 -0400
Received: by mail-pf0-x229.google.com with SMTP id s66so45859262pfs.1
	for <qemu-devel@nongnu.org>; Sun, 25 Jun 2017 13:42:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170625192125.9992-1-laurent@vivier.eu>
	<20170625192125.9992-2-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3c22490c-58ed-054c-9ac5-40acea5e0cef@twiddle.net>
Date: Sun, 25 Jun 2017 13:42:12 -0700
MIME-Version: 1.0
In-Reply-To: <20170625192125.9992-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] target/m68k: add fscc.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 06/25/2017 12:21 PM, Laurent Vivier wrote:
> +    c->g1 = 0;
> +    c->v2 = tcg_const_i32(0);
> +    c->g2 = 1;
> +    /* TODO: Raise BSUN exception.  */
>       fpsr = tcg_temp_new();
>       gen_load_fcr(s, fpsr, M68K_FPSR);
> -    l1 = gen_new_label();
> -    /* TODO: Raise BSUN exception.  */
> -    /* Jump to l1 if condition is true.  */
> -    switch (insn & 0x3f)  {
> +    switch (cond) {
>       case 0:  /* False */
>       case 16: /* Signaling False */
> +        c->v1 = c->v2;
> +        c->tcond = TCG_COND_NEVER;
>           break;
>       case 1:  /* EQual Z */
>       case 17: /* Signaling EQual Z */
> -        tmp = tcg_temp_new();
> -        tcg_gen_andi_i32(tmp, fpsr, FPSR_CC_Z);
> -        tcg_gen_brcondi_i32(TCG_COND_NE, tmp, 0, l1);
> +        c->v1 = tcg_temp_new();
> +        c->g1 = 1;

g[12] means "global", i.e. don't free the temp in free_cond.
Which is not true of any of the temps that you allocate here.


r~
