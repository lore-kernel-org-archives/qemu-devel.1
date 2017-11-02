Received: from eggs.gnu.org ([2001:4830:134:3::10]:49347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADxK-0002EW-EK
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eADxH-0007Sm-Ac
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:46:42 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:51361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eADxH-0007QM-3Y
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 07:46:39 -0400
Received: by mail-wr0-f196.google.com with SMTP id j15so4718730wre.8
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 04:46:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112644.10516.1734.stgit@pasha-VirtualBox>
	<a8979594-78e4-13dc-2958-f7b4444a1bb0@redhat.com>
	<001501d353cd$29099010$7b1cb030$@ru>
	<18ddcf7c-0198-a0ce-c2cc-992131512897@redhat.com>
Message-ID: <fbda6d5e-aee1-ec74-faf4-e2dde0003588@redhat.com>
Date: Thu, 2 Nov 2017 12:46:35 +0100
MIME-Version: 1.0
In-Reply-To: <18ddcf7c-0198-a0ce-c2cc-992131512897@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org

On 02/11/2017 12:33, Paolo Bonzini wrote:
> On 02/11/2017 12:24, Pavel Dovgalyuk wrote:
>>> I am not sure about this.  I think if instead you should return false
>>> from here and EXCP_INTERRUPT from cpu_exec.
>> The problem is inside the TB. It checks cpu->icount_decr.u16.high which is -1.
>> And we have to enter the TB to cause an exception (because it exists in replay log).
>> That is why we reset this flag and try to execute the TB.
> 
> But if u16.high is -1, shouldn't you return EXCP_INTERRUPT first (via
> "Finally, check if we need to exit to the main loop" in
> cpu_handle_interrupt)?  Then only cause the exception when that one is
> processed.

... indeed, you probably need something like:

    /* Clear the interrupt flag now since we're processing
     * cpu->interrupt_request and cpu->exit_request.
     */
    insns_left = atomic_read(&cpu->icount_decr.u32);
    atomic_set(&cpu->icount_decr.u16.high, 0);
    if (unlikely(insns_left < 0) {
        /* Ensure the zeroing of icount_decr comes before the next read
         * of cpu->exit_request or cpu->interrupt_request.
         */
        smb_mb();
    }

at the top of cpu_handle_interrupt.  Then you can remove the same
atomic_set+smp_mb in cpu_loop_exec_tb, like

    *last_tb = NULL;
    insns_left = atomic_read(&cpu->icount_decr.u32);
    if (insns_left < 0) {
        /* Something asked us to stop executing chained TBs; just
         * continue round the main loop. Whatever requested the exit
         * will also have set something else (eg exit_request or
         * interrupt_request) which will be handled by
         * cpu_handle_interrupt.  cpu_handle_interrupt will also
         * clear cpu->icount_decr.u16.high.
         */
        return;
    }

Thanks,

Paolo
