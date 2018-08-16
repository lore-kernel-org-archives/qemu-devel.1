Received: from eggs.gnu.org ([2001:4830:134:3::10]:45927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqNxF-000839-O8
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqNxA-0003hd-Ry
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:29:09 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:43169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqNxA-0003hV-KK
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:29:04 -0400
Received: by mail-pl0-x244.google.com with SMTP id x6-v6so2551340plv.10
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 12:29:04 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-51-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72569c5a-76b6-027a-f8c6-5d309d4d4060@linaro.org>
Date: Thu, 16 Aug 2018 12:29:00 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-51-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 50/84] target/mips: Add updating
 BadInstr, BadInstrP, BadInstrX for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> +        if ((env->CP0_Config3 & (1 << CP0C3_BP)) &&
> +            (env->hflags & MIPS_HFLAG_BMASK)) {
> +            if (!(env->hflags & MIPS_HFLAG_B16)) {
> +                env->CP0_BadInstrP = cpu_ldl_code(env, env->active_tc.PC - 4);
> +            } else {
> +                env->CP0_BadInstrP =
> +                    (cpu_lduw_code(env, env->active_tc.PC - 2)) << 16;
> +            }

Does BadInstrP really make sense for nanomips?  I do still see it in the
documentation, but I thought that was all about the branch delay slot, which is
no longer present.

Patch 39 began avoiding the set of BMASK.  So you can no longer rely on it
here.  Do we need a different mechanism to support BadInstrP, or do we really
need to keep BMASK?


r~
