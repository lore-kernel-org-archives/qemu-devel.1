Received: from eggs.gnu.org ([2001:4830:134:3::10]:32914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWTLr-0004H7-PC
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWTLm-0000n4-Qh
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:12:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fWTLm-0000ln-Jx
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:12:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C98A400138A
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 21:12:10 +0000 (UTC)
References: <20180622165159.19863-1-pbonzini@redhat.com>
	<5de1e7ce-a0ef-f4a8-45af-bfd7e7d68d30@redhat.com>
	<99e7e292-4fb4-7ce1-b69d-b69ee352abec@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d6ede496-6900-da3d-a1fb-678d29e48513@redhat.com>
Date: Fri, 22 Jun 2018 17:12:07 -0400
MIME-Version: 1.0
In-Reply-To: <99e7e292-4fb4-7ce1-b69d-b69ee352abec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] ahci: fix FIS I bit and PIO Setup FIS
 interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com



On 06/22/2018 05:06 PM, Paolo Bonzini wrote:
> On 22/06/2018 21:07, John Snow wrote:
>>> @@ -1251,6 +1249,7 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
>>>  
>>>      /* Copy the ACMD field (ATAPI packet, if any) from the AHCI command
>>>       * table to ide_state->io_buffer */
>>> +    s->dev[port].done_first_drq = false;
>>
>> If you don't mind I'm going to shift this down so that it's beneath the
>> ATAPI section, just before the ide_exec_cmd call alongside all of the
>> other reset/init calls.
> 
> It's okay if the tests pass. :)
> 

They do! Thanks for solving two of the mysteries I had for the AHCI
emulation.

>>> @@ -883,19 +879,24 @@ AHCICommand *ahci_command_create(uint8_t command_name)
>>>      return cmd;
>>>  }
>>>  
>>> -AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl)
>>> +AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl, bool dma)
>>>  {
>>>      AHCICommand *cmd = ahci_command_create(CMD_PACKET);
>>>      cmd->atapi_cmd = g_malloc0(16);
>>>      cmd->atapi_cmd[0] = scsi_cmd;
>>>      stw_le_p(&cmd->fis.lba_lo[1], bcl);
>>> +    if (dma) {
>>> +        ahci_command_enable_atapi_dma(cmd);
>>> +    } else {
>>> +        cmd->interrupts |= bcl ? AHCI_PX_IS_PSS : 0;
>>> +    }
>>
>> Why are we gating on the DRQ byte count limit?
>>
>> (Oh, I guess it CAN'T be zero if we expect to transfer any data, so this
>> assumption is good to test if we expect to see even a single DRQ block.)
> 
> This is ATAPI, so "having a PIO Setup FIS with I=1" is the same as
> "having >1 PIO Setup FIS's" (data direction doesn't matter) and in turn
> that is the same as "having some bytes to transfer while DMA is off".
> 

Right, but "byte count limit" being the same as "having some bytes to
transfer" took me an extra minute. It's okay in the end because BCL is
not allowed to be zero if there is any data to transfer.

> Thanks,
> 
> Paolo
> 
