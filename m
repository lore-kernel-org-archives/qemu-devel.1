Received: from eggs.gnu.org ([2001:4830:134:3::10]:33631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9uxq-0006Le-VX
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9uxn-0003G6-64
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:34:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:36692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9uxl-0003C8-61
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 12:34:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id a8-v6so2685853wmf.1
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 09:34:22 -0700 (PDT)
References: <20181008232756.30704-1-cota@braap.org>
	<20181008232756.30704-6-cota@braap.org>
	<87d0sjmaqq.fsf@linaro.org> <20181009160325.GB7480@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181009160325.GB7480@flamenco>
Date: Tue, 09 Oct 2018 17:34:20 +0100
Message-ID: <87a7nnm643.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> On Tue, Oct 09, 2018 at 15:54:21 +0100, Alex Benn=C3=A9e wrote:
>> Emilio G. Cota <cota@braap.org> writes:
>> > +    if (new_size =3D=3D old_size) {
>> > +        return;
>> > +    }
>> > +
>> > +    g_free(env->tlb_table[mmu_idx]);
>> > +    g_free(env->iotlb[mmu_idx]);
>> > +
>> > +    /* desc->n_used_entries is cleared by the caller */
>> > +    desc->n_flushes_low_rate =3D 0;
>> > +    env->tlb_mask[mmu_idx] =3D (new_size - 1) << CPU_TLB_ENTRY_BITS;
>> > +    env->tlb_table[mmu_idx] =3D g_new(CPUTLBEntry, new_size);
>> > +    env->iotlb[mmu_idx] =3D g_new0(CPUIOTLBEntry, new_size);
>
> For the iotlb we can use g_new, right?
>
> iotlb[foo][bar] is only checked after having checked tlb_table[foo][bar].
> Otherwise tlb_flush would also flush the iotlb.
>
>> I guess the allocation is a big enough stall there is no point either
>> pre-allocating or using RCU to clean-up the old data?
>
> I tried this. Turns out not to make a difference, because (1) we only
> resize on flushes, which do not happen that often, and (2) we
> size up aggressively, but the shrink rate is more conservative. So
> in the end, it's a drop in the ocean. For instance, bootup+shutdown
> requires 100 calls to g_new+g_free -- at ~300 cycles each, that's
> about 30us out of ~8s of execution time.
>
>> Given this is a new behaviour it would be nice to expose the occupancy
>> of the TLBs in "info jit" much like we do for TBs.
>
> The occupancy changes *very* quickly, so by the time the report is out,
> the info is stale. So I'm not sure that's very useful.

Hmm do I mean occupancy or utilisation? I guess I want to get an idea of
how much of the TLB has been used and how much is empty never to be used
space. In theory as the TLB tends towards guest page size out TLB
turnover should be of the order of the guests' TLB re-fill rate?

> The TLB size changes less often, but reporting on it is not obvious,
> since we have NB_MMU_MODES sizes per CPU. Say we have 20 CPUs, what should
> we report? A table with 20 * NB_MMU_MODES cells? I dunno.

I guess not. Although I suspect some MMU_MODES are more interesting than
others. I'm hoping the usage of EL3 related modes is negligible if we
haven't booted with a secure firmware for example.

>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Thanks!
>
> 		Emilio


--
Alex Benn=C3=A9e
