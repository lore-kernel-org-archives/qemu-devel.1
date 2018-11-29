Received: from eggs.gnu.org ([2001:4830:134:3::10]:54352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gSKzC-0006VG-2w
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 07:00:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gSKwF-0006kq-GG
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:57:02 -0500
Received: from chuckie.co.uk ([82.165.15.123]:38384
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gSKwF-0006Zo-8c
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 06:56:59 -0500
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
	<3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <734e8388-2f0f-1c5b-7767-29e43d261bcb@ilande.co.uk>
Date: Thu, 29 Nov 2018 11:56:39 +0000
MIME-Version: 1.0
In-Reply-To: <3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
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
To: Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 29/11/2018 09:58, Paolo Bonzini wrote:

> On 28/11/18 22:56, Guenter Roeck wrote:
>> The guest OS reads RSTAT, RSEQ, and RINTR, and expects those registers
>> to reflect a consistent state. However, it is possible that the registers
>> can change after RSTAT was read, but before RINTR is read.
>>
>> Guest OS		qemu
>> --------		----
>> Read RSTAT
>> 			esp_command_complete()
>> 			 RSTAT = STAT_ST
>> 			 esp_dma_done()
>> 			  RSTAT |= STAT_TC
>> 			  RSEQ = 0
>> 			  RINTR = INTR_BS
>>
>> Read RSEQ
>> Read RINTR		RINTR = 0
>> 			RSTAT &= ~STAT_TC
>> 			RSEQ = SEQ_CD
>>
>> The guest OS would then try to handle INTR_BS combined with an old
>> value of RSTAT. This sometimes resulted in lost events, spurious
>> interrupts, guest OS confusion, and stalled SCSI operations.
> 
> The question is, why was the guest running the interrupt routine before
> STAT_INT was set in RSTAT?  The code in esp_raise_irq seems good:
> 
>     if (!(s->rregs[ESP_RSTAT] & STAT_INT)) {
>         s->rregs[ESP_RSTAT] |= STAT_INT;
>         qemu_irq_raise(s->irq);
>         trace_esp_raise_irq();
>     }
> 
> Paolo

This patch is very interesting, as I have a long-running regression trying to boot
NextSTEP 3.3 on qemu-system-sparc which I eventually bisected down to the commit that
turned on iothread by default in QEMU.

The symptom is that ESP SCSI requests hang/timeout before the kernel is able to get
to the userspace installer: however if you launch QEMU with "taskset –cpu-list 1
qemu-system-sparc ..." then it works and you can complete the installation.

So certainly this suggests that there is a race condition still present in ESP
somewhere. I've given this patch a spin, and in a few quick tests here I was able to
consistently get further in kernel boot, but it still doesn't completely solve issue
for me :/


ATB,

Mark.
