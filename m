Received: from eggs.gnu.org ([2001:4830:134:3::10]:60379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Ffm-0000lf-TO
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Ffi-0001pM-QS
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:56:50 -0400
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:42677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9Ffi-0001mk-I5
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:56:46 -0400
Received: by mail-pl0-x22b.google.com with SMTP id t20-v6so3856447ply.9
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 12:56:46 -0700 (PDT)
References: <20180419112131.16932-1-edgar.iglesias@gmail.com>
	<20180419112131.16932-2-edgar.iglesias@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4439efca-e41e-14f8-85ff-89478608c80a@linaro.org>
Date: Thu, 19 Apr 2018 09:56:40 -1000
MIME-Version: 1.0
In-Reply-To: <20180419112131.16932-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/5] target-microblaze: Respect MSR.PVR
 as read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sai.pavan.boddu@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, edgar.iglesias@xilinx.com, frasse.iglesias@gmail.com

On 04/19/2018 01:21 AM, Edgar E. Iglesias wrote:
>  static inline void msr_write(DisasContext *dc, TCGv v)
>  {
> -    TCGv t;
> -
> -    t = tcg_temp_new();
>      dc->cpustate_changed = 1;
>      /* PVR bit is not writable.  */
> -    tcg_gen_andi_tl(t, v, ~MSR_PVR);
> -    tcg_gen_andi_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR);
> -    tcg_gen_or_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], v);
> -    tcg_temp_free(t);
> +    tcg_gen_deposit_tl(cpu_SR[SR_MSR], v, cpu_SR[SR_MSR], MSR_PVR_SHIFT, 1);
>  }

Um... the old code was correct, but the new code isn't.

The new code sets msr to v, with bit 10 set to the old msr bit 0.

Why do you believe the old code to be wrong?


r~
