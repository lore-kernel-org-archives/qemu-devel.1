Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3299DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0606F21BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 12:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0606F21BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvL5F-0000Ju-RB
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 08:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43402)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvL4d-0008CZ-U2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvL4a-0007qm-2B
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:29:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvL4Z-0007qL-Ri
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 08:29:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so5333224wrq.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 05:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hrlB1nO6Jtxdp3OlknFOaAAJHuiWFNhKBtemia6tTpo=;
 b=epz7vH4r1Az1/zxmPpvI5K06p1A+Rkq9ZdZevUOVAvO3k4ua6/hlUQBbcC2b3NaAJF
 UoqbCy8ejvGp6tYF0ZNieSK3IwbSujPp8eMb3UGTdLzXqnAJXmHTfh5b2vp4E+0npWPd
 ZR81xz7Y8OoAesinBSBqQhkP9atXqE75IxVd+pqx3+GRbskHV08gz+GCHVZl8IGFuJBk
 0SC8+XUzjzZkyTpDd3ohaMpySooln56qzQxxTt+XryuLtmhw2ZdsilzLKbGfeRBZCU8g
 M/VYvzgk3vAD4fRVQMndj5Gq/97px5QvKBKyDxK9Ufk3iABvmrVNwlpFwP+4iaMpvfRN
 tJgg==
X-Gm-Message-State: APjAAAWBH+gftGUl3zwL0EgSd5ONRcas8qcioMlTp33QcM12jYp8ZN36
 HiLK9AAiTCPLkgkCsvnZzosexw4by+g=
X-Google-Smtp-Source: APXvYqz9cSmJcMhXSIcjBekviStX/wZeLZKcVM44LcbdE89Rk/t+VzxbOGoxnNx5cwXeL7rdlR86jA==
X-Received: by 2002:adf:ce88:: with SMTP id r8mr11372957wrn.42.1565180982505; 
 Wed, 07 Aug 2019 05:29:42 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id j189sm111061712wmb.48.2019.08.07.05.29.41
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 05:29:41 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-11-armbru@redhat.com>
 <6cca4d01-14ae-ac49-7716-7675f1154db4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c1e3616c-84b3-35a8-b528-d78ed8bf8ffc@redhat.com>
Date: Wed, 7 Aug 2019 14:29:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6cca4d01-14ae-ac49-7716-7675f1154db4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 10/29] ide: Include hw/ide/internal a
 bit less outside hw/ide/
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/19 11:40 PM, John Snow wrote:
> On 8/6/19 11:14 AM, Markus Armbruster wrote:
>> According to hw/ide/internal's file comment, only files in hw/ide/ are
>> supposed to include it.  Drag reality slightly closer to supposition.
>>
> 
> The downside of having your internal include ripped away and stuck in
> the includes/ folder.

Not sure this is a 'downside', it looks more than proper design issue to
me (often the case with very old subsystems).

