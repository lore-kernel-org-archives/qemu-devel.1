Received: from eggs.gnu.org ([2001:4830:134:3::10]:53192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eBhy0-0008Dh-O9
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eBhxr-0004vy-3w
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:01:32 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:48768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eBhxq-0004uP-TI
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:01:23 -0500
Received: by mail-wr0-x241.google.com with SMTP id 15so8688921wrb.5
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 06:01:22 -0800 (PST)
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112644.10516.1734.stgit@pasha-VirtualBox>
	<a8979594-78e4-13dc-2958-f7b4444a1bb0@redhat.com>
	<001501d353cd$29099010$7b1cb030$@ru>
	<18ddcf7c-0198-a0ce-c2cc-992131512897@redhat.com>
	<fbda6d5e-aee1-ec74-faf4-e2dde0003588@redhat.com>
	<001201d3547d$929156c0$b7b40440$@ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <001201d3547d$929156c0$b7b40440$@ru>
Date: Mon, 06 Nov 2017 14:01:20 +0000
Message-ID: <874lq7sdzj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 19/26] cpu-exec: reset exit flag before
 calling cpu_exec_nocache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, boost.lists@gmail.com


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 02/11/2017 12:33, Paolo Bonzini wrote:
>> > On 02/11/2017 12:24, Pavel Dovgalyuk wrote:
>> >>> I am not sure about this.  I think if instead you should return false
>> >>> from here and EXCP_INTERRUPT from cpu_exec.
>> >> The problem is inside the TB. It checks cpu->icount_decr.u16.high whi=
ch is -1.
>> >> And we have to enter the TB to cause an exception (because it exists =
in replay log).
>> >> That is why we reset this flag and try to execute the TB.
>> >
>> > But if u16.high is -1, shouldn't you return EXCP_INTERRUPT first (via
>> > "Finally, check if we need to exit to the main loop" in
>> > cpu_handle_interrupt)?  Then only cause the exception when that one is
>> > processed.
>>
>> ... indeed, you probably need something like:
>>
>>     /* Clear the interrupt flag now since we're processing
>>      * cpu->interrupt_request and cpu->exit_request.
>>      */
>>     insns_left =3D atomic_read(&cpu->icount_decr.u32);
>>     atomic_set(&cpu->icount_decr.u16.high, 0);
>>     if (unlikely(insns_left < 0) {
>>         /* Ensure the zeroing of icount_decr comes before the next read
>>          * of cpu->exit_request or cpu->interrupt_request.
>>          */
>>         smb_mb();
>>     }
>>
>> at the top of cpu_handle_interrupt.  Then you can remove the same
>> atomic_set+smp_mb in cpu_loop_exec_tb, like
>>
>>     *last_tb =3D NULL;
>>     insns_left =3D atomic_read(&cpu->icount_decr.u32);
>>     if (insns_left < 0) {
>>         /* Something asked us to stop executing chained TBs; just
>>          * continue round the main loop. Whatever requested the exit
>>          * will also have set something else (eg exit_request or
>>          * interrupt_request) which will be handled by
>>          * cpu_handle_interrupt.  cpu_handle_interrupt will also
>>          * clear cpu->icount_decr.u16.high.
>>          */
>>         return;
>>     }
>
> I tried this approach and it didn't work.
> I think iothread sets u16.high flag after resetting it in cpu_handle_inte=
rrupt.
>
> But there is another possible approach: set new tcg flag, which disables =
checking
> the exit_request at the entry to the TB.

I'm instinctively wary of adding additional flags as it complicates the
number of exit states - especially as we went to the trouble of merging
it all into one (wide) flag.

Where in the TB is this exception we need to execute? It can't be more
than one instruction can it - otherwise the icount would be higher. Is
this an off-by-one issue?

Would another approach be to say:

  - icount is 0
  - we have a pending exception not yet generated

therefor

  - translate a new, non-cached, non-icount/exit checking, single
    instruction block for the exception

and then assert if an exception wasn't raised?

>
>
> Pavel Dovgalyuk


--
Alex Benn=C3=A9e
