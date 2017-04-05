Received: from eggs.gnu.org ([2001:4830:134:3::10]:48194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvixS-0000gN-TQ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvixP-0002mT-NU
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:18:38 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:33978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvixP-0002lj-Cc
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 07:18:35 -0400
Received: by mail-wr0-x229.google.com with SMTP id t20so9506441wra.1
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 04:18:35 -0700 (PDT)
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-8-alex.bennee@linaro.org>
	<000201d2ad05$e28626d0$a7927470$@ru>
	<8760ikblf7.fsf@linaro.org> <874ly4bgbu.fsf@linaro.org>
	<3c4f3f42-3b33-8e0a-b3f4-0963670b47de@redhat.com>
	<8737dobbhm.fsf@linaro.org>
	<fe4ee48e-9a96-bcc4-54ec-86d53212d75b@redhat.com>
	<871st8b8ta.fsf@linaro.org> <000f01d2adf9$938d0400$baa70c00$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <000f01d2adf9$938d0400$baa70c00$@ru>
Date: Wed, 05 Apr 2017 12:18:29 +0100
Message-ID: <87y3vf9k6y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 7/9] cpus: move icount preparation
 out of tcg_exec_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, rth@twiddle.net, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, 'Peter Crosthwaite' <crosthwaite.peter@gmail.com>


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Alex Bennée [mailto:alex.bennee@linaro.org]
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>> > On 04/04/2017 14:31, Alex Bennée wrote:
>> >>
>> >> Paolo Bonzini <pbonzini@redhat.com> writes:
>> >>
>> >>> On 04/04/2017 12:46, Alex Bennée wrote:
>> >>>>> In theory the main-loop should be sequenced before or after vCPU events
>> >>>>> because of the BQL. I'm not sure why this is not currently the case.
>> >>>>
>> >>>> It seems cpu_handle_exception doesn't take the BQL until
>> >>>> replay_exception() has done its thing. This is fixable but the function
>> >>>> is a mess so I'm trying to neaten that up first.
>> >>>
>> >>> Long term neither cpu_handle_exception nor cpu_handle_interrupt need the
>> >>> BQL at all.
>> >>
>> >> Well for record/replay they might. Otherwise we end up moving the record
>> >> stream on even though a checkpoint might be being written by the
>> >> main-loop.
>> >>
>> >> As far as the cc->do_interrupt() stuff is concerned it will be guest
>> >> dependant because you could end up in device emulation code down this
>> >> path which must be protected by the BQL - the arm_gic code being a good
>> >> example.
>> >
>> > I think recording an event could be split in two parts:
>> >
>> > - recording the (icount, event) tuple and getting back a unique event id
>> >
>> > - waiting for all events with lower event id to be complete before
>> > starting to process this one
>> >
>> > This doesn't require the BQL, you can use a condition variable on
>> > replay_lock (but you do need to unlock/lock the BQL around it if
>> > currently taken).
>>
>> Would you then leave the recording to the stream to the main-loop
>> thread? I guess it would marshal all events that occurred before the
>> checkpoint first and then finish draining the queue after recording its
>> checkpoint?
>>
>> Wrapping the exception stuff in the BQL does improve the repeat-ability
>> but of course it breaks if I take away the graceful handling of time
>> differences because there is a race between recording the exception
>> event (with current_step+insns so far) and getting back to the main loop
>> where insns is finally credited to timers_state.qemu_icount.
>>
>> I guess we could improve the situation by updating
>> timers_state.qemu_icount (under BQL) as we record events. I don't know
>> how clunky that would get.
>
> Does io instructions make some lock to prevent races in virtual
> hardware?

Yes the BQL is taken for MMIO operations unless the hardware explicitly
does its own locking. Other operations that trigger hardware emulation
(for example changing ARM_CP_IO registers) should also take the BQL.

> vCPU thread updates icount in the beginning of the TB execution.
> It means that checkpoints in the replay log will appear only at the boundaries
> of TBs.

Not quite. The vCPU thread takes into account "in flight" instructions
when calculating the icount. In the next series I'm about to post I've
ensured this reflects an update to the main-loop icount when we read the
value.

> However, the same log may be generated by different scenarios.
> Consider the following cases:
>
> 1. Sequence: vCPU-block-begin vCPU-update-icount iothread-io vCPU-io vCPU-block-end
> 2. Sequence: vCPU-block-begin vCPU-update-icount vCPU-io iothread-io vCPU-block-end
>
> These sequences will generate the same order of replay events, but different
> states of virtual hardware.
>
> Therefore we need some lock for the time while vCPU executes translation block
> (or the whole sequence of blocks as in old times).

Well this can't be the BQL anymore. Using it for serialisation of
multiple threads conflicts with the general aim of reducing BQL
contention across the code-base.

Perhaps we should just push replay_lock up the call-stack to
prepare/process_icount_data take and release the lock and we do the same
in the checkpoint code?

>
>> > The complicated part is ensuring that there are no deadlocks where the
>> > I/O thread needs the VCPU thread to proceed, but the VCPU thread is
>> > waiting on the I/O thread's event processing.
>>
>> This sort of update sounds more like 2.10 material though.
>
> Pavel Dovgalyuk


--
Alex Bennée
