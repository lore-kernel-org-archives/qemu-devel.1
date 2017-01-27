Received: from eggs.gnu.org ([2001:4830:134:3::10]:53007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX4IS-0001Dv-1X
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX4IO-0001qf-33
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:02:24 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:35802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX4IN-0001qO-Th
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 06:02:20 -0500
Received: by mail-wj0-x242.google.com with SMTP id i7so5718141wjf.2
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 03:02:18 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
	<20170126123423.5412.2388.stgit@PASHA-ISP>
	<06b49612-9faf-5933-d8e9-8645a2fcde4d@redhat.com>
	<000e01d277d9$5d80dae0$188290a0$@ru>
	<d449fbf5-c878-7420-f064-eb819b296e1a@redhat.com>
	<001e01d277e1$0abe0d20$203a2760$@ru>
	<3634a513-bb63-dc21-3248-d8fc1e8f30e9@redhat.com>
	<000301d27863$de11f560$9a35e020$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb23765b-6ecd-daa1-9b6d-2dfb97246f1e@redhat.com>
Date: Fri, 27 Jan 2017 12:02:10 +0100
MIME-Version: 1.0
In-Reply-To: <000301d27863$de11f560$9a35e020$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 2/9] icount: exit cpu loop on expire
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com



On 27/01/2017 07:09, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 26/01/2017 15:32, Pavel Dovgalyuk wrote:
>>>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>>>> On 26/01/2017 14:37, Pavel Dovgalyuk wrote:
>>>>>> Simpler:
>>>>>>
>>>>>> 	use_icount &&
>>>>>> 	((int32_t)cpu->icount_decr.u32 < 0 ||
>>>>>> 	 cpu->icount_decr.u16.low + cpu->icount_extra == 0)
>>>>> Right.
>>>>>
>>>>>> But I'm not sure that you need to test u32.  After all you're not
>>>>> Checking u32 is needed, because sometimes it is less than zero.
>>>>
>>>> If cpu->icount_decr.u32 is less than zero, the next translation block
>>>> would immediately exit with TB_EXIT_ICOUNT_EXPIRED, causing
>>>>
>>>>             cpu->exception_index = EXCP_INTERRUPT;
>>>>             *last_tb = NULL;	
>>>>             cpu_loop_exit(cpu);
>>>>
>>>> from cpu_loop_exec_tb's "case TB_EXIT_ICOUNT_EXPIRED".
>>>>
>>>> And the same is true for cpu->icount_decr.u16.low + cpu->icount_extra ==
>>>> 0, so I don't understand why this part of the patch is necessary.
>>>
>>> I removed that lines because we have to check icount=0 not only when it is expired,
>>> but also when all instructions were executed successfully.
>>> If there are no instructions to execute, calling tb_find (and translation then)
>>> may cause an exception at the wrong moment.
>>
>> Ok, that makes sense for cpu->icount_decr.u16.low + cpu->icount_extra == 0.
>>
>> But for decr.u32 < 0, the same reasoning of this comment is also true:
>>
>>         /* Something asked us to stop executing
>>          * chained TBs; just continue round the main
>>          * loop. Whatever requested the exit will also
>>          * have set something else (eg exit_request or
>>          * interrupt_request) which we will handle
>>          * next time around the loop.  But we need to
>>          * ensure the tcg_exit_req read in generated code
>>          * comes before the next read of cpu->exit_request
>>          * or cpu->interrupt_request.
>>          */
> 
> Right. If the following lines will not be removed (as opposite to my patch) then checking
> decr.u32 < 0 will not be needed.

That's what I'm not sure about.  u32 < 0 is only true if you have set
the interrupt_request as well, but interrupt requests are processed in
cpu_handle_interrupt and that doesn't require going back to the main loop.

Let me try some cleanups early next week and come back to you with a
patch to base your work on.

Paolo

> -             cpu->exception_index = EXCP_INTERRUPT;
> -             *last_tb = NULL;	
> -             cpu_loop_exit(cpu);
> 
> What is your point about the new version of that patch?
> 
> Pavel Dovgalyuk
> 
> 
> 
