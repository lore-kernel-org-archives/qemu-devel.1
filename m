Received: from eggs.gnu.org ([2001:4830:134:3::10]:47279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frmDm-0001du-UV
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frmDm-0007qW-54
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:35:58 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frmDl-0007pz-TH
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:35:58 -0400
Received: by mail-oi0-x242.google.com with SMTP id j205-v6so26560484oib.4
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 08:35:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA++5wjhY3Dh8vSoT98DCDY2PT0Hc3rg8Q4U5QTnT3q-cnDaxzg@mail.gmail.com>
References: <CA++5wji8hmxezOz=ccBR_hxWXNc-CjAahBKDeMrXewyAsONmJg@mail.gmail.com>
	<CAFEAcA_dzS=b4sd_=qr0ihd0ofWZLM4pF33gU4ygtJb-tHxbUg@mail.gmail.com>
	<CA++5wjhY3Dh8vSoT98DCDY2PT0Hc3rg8Q4U5QTnT3q-cnDaxzg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 16:35:36 +0100
Message-ID: <CAFEAcA9CCz6cTy9Mfs=-9omhh9HRVqTw+1Jpfp2czTRVWTZRaQ@mail.gmail.com>
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

On 20 August 2018 at 16:07, Probir Roy <roy@probir.info> wrote:
>> What exactly are you trying to do
>> with your new signal ?
>
> I am implementing PEBS (Intel's Precise-Event Based Sampling)
> virtualization, so that I can sample guest OS from host machine using
> Linux Perf. The PEBS device is configured from host's user space as
> perf event. I am registering a perf-event using "perf_event_open" in
> kvm_cpu_exec:
>
> +++ accel/kvm/kvm-all.c    2018-08-07 11:01:05.326280431 -0500
>    @@ -1903,6 +1904,12 @@
>      qemu_mutex_unlock_iothread();
>      cpu_exec_start(cpu);
>
> +    /* Probir: vcpu thread starting. Should call the tool thread handler*/
> +    kvm__VCPU_start(); // calling perf_event_open
>
>
> "kvm__VCPU_start" calling perf_event_open and a signal handler
> "generic_dev_signal_handler" is set via sigaction:
>
> // Set a signal handler for SIGUSR1
>         struct sigaction sa;
>         sa.sa_sigaction = generic_dev_signal_handler;
>         sa.sa_mask = block_mask_dev;
>         sa.sa_flags = SA_SIGINFO | SA_RESTART | SA_NODEFER | SA_ONSTACK;

You cannot use SIGUSR1 for this. QEMU uses it internally as
its SIG_IPI (inter-vcpu-communication). You'll need to get
the perf code to use a different signal. (And you'll need to
manually unblock that signal on the CPU thread when you install
your handler.)

> I am expecting to perform some task in "generic_dev_signal_handler" at
> PEBS event when the VCPU is halted. This task can be reading/writing
> hardware registers at that event point.

Guest or host hardware registers? Either way, this is tricky
stuff to be trying to do in a signal handler.

thanks
-- PMM
