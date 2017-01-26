Received: from eggs.gnu.org ([2001:4830:134:3::10]:52104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWlI7-0004w1-JC
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWlI2-0006K1-MR
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:44:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWlI2-0006Jq-Fh
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:44:42 -0500
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
	<20170126123423.5412.2388.stgit@PASHA-ISP>
	<06b49612-9faf-5933-d8e9-8645a2fcde4d@redhat.com>
	<000e01d277d9$5d80dae0$188290a0$@ru>
	<d449fbf5-c878-7420-f064-eb819b296e1a@redhat.com>
	<001e01d277e1$0abe0d20$203a2760$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3634a513-bb63-dc21-3248-d8fc1e8f30e9@redhat.com>
Date: Thu, 26 Jan 2017 15:44:37 +0100
MIME-Version: 1.0
In-Reply-To: <001e01d277e1$0abe0d20$203a2760$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, kraxel@redhat.com



On 26/01/2017 15:32, Pavel Dovgalyuk wrote:
>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
>> On 26/01/2017 14:37, Pavel Dovgalyuk wrote:
>>>> Simpler:
>>>>
>>>> 	use_icount &&
>>>> 	((int32_t)cpu->icount_decr.u32 < 0 ||
>>>> 	 cpu->icount_decr.u16.low + cpu->icount_extra == 0)
>>> Right.
>>>
>>>> But I'm not sure that you need to test u32.  After all you're not
>>> Checking u32 is needed, because sometimes it is less than zero.
>>
>> If cpu->icount_decr.u32 is less than zero, the next translation block
>> would immediately exit with TB_EXIT_ICOUNT_EXPIRED, causing
>>
>>             cpu->exception_index = EXCP_INTERRUPT;
>>             *last_tb = NULL;
>>             cpu_loop_exit(cpu);
>>
>> from cpu_loop_exec_tb's "case TB_EXIT_ICOUNT_EXPIRED".
>>
>> And the same is true for cpu->icount_decr.u16.low + cpu->icount_extra ==
>> 0, so I don't understand why this part of the patch is necessary.
> 
> I removed that lines because we have to check icount=0 not only when it is expired,
> but also when all instructions were executed successfully. 
> If there are no instructions to execute, calling tb_find (and translation then)
> may cause an exception at the wrong moment.

Ok, that makes sense for cpu->icount_decr.u16.low + cpu->icount_extra == 0.

But for decr.u32 < 0, the same reasoning of this comment is also true:

        /* Something asked us to stop executing
         * chained TBs; just continue round the main
         * loop. Whatever requested the exit will also
         * have set something else (eg exit_request or
         * interrupt_request) which we will handle
         * next time around the loop.  But we need to
         * ensure the tcg_exit_req read in generated code
         * comes before the next read of cpu->exit_request
         * or cpu->interrupt_request.
         */

(and by the way, this means that you need an smp_rmb in case
TB_EXIT_ICOUNT_EXPIRED).

Thanks,

Paolo
