Received: from eggs.gnu.org ([2001:4830:134:3::10]:46833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgwFO-0005jb-Qk
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 14:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgwFO-0004Mw-2n
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 14:04:50 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgwFN-0004Mb-Ss
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 14:04:50 -0400
Received: by mail-pg1-x541.google.com with SMTP id p23-v6so9333834pgv.13
	for <qemu-devel@nongnu.org>; Sat, 21 Jul 2018 11:04:49 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-22-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8720b1f8-3f43-9800-d825-25a46aa20f08@linaro.org>
Date: Sat, 21 Jul 2018 11:04:45 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-22-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 21/40] target/mips: Implement DSP ASE
 support for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> +        gen_helper_cmpgu_eq_qb(t1, v1_t, v2_t);
> +        tcg_gen_mov_tl(cpu_gpr[ret], t1);
> +        tcg_gen_andi_tl(cpu_dspctrl, cpu_dspctrl, 0xF0FFFFFF);
> +        tcg_gen_shli_tl(t1, t1, 24);
> +        tcg_gen_or_tl(cpu_dspctrl, cpu_dspctrl, t1);

Better as

  gen_helper_cmpgu_eq_qb(cpu_gpr[ret], v1_t, v2_t);
  tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, cpu_gpr[ret], 24, 4);

and the several repetitions.


r~
