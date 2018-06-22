Received: from eggs.gnu.org ([2001:4830:134:3::10]:60256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fWTGK-000358-7E
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fWTGH-00048M-2P
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:06:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fWTGG-000472-QF
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 17:06:28 -0400
Received: by mail-wr0-f195.google.com with SMTP id w10-v6so7897103wrk.9
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 14:06:28 -0700 (PDT)
References: <20180622165159.19863-1-pbonzini@redhat.com>
	<5de1e7ce-a0ef-f4a8-45af-bfd7e7d68d30@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99e7e292-4fb4-7ce1-b69d-b69ee352abec@redhat.com>
Date: Fri, 22 Jun 2018 23:06:25 +0200
MIME-Version: 1.0
In-Reply-To: <5de1e7ce-a0ef-f4a8-45af-bfd7e7d68d30@redhat.com>
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
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 22/06/2018 21:07, John Snow wrote:
>> @@ -1251,6 +1249,7 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
>>  
>>      /* Copy the ACMD field (ATAPI packet, if any) from the AHCI command
>>       * table to ide_state->io_buffer */
>> +    s->dev[port].done_first_drq = false;
> 
> If you don't mind I'm going to shift this down so that it's beneath the
> ATAPI section, just before the ide_exec_cmd call alongside all of the
> other reset/init calls.

It's okay if the tests pass. :)

>> @@ -883,19 +879,24 @@ AHCICommand *ahci_command_create(uint8_t command_name)
>>      return cmd;
>>  }
>>  
>> -AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl)
>> +AHCICommand *ahci_atapi_command_create(uint8_t scsi_cmd, uint16_t bcl, bool dma)
>>  {
>>      AHCICommand *cmd = ahci_command_create(CMD_PACKET);
>>      cmd->atapi_cmd = g_malloc0(16);
>>      cmd->atapi_cmd[0] = scsi_cmd;
>>      stw_le_p(&cmd->fis.lba_lo[1], bcl);
>> +    if (dma) {
>> +        ahci_command_enable_atapi_dma(cmd);
>> +    } else {
>> +        cmd->interrupts |= bcl ? AHCI_PX_IS_PSS : 0;
>> +    }
> 
> Why are we gating on the DRQ byte count limit?
> 
> (Oh, I guess it CAN'T be zero if we expect to transfer any data, so this
> assumption is good to test if we expect to see even a single DRQ block.)

This is ATAPI, so "having a PIO Setup FIS with I=1" is the same as
"having >1 PIO Setup FIS's" (data direction doesn't matter) and in turn
that is the same as "having some bytes to transfer while DMA is off".

Thanks,

Paolo
