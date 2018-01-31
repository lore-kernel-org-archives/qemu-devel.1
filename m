Received: from eggs.gnu.org ([2001:4830:134:3::10]:34900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh0ur-000130-6O
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 17:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eh0uq-0004tu-9Q
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 17:31:41 -0500
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:47055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eh0uq-0004st-2B
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 17:31:40 -0500
Received: by mail-lf0-x233.google.com with SMTP id q194so23139505lfe.13
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 14:31:39 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <87tvv1ydjl.fsf@linaro.org>
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
	<87lghd3mq6.fsf@linaro.org>
	<CAKmqyKMgrU+4ABijd0SgomyZriVjVFMYt=TXs5b9--w_kenZ+Q@mail.gmail.com>
	<CAKmqyKMopCi5jaDstAX0Q3CzLdQ9wRgKWT2ggR_Or8Yh09zkrQ@mail.gmail.com>
	<0b0a9968-02bf-9273-e5fe-a69e04cf7f5e@redhat.com>
	<CAKmqyKMAy3qjjTFdtw4ksa=wJQYVzYZqvSopQ_cHbqwd0tr2cg@mail.gmail.com>
	<87tvv1ydjl.fsf@linaro.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 31 Jan 2018 14:31:08 -0800
Message-ID: <CAKmqyKM10j7yyyhJn8SAv7K3EkZbmL-ckiv5_qQrFqiHvJ2z8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 31, 2018 at 12:32 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>
> Alistair Francis <alistair.francis@xilinx.com> writes:
>
>> On Tue, Jan 30, 2018 at 8:26 PM, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
>>> On 30/01/2018 18:56, Alistair Francis wrote:
>>>>
>>>> I don't have a good solution though, as setting CPU_INTERRUPT_RESET
>>>> doesn't help (that isn't handled while we are halted) and
>>>> async_run_on_cpu()/run_on_cpu() doesn't reliably reset the CPU when we
>>>> want.
>>>>
>>>> I've ever tried pausing all CPUs before reseting the CPU and them
>>>> resuming them all but that doesn't seem to to work either.
>>>
>>> async_safe_run_on_cpu would be like async_run_on_cpu, except that it
>>> takes care of stopping all other CPUs while the function runs.
>>>
>>>> Is there
>>>> anything I'm missing? Is there no reliable way to reset a CPU?
>>>
>>> What do you mean by reliable?  Executing no instruction after the one
>>> you were at?
>>
>> The reset is called by a GPIO line, so I need the reset to be called
>> basically as quickly as the GPIO line changes. The async_ and
>> async_safe_ functions seem to not run quickly enough, even if I run a
>> process_work_queue() function afterwards.
>>
>> Is there a way to kick the CPU to act on the async_*?
>
> Define quickly enough? The async_(safe) functions kick the vCPUs so they
> will all exit the run loop as they enter the next TB (even if they loop
> to themselves).

We have a special power controller CPU that wakes all the CPUs up and
at boot the async_* functions don't wake the CPUs up. If I just use
the cpu_rest() function directly everything starts fine (but then I
hit issues later).

If I forcefully run process_queued_cpu_work() then I can get the CPUs
up, but I don't think that is the right solution.

>
> From an external vCPUs point of view those extra instructions have
> already executed. If the resetting vCPU needs them to have reset by the
> time it executes it's next instruction it should either cpu_loop_exit at
> that point or ensure it is the last instruction in it's TB (which is
> what we do for the MMU flush cases in ARM, they all end the TB at that
> point).

cpu_loop_exit() sounds like it would help, but as I'm not in the CPU
context it just seg faults.

Alistair

>
>
>>
>> Thanks,
>> Alistair
>>
>>>
>>> Paolo
>>>
>
>
> --
> Alex Benn=C3=A9e
>
