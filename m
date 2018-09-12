Received: from eggs.gnu.org ([2001:4830:134:3::10]:55232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g0BcB-0005Ul-Qy
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g0Bc6-0001qd-4k
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:19:55 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g0Bc2-0001km-0t
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:19:48 -0400
Received: by mail-pg1-x543.google.com with SMTP id r1-v6so1600508pgp.11
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 13:19:45 -0700 (PDT)
References: <20180830193019.20104-1-jancraig@amazon.com>
	<20180830193019.20104-6-jancraig@amazon.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8542d2e6-c2e2-fa86-28e6-af4be0929801@linaro.org>
Date: Wed, 12 Sep 2018 13:19:42 -0700
MIME-Version: 1.0
In-Reply-To: <20180830193019.20104-6-jancraig@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/9] target/mips: Add MXU instruction
 S8LDD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com

On 08/30/2018 12:30 PM, Craig Janeczek via Qemu-devel wrote:
> +    gen_load_mxu_cr(t0);
> +    tcg_gen_andi_tl(t0, t0, MXUEN);
> +    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXUEN, l0);

Probably MXUEN should be included in env->hflags, and therefore
tested via ctx->hflags.  (Which also means ending a TB after a
write to MCR, which can change this value).

The documentation says that if MXUEN is unset the result is
"unpredictable".  What does real hardware do?  Does it really
treat the instruction as a nop?  Does it raise an exception?

Otherwise another possibility for "unpredictable" is to simply
execute the instruction.  Which would certainly be the easiest
implementation...


r~