>> Three includes outside hw/ide remain: hw/arm/sbsa-ref.c,
>> include/hw/ide/pci.h, and include/hw/misc/macio/macio.h.  Turns out
>> board code needs ide-internal.h to wire up IDE stuff.  More cleanup is
>> needed.  Left for another day.
>>
> 
> Yuh. This is mostly why I haven't touched it.
> 
>> Cc: John Snow <jsnow@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> Thank you.
> 
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>> ---
>>  hw/arm/allwinner-a10.c         | 1 +
>>  hw/arm/cubieboard.c            | 1 +
>>  hw/arm/xlnx-zynqmp.c           | 1 +
>>  hw/ide/ahci_internal.h         | 1 +
>>  hw/ppc/mac.h                   | 1 -
>>  include/hw/arm/allwinner-a10.h | 1 -
>>  include/hw/arm/xlnx-zynqmp.h   | 1 -
>>  include/hw/misc/mos6522.h      | 1 -
>>  8 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
>> index 35e906ca54..3b0d3eccdd 100644
>> --- a/hw/arm/allwinner-a10.c
>> +++ b/hw/arm/allwinner-a10.c
>> @@ -16,6 +16,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "exec/address-spaces.h"
>>  #include "qapi/error.h"
>>  #include "qemu/module.h"
>>  #include "cpu.h"
>> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
>> index f7c8a5985a..38e0ca0f53 100644
>> --- a/hw/arm/cubieboard.c
>> +++ b/hw/arm/cubieboard.c
>> @@ -16,6 +16,7 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> +#include "exec/address-spaces.h"
>>  #include "qapi/error.h"
>>  #include "cpu.h"
>>  #include "hw/sysbus.h"
>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>> index a60830d37a..0f587e63d3 100644
>> --- a/hw/arm/xlnx-zynqmp.c
>> +++ b/hw/arm/xlnx-zynqmp.c
>> @@ -24,6 +24,7 @@
>>  #include "hw/boards.h"
>>  #include "exec/address-spaces.h"
>>  #include "sysemu/kvm.h"
>> +#include "sysemu/sysemu.h"
>>  #include "kvm_arm.h"
>>  
>>  #define GIC_NUM_SPI_INTR 160
>> diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
>> index 95ecddcd3c..73424516da 100644
>> --- a/hw/ide/ahci_internal.h
>> +++ b/hw/ide/ahci_internal.h
>> @@ -25,6 +25,7 @@
>>  #define HW_IDE_AHCI_INTERNAL_H
>>  
>>  #include "hw/ide/ahci.h"
>> +#include "hw/ide/internal.h"
>>  #include "hw/sysbus.h"
>>  
>>  #define AHCI_MEM_BAR_SIZE         0x1000
>> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
>> index a741300ac9..6af87d1fa0 100644
>> --- a/hw/ppc/mac.h
>> +++ b/hw/ppc/mac.h
>> @@ -30,7 +30,6 @@
>>  #include "exec/memory.h"
>>  #include "hw/boards.h"
>>  #include "hw/sysbus.h"
>> -#include "hw/ide/internal.h"
>>  #include "hw/input/adb.h"
>>  #include "hw/misc/mos6522.h"
>>  #include "hw/pci/pci_host.h"
>> diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
>> index 7182ce5c4b..101b72a71d 100644
>> --- a/include/hw/arm/allwinner-a10.h
>> +++ b/include/hw/arm/allwinner-a10.h
>> @@ -7,7 +7,6 @@
>>  #include "hw/timer/allwinner-a10-pit.h"
>>  #include "hw/intc/allwinner-a10-pic.h"
>>  #include "hw/net/allwinner_emac.h"
>> -#include "hw/ide/pci.h"
>>  #include "hw/ide/ahci.h"
>>  
>>  #include "sysemu/sysemu.h"
>> diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
>> index 6cb65e7537..d7483c3b42 100644
>> --- a/include/hw/arm/xlnx-zynqmp.h
>> +++ b/include/hw/arm/xlnx-zynqmp.h
>> @@ -22,7 +22,6 @@
>>  #include "hw/intc/arm_gic.h"
>>  #include "hw/net/cadence_gem.h"
>>  #include "hw/char/cadence_uart.h"
>> -#include "hw/ide/pci.h"
>>  #include "hw/ide/ahci.h"
>>  #include "hw/sd/sdhci.h"
>>  #include "hw/ssi/xilinx_spips.h"
>> diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
>> index 03d9f0c059..493c907537 100644
>> --- a/include/hw/misc/mos6522.h
>> +++ b/include/hw/misc/mos6522.h
>> @@ -29,7 +29,6 @@
>>  
>>  #include "exec/memory.h"
>>  #include "hw/sysbus.h"
>> -#include "hw/ide/internal.h"
>>  #include "hw/input/adb.h"
>>  
>>  /* Bits in ACR */
>>
> 

