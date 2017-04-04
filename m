Received: from eggs.gnu.org ([2001:4830:134:3::10]:57995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvOWF-0007Xz-7H
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cvOWB-00013K-9n
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:29:11 -0400
Received: from mail-lf0-x22a.google.com ([2a00:1450:4010:c07::22a]:33909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cvOWA-00012p-Uq
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:29:07 -0400
Received: by mail-lf0-x22a.google.com with SMTP id z15so93217972lfd.1
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 06:29:06 -0700 (PDT)
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-8-alex.bennee@linaro.org>
	<000201d2ad05$e28626d0$a7927470$@ru>
	<8760ikblf7.fsf@linaro.org> <874ly4bgbu.fsf@linaro.org>
	<3c4f3f42-3b33-8e0a-b3f4-0963670b47de@redhat.com>
	<8737dobbhm.fsf@linaro.org>
	<fe4ee48e-9a96-bcc4-54ec-86d53212d75b@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <fe4ee48e-9a96-bcc4-54ec-86d53212d75b@redhat.com>
Date: Tue, 04 Apr 2017 14:29:05 +0100
Message-ID: <871st8b8ta.fsf@linaro.org>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, rth@twiddle.net, peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, 'Peter Crosthwaite' <crosthwaite.peter@gmail.com>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/04/2017 14:31, Alex Bennée wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> On 04/04/2017 12:46, Alex Bennée wrote:
>>>>> In theory the main-loop should be sequenced before or after vCPU events
>>>>> because of the BQL. I'm not sure why this is not currently the case.
>>>>
>>>> It seems cpu_handle_exception doesn't take the BQL until
>>>> replay_exception() has done its thing. This is fixable but the function
>>>> is a mess so I'm trying to neaten that up first.
>>>
>>> Long term neither cpu_handle_exception nor cpu_handle_interrupt need the
>>> BQL at all.
>>
>> Well for record/replay they might. Otherwise we end up moving the record
>> stream on even though a checkpoint might be being written by the
>> main-loop.
>>
>> As far as the cc->do_interrupt() stuff is concerned it will be guest
>> dependant because you could end up in device emulation code down this
>> path which must be protected by the BQL - the arm_gic code being a good
>> example.
>
> I think recording an event could be split in two parts:
>
> - recording the (icount, event) tuple and getting back a unique event id
>
> - waiting for all events with lower event id to be complete before
> starting to process this one
>
> This doesn't require the BQL, you can use a condition variable on
> replay_lock (but you do need to unlock/lock the BQL around it if
> currently taken).

Would you then leave the recording to the stream to the main-loop
thread? I guess it would marshal all events that occurred before the
checkpoint first and then finish draining the queue after recording its
checkpoint?

Wrapping the exception stuff in the BQL does improve the repeat-ability
but of course it breaks if I take away the graceful handling of time
differences because there is a race between recording the exception
event (with current_step+insns so far) and getting back to the main loop
where insns is finally credited to timers_state.qemu_icount.

I guess we could improve the situation by updating
timers_state.qemu_icount (under BQL) as we record events. I don't know
how clunky that would get.

> The complicated part is ensuring that there are no deadlocks where the
> I/O thread needs the VCPU thread to proceed, but the VCPU thread is
> waiting on the I/O thread's event processing.

This sort of update sounds more like 2.10 material though.

--
Alex Bennée
