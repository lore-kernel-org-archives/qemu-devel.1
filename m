Received: from eggs.gnu.org ([2001:4830:134:3::10]:39044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUWLz-0003O4-5k
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUWLv-0005vp-OO
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:55:46 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUWLv-0005vc-Gw
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 06:55:43 -0400
Received: by mail-wr0-f177.google.com with SMTP id c11so133372458wrc.3
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 03:55:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <B1DA44315104F94D9F3F23C74275EA9D729B61@Ikerlan-12.ikerlan.es>
References: <B1DA44315104F94D9F3F23C74275EA9D729B34@Ikerlan-12.ikerlan.es>
	<CAFEAcA853fSo86JXF0E=yt+Dfu8gVjcdpycx+z5OMX7z_mPKXg@mail.gmail.com>
	<B1DA44315104F94D9F3F23C74275EA9D729B4B@Ikerlan-12.ikerlan.es>
	<CAFEAcA_CF7KVq2MAhR3twsXfio3RNFRJ-SiK2pO7g1ZEzGvpGg@mail.gmail.com>
	<B1DA44315104F94D9F3F23C74275EA9D729B61@Ikerlan-12.ikerlan.es>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2017 11:54:21 +0100
Message-ID: <CAFEAcA9bt_wwd4LzCppcqeUJs229cOM4G+mnTBkfw05zBN31CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Code source modifying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ormaetxea Xabier <xormaetxea@ikerlan.es>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 10 July 2017 at 11:16, Ormaetxea Xabier <xormaetxea@ikerlan.es> wrote:
> Ah sorry, I thought that replying to your message it was somehow
> redirected to the mailing list. So, every-time I respond, I have
> to do it to qemu-devel@nongnu.org? Or a CC it's enough? Sorry for
> my ignorance...

Yes, you just have to send mail to: or cc: the qemu-devel
address.

> Anyway, do you imagine how can I make this "virtual world"-"real world"
> connection? I mean, is there an easy way of connecting an execution
> from the standalone with the source code?

Two things:

(1) you should try to make your interface with the emulator
map more closely to what existing examples do. "Write to
a virtual address in RAM that is monitored" is really weird and
will be a pain to implement.

What makes more sense depends a bit on whether you're using
qemu-system-* (a full-system emulator of cpu and devices) or
qemu-* (which just emulate a single Linux process by intercepting
system calls). For full-system, you can for instance provide
a device model that sits at a known physical address. Or you
can use the kind of interface that OSes might use to talk to
firmware (like an SMC instruction on ARM -- our PSCI
implementation works this way).

For linux-user the simplest thing is obviously just to
implement a syscall (or to use the existing timer ones!)

(2) you don't want to do this by "check something every
time round an execution loop" because this will make the
performance very bad. What you need to do is arrange that
when the guest does some action (write to physical address,
make SMC call, make system call) you get control and can
implement your behaviour there. (This is another reason
why write-to-virtual-address is a suboptimal choice: it's
harder to get control for that.)

thanks
-- PMM
