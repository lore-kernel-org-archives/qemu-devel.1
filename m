Received: from eggs.gnu.org ([2001:4830:134:3::10]:38014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIhj1-0001kn-Ow
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:38:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIhiy-0005qk-E1
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:38:43 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIhiy-0005px-9G
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:38:40 -0400
Received: by mail-qt0-x241.google.com with SMTP id s33so3783101qtg.3
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 13:38:40 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170605165233.4135-1-rth@twiddle.net>
	<20170605165233.4135-23-rth@twiddle.net> <87h8zrdh02.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <02d52209-3f94-7c06-3637-2ee84573d700@twiddle.net>
Date: Wed, 7 Jun 2017 13:38:35 -0700
MIME-Version: 1.0
In-Reply-To: <87h8zrdh02.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

On 06/07/2017 07:11 AM, Alex Bennée wrote:
> 
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
>    timeout -k 1s --foreground 120s ./aarch64-softmmu/qemu-system-aarch64 -machine type=virt -display none -m 4096 -cpu cortex-a57 -serial mon:stdio -netdev user,id=unet -device virtio-net-device,netdev=unet -drive file=/home/alex/lsrc/qemu/images/jessie-arm64.qcow2,id=myblock,index=0,if=none -device virtio-blk-device,drive=myblock -append "console=ttyAMA0 root=/dev/vda1 systemd.unit=benchmark.service" -kernel /home/alex/lsrc/qemu/images/aarch64-current-linux-kernel-only.img -smp 4 -machine gic-version=3 -machine virtualization=true -name debug-threads=on

If you ignore the timeout, does it complete eventually?

It may not be the same thing, but that pull left out the final patch for 
target/alpha that enabled goto_ptr.  But as I hadn't seen a similar problem 
with other guests, I was assuming that the problem was in hw/alpha/, or some 
other bit of the interrupt chain.


r~
