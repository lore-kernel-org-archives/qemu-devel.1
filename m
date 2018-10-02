Received: from eggs.gnu.org ([2001:4830:134:3::10]:39134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7Nok-0000U4-In
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7Noh-0004eN-Ar
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:46:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36215)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7Noh-0004dh-0r
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 12:46:35 -0400
References: <CAFEAcA-T7-PcKLwPr0VO0wrwW3x+w2WbdEjTjN2YfWOmZXyfUg@mail.gmail.com>
	<87lg7hlend.fsf@linaro.org>
	<CAFEAcA8ZW_rDyUg0G+agmBfNc8dNVc7r1pdu-Tyb6cvLXdvzHw@mail.gmail.com>
	<021f3f1e-e767-8d84-0189-fbfa7ca5f143@redhat.com>
	<CAFEAcA-M_x8oC_1Z5A9Lv3DQ1Z+_vVdyUnaHoBMv4nkJepcBhA@mail.gmail.com>
	<59e637ee-2a5a-6256-461a-7c8037e81558@redhat.com>
	<CAFEAcA_sqtGy0=M8Q9X5uhEc6MGO6NTvZGYviW=gT-MBC39coQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <45814fee-9189-5934-e251-ca8c76f1709c@redhat.com>
Date: Tue, 2 Oct 2018 18:46:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_sqtGy0=M8Q9X5uhEc6MGO6NTvZGYviW=gT-MBC39coQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, "Emilio G. Cota" <cota@braap.org>

On 02/10/2018 12:34, Peter Maydell wrote:
> On 2 October 2018 at 10:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 02/10/2018 11:04, Peter Maydell wrote:
>>> On 2 October 2018 at 09:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>
>>>> First, the reset code should indeed use run_on_cpu (it need not be safe
>>>> i.e. stop-the-world; just run it in the vCPU thread).  It certainly
>>>> doesn't do this right now.
>>>
>>> I don't understand this part. We're resetting the entire world:
>>> surely we need to stop the entire world first ?
>>
>> Most of the world is stopped because it only runs with BQL taken.  vCPU
>> isn't, so we ensure it is stopped by: 1) using run_on_cpu to synchronize
>> with the executed TBs (or KVM_RUN) 2) ensuring the execution loop is
>> paused after reset, which is the cpu_can_run part that you snipped.
> 
> Maybe I just don't understand what you're suggesting should be
> done via run-on-cpu. But it seems to me that the problem here
> is that cpu_stop_current() should not call qemu_cpu_stop()
> immediately, but instead arrange that this vCPU calls qemu_cpu_stop()
> when it gets back out of the execution loop.

It will already do it in qemu_wait_io_event_common.  So perhaps it's
enough to do cpu_exit(cpu) in pause_all_vcpus() and cpu_stop_current(),
instead of cpu_stop_current() which incorrectly sets cpu->stopped to true?

Paolo
