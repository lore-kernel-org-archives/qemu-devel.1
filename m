Received: from eggs.gnu.org ([2001:4830:134:3::10]:49024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSOSR-0003H0-R7
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSOSP-0003Zf-TN
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:42:27 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1gSOSP-0003Z7-Ji
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:42:25 -0500
Received: by mail-pg1-x543.google.com with SMTP id d72so1092692pga.9
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 07:42:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 29 Nov 2018 07:42:20 -0800
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <20181129154220.GA2891@roeck-us.net>
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
	<3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
	<734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 2/2] scsi: esp: Improve consistency of
 RSTAT, RSEQ, and RINTR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On Thu, Nov 29, 2018 at 11:56:39AM +0000, Mark Cave-Ayland wrote:
> On 29/11/2018 09:58, Paolo Bonzini wrote:
> 
> > On 28/11/18 22:56, Guenter Roeck wrote:
> >> The guest OS reads RSTAT, RSEQ, and RINTR, and expects those registers
> >> to reflect a consistent state. However, it is possible that the registers
> >> can change after RSTAT was read, but before RINTR is read.
> >>
> >> Guest OS		qemu
> >> --------		----
> >> Read RSTAT
> >> 			esp_command_complete()
> >> 			 RSTAT = STAT_ST
> >> 			 esp_dma_done()
> >> 			  RSTAT |= STAT_TC
> >> 			  RSEQ = 0
> >> 			  RINTR = INTR_BS
> >>
> >> Read RSEQ
> >> Read RINTR		RINTR = 0
> >> 			RSTAT &= ~STAT_TC
> >> 			RSEQ = SEQ_CD
> >>
> >> The guest OS would then try to handle INTR_BS combined with an old
> >> value of RSTAT. This sometimes resulted in lost events, spurious
> >> interrupts, guest OS confusion, and stalled SCSI operations.
> > 
> > The question is, why was the guest running the interrupt routine before
> > STAT_INT was set in RSTAT?  The code in esp_raise_irq seems good:
> > 
> >     if (!(s->rregs[ESP_RSTAT] & STAT_INT)) {
> >         s->rregs[ESP_RSTAT] |= STAT_INT;
> >         qemu_irq_raise(s->irq);
> >         trace_esp_raise_irq();
> >     }
> > 
> > Paolo
> 
> This patch is very interesting, as I have a long-running regression trying to boot
> NextSTEP 3.3 on qemu-system-sparc which I eventually bisected down to the commit that
> turned on iothread by default in QEMU.
> 
Makes me wonder: Is there a means to hold up processing esp_command_complete()
until a pending interrupt has been handled ? That might be a cleaner solution.
I could try to implement that in the driver, but maybe there is a means to do
that using the infrastructure.

Thanks,
Guenter

> The symptom is that ESP SCSI requests hang/timeout before the kernel is able to get
> to the userspace installer: however if you launch QEMU with "taskset –cpu-list 1
> qemu-system-sparc ..." then it works and you can complete the installation.
> 
> So certainly this suggests that there is a race condition still present in ESP
> somewhere. I've given this patch a spin, and in a few quick tests here I was able to
> consistently get further in kernel boot, but it still doesn't completely solve issue
> for me :/
> 
> 
> ATB,
> 
> Mark.
