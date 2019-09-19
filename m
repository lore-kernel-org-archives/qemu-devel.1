Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272B2C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAFF21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAFF21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4mq-0003CZ-3U
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tasleson@redhat.com>) id 1iB4JD-0003dq-EY
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tasleson@redhat.com>) id 1iB4JB-0002EG-Pp
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 17:49:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47282)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tasleson@redhat.com>)
 id 1iB4J8-0002B9-8q; Thu, 19 Sep 2019 17:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8846E308A9E2;
 Thu, 19 Sep 2019 21:49:45 +0000 (UTC)
Received: from [10.3.112.12] (ovpn-112-12.phx2.redhat.com [10.3.112.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B04160BF1;
 Thu, 19 Sep 2019 21:49:41 +0000 (UTC)
Subject: Re: [RFC 4/4] ahci media error reporting
To: John Snow <jsnow@redhat.com>
References: <20190919194847.18518-1-tasleson@redhat.com>
 <20190919194847.18518-5-tasleson@redhat.com>
 <df07a621-8515-2414-2f59-a7eb7eebd75b@redhat.com>
From: Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <afac6895-9a42-1eaa-3068-3e3dfdd1bd23@redhat.com>
Date: Thu, 19 Sep 2019 16:49:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <df07a621-8515-2414-2f59-a7eb7eebd75b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 19 Sep 2019 21:49:45 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: tasleson@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 3:43 PM, John Snow wrote:
> 
> 
> On 9/19/19 3:48 PM, Tony Asleson wrote:
>> Initial attempt at returning a media error for ahci.  This is certainly
>> wrong and needs serious improvement.
>>
> 
> Hi; I have the unfortunate distinction of being the AHCI maintainer.
> Please CC me on future revisions and discussion if you are interacting
> with my problem child.

Will do and thank you for taking a look at this!

> Also remember to CC qemu-block.
> 
>> Signed-off-by: Tony Asleson <tasleson@redhat.com>
>> ---
>>  hw/ide/ahci.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index d45393c019..f487764106 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -36,6 +36,7 @@
>>  #include "hw/ide/internal.h"
>>  #include "hw/ide/pci.h"
>>  #include "ahci_internal.h"
>> +#include "block/error_inject.h"
>>  
>>  #include "trace.h"
>>  
>> @@ -999,6 +1000,22 @@ static void ncq_err(NCQTransferState *ncq_tfs)
>>      ncq_tfs->used = 0;
>>  }
>>  
>> +/*
>> + * Figure out correct way to report media error, this is at best a guess
>> + * and based on the output of linux kernel, not even remotely close.
>> + */
> 
> Depends on what kind of error, exactly, you're trying to report, and at
> what level. (AHCI, NCQ, SATA, ATA?)

I was trying to return a media error, like a 3/1101 for SCSI device.  I
think that is at the ATA level?


> Keep in mind that you've inserted an error path for SATA drives using
> NCQ, but seemingly haven't touched SATA drives not using NCQ, or ATAPI
> devices using either PATA/SATA, or ATA drives on PATA.

Correct, but for trying out a simple read on a SATA drive for Linux I
end up here first :-)  Well, until the kernel retries a number of times
and finally gives up and returns an error while also disabling NCQ for
the device.


