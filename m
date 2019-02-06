Received: from eggs.gnu.org ([209.51.188.92]:57887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grDkd-0004X6-VA
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grDgR-0002dM-Pi
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:15:32 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grDgR-0002cz-4c
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:15:31 -0500
Received: by mail-wm1-x344.google.com with SMTP id y8so1060168wmi.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 19:15:30 -0800 (PST)
References: <20190205151810.571-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b8c414fe-e0cb-29ea-84cd-1f4386e6a10b@linaro.org>
Date: Wed, 6 Feb 2019 03:15:26 +0000
MIME-Version: 1.0
In-Reply-To: <20190205151810.571-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel/tcg: Consider cluster index in
 tb_lookup__cpu_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Howard Spoelstra <hsp.cat7@gmail.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>

On 2/5/19 3:18 PM, Peter Maydell wrote:
> In commit f7b78602fdc6c6e4be we added the CPU cluster number to the
> cflags field of the TB hash; this included adding it to the value
> kept in tb->cflags, since we pass that field directly into the hash
> calculation in some places. Unfortunately we forgot to check whether
> other parts of the code were doing comparisons against tb->cflags
> that would need to be updated.
> 
> It turns out that there is exactly one such place: the
> tb_lookup__cpu_state() function checks whether the TB it has
> found in the tb_jmp_cache has a tb->cflags matching the cf_mask
> that is passed in. The tb->cflags has the cluster_index in it
> but the cf_mask does not.
> 
> Hoist the "add cluster index to the cf_mask" code up from
> tb_htable_lookup() to tb_lookup__cpu_state() so it can be considered
> in the "did this TB match in the jmp cache" condition, as well as
> when we do the full hash lookup by physical PC, flags, etc.
> (tb_htable_lookup() is only called from tb_lookup__cpu_state(),
> so this change doesn't require any further knock-on changes.)
> 
> Fixes: f7b78602fdc6c6e4be ("accel/tcg: Add cluster number to TCG TB hash")
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Reported-by: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> Does anybody know why tb_lookup__cpu_state() has that odd
> double-underscore in the middle of its name?

I'm inclined to think typo...  Emilio?


r~
