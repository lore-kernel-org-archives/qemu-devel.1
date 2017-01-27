Received: from eggs.gnu.org ([2001:4830:134:3::10]:51601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWzig-00041O-Ly
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 01:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWzia-000607-7c
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 01:09:10 -0500
Received: from mail.ispras.ru ([83.149.199.45]:40942)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWziZ-0005zL-W3
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 01:09:04 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
	<20170126123423.5412.2388.stgit@PASHA-ISP>
	<06b49612-9faf-5933-d8e9-8645a2fcde4d@redhat.com>
	<000e01d277d9$5d80dae0$188290a0$@ru>
	<d449fbf5-c878-7420-f064-eb819b296e1a@redhat.com>
	<001e01d277e1$0abe0d20$203a2760$@ru>
	<3634a513-bb63-dc21-3248-d8fc1e8f30e9@redhat.com>
In-Reply-To: <3634a513-bb63-dc21-3248-d8fc1e8f30e9@redhat.com>
Date: Fri, 27 Jan 2017 09:09:06 +0300
Message-ID: <000301d27863$de11f560$9a35e020$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v8 2/9] icount: exit cpu loop on expire
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, kraxel@redhat.com

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 26/01/2017 15:32, Pavel Dovgalyuk wrote:
> >> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >> On 26/01/2017 14:37, Pavel Dovgalyuk wrote:
> >>>> Simpler:
> >>>>
> >>>> 	use_icount &&
> >>>> 	((int32_t)cpu->icount_decr.u32 < 0 ||
> >>>> 	 cpu->icount_decr.u16.low + cpu->icount_extra == 0)
> >>> Right.
> >>>
> >>>> But I'm not sure that you need to test u32.  After all you're not
> >>> Checking u32 is needed, because sometimes it is less than zero.
> >>
> >> If cpu->icount_decr.u32 is less than zero, the next translation block
> >> would immediately exit with TB_EXIT_ICOUNT_EXPIRED, causing
> >>
> >>             cpu->exception_index = EXCP_INTERRUPT;
> >>             *last_tb = NULL;	
> >>             cpu_loop_exit(cpu);
> >>
> >> from cpu_loop_exec_tb's "case TB_EXIT_ICOUNT_EXPIRED".
> >>
> >> And the same is true for cpu->icount_decr.u16.low + cpu->icount_extra ==
> >> 0, so I don't understand why this part of the patch is necessary.
> >
> > I removed that lines because we have to check icount=0 not only when it is expired,
> > but also when all instructions were executed successfully.
> > If there are no instructions to execute, calling tb_find (and translation then)
> > may cause an exception at the wrong moment.
> 
> Ok, that makes sense for cpu->icount_decr.u16.low + cpu->icount_extra == 0.
> 
> But for decr.u32 < 0, the same reasoning of this comment is also true:
> 
>         /* Something asked us to stop executing
>          * chained TBs; just continue round the main
>          * loop. Whatever requested the exit will also
>          * have set something else (eg exit_request or
>          * interrupt_request) which we will handle
>          * next time around the loop.  But we need to
>          * ensure the tcg_exit_req read in generated code
>          * comes before the next read of cpu->exit_request
>          * or cpu->interrupt_request.
>          */

Right. If the following lines will not be removed (as opposite to my patch) then checking
decr.u32 < 0 will not be needed.
-             cpu->exception_index = EXCP_INTERRUPT;
-             *last_tb = NULL;	
-             cpu_loop_exit(cpu);

What is your point about the new version of that patch?

Pavel Dovgalyuk