>> +static void ncq_media_err(NCQTransferState *ncq_tfs, uint64_t err_sector)
>> +{
>> +    IDEState *ide_state = &ncq_tfs->drive->port.ifs[0];
>> +
>> +    ide_state->error = ECC_ERR;
>> +    ide_state->status = READY_STAT | ERR_STAT;
>> +    ncq_tfs->drive->port_regs.scr_err |= (1 << ncq_tfs->tag);
>> +    ncq_tfs->lba = err_sector;
>> +    qemu_sglist_destroy(&ncq_tfs->sglist);
>> +    ncq_tfs->used = 0;
>> +}
>> +
> 
> If you are definitely very sure you only want an ide_state error
> difference, you could just as well call ncq_err and then patch
> ide_state->error.
> 
> (I am not sure that's what you want, but... maybe it is?)

As I mentioned above, return an unrecoverable media error.

SCSI sense data can report the first sector in error and I thought I
could do the same for SATA too?

> I'd have to check -- because I can't say the AHCI emulator was designed
> so much as congealed -- but you might need calls to ncq_finish.
> 
> usually, ncq_cb handles the return from any NCQ command and will call
> ncq_err and ncq_finish as appropriate to tidy up the command.
> 
> It might be a mistake that execute_ncq_command issues ncq_err in the
> `default` arm of the switch statement without a call to finish.
> 
> If we do call ncq_finish from this context I'm not sure if we want
> block_acct_done here unconditionally. We may not have started a block
> accounting operation if we never started a backend operation. Everything
> else looks about right to me.
> 
> 
>>  static void ncq_finish(NCQTransferState *ncq_tfs)
>>  {
>>      /* If we didn't error out, set our finished bit. Errored commands
>> @@ -1065,6 +1082,8 @@ static void execute_ncq_command(NCQTransferState *ncq_tfs)
>>  {
>>      AHCIDevice *ad = ncq_tfs->drive;
>>      IDEState *ide_state = &ad->port.ifs[0];
>> +    uint64_t error_sector = 0;
>> +    char device_id[32];
>>      int port = ad->port_no;
>>  
>>      g_assert(is_ncq(ncq_tfs->cmd));
>> @@ -1072,6 +1091,14 @@ static void execute_ncq_command(NCQTransferState *ncq_tfs)
>>  
>>      switch (ncq_tfs->cmd) {
>>      case READ_FPDMA_QUEUED:
>> +        sprintf(device_id, "%lu", ide_state->wwn);
> 
> This seems suspicious for your design in general, but I'd like to not
> run sprintf to a buffer in the hotpath for NCQ.

I totally agree.

I started out using integers in the call for error_in_read, as that is
what SCSI uses internally for wwn.  Then I did NVMe and it's using a
string that doesn't apparently need to be an integer for the wwn? so I
changed it to being a string to accommodate.

I also find it interesting that when a SATA device wwid is dumped out
within the guest it doesn't appear to have any correlation with the wwn
that was passed in on the command line, eg.

-device ide-drive,drive=satadisk,bus=ahci.0,wwn=8675309

$cat /sys/block/sda/device/wwid
t10.ATA     QEMU HARDDISK                           QM00005


This does correlate for SCSI

-device scsi-hd,drive=hd,wwn=12345678

$ cat /sys/block/sdc/device/wwid
naa.0000000000bc614e


as 0xbc614e = 12345678


For NVMe, the wwn is in the wwid, but it's not immediately obvious.

Being able to correlate between the command line and what you find in
the guest would be good.


> If you need this, I'd do it when wwn is set and just grab it from the
> state structure.
> 
>> +
>> +        if (error_in_read(device_id, ncq_tfs->lba,
>> +                ncq_tfs->sector_count, &error_sector)) {
>> +            ncq_media_err(ncq_tfs, error_sector);
>> +            return;
>> +        }
>> +
> 
> One of the downsides to trying to trigger read error injections
> per-device instead of per-node is that now you have to goof around with
> device-specific code everywhere>
> I suppose from your cover letter you *WANT* device-specific error
> exercising, which would necessitate a different design from blkdebug,
> but it means you have to add support for the framework per-device and it
> might be very tricky to get right.

Yes, goal was to be able to selectively pick one or more specific block
devices and then create one or more block errors on each device with
potentially different error behavior for each block in error.


>>          trace_execute_ncq_command_read(ad->hba, port, ncq_tfs->tag,
>>                                         ncq_tfs->sector_count, ncq_tfs->lba);
>>          dma_acct_start(ide_state->blk, &ncq_tfs->acct,
>>


