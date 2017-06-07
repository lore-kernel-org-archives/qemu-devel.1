Received: from eggs.gnu.org ([2001:4830:134:3::10]:45520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIbgP-0001oJ-E3
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dIbgL-0003vw-9P
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:11:37 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dIbgL-0003vD-1I
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 10:11:33 -0400
Received: by mail-wr0-x22d.google.com with SMTP id v104so6770601wrb.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 07:11:32 -0700 (PDT)
References: <20170605165233.4135-1-rth@twiddle.net>
	<20170605165233.4135-23-rth@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170605165233.4135-23-rth@twiddle.net>
Date: Wed, 07 Jun 2017 15:11:57 +0100
Message-ID: <87h8zrdh02.fsf@linaro.org>
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


Richard Henderson <rth@twiddle.net> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> Measurements:
>
> [Baseline performance is that before applying this and the previous
> commit]

Sadly this has regressed my qemu-system-aarch64 EL2 run. It was slightly
masked by an unrelated assertion breakage which I had to fix. However
with this patch my boot hangs spinning all 4 threads. Once reverted
things work again.

My command line:

  timeout -k 1s --foreground 120s ./aarch64-softmmu/qemu-system-aarch64 -machine type=virt -display none -m 4096 -cpu cortex-a57 -serial mon:stdio -netdev user,id=unet -device virtio-net-device,netdev=unet -drive file=/home/alex/lsrc/qemu/images/jessie-arm64.qcow2,id=myblock,index=0,if=none -device virtio-blk-device,drive=myblock -append "console=ttyAMA0 root=/dev/vda1 systemd.unit=benchmark.service" -kernel /home/alex/lsrc/qemu/images/aarch64-current-linux-kernel-only.img -smp 4 -machine gic-version=3 -machine virtualization=true -name debug-threads=on

My tree with fix and revert:

  https://github.com/stsquad/qemu/tree/debug/aarch64-hang

I'm investigating now.

--
Alex Bennée
