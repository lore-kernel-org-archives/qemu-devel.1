Received: from eggs.gnu.org ([2001:4830:134:3::10]:51226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1d0UmZ-0006gV-IJ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1d0UmT-0008MU-H2
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:11:07 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:35787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1d0UmT-0008MB-AE
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:11:01 -0400
Received: by mail-qk0-x232.google.com with SMTP id f133so132766346qke.2
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 08:11:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170418143217.GH21261@stefanha-x1.localdomain>
References: <CAJy91CZHb_aJncY1KSqTorZF3Gex=4_xd9=FmS5_QGzkXDNwGg@mail.gmail.com>
	<20170418143217.GH21261@stefanha-x1.localdomain>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Tue, 18 Apr 2017 17:10:59 +0200
Message-ID: <CAJy91Cb-3GzZV-vCX7eqo6bPFwGdp9Quk2Ht-PEiH_xNdcOr9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] guest host time synchronization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On 18 April 2017 at 16:32, Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Tue, Apr 11, 2017 at 09:01:40AM +0200, Jiahuan Zhang wrote:
> > I made a test to check the time difference of QEMU emulated ARM-based
> Linux
> > guest and the Windows host. The result is, the guest time is around 0.2
> > second faster than the host. I used the "-rtc base" option.
> >
> > So can I say that, the time precision of QEMU emulation is in seconds? Is
> > it possible to make it more precise? because I need to test the latency
> of
> > my guest/host communication with high time resolution, at least in
> > miliseconds.
> >
> > Please let me know if you have any method  for the communication
> > performance testing. Thank you very much.
>
> This can depend on the exact board (machine type) being emulated because
> the emulated clock and timer hardware may be different.
>
> Please share your QEMU command-line so we can see the exact ARM guest
> hardware configuration.
>
> Stefan
>
Hi. Sorry that I forgot to update the testing.

I found out an error in my application codes and fixed it.

Now the testing is that, guest app sends data and host app receives data. I
use gettimeofday() to get the time stamp before the sending function
in LInux guest app, and use GetSystemAsFileTime() to get the timestamp
after the receiving function in Windows Host.
Now the testing result is that, the time difference is around 279ms.

My QEMU command-line is

$ qemu/build/arm-softmmu/qemu-system-arm.exe -M vexpress-a9 -kernel
zImage_vexpress_4-10 -dtb vexpress-v2p-ca9.dtb -initrd rootfs.img.gz
-append "console=ttyAMA0 root=/dev/ram rdinit=linuxrc" -chardev
pipe,id=char1,path=mynamedpipe -serial telnet:localhost:5555,server,nowait
-serial stdio -serial stdio -serial stdio -serial chardev:char1 -monitor
telnet:localhost:4444,server,nowait -sd test.img -nographic -rtc
base=utc,clock=host,driftfix=slew
I want to get the latency of the pipe communication as precise as possible.
Currently, the mehod I am using gets the time difference which must
include some pre-emption that I don't know. So it's not reliable.

Do you know any method for QEMU to evaluate this kind of communciation
performance?
