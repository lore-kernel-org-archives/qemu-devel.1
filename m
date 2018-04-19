Received: from eggs.gnu.org ([2001:4830:134:3::10]:54329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1f9GFu-0000sx-Me
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1f9GFs-0001Ba-3k
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:34:10 -0400
Received: from mail-by2nam03on0051.outbound.protection.outlook.com
	([104.47.42.51]:10216
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1f9GFr-00018S-Kd
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 16:34:08 -0400
Date: Thu, 19 Apr 2018 22:33:47 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180419203347.5m4bwxmkkesergbx@toto>
References: <20180419112131.16932-1-edgar.iglesias@gmail.com>
	<20180419112131.16932-2-edgar.iglesias@gmail.com>
	<4439efca-e41e-14f8-85ff-89478608c80a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4439efca-e41e-14f8-85ff-89478608c80a@linaro.org>
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, sai.pavan.boddu@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, frasse.iglesias@gmail.com

On Thu, Apr 19, 2018 at 09:56:40AM -1000, Richard Henderson wrote:
> On 04/19/2018 01:21 AM, Edgar E. Iglesias wrote:
> >  static inline void msr_write(DisasContext *dc, TCGv v)
> >  {
> > -    TCGv t;
> > -
> > -    t = tcg_temp_new();
> >      dc->cpustate_changed = 1;
> >      /* PVR bit is not writable.  */
> > -    tcg_gen_andi_tl(t, v, ~MSR_PVR);
> > -    tcg_gen_andi_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR);
> > -    tcg_gen_or_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], v);
> > -    tcg_temp_free(t);
> > +    tcg_gen_deposit_tl(cpu_SR[SR_MSR], v, cpu_SR[SR_MSR], MSR_PVR_SHIFT, 1);
> >  }
> 
> Um... the old code was correct, but the new code isn't.
> 
> The new code sets msr to v, with bit 10 set to the old msr bit 0.
> 
> Why do you believe the old code to be wrong?

The old code was incorrectly ORing v instead of t...

What about the following?
    tcg_gen_shri_tl(cpu_SR[SR_MSR], cpu_SR[SR_MSR], MSR_PVR_SHIFT);
    tcg_gen_deposit_tl(cpu_SR[SR_MSR], v, cpu_SR[SR_MSR], MSR_PVR_SHIFT, 1);

Cheers,
Edgar
