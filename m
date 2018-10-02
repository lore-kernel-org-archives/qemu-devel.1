Received: from eggs.gnu.org ([2001:4830:134:3::10]:42478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7O08-0006nq-QJ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7O06-0003Hw-7E
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:58:24 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:40118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7O04-0003F4-Hv
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:58:22 -0400
Received: by mail-ot1-x32f.google.com with SMTP id w67so2599211ota.7
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 09:58:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <45814fee-9189-5934-e251-ca8c76f1709c@redhat.com>
References: <CAFEAcA-T7-PcKLwPr0VO0wrwW3x+w2WbdEjTjN2YfWOmZXyfUg@mail.gmail.com>
	<87lg7hlend.fsf@linaro.org>
	<CAFEAcA8ZW_rDyUg0G+agmBfNc8dNVc7r1pdu-Tyb6cvLXdvzHw@mail.gmail.com>
	<021f3f1e-e767-8d84-0189-fbfa7ca5f143@redhat.com>
	<CAFEAcA-M_x8oC_1Z5A9Lv3DQ1Z+_vVdyUnaHoBMv4nkJepcBhA@mail.gmail.com>
	<59e637ee-2a5a-6256-461a-7c8037e81558@redhat.com>
	<CAFEAcA_sqtGy0=M8Q9X5uhEc6MGO6NTvZGYviW=gT-MBC39coQ@mail.gmail.com>
	<45814fee-9189-5934-e251-ca8c76f1709c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 17:57:58 +0100
Message-ID: <CAFEAcA9++0mjmYQKZi4q02JfFjiQ7Hv2qMtDnvp5iWf41kn=Yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] racing between pause_all_vcpus() and
 qemu_cpu_stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>

On 2 October 2018 at 17:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 02/10/2018 12:34, Peter Maydell wrote:
>> Maybe I just don't understand what you're suggesting should be
>> done via run-on-cpu. But it seems to me that the problem here
>> is that cpu_stop_current() should not call qemu_cpu_stop()
>> immediately, but instead arrange that this vCPU calls qemu_cpu_stop()
>> when it gets back out of the execution loop.
>
> It will already do it in qemu_wait_io_event_common.  So perhaps it's
> enough to do cpu_exit(cpu) in pause_all_vcpus() and cpu_stop_current(),
> instead of cpu_stop_current() which incorrectly sets cpu->stopped to true?

Sounds plausible in the cpu_stop_current() case, but for
pause_all_vcpus(), we need to (continue to) do something that makes
the current CPU immediately set cpu->stopped to true, because the
second part of the function is going to wait until all cpus
(including this one) have cpu->stopped set. (That is, if the vcpu
thread calls pause_all_vcpus() then we can't say "wait for this
thread to get back out to the main loop": that's a deadlock. We
could leave pause_all_vcpus() as it is, or if we cared we'd
need to rewrite all the places that call pause_all_vcpus() from
the vcpu thread to do something else instead. That's basically
kvmvapic.c -- which could probably be rewritten to do something
else than its current pause_all_vcpus/do stuff/resume_all_vcpus
sequence -- plus vm_stop(), which has a related FIXME comment
in it already.)

thanks
-- PMM
