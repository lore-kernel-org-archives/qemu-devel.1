Received: from eggs.gnu.org ([2001:4830:134:3::10]:33796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIhSv-00041x-IL
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIhSr-0007qa-J0
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:22:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57087)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dIhSr-0007qM-Ed
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 16:22:01 -0400
Date: Wed, 7 Jun 2017 16:22:00 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170607202200.GA20593@flamenco>
References: <20170605165233.4135-1-rth@twiddle.net>
	<20170605165233.4135-23-rth@twiddle.net>
	<87h8zrdh02.fsf@linaro.org> <87fufbdghz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87fufbdghz.fsf@linaro.org>
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
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Jun 07, 2017 at 15:22:48 +0100, Alex Bennée wrote:
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
> > Richard Henderson <rth@twiddle.net> writes:
> >
> >> From: "Emilio G. Cota" <cota@braap.org>
> >>
> >> Measurements:
> >>
> >> [Baseline performance is that before applying this and the previous
> >> commit]
> >
> > Sadly this has regressed my qemu-system-aarch64 EL2 run. It was slightly
> > masked by an unrelated assertion breakage which I had to fix. However
> > with this patch my boot hangs spinning all 4 threads. Once reverted
> > things work again.
> >
> > My command line:
> >
> >   timeout -k 1s --foreground 120s ./aarch64-softmmu/qemu-system-aarch64 -machine type=virt -display none -m 4096 -cpu cortex-a57 -serial mon:stdio -netdev user,id=unet -device virtio-net-device,netdev=unet -drive file=/home/alex/lsrc/qemu/images/jessie-arm64.qcow2,id=myblock,index=0,if=none -device virtio-blk-device,drive=myblock -append "console=ttyAMA0 root=/dev/vda1 systemd.unit=benchmark.service" -kernel /home/alex/lsrc/qemu/images/aarch64-current-linux-kernel-only.img -smp 4 -machine gic-version=3 -machine virtualization=true -name debug-threads=on
> >
> > My tree with fix and revert:
> >
> >   https://github.com/stsquad/qemu/tree/debug/aarch64-hang
> >
> > I'm investigating now.
> 
> Well this seems to be a case of hangs with -smp > 1 (which I guess was
> obvious seeing as the TCG threads seem to be spinning against each
> other).

Not sure the problem is in MTTCG; I cannot reproduce with -smp > 1 and
thread=single; can you? [ I get no output whatsoever when trying to boot ]

Note that you'll need to revert bde4d9205ee to get thread=foo to
work again -- see [1].

Thanks,

		E.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01980.html
