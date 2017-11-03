Received: from eggs.gnu.org ([2001:4830:134:3::10]:45392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eAXJz-00048A-Qe
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eAXJw-0001YM-Mh
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:27:23 -0400
Received: from mail.ispras.ru ([83.149.199.45]:35214)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eAXJw-0001Y5-EU
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:27:20 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112644.10516.1734.stgit@pasha-VirtualBox>
	<a8979594-78e4-13dc-2958-f7b4444a1bb0@redhat.com>
	<001501d353cd$29099010$7b1cb030$@ru>
	<18ddcf7c-0198-a0ce-c2cc-992131512897@redhat.com>
	<fbda6d5e-aee1-ec74-faf4-e2dde0003588@redhat.com>
In-Reply-To: <fbda6d5e-aee1-ec74-faf4-e2dde0003588@redhat.com>
Date: Fri, 3 Nov 2017 11:27:21 +0300
Message-ID: <001201d3547d$929156c0$b7b40440$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 02/11/2017 12:33, Paolo Bonzini wrote:
> > On 02/11/2017 12:24, Pavel Dovgalyuk wrote:
> >>> I am not sure about this.  I think if instead you should return false
> >>> from here and EXCP_INTERRUPT from cpu_exec.
> >> The problem is inside the TB. It checks cpu->icount_decr.u16.high which is -1.
> >> And we have to enter the TB to cause an exception (because it exists in replay log).
> >> That is why we reset this flag and try to execute the TB.
> >
> > But if u16.high is -1, shouldn't you return EXCP_INTERRUPT first (via
> > "Finally, check if we need to exit to the main loop" in
> > cpu_handle_interrupt)?  Then only cause the exception when that one is
> > processed.
> 
> ... indeed, you probably need something like:
> 
>     /* Clear the interrupt flag now since we're processing
>      * cpu->interrupt_request and cpu->exit_request.
>      */
>     insns_left = atomic_read(&cpu->icount_decr.u32);
>     atomic_set(&cpu->icount_decr.u16.high, 0);
>     if (unlikely(insns_left < 0) {
>         /* Ensure the zeroing of icount_decr comes before the next read
>          * of cpu->exit_request or cpu->interrupt_request.
>          */
>         smb_mb();
>     }
> 
> at the top of cpu_handle_interrupt.  Then you can remove the same
> atomic_set+smp_mb in cpu_loop_exec_tb, like
> 
>     *last_tb = NULL;
>     insns_left = atomic_read(&cpu->icount_decr.u32);
>     if (insns_left < 0) {
>         /* Something asked us to stop executing chained TBs; just
>          * continue round the main loop. Whatever requested the exit
>          * will also have set something else (eg exit_request or
>          * interrupt_request) which will be handled by
>          * cpu_handle_interrupt.  cpu_handle_interrupt will also
>          * clear cpu->icount_decr.u16.high.
>          */
>         return;
>     }

I tried this approach and it didn't work.
I think iothread sets u16.high flag after resetting it in cpu_handle_interrupt.

But there is another possible approach: set new tcg flag, which disables checking
the exit_request at the entry to the TB.


Pavel Dovgalyuk
