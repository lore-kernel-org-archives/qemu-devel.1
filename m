Received: from eggs.gnu.org ([2001:4830:134:3::10]:48227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSNBK-0004F8-JJ
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groeck7@gmail.com>) id 1gSN9P-0004tf-Uw
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:18:44 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1gSN9P-0004tD-Nj
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:18:43 -0500
Received: by mail-pg1-x544.google.com with SMTP id y4so982408pgc.12
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 06:18:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
References: <1543442171-24863-1-git-send-email-linux@roeck-us.net>
	<1543442171-24863-2-git-send-email-linux@roeck-us.net>
	<3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <889bd1c9-7de3-54c5-24a1-e0f35990c872@roeck-us.net>
Date: Thu, 29 Nov 2018 06:18:40 -0800
MIME-Version: 1.0
In-Reply-To: <3d1287e7-29c1-dbb1-c0f9-273b7b31645c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 11/29/18 1:58 AM, Paolo Bonzini wrote:
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

It doesn't. It polls for interrupts, but only enters the interrupt handler
if one was observed. It uses the DMA status (see first patch) for the polling,
presumably to not disturb RSTAT. Qemu produces two interrupts in a row,
the second while the first one is still handled.

Also, it works fine with a real controller (yes, I did buy one, and an
old SCSI drive, to test).

Guenter

>      if (!(s->rregs[ESP_RSTAT] & STAT_INT)) {
>          s->rregs[ESP_RSTAT] |= STAT_INT;
>          qemu_irq_raise(s->irq);
>          trace_esp_raise_irq();
>      }
> 
> Paolo
> 
>> A typical guest error log (observed with various versions of Linux)
>> looks as follows.
>>
>> scsi host1: Spurious irq, sreg=13.
>> ...
>> scsi host1: Aborting command [84531f10:2a]
>> scsi host1: Current command [f882eea8:35]
>> scsi host1: Queued command [84531f10:2a]
>> scsi host1:  Active command [f882eea8:35]
>> scsi host1: Dumping command log
>> scsi host1: ent[15] CMD val[44] sreg[90] seqreg[00] sreg2[00] ireg[20] ss[00] event[0c]
>> scsi host1: ent[16] CMD val[01] sreg[90] seqreg[00] sreg2[00] ireg[20] ss[02] event[0c]
>> scsi host1: ent[17] CMD val[43] sreg[90] seqreg[00] sreg2[00] ireg[20] ss[02] event[0c]
>> scsi host1: ent[18] EVENT val[0d] sreg[92] seqreg[04] sreg2[00] ireg[18] ss[00] event[0c]
>> ...
> 
> 
