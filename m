Received: from eggs.gnu.org ([2001:4830:134:3::10]:48851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgwQ8-0001bP-6F
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 14:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fgwQ5-0006oh-0V
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 14:15:56 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:47027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fgwQ4-0006oX-OM
	for qemu-devel@nongnu.org; Sat, 21 Jul 2018 14:15:52 -0400
Received: by mail-pg1-x541.google.com with SMTP id p23-v6so9344050pgv.13
	for <qemu-devel@nongnu.org>; Sat, 21 Jul 2018 11:15:52 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-24-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b2be38da-84b6-904c-a826-1c86fed7e03c@linaro.org>
Date: Sat, 21 Jul 2018 11:15:48 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-24-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 23/40] target/mips: Implement emulation
 of nanoMIPS LLWP/SCWP pair
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
> From: Yongbok Kim <yongbok.kim@mips.com>
> 
> Implement nanoMIPS LLWP and SCWP instruction pair.
> 
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  linux-user/mips/cpu_loop.c |  25 ++++++++---
>  target/mips/cpu.h          |   2 +
>  target/mips/helper.h       |   2 +
>  target/mips/op_helper.c    |  35 +++++++++++++++
>  target/mips/translate.c    | 107 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 166 insertions(+), 5 deletions(-)

Hmm.  Well, it's ok as far as it goes, but I'd really really like to see
target/mips to be updated to use actual atomic operations.  Otherwise
mips*-linux-user will never be reliable and mips*-softmmu cannot run SMP in
multi-threaded mode.

While converting the rest of target/mips to atomic operations is perhaps out of
scope for this patch set, there's really no reason not to do these two
instructions correctly from the start.  It'll save the trouble of rewriting
them from scratch later.

Please see target/arm/translate.c, gen_load_exclusive and gen_store_exclusive,
for the size == 3 case.  That is arm32 doing a 64-bit "paired" atomic
operation, just like you are attempting here.

Note that single-copy atomic semantics apply in both cases, so LLWP must
perform one 64-bit load, not two 32-bit loads.  The store in SCWP must happen
with a 64-bit atomic cmpxchg operation.


r~
