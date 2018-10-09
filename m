Received: from eggs.gnu.org ([2001:4830:134:3::10]:52933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9uTz-0003jc-Uq
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:03:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g9uTt-0000Rw-3E
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:03:38 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:46209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g9uTp-0000PB-CS
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:03:31 -0400
Date: Tue, 9 Oct 2018 12:03:25 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181009160325.GB7480@flamenco>
References: <20181008232756.30704-1-cota@braap.org>
	<20181008232756.30704-6-cota@braap.org> <87d0sjmaqq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87d0sjmaqq.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC v2 5/5] cputlb: dynamically resize TLBs based
 on use rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Tue, Oct 09, 2018 at 15:54:21 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > +    if (new_size == old_size) {
> > +        return;
> > +    }
> > +
> > +    g_free(env->tlb_table[mmu_idx]);
> > +    g_free(env->iotlb[mmu_idx]);
> > +
> > +    /* desc->n_used_entries is cleared by the caller */
> > +    desc->n_flushes_low_rate = 0;
> > +    env->tlb_mask[mmu_idx] = (new_size - 1) << CPU_TLB_ENTRY_BITS;
> > +    env->tlb_table[mmu_idx] = g_new(CPUTLBEntry, new_size);
> > +    env->iotlb[mmu_idx] = g_new0(CPUIOTLBEntry, new_size);

For the iotlb we can use g_new, right?

iotlb[foo][bar] is only checked after having checked tlb_table[foo][bar].
Otherwise tlb_flush would also flush the iotlb.

> I guess the allocation is a big enough stall there is no point either
> pre-allocating or using RCU to clean-up the old data?

I tried this. Turns out not to make a difference, because (1) we only
resize on flushes, which do not happen that often, and (2) we
size up aggressively, but the shrink rate is more conservative. So
in the end, it's a drop in the ocean. For instance, bootup+shutdown
requires 100 calls to g_new+g_free -- at ~300 cycles each, that's
about 30us out of ~8s of execution time.

> Given this is a new behaviour it would be nice to expose the occupancy
> of the TLBs in "info jit" much like we do for TBs.

The occupancy changes *very* quickly, so by the time the report is out,
the info is stale. So I'm not sure that's very useful.

The TLB size changes less often, but reporting on it is not obvious,
since we have NB_MMU_MODES sizes per CPU. Say we have 20 CPUs, what should
we report? A table with 20 * NB_MMU_MODES cells? I dunno.

> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

		Emilio
