Received: from eggs.gnu.org ([2001:4830:134:3::10]:42478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzQD4-0006dm-0I
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzQD3-000752-0D
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:38:18 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:51698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dzQD2-00072v-P5
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 12:38:16 -0400
Received: by mail-wr0-x22e.google.com with SMTP id j14so6842664wre.8
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 09:38:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3d82d0c3-b109-3996-be93-d2e6b5ec5031@bitwagon.com>
References: <4d10cdd2-233c-46ac-926b-d4254b017c78@bitwagon.com>
	<CAFEAcA82LzXcT6BoAoAuD3XtmO6+hehwWd=Jno1DXZd5qEuYcw@mail.gmail.com>
	<CAFEAcA85ZRSgbpSQSFXO+u_jyZrv_4XHcpviP1W1TzYnGcYpUQ@mail.gmail.com>
	<cf804325-c982-c07d-b88c-5d069252f76f@bitwagon.com>
	<CAFEAcA8XU004=Tiv2mTgxVFoToZYL_UshmJjbeJ9v2dP7V0rMw@mail.gmail.com>
	<ef3336f8-6eee-c775-3f1e-472e2cae735d@suse.de>
	<3d82d0c3-b109-3996-be93-d2e6b5ec5031@bitwagon.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Oct 2017 17:37:55 +0100
Message-ID: <CAFEAcA-mQCzO38a7r-bQKDabrL-fcHQOnVShH35WDXBE7HiKBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu-arm SIGSEGV for self-modifying code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Reiser <jreiser@bitwagon.com>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 20 September 2017 at 23:13, John Reiser <jreiser@bitwagon.com> wrote:
> Now that I know the nature of the conflict, then I will spend a
> handful of instructions to avoid [0xf7000000, +), and also the
> stack if it gets placed immediately below that.

Cool. I figured out why -R 0xffff0000 didn't work and have sent
a patch for that; rth has some patches he's going to respin and
resend which will make -R 0xffff0000 the default and should help
in the sense of avoiding the guest SIGSEGV.

With your test binary and those fixes I now get it exiting early
with "PROT_EXEC|PROT_WRITE failed", which seems to be because it
does
 mmap2(0xffff0000,228092,PROT_EXEC|PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED,-1,0)
= -1 errno=22

which is trying to mmap off the end of the valid address space
(as well as over the kernel commpage). I'm not sure how it's
calculating the address to mmap, because it's different this
time around.

thanks
-- PMM
