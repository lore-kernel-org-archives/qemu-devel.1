Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D124C35DEB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104252176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 23:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104252176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6NTk-0008Km-69
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 18:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1j6NT0-0007YL-6M
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1j6NSy-0003tN-O8
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:48:49 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59174 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1j6NSy-0003sC-D1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 18:48:48 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 2F85863F3023651172B5;
 Tue, 25 Feb 2020 07:48:43 +0800 (CST)
Received: from [10.173.228.124] (10.173.228.124) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 25 Feb
 2020 07:48:34 +0800
Subject: Re: [PATCH RESEND 1/3] vfio/pci: fix a null pointer reference in
 vfio_rom_read
To: Alex Williamson <alex.williamson@redhat.com>
References: <20200224064219.1434-1-longpeng2@huawei.com>
 <20200224064219.1434-2-longpeng2@huawei.com>
 <20200224090458.080152c0@w520.home>
From: "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
Message-ID: <5b6a9b3c-0efe-8f57-d61e-731e9fd51470@huawei.com>
Date: Tue, 25 Feb 2020 07:48:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200224090458.080152c0@w520.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: weifuqiang@huawei.com, arei.gonglei@huawei.com, huangzhichao@huawei.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/25 0:04, Alex Williamson wrote:
> On Mon, 24 Feb 2020 14:42:17 +0800
> "Longpeng(Mike)" <longpeng2@huawei.com> wrote:
> 
>> From: Longpeng <longpeng2@huawei.com>
>>
>> vfio_pci_load_rom() maybe failed and then the vdev->rom is NULL in
>> some situation (though I've not encountered yet), maybe we should
>> avoid the VM abort.
>>
>> Signed-off-by: Longpeng <longpeng2@huawei.com>
>> ---
>>  hw/vfio/pci.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 5e75a95..ed798ae 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -768,7 +768,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
>>      }
>>  }
>>  
>> -static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>> +static bool vfio_pci_load_rom(VFIOPCIDevice *vdev)
>>  {
>>      struct vfio_region_info *reg_info;
>>      uint64_t size;
>> @@ -778,7 +778,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>>      if (vfio_get_region_info(&vdev->vbasedev,
>>                               VFIO_PCI_ROM_REGION_INDEX, &reg_info)) {
>>          error_report("vfio: Error getting ROM info: %m");
>> -        return;
>> +        return false;
>>      }
>>  
>>      trace_vfio_pci_load_rom(vdev->vbasedev.name, (unsigned long)reg_info->size,
>> @@ -797,7 +797,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>>          error_printf("Device option ROM contents are probably invalid "
>>                      "(check dmesg).\nSkip option ROM probe with rombar=0, "
>>                      "or load from file with romfile=\n");
>> -        return;
>> +        return false;
>>      }
>>  
>>      vdev->rom = g_malloc(size);
>> @@ -849,6 +849,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
>>              data[6] = -csum;
>>          }
>>      }
>> +
>> +    return true;
>>  }
>>  
>>  static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>> @@ -863,8 +865,9 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>>      uint64_t data = 0;
>>  
>>      /* Load the ROM lazily when the guest tries to read it */
>> -    if (unlikely(!vdev->rom && !vdev->rom_read_failed)) {
>> -        vfio_pci_load_rom(vdev);
>> +    if (unlikely(!vdev->rom && !vdev->rom_read_failed) &&
>> +        !vfio_pci_load_rom(vdev)) {
>> +        return 0;
>>      }
>>  
>>      memcpy(&val, vdev->rom + addr,
> 
> Looks like an obvious bug, until you look at the rest of this memcpy():
> 
> memcpy(&val, vdev->rom + addr,
>            (addr < vdev->rom_size) ? MIN(size, vdev->rom_size - addr) : 0);
> 
> IOW, we'll do a zero sized memcpy() if rom_size is zero, so there's no
> risk of the concern identified in the commit log.  This patch is
> unnecessary.  Thanks,
> 
Oh, I missed that, sorry for make the noise, thanks

> Alex
> 
> .
> 

