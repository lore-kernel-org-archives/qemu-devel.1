Received: from eggs.gnu.org ([2001:4830:134:3::10]:38018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIck5-0004Ax-Ut
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIck2-00089i-Nz
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:19:29 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dIck2-00089a-Gw
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:19:26 -0400
Received: by mail-wr0-x22c.google.com with SMTP id q97so7654152wrb.2
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:19:26 -0700 (PDT)
References: <20170605165233.4135-1-rth@twiddle.net>
	<20170605165233.4135-23-rth@twiddle.net>
	<87h8zrdh02.fsf@linaro.org> <87fufbdghz.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87fufbdghz.fsf@linaro.org>
Date: Wed, 07 Jun 2017 16:19:50 +0100
Message-ID: <87efuvddux.fsf@linaro.org>
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
>> Richard Henderson <rth@twiddle.net> writes:
>>
>>> From: "Emilio G. Cota" <cota@braap.org>
>>>
>>> Measurements:
>>>
>>> [Baseline performance is that before applying this and the previous
>>> commit]
>>
>> Sadly this has regressed my qemu-system-aarch64 EL2 run. It was slightly
>> masked by an unrelated assertion breakage which I had to fix. However
>> with this patch my boot hangs spinning all 4 threads. Once reverted
>> things work again.
>>
>> My command line:
>>
>>   timeout -k 1s --foreground 120s ./aarch64-softmmu/qemu-system-aarch64 -machine type=virt -display none -m 4096 -cpu cortex-a57 -serial mon:stdio -netdev user,id=unet -device virtio-net-device,netdev=unet -drive file=/home/alex/lsrc/qemu/images/jessie-arm64.qcow2,id=myblock,index=0,if=none -device virtio-blk-device,drive=myblock -append "console=ttyAMA0 root=/dev/vda1 systemd.unit=benchmark.service" -kernel /home/alex/lsrc/qemu/images/aarch64-current-linux-kernel-only.img -smp 4 -machine gic-version=3 -machine virtualization=true -name debug-threads=on
>>
>> My tree with fix and revert:
>>
>>   https://github.com/stsquad/qemu/tree/debug/aarch64-hang
>>
>> I'm investigating now.
>
> Well this seems to be a case of hangs with -smp > 1 (which I guess was
> obvious seeing as the TCG threads seem to be spinning against each
> other).

So the minimum fix I've found to get things working again is:

void *HELPER(lookup_tb_ptr)(CPUArchState *env, target_ulong addr)
{
    CPUState *cpu = ENV_GET_CPU(env);
    TranslationBlock *tb;
    target_ulong cs_base, pc;
    uint32_t flags;

    tb = atomic_rcu_read(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)]);
    if (likely(tb)) {
        cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
        if (likely(tb->pc == addr && tb->cs_base == cs_base &&
                   tb->flags == flags)) {
            goto found;
        }
        tb = tb_htable_lookup(cpu, addr, cs_base, flags);
        if (likely(tb)) {
            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
            /* goto found; */
        }
    }
    return tcg_ctx.code_gen_epilogue;
 found:
    qemu_log_mask_and_addr(CPU_LOG_EXEC, addr,
                           "Chain %p [%d: " TARGET_FMT_lx "] %s\n",
                           tb->tc_ptr, cpu->cpu_index, addr,
                           lookup_symbol(addr));
    return tb->tc_ptr;
}

Which I find very odd. It would imply that tb_htable_lookup is giving us
a bad result, except I would find it very unlikely what ever funky value
we stored in the jmp cache would never get hit again.

/me is very confused.

--
Alex Bennée
