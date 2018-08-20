Received: from eggs.gnu.org ([2001:4830:134:3::10]:50260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frjtP-0002B4-I2
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frjtO-0004VF-6a
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:06:47 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frjtL-0004Qr-Qj
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 09:06:45 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so25600096oie.13
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 06:06:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA++5wji8hmxezOz=ccBR_hxWXNc-CjAahBKDeMrXewyAsONmJg@mail.gmail.com>
References: <CA++5wji8hmxezOz=ccBR_hxWXNc-CjAahBKDeMrXewyAsONmJg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 14:06:21 +0100
Message-ID: <CAFEAcA_dzS=b4sd_=qr0ihd0ofWZLM4pF33gU4ygtJb-tHxbUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-discuss] Handling signal of Qemu thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Probir Roy <roy@probir.info>
Cc: qemu-discuss <qemu-discuss@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 16 August 2018 at 21:22, Probir Roy <roy@probir.info> wrote:
> I am registering a signal handler per Qemu thread (per VCPU) and
> expecting to handle it in that thread context. But I never receive the
> signal on the Qemu thread that is causing the event, rather the signal
> is sent to parent thread context. Can you please explain the reason
> behind this? I also see that Qemu has a function called
> "kvm_eat_signals". Does it have to do anything with my issue?

Signal handling is complicated, especially when the process
has multiple threads. QEMU's strategy for it is:

 * only the iothread deals with signal handling, except for
   one or two signals which are specifically directed to a
   particular CPU thread (notably SIG_IPI)
 * other threads block all signals, so that the iothread
   will handle them (this is done as part of qemu_thread_create())
 * the iothread handles most signals synchronously, using signalfd():
   this is done in qemu_signal_init(), and is how we handle
   SIGIO, SIGALRM and SIGBUS
 * SIGINT, SIGHUP, SIGTERM are handled by the iothread, asynchronously
   (their handlers are set in os_setup_signal_handling())
 * SIGPIPE is set to SIG_IGN, so we handle pipe-closed via the
   EPIPE errno rather than via a signal
 * SIG_IPI is one of the signals for specific CPU threads; so
   it is blocked in the iothread, and enabled in CPU threads
 * kvm_eat_signals() is specifically to handle SIG_IPI, and
   affects no other signal -- if the kernel returned control
   to QEMU because of a pending signal on this CPU thread,
   we must make sure we've processed all the SIG_IPIs before
   we continue

Adding support for a new usage of signals to this design is
complicated: depending on what is going on, it might be best
handled asynchronously in the iothread, synchronously in the
iothread, or per CPU thread. What exactly are you trying to do
with your new signal ?

thanks
-- PMM
