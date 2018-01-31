Received: from eggs.gnu.org ([2001:4830:134:3::10]:35522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1egz3u-00054p-Ea
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1egz3p-0006sg-OB
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:32:54 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:55925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1egz3p-0006s5-Fl
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 15:32:49 -0500
Received: by mail-wm0-x22b.google.com with SMTP id 143so1568832wma.5
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 12:32:49 -0800 (PST)
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
	<87lghd3mq6.fsf@linaro.org>
	<CAKmqyKMgrU+4ABijd0SgomyZriVjVFMYt=TXs5b9--w_kenZ+Q@mail.gmail.com>
	<CAKmqyKMopCi5jaDstAX0Q3CzLdQ9wRgKWT2ggR_Or8Yh09zkrQ@mail.gmail.com>
	<0b0a9968-02bf-9273-e5fe-a69e04cf7f5e@redhat.com>
	<CAKmqyKMAy3qjjTFdtw4ksa=wJQYVzYZqvSopQ_cHbqwd0tr2cg@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAKmqyKMAy3qjjTFdtw4ksa=wJQYVzYZqvSopQ_cHbqwd0tr2cg@mail.gmail.com>
Date: Wed, 31 Jan 2018 20:32:46 +0000
Message-ID: <87tvv1ydjl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>


Alistair Francis <alistair.francis@xilinx.com> writes:

> On Tue, Jan 30, 2018 at 8:26 PM, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
>> On 30/01/2018 18:56, Alistair Francis wrote:
>>>
>>> I don't have a good solution though, as setting CPU_INTERRUPT_RESET
>>> doesn't help (that isn't handled while we are halted) and
>>> async_run_on_cpu()/run_on_cpu() doesn't reliably reset the CPU when we
>>> want.
>>>
>>> I've ever tried pausing all CPUs before reseting the CPU and them
>>> resuming them all but that doesn't seem to to work either.
>>
>> async_safe_run_on_cpu would be like async_run_on_cpu, except that it
>> takes care of stopping all other CPUs while the function runs.
>>
>>> Is there
>>> anything I'm missing? Is there no reliable way to reset a CPU?
>>
>> What do you mean by reliable?  Executing no instruction after the one
>> you were at?
>
> The reset is called by a GPIO line, so I need the reset to be called
> basically as quickly as the GPIO line changes. The async_ and
> async_safe_ functions seem to not run quickly enough, even if I run a
> process_work_queue() function afterwards.
>
> Is there a way to kick the CPU to act on the async_*?

Define quickly enough? The async_(safe) functions kick the vCPUs so they
will all exit the run loop as they enter the next TB (even if they loop
to themselves).

>From an external vCPUs point of view those extra instructions have
already executed. If the resetting vCPU needs them to have reset by the
time it executes it's next instruction it should either cpu_loop_exit at
that point or ensure it is the last instruction in it's TB (which is
what we do for the MMU flush cases in ARM, they all end the TB at that
point).


>
> Thanks,
> Alistair
>
>>
>> Paolo
>>


--
Alex Benn=C3=A9e
