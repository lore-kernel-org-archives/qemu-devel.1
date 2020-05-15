Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA719C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE102065F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 07:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPMnjUlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE102065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZUeN-0007I8-QT
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 03:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZUdf-0006TI-HA
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:20:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48920
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZUdd-0008Fy-QQ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 03:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589527208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMk1o0OEy/p0nRIzOdSeYPWb9G28VVR5RnbYWbz2KUA=;
 b=gPMnjUlhyV4Ot8oMKmvt9BZ/u0B6xLOBfPL/TGpSmDzwjT8CvH9Hj+9Pd9wsVj6YMebTey
 BGlvR1RbI+P+AyitHk978j2CyuihKuuV0sCCDSvyLsX94IaaKaGRAyhVPfcwkiYAUoRRtV
 7Vi2UZ0/s0ZjNqaWaSC7uFI1Xm7TFpk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-wuVu4RQ4NVySXHfQ-ptIQQ-1; Fri, 15 May 2020 03:20:04 -0400
X-MC-Unique: wuVu4RQ4NVySXHfQ-ptIQQ-1
Received: by mail-wm1-f71.google.com with SMTP id l26so565460wmh.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 00:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XMk1o0OEy/p0nRIzOdSeYPWb9G28VVR5RnbYWbz2KUA=;
 b=OUEpq8t+WDG1yUNbKIDp11tuhAKhyqIFDfxPIiX6UQq3QA1wxjKqOEASJTcLNsfDxJ
 UVN4xOo1PupcViX7WIrwGB/Z5RX/vCdS5EFKArFw9sfoXqmqIayakNVceRm0XRLR2842
 gM6GZ4gIPGlT0y0dnzRCwXWxkss40KGVjnbkw6B3iLGtPhWQV9yipoew63U2FWvLEAjm
 sFpeqEAjbN8M7Ui2ZmEq6Nr/8FPJMzn2oFkOQjxrrFnBpgjm692hdLdfDnJDpiIdgVeP
 s/rToO8WD562k1Xg4E5IbWzaqQOiuA5X8m+s3fU3PXMJVa0ZD6VGrg5gXjZj3NMx2ouk
 SEng==
X-Gm-Message-State: AOAM533ggwGmNC3XwL8ICdi4/GkdUBZeHcIgfkjfN7ztr/3SKeTxiDxx
 GBlIxTvh2CXC6IP7+DI+oZ85W+xQF5rwLEK9EMkrIDUu1VI6DLkM7STwvwtPe+w3OYVAwhlvqG0
 kCeGUYPGJm3/7wI8=
X-Received: by 2002:adf:f605:: with SMTP id t5mr2609426wrp.354.1589527203653; 
 Fri, 15 May 2020 00:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2D18lQUdKKgtdOBzQEi/bdAgUxK6JviQmaIGYB7SKkqzeFW112hf6f89MbAShKCXJst6mag==
X-Received: by 2002:adf:f605:: with SMTP id t5mr2609398wrp.354.1589527203288; 
 Fri, 15 May 2020 00:20:03 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id t7sm2224019wrq.39.2020.05.15.00.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 00:20:02 -0700 (PDT)
Subject: Re: [PATCH] hw/ide: Make IDEDMAOps handlers take a const IDEDMA
 pointer
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200512194917.15807-1-philmd@redhat.com>
 <01f5f413-d1d0-43cb-65cc-9f7bd1e59893@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7482643e-f547-5d2c-7314-3a0ec91c047e@redhat.com>
Date: Fri, 15 May 2020 09:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <01f5f413-d1d0-43cb-65cc-9f7bd1e59893@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 10:21 PM, John Snow wrote:
> 
> 
> On 5/12/20 3:49 PM, Philippe Mathieu-Daudé wrote:
>> Handlers don't need to modify the IDEDMA structure.
>> Make it const.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> I'll trust your judgment. As long as it still compiles and passes
> qtests, I'm happy if you're happy.

I guess "all data is modifyable until proven otherwise" is one of the 
'defensive programming' rules.

https://wiki.sei.cmu.edu/confluence/display/c/DCL00-C.+Const-qualify+immutable+objects

"Immutable objects should be const-qualified. Enforcing object 
immutability using const qualification helps ensure the correctness and 
security of applications."

It is also a hint to static analyzer and compilers for optimization.

https://en.wikipedia.org/wiki/Const_(computer_programming)#Consequences

"A const parameter in pass-by-reference means that the referenced value 
is not modified – it is part of the contract –"

> 
> Acked-by: John Snow <jsnow@redhat.com>

Thanks!

