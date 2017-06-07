Received: from eggs.gnu.org ([2001:4830:134:3::10]:48632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIbqu-0000Qr-QG
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIbqq-0000DB-W1
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:22:28 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:37745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dIbqq-0000D4-Nv
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:22:24 -0400
Received: by mail-wm0-x234.google.com with SMTP id d73so12373640wma.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 07:22:24 -0700 (PDT)
References: <20170605165233.4135-1-rth@twiddle.net>
	<20170605165233.4135-23-rth@twiddle.net>
	<87h8zrdh02.fsf@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87h8zrdh02.fsf@linaro.org>
Date: Wed, 07 Jun 2017 15:22:48 +0100
Message-ID: <87fufbdghz.fsf@linaro.org>
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

> Richard Henderson <rth@twiddle.net> writes:
>
>> From: "Emilio G. Cota" <cota@braap.org>
>>
>> Measurements:
>>
>> [Baseline performance is that before applying this and the previous
>> commit]
>
> Sadly this has regressed my qemu-system-aarch64 EL2 run. It was slightly
> masked by an unrelated assertion breakage which I had to fix. However
> with this patch my boot hangs spinning all 4 threads. Once reverted
> things work again.
>
> My command line:
>
>   timeout -k 1s --foreground 120s ./aarch64-softmmu/qemu-system-aarch64 -machine type=virt -display none -m 4096 -cpu cortex-a57 -serial mon:stdio -netdev user,id=unet -device virtio-net-device,netdev=unet -drive file=/home/alex/lsrc/qemu/images/jessie-arm64.qcow2,id=myblock,index=0,if=none -device virtio-blk-device,drive=myblock -append "console=ttyAMA0 root=/dev/vda1 systemd.unit=benchmark.service" -kernel /home/alex/lsrc/qemu/images/aarch64-current-linux-kernel-only.img -smp 4 -machine gic-version=3 -machine virtualization=true -name debug-threads=on
>
> My tree with fix and revert:
>
>   https://github.com/stsquad/qemu/tree/debug/aarch64-hang
>
> I'm investigating now.

Well this seems to be a case of hangs with -smp > 1 (which I guess was
obvious seeing as the TCG threads seem to be spinning against each
other).

--
Alex Bennée
