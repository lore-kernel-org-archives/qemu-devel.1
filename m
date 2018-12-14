Received: from eggs.gnu.org ([2001:4830:134:3::10]:40936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gXeYv-0000bQ-N2
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gXeYr-0008Mw-LU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:54:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:59313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@kernel.crashing.org>)
	id 1gXeYr-0008Ea-9F
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:54:49 -0500
Message-ID: <cf77c9e71a0ae5d3dd4ed163c60785ceffb05ffd.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 14 Dec 2018 14:54:38 +1100
In-Reply-To: <0ad68048-8f16-930f-2e87-ca90d8038bd0@linaro.org>
References: <20181213235804.14956-1-benh@kernel.crashing.org>
	<0ad68048-8f16-930f-2e87-ca90d8038bd0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] memory_ldst: Add atomic ops for PTE
 updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On Thu, 2018-12-13 at 21:01 -0600, Richard Henderson wrote:
> On 12/13/18 5:58 PM, Benjamin Herrenschmidt wrote:
> > +#ifdef CONFIG_ATOMIC64
> > +/* This is meant to be used for atomic PTE updates under MT-TCG */
> > +uint32_t glue(address_space_cmpxchgq_notdirty, SUFFIX)(ARG1_DECL,
> > +    hwaddr addr, uint64_t old, uint64_t new, MemTxAttrs attrs, MemTxResult *result)
> > +{
> > +    uint8_t *ptr;
> > +    MemoryRegion *mr;
> > +    hwaddr l = 8;
> > +    hwaddr addr1;
> > +    MemTxResult r;
> > +    uint8_t dirty_log_mask;
> > +
> > +    /* Must test result */
> > +    assert(result);
> > +
> > +    RCU_READ_LOCK();
> > +    mr = TRANSLATE(addr, &addr1, &l, true, attrs);
> > +    if (l < 8 || !memory_access_is_direct(mr, true)) {
> > +        r = MEMTX_ERROR;
> > +    } else {
> > +        uint32_t orig = old;
> > +
> > +        ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> > +        old = atomic_cmpxchg(ptr, orig, new);
> > +
> 
> I think you need atomic_cmpxchg__nocheck here.
> 
> Failure would be with a 32-bit host that supports ATOMIC64.
> E.g. i686.

I'm confused by this and the comments around the definition of
ATOMIC_REG_SIZE :)

So would we have CONFIG_ATOMIC64 in that case and if yes why if all the
atomic_* end up barfing ?

Or rather, why set CONFIG_ATOMIC64 if we ought not to use 64-bit
atomics ?

Also we should probably define ATOMIC_REG_SIZE to 8 for ppc64...

Cheers
Ben.
> 
> r~