> 
>> ---
>>   include/hw/ide/internal.h | 12 ++++++------
>>   hw/ide/ahci.c             | 18 +++++++++---------
>>   hw/ide/core.c             |  6 +++---
>>   hw/ide/macio.c            |  6 +++---
>>   hw/ide/pci.c              | 12 ++++++------
>>   5 files changed, 27 insertions(+), 27 deletions(-)
>>
>> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
>> index 55da35d768..1a7869e85d 100644
>> --- a/include/hw/ide/internal.h
>> +++ b/include/hw/ide/internal.h
>> @@ -322,12 +322,12 @@ typedef enum { IDE_HD, IDE_CD, IDE_CFATA } IDEDriveKind;
>>   
>>   typedef void EndTransferFunc(IDEState *);
>>   
>> -typedef void DMAStartFunc(IDEDMA *, IDEState *, BlockCompletionFunc *);
>> -typedef void DMAVoidFunc(IDEDMA *);
>> -typedef int DMAIntFunc(IDEDMA *, bool);
>> -typedef int32_t DMAInt32Func(IDEDMA *, int32_t len);
>> -typedef void DMAu32Func(IDEDMA *, uint32_t);
>> -typedef void DMAStopFunc(IDEDMA *, bool);
>> +typedef void DMAStartFunc(const IDEDMA *, IDEState *, BlockCompletionFunc *);
>> +typedef void DMAVoidFunc(const IDEDMA *);
>> +typedef int DMAIntFunc(const IDEDMA *, bool);
>> +typedef int32_t DMAInt32Func(const IDEDMA *, int32_t len);
>> +typedef void DMAu32Func(const IDEDMA *, uint32_t);
>> +typedef void DMAStopFunc(const IDEDMA *, bool);
>>   
>>   struct unreported_events {
>>       bool eject_request;
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index 13d91e109a..168d34e9f2 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -44,7 +44,7 @@ static int handle_cmd(AHCIState *s, int port, uint8_t slot);
>>   static void ahci_reset_port(AHCIState *s, int port);
>>   static bool ahci_write_fis_d2h(AHCIDevice *ad);
>>   static void ahci_init_d2h(AHCIDevice *ad);
>> -static int ahci_dma_prepare_buf(IDEDMA *dma, int32_t limit);
>> +static int ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit);
>>   static bool ahci_map_clb_address(AHCIDevice *ad);
>>   static bool ahci_map_fis_address(AHCIDevice *ad);
>>   static void ahci_unmap_clb_address(AHCIDevice *ad);
>> @@ -1338,7 +1338,7 @@ out:
>>   }
>>   
>>   /* Transfer PIO data between RAM and device */
>> -static void ahci_pio_transfer(IDEDMA *dma)
>> +static void ahci_pio_transfer(const IDEDMA *dma)
>>   {
>>       AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>>       IDEState *s = &ad->port.ifs[0];
>> @@ -1397,7 +1397,7 @@ out:
>>       }
>>   }
>>   
>> -static void ahci_start_dma(IDEDMA *dma, IDEState *s,
>> +static void ahci_start_dma(const IDEDMA *dma, IDEState *s,
>>                              BlockCompletionFunc *dma_cb)
>>   {
>>       AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>> @@ -1406,7 +1406,7 @@ static void ahci_start_dma(IDEDMA *dma, IDEState *s,
>>       dma_cb(s, 0);
>>   }
>>   
>> -static void ahci_restart_dma(IDEDMA *dma)
>> +static void ahci_restart_dma(const IDEDMA *dma)
>>   {
>>       /* Nothing to do, ahci_start_dma already resets s->io_buffer_offset.  */
>>   }
>> @@ -1415,7 +1415,7 @@ static void ahci_restart_dma(IDEDMA *dma)
>>    * IDE/PIO restarts are handled by the core layer, but NCQ commands
>>    * need an extra kick from the AHCI HBA.
>>    */
>> -static void ahci_restart(IDEDMA *dma)
>> +static void ahci_restart(const IDEDMA *dma)
>>   {
>>       AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>>       int i;
>> @@ -1432,7 +1432,7 @@ static void ahci_restart(IDEDMA *dma)
>>    * Called in DMA and PIO R/W chains to read the PRDT.
>>    * Not shared with NCQ pathways.
>>    */
>> -static int32_t ahci_dma_prepare_buf(IDEDMA *dma, int32_t limit)
>> +static int32_t ahci_dma_prepare_buf(const IDEDMA *dma, int32_t limit)
>>   {
>>       AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>>       IDEState *s = &ad->port.ifs[0];
>> @@ -1453,7 +1453,7 @@ static int32_t ahci_dma_prepare_buf(IDEDMA *dma, int32_t limit)
>>    * Called via dma_buf_commit, for both DMA and PIO paths.
>>    * sglist destruction is handled within dma_buf_commit.
>>    */
>> -static void ahci_commit_buf(IDEDMA *dma, uint32_t tx_bytes)
>> +static void ahci_commit_buf(const IDEDMA *dma, uint32_t tx_bytes)
>>   {
>>       AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>>   
>> @@ -1461,7 +1461,7 @@ static void ahci_commit_buf(IDEDMA *dma, uint32_t tx_bytes)
>>       ad->cur_cmd->status = cpu_to_le32(tx_bytes);
>>   }
>>   
>> -static int ahci_dma_rw_buf(IDEDMA *dma, bool is_write)
>> +static int ahci_dma_rw_buf(const IDEDMA *dma, bool is_write)
>>   {
>>       AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>>       IDEState *s = &ad->port.ifs[0];
>> @@ -1486,7 +1486,7 @@ static int ahci_dma_rw_buf(IDEDMA *dma, bool is_write)
>>       return 1;
>>   }
>>   
>> -static void ahci_cmd_done(IDEDMA *dma)
>> +static void ahci_cmd_done(const IDEDMA *dma)
>>   {
>>       AHCIDevice *ad = DO_UPCAST(AHCIDevice, dma, dma);
>>   
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index 689bb36409..d997a78e47 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -2570,16 +2570,16 @@ static void ide_init1(IDEBus *bus, int unit)
>>                                              ide_sector_write_timer_cb, s);
>>   }
>>   
>> -static int ide_nop_int(IDEDMA *dma, bool is_write)
>> +static int ide_nop_int(const IDEDMA *dma, bool is_write)
>>   {
>>       return 0;
>>   }
>>   
>> -static void ide_nop(IDEDMA *dma)
>> +static void ide_nop(const IDEDMA *dma)
>>   {
>>   }
>>   
>> -static int32_t ide_nop_int32(IDEDMA *dma, int32_t l)
>> +static int32_t ide_nop_int32(const IDEDMA *dma, int32_t l)
>>   {
>>       return 0;
>>   }
>> diff --git a/hw/ide/macio.c b/hw/ide/macio.c
>> index a9f25e5d02..5b8098268d 100644
>> --- a/hw/ide/macio.c
>> +++ b/hw/ide/macio.c
>> @@ -376,17 +376,17 @@ static void macio_ide_reset(DeviceState *dev)
>>       ide_bus_reset(&d->bus);
>>   }
>>   
>> -static int ide_nop_int(IDEDMA *dma, bool is_write)
>> +static int ide_nop_int(const IDEDMA *dma, bool is_write)
>>   {
>>       return 0;
>>   }
>>   
>> -static int32_t ide_nop_int32(IDEDMA *dma, int32_t l)
>> +static int32_t ide_nop_int32(const IDEDMA *dma, int32_t l)
>>   {
>>       return 0;
>>   }
>>   
>> -static void ide_dbdma_start(IDEDMA *dma, IDEState *s,
>> +static void ide_dbdma_start(const IDEDMA *dma, IDEState *s,
>>                               BlockCompletionFunc *cb)
>>   {
>>       MACIOIDEState *m = container_of(dma, MACIOIDEState, dma);
>> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
>> index 97347f07f1..5e85c4ad17 100644
>> --- a/hw/ide/pci.c
>> +++ b/hw/ide/pci.c
>> @@ -103,7 +103,7 @@ const MemoryRegionOps pci_ide_data_le_ops = {
>>       .endianness = DEVICE_LITTLE_ENDIAN,
>>   };
>>   
>> -static void bmdma_start_dma(IDEDMA *dma, IDEState *s,
>> +static void bmdma_start_dma(const IDEDMA *dma, IDEState *s,
>>                               BlockCompletionFunc *dma_cb)
>>   {
>>       BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>> @@ -126,7 +126,7 @@ static void bmdma_start_dma(IDEDMA *dma, IDEState *s,
>>    * IDEState.io_buffer_size will contain the number of bytes described
>>    * by the PRDs, whether or not we added them to the sglist.
>>    */
>> -static int32_t bmdma_prepare_buf(IDEDMA *dma, int32_t limit)
>> +static int32_t bmdma_prepare_buf(const IDEDMA *dma, int32_t limit)
>>   {
>>       BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>>       IDEState *s = bmdma_active_if(bm);
>> @@ -181,7 +181,7 @@ static int32_t bmdma_prepare_buf(IDEDMA *dma, int32_t limit)
>>   }
>>   
>>   /* return 0 if buffer completed */
>> -static int bmdma_rw_buf(IDEDMA *dma, bool is_write)
>> +static int bmdma_rw_buf(const IDEDMA *dma, bool is_write)
>>   {
>>       BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>>       IDEState *s = bmdma_active_if(bm);
>> @@ -230,7 +230,7 @@ static int bmdma_rw_buf(IDEDMA *dma, bool is_write)
>>       return 1;
>>   }
>>   
>> -static void bmdma_set_inactive(IDEDMA *dma, bool more)
>> +static void bmdma_set_inactive(const IDEDMA *dma, bool more)
>>   {
>>       BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>>   
>> @@ -242,7 +242,7 @@ static void bmdma_set_inactive(IDEDMA *dma, bool more)
>>       }
>>   }
>>   
>> -static void bmdma_restart_dma(IDEDMA *dma)
>> +static void bmdma_restart_dma(const IDEDMA *dma)
>>   {
>>       BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>>   
>> @@ -257,7 +257,7 @@ static void bmdma_cancel(BMDMAState *bm)
>>       }
>>   }
>>   
>> -static void bmdma_reset(IDEDMA *dma)
>> +static void bmdma_reset(const IDEDMA *dma)
>>   {
>>       BMDMAState *bm = DO_UPCAST(BMDMAState, dma, dma);
>>   
>>
> 


