Received: from eggs.gnu.org ([2001:4830:134:3::10]:49146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWl6M-00086l-Kk
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWl6I-0001qw-Hb
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:32:38 -0500
Received: from mail.ispras.ru ([83.149.199.45]:55016)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWl6I-0001qW-Am
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:32:34 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170126123411.5412.44769.stgit@PASHA-ISP>
	<20170126123423.5412.2388.stgit@PASHA-ISP>
	<06b49612-9faf-5933-d8e9-8645a2fcde4d@redhat.com>
	<000e01d277d9$5d80dae0$188290a0$@ru>
	<d449fbf5-c878-7420-f064-eb819b296e1a@redhat.com>
In-Reply-To: <d449fbf5-c878-7420-f064-eb819b296e1a@redhat.com>
Date: Thu, 26 Jan 2017 17:32:37 +0300
Message-ID: <001e01d277e1$0abe0d20$203a2760$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
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
> On 26/01/2017 14:37, Pavel Dovgalyuk wrote:
> >> Simpler:
> >>
> >> 	use_icount &&
> >> 	((int32_t)cpu->icount_decr.u32 < 0 ||
> >> 	 cpu->icount_decr.u16.low + cpu->icount_extra == 0)
> > Right.
> >
> >> But I'm not sure that you need to test u32.  After all you're not
> > Checking u32 is needed, because sometimes it is less than zero.
> 
> If cpu->icount_decr.u32 is less than zero, the next translation block
> would immediately exit with TB_EXIT_ICOUNT_EXPIRED, causing
> 
>             cpu->exception_index = EXCP_INTERRUPT;
>             *last_tb = NULL;
>             cpu_loop_exit(cpu);
> 
> from cpu_loop_exec_tb's "case TB_EXIT_ICOUNT_EXPIRED".
> 
> And the same is true for cpu->icount_decr.u16.low + cpu->icount_extra ==
> 0, so I don't understand why this part of the patch is necessary.

I removed that lines because we have to check icount=0 not only when it is expired,
but also when all instructions were executed successfully. 
If there are no instructions to execute, calling tb_find (and translation then)
may cause an exception at the wrong moment.

Pavel Dovgalyuk
