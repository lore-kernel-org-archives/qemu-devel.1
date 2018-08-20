Received: from eggs.gnu.org ([2001:4830:134:3::10]:37556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roy@probir.info>) id 1frlm6-0005XZ-8n
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roy@probir.info>) id 1frlm2-00055N-Si
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:07:22 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roy@probir.info>) id 1frlm2-000545-Ic
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:07:18 -0400
Received: by mail-oi0-x244.google.com with SMTP id v8-v6so26370623oie.5
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 08:07:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_dzS=b4sd_=qr0ihd0ofWZLM4pF33gU4ygtJb-tHxbUg@mail.gmail.com>
References: <CA++5wji8hmxezOz=ccBR_hxWXNc-CjAahBKDeMrXewyAsONmJg@mail.gmail.com>
	<CAFEAcA_dzS=b4sd_=qr0ihd0ofWZLM4pF33gU4ygtJb-tHxbUg@mail.gmail.com>
From: Probir Roy <roy@probir.info>
Date: Mon, 20 Aug 2018 10:07:16 -0500
Message-ID: <CA++5wjhY3Dh8vSoT98DCDY2PT0Hc3rg8Q4U5QTnT3q-cnDaxzg@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-discuss <qemu-discuss@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

> What exactly are you trying to do
> with your new signal ?

I am implementing PEBS (Intel's Precise-Event Based Sampling)
virtualization, so that I can sample guest OS from host machine using
Linux Perf. The PEBS device is configured from host's user space as
perf event. I am registering a perf-event using "perf_event_open" in
kvm_cpu_exec:

+++ accel/kvm/kvm-all.c    2018-08-07 11:01:05.326280431 -0500
   @@ -1903,6 +1904,12 @@
     qemu_mutex_unlock_iothread();
     cpu_exec_start(cpu);

+    /* Probir: vcpu thread starting. Should call the tool thread handler*/
+    kvm__VCPU_start(); // calling perf_event_open


"kvm__VCPU_start" calling perf_event_open and a signal handler
"generic_dev_signal_handler" is set via sigaction:

// Set a signal handler for SIGUSR1
        struct sigaction sa;
        sa.sa_sigaction = generic_dev_signal_handler;
        sa.sa_mask = block_mask_dev;
        sa.sa_flags = SA_SIGINFO | SA_RESTART | SA_NODEFER | SA_ONSTACK;

I am expecting to perform some task in "generic_dev_signal_handler" at
PEBS event when the VCPU is halted. This task can be reading/writing
hardware registers at that event point. How can I achieve this in Qemu
environment?

Regards,
Probir
