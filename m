Received: from eggs.gnu.org ([209.51.188.92]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grE2A-0002qG-4Z
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grE28-0003EW-Hv
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:37:58 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grE28-0003Dq-8F
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 22:37:56 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so5981760wrv.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 19:37:55 -0800 (PST)
References: <20190104223116.14037-1-richard.henderson@linaro.org>
	<d52c8ae0-edee-ed9a-56b8-43cc1cf0208d@ilande.co.uk>
	<362de5ba-a678-aeed-6a5d-3a02844c2560@linaro.org>
	<6314c25b-a8c9-a8e2-2e1d-a8eeb3b88f2c@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <935af9ba-3fd8-ebd8-4f70-5050351d89d5@linaro.org>
Date: Wed, 6 Feb 2019 03:37:50 +0000
MIME-Version: 1.0
In-Reply-To: <6314c25b-a8c9-a8e2-2e1d-a8eeb3b88f2c@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/10] tcg vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Howard Spoelstra <hsp.cat7@gmail.com>

On 2/5/19 9:29 PM, Mark Cave-Ayland wrote:
> The only minor question I had with the patchset in its current form is whether to use
> the new VsrD() macro for vscr_sat, or whether we don't really care enough?

Given the comment

  /* Which bit we set is completely arbitrary, but clear the rest.  */

I don't think VsrD is helpful.


In "target/ppc: Split out VSCR_SAT to a vector field":

      ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
+     /* Non-zero if and only if VSCR_SAT should be set.  */
+     ppc_vsr_t vscr_sat;

Better to add the QEMU_ALIGNED(16) to vscr_sat as well.  Yes, it will already
happen to be aligned by placement, but this is also a bit documentation.


In "target/ppc: convert vadd*s and vsub*s to vector operations":

          if (sat) {                                                      \
-             set_vscr_sat(env);                                          \
+             vscr_sat->u32[0] = 1;                                       \
          }                                                               \

Changed in error?


r~
