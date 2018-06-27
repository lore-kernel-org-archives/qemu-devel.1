Received: from eggs.gnu.org ([2001:4830:134:3::10]:43893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fYJXt-00082q-2z
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fYJXp-0006MJ-S0
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:08:17 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fYJXp-0006KB-LH
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:08:13 -0400
Received: by mail-pf0-x244.google.com with SMTP id y5-v6so1648882pfn.4
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 16:08:13 -0700 (PDT)
Date: Thu, 28 Jun 2018 08:08:10 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180627230810.GL24595@lianli.shorne-pla.net>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-14-richard.henderson@linaro.org>
	<CAAfxs74pe4BnScaFdmUBbX=-kD5qp2pQN-JgnFy4QGfGXNe9oQ@mail.gmail.com>
	<CAAfxs77w97-8iNRf_XfqDewrgm61SroT-WcCedM9hvg8E+kMYQ@mail.gmail.com>
	<d80aae07-404e-ada2-9a9b-4d1d96c9e63b@linaro.org>
	<20180627125953.GK24595@lianli.shorne-pla.net>
	<ad0fc460-02ee-ca79-de48-ab01e19f0ce7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0fc460-02ee-ca79-de48-ab01e19f0ce7@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 13/22] target/openrisc: Fix cpu_mmu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On Wed, Jun 27, 2018 at 06:50:18AM -0700, Richard Henderson wrote:
> On 06/27/2018 05:59 AM, Stafford Horne wrote:
> > The index is negative... this patch should fix that.
> > 
> > @@ -78,6 +78,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr,
> > target_ulong rb)
> >      case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
> >          idx = (spr - 1024);
> >          env->shadow_gpr[idx / 32][idx % 32] = rb;
> > +        break;
> >  
> >      case TO_SPR(1, 512) ... TO_SPR(1, 512 + TLB_SIZE - 1): /* DTLBW0MR 0-127 */
> 
> OMG.  That's embarrasing...

Yes, I thought so too, it's my bug.  I am little surprised it didn't cause
issues before.

I am still getting failures on SMP, this time the kernel is jumping to some
unknown address, maybe an itlb issue, I will continue to debug.  Bisecting it is
exposing some other issues (the mmu handlers were not getting init'd during one
point in time).

-Stafford
