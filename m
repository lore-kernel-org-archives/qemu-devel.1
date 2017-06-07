Received: from eggs.gnu.org ([2001:4830:134:3::10]:47319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIdFS-0005Yh-V9
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIdFP-0003sF-4k
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:51:55 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dIdFO-0003sA-UB
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:51:51 -0400
Received: by mail-wm0-x229.google.com with SMTP id n195so14205622wmg.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:51:50 -0700 (PDT)
References: <20170605165233.4135-1-rth@twiddle.net>
	<20170605165233.4135-23-rth@twiddle.net>
	<87h8zrdh02.fsf@linaro.org> <87fufbdghz.fsf@linaro.org>
	<87efuvddux.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87efuvddux.fsf@linaro.org>
Date: Wed, 07 Jun 2017 16:52:15 +0100
Message-ID: <87d1afdccw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 22/26] target/aarch64: optimize indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>


Alex Bennée <alex.bennee@linaro.org> writes:

> Alex Bennée <alex.bennee@linaro.org> writes:
>
>> Alex Bennée <alex.bennee@linaro.org> writes:
>>
>>> Richard Henderson <rth@twiddle.net> writes:
>>>
>>>> From: "Emilio G. Cota" <cota@braap.org>
>>>>
>>>> Measurements:
>>>>
>>>> [Baseline performance is that before applying this and the previous
>>>> commit]
>>>
>>> Sadly this has regressed my qemu-system-aarch64 EL2 run. It was slightly
>>> masked by an unrelated assertion breakage which I had to fix. However
>>> with this patch my boot hangs spinning all 4 threads. Once reverted
>>> things work again.
>>>
>>> My command line:
>>>
>>>   timeout -k 1s --foreground 120s ./aarch64-softmmu/qemu-system-aarch64 -machine type=virt -display none -m 4096 -cpu cortex-a57 -serial mon:stdio -netdev user,id=unet -device virtio-net-device,netdev=unet -drive file=/home/alex/lsrc/qemu/images/jessie-arm64.qcow2,id=myblock,index=0,if=none -device virtio-blk-device,drive=myblock -append "console=ttyAMA0 root=/dev/vda1 systemd.unit=benchmark.service" -kernel /home/alex/lsrc/qemu/images/aarch64-current-linux-kernel-only.img -smp 4 -machine gic-version=3 -machine virtualization=true -name debug-threads=on
>>>
>>> My tree with fix and revert:
>>>
>>>   https://github.com/stsquad/qemu/tree/debug/aarch64-hang
>>>
>>> I'm investigating now.
>>
>> Well this seems to be a case of hangs with -smp > 1 (which I guess was
>> obvious seeing as the TCG threads seem to be spinning against each
>> other).
>
> So the minimum fix I've found to get things working again is:
>
> void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
> {
>     CPUState *cpu = ENV_GET_CPU(env);
>     TranslationBlock *tb;
>     target_ulong cs_base, pc;
>     uint32_t flags;
>
>     tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
>     if (likely(tb)) {
>         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>         if (likely(tb->pc == addr && tb->cs_base == cs_base &&
>                    tb->flags == flags)) {
>             goto found;
>         }
>         tb = tb_htable_lookup(cpu, addr, cs_base, flags);
>         if (likely(tb)) {
>             atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
>             /* goto found; */
>         }
>     }
>     return tcg_ctx.code_gen_epilogue;
>  found:
>     qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
>                            "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
>                            tb->tc_ptr, cpu->cpu_index, addr,
>                            lookup_symbol(addr));
>     return tb->tc_ptr;
> }
>
> Which I find very odd. It would imply that tb_htable_lookup is giving us
> a bad result, except I would find it very unlikely what ever funky value
> we stored in the jmp cache would never get hit again.
>
> /me is very confused.

OK I think we need to think about when we can run code, c.f. comment in
tb_gen_code:

    /* As long as consistency of the TB stuff is provided by tb_lock in user
     * mode and is implicit in single-threaded softmmu emulation, no explicit
     * memory barrier is required before tb_link_page() makes the TB visible
     * through the physical hash table and physical page list.
     */
    tb_link_page(tb, phys_pc, phys_page2);

As tb_link_page does the qht_insert I think what is happening is we are
attempting to run code that has just been generated but is not
completely visible to other cores yet. By commenting out the goto found
we slip it enough that next time around it is complete.

However I'm still confused because qht_insert and qht_lookup have
implied barriers in them that should mean we don't pull a partially
complete TB out of the hash.

I did add some debug that saved the tb_htable_lookup's in an cpu indexed
array and they certainly get hits on the tb_jmp_cache lookup so I don't
think my commenting of found means those htable looked up TBs never get
executed.

--
Alex Bennée
