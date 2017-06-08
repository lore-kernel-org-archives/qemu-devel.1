Received: from eggs.gnu.org ([2001:4830:134:3::10]:59798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIuz7-0003mf-3p
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIuz3-0002cw-Vr
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:48:13 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:33939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dIuz3-0002cc-No
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 06:48:09 -0400
Received: by mail-wm0-x22f.google.com with SMTP id d64so13477813wmf.1
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 03:48:07 -0700 (PDT)
References: <20170605165233.4135-1-rth@twiddle.net>
	<20170605165233.4135-23-rth@twiddle.net>
	<87h8zrdh02.fsf@linaro.org> <87fufbdghz.fsf@linaro.org>
	<20170607202200.GA20593@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170607202200.GA20593@flamenco>
Date: Thu, 08 Jun 2017 11:48:33 +0100
Message-ID: <871squdabi.fsf@linaro.org>
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
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, peter.maydell@linaro.org


Emilio G. Cota <cota@braap.org> writes:

> On Wed, Jun 07, 2017 at 15:22:48 +0100, Alex Bennée wrote:
>>
>> Alex Bennée <alex.bennee@linaro.org> writes:
>>
>> > Richard Henderson <rth@twiddle.net> writes:
>> >
>> >> From: "Emilio G. Cota" <cota@braap.org>
>> >>
>> >> Measurements:
>> >>
>> >> [Baseline performance is that before applying this and the previous
>> >> commit]
>> >
>> > Sadly this has regressed my qemu-system-aarch64 EL2 run. It was slightly
>> > masked by an unrelated assertion breakage which I had to fix. However
>> > with this patch my boot hangs spinning all 4 threads. Once reverted
>> > things work again.
>> >
>> > My command line:
>> >
>> >   timeout -k 1s --foreground 120s ./aarch64-softmmu/qemu-system-aarch64 -machine type=virt -display none -m 4096 -cpu cortex-a57 -serial mon:stdio -netdev user,id=unet -device virtio-net-device,netdev=unet -drive file=/home/alex/lsrc/qemu/images/jessie-arm64.qcow2,id=myblock,index=0,if=none -device virtio-blk-device,drive=myblock -append "console=ttyAMA0 root=/dev/vda1 systemd.unit=benchmark.service" -kernel /home/alex/lsrc/qemu/images/aarch64-current-linux-kernel-only.img -smp 4 -machine gic-version=3 -machine virtualization=true -name debug-threads=on
>> >
>> > My tree with fix and revert:
>> >
>> >   https://github.com/stsquad/qemu/tree/debug/aarch64-hang
>> >
>> > I'm investigating now.
>>
>> Well this seems to be a case of hangs with -smp > 1 (which I guess was
>> obvious seeing as the TCG threads seem to be spinning against each
>> other).

*sigh* OK I can replicate with thread=single so I guess that rules out
race conditions. So that leaves us with some TCG state that is
different when we chain compared to returning to the epilogue. It's odd
that it doesn't trigger for cache lookups though.

I tried this:

        tb = tb_htable_lookup(cpu, addr, cs_base, flags);
        if (likely(tb)) {
            atomic_set(&cpu->tb_jmp_cache[tb_jmp_cache_hash_func(addr)], tb);
            if (cpu->icount_decr.u32) {
                goto found;
            }
        }

So we only chain htable looksups when an IRQ is happening and it gets
further but still hangs. It doesn't rule out IRQ handling but I can't
image a mechanism that breaks it.

Time to re-review the code I guess!

>
> Not sure the problem is in MTTCG; I cannot reproduce with -smp > 1 and
> thread=single; can you? [ I get no output whatsoever when trying to boot ]
>
> Note that you'll need to revert bde4d9205ee to get thread=foo to
> work again -- see [1].
>
> Thanks,
>
> 		E.
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01980.html


--
Alex Bennée
