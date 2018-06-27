Received: from eggs.gnu.org ([2001:4830:134:3::10]:49866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fYA3F-0004lY-C3
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:00:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fYA3B-0004sB-Bl
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:00:01 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:42207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fYA3B-0004rp-2O
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:59:57 -0400
Received: by mail-pl0-x242.google.com with SMTP id w17-v6so1000937pll.9
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 05:59:56 -0700 (PDT)
Date: Wed, 27 Jun 2018 21:59:53 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180627125953.GK24595@lianli.shorne-pla.net>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
	<20180618184046.6270-14-richard.henderson@linaro.org>
	<CAAfxs74pe4BnScaFdmUBbX=-kD5qp2pQN-JgnFy4QGfGXNe9oQ@mail.gmail.com>
	<CAAfxs77w97-8iNRf_XfqDewrgm61SroT-WcCedM9hvg8E+kMYQ@mail.gmail.com>
	<d80aae07-404e-ada2-9a9b-4d1d96c9e63b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d80aae07-404e-ada2-9a9b-4d1d96c9e63b@linaro.org>
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

On Tue, Jun 26, 2018 at 03:26:01PM -0700, Richard Henderson wrote:
> On 06/26/2018 03:07 PM, Stafford Horne wrote:
> > Hello,
> > 
> > I think I found out something.
> > 
> > in: target/openrisc/sys_helper.c:92
> > 
> > When we write to `env->tlb.dtlb[idx].tr`  in helper_mtspr():
> >   93          case TO_SPR(1, 640) ... TO_SPR(1, 640 + TLB_SIZE - 1):
> > /* DTLBW0TR 0-127 */
> >   94              idx = spr - TO_SPR(1, 640);
> >   95              env->tlb.dtlb[idx].tr = rb;
> > 
> > 
> > Somehow we are overlapping with `cpu->tb_jmp_cache`,  these are both
> > pointing to the same spot in memory.
> > 
> > (gdb) p &cs->tb_jmp_cache[3014]
> > $9 = (struct TranslationBlock **) 0x55555608b300
> > (gdb) p &env->tlb.dtlb[idx].tr
> > $10 = (uint32_t *) 0x55555608b304
> 
> That is definitely weird.  How about
> 
> (gdb) p openrisc_env_get_cpu(env)
> $1 = xxxx
> (gdb) p &$1->parent_obj
> (gdb) p &$1->env
> (gdb) p cs->env_ptr
> 
> There should be 4096 entries in tb_jmp_cache, so there should
> be no way that overlaps.  I can only imagine either CS or ENV
> is incorrect somehow.  How that would be, I don't know...

Nothing looks strange there... but this does... :)

(gdb) p &cs->tb_jmp_cache[3014]
$56 = (struct TranslationBlock **) 0x55555606c570
(gdb) p &env->tlb.dtlb[idx].tr
$57 = (uint32_t *) 0x55555606c574
(gdb) p &env->tlb.dtlb[idx].mr
$58 = (uint32_t *) 0x55555606c570
(gdb) p idx
$59 = -1502

The index is negative... this patch should fix that.

@@ -78,6 +78,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr,
target_ulong rb)
     case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
         idx = (spr - 1024);
         env->shadow_gpr[idx / 32][idx % 32] = rb;
+        break;
 
     case TO_SPR(1, 512) ... TO_SPR(1, 512 + TLB_SIZE - 1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);

-Stafford
