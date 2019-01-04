Received: from eggs.gnu.org ([208.118.235.92]:35260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfRXA-0001ag-EU
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:37:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfRX7-0000iG-Eu
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:37:14 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfRX6-0000aV-Ey
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 10:37:12 -0500
Received: by mail-oi1-x241.google.com with SMTP id j21so30636591oii.8
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 07:37:11 -0800 (PST)
MIME-Version: 1.0
References: <20181207155911.12710-1-peter.maydell@linaro.org>
In-Reply-To: <20181207155911.12710-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 15:36:59 +0000
Message-ID: <CAFEAcA9mUWKVuQ-Oi9uNoc4dtMrh6ORy3A9_Ee-0iM-=Yr7X+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] cpus.c: Fix race condition in
 cpu_stop_current()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jaap Crezee <jaap@jcz.nl>, "patches@linaro.org" <patches@linaro.org>

On Fri, 7 Dec 2018 at 16:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> We use cpu_stop_current() to ensure the current CPU has stopped
> from places like qemu_system_reset_request(). Unfortunately its
> current implementation has a race. It calls qemu_cpu_stop(),
> which sets cpu->stopped to true even though the CPU hasn't
> actually stopped yet. The main thread will look at the flags
> set by qemu_system_reset_request() and call pause_all_vcpus().
> pause_all_vcpus() waits for every cpu to have cpu->stopped true,
> so it can continue (and we will start the system reset operation)
> before the vcpu thread has got back to its top level loop.
>
> Instead, just set cpu->stop and call cpu_exit(). This will
> cause the vcpu to exit back to the top level loop, and there
> (as part of the wait_io_event code) it will call qemu_cpu_stop().
>
> This fixes bugs where the reset request appeared to be ignored
> or the CPU misbehaved because the reset operation started
> to change vcpu state while the vcpu thread was still using it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I'm going to put this in via target-arm.next, unless anybody
would like to suggest another route.

thanks
-- PMM
