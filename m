Received: from eggs.gnu.org ([2001:4830:134:3::10]:42543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQsU-0003Br-3Y
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWQsP-0001rx-AL
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:06:02 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWQsO-0001rQ-Qs
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:05:57 -0500
Received: by mail-ot1-x343.google.com with SMTP id v23so11492072otk.9
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 11:05:56 -0800 (PST)
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<20181207085635.4291-5-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <958fc521-9193-bd72-ca82-c8aac222fad2@linaro.org>
Date: Mon, 10 Dec 2018 13:05:52 -0600
MIME-Version: 1.0
In-Reply-To: <20181207085635.4291-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/6] target/ppc: switch FPR,
 VMX and VSX helpers to access data directly from cpu_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/7/18 2:56 AM, Mark Cave-Ayland wrote:
> Instead of accessing the FPR, VMX and VSX registers through static arrays of
> TCGv_i64 globals, remove them and change the helpers to load/store data directly
> within cpu_env.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/translate.c | 59 ++++++++++++++------------------------------------
>  1 file changed, 16 insertions(+), 43 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Note however, that there are other steps that you must add here before using
vector operations in the next patch:

(1a) The fpr and vsr arrays must be merged, since fpr[n] == vsrh[n].
     If this isn't done, then you simply cannot apply one operation
     to two disjoint memory blocks.

(1b) The vsr and avr arrays should be merged, since vsr[32+n] == avr[n].
     This is simply tidiness, matching the layout to the architecture.

These steps will modify gdbstub.c, machine.c, and linux-user/.

(2) The vsr array needs to be QEMU_ALIGN(16).  See target/arm/cpu.h.
    We assert that the host addresses are 16 byte aligned, so that we
    can eventually use Altivec/VSX in tcg/ppc/.


r~
