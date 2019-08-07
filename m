Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71E7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B75B2229C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B75B2229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPlz-0007Kc-R5
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55271)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvPlM-0006c2-El
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvPlL-0007xL-CV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:30:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvPlL-0007uh-7B
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:30:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so847054wme.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oLQ549ST4kv0q/wJ6ABT0LcwW5N5HZQQxNu6q2Dq1p4=;
 b=qlUMdGWYCMNdOh1pvzLx+yuu0A3bEf35C+4KjoZLmJBkAgq1W/w5TCEqkbnVeHevIb
 jgr98skSwo8o6c8izyG/HBF0Pmd5BccVk4pFy+3z8TDklAMqJECIW7WJNNQEC53JeyZq
 2exVFNb1eD7eeksU9N2cubjGyb/PwrQHWNeOB1Gt9Ik1VlHKqpRdJuGqHSYp3Ny7LABY
 rL+zfsmwUf5mzRS4aJyF7T00XpdwznR/3cKCCiKULnWH5e+b+eu6dhZn9ojCZCFLoZ69
 qvPPhK0DamHZGevC2QYx0cxfJoEoOnuXE8xv5POaLtgP+S6MrvM9yssu65b+qD9k+SCi
 WlCg==
X-Gm-Message-State: APjAAAUHzqliV2r39U9yOiEYxviuqywMbtRSboUoZoVpwrcPrNkvlxo7
 10sbQmoAI6jty7kF6MXm/mkFXvHps6g=
X-Google-Smtp-Source: APXvYqxEDrPD43EovmS+MPDFGDEv21zjqBkqjR5NnFf0ak6HSaorpy1q7kxMFc39TSSpGZj/HgXyYw==
X-Received: by 2002:a05:600c:245:: with SMTP id 5mr247472wmj.36.1565199009963; 
 Wed, 07 Aug 2019 10:30:09 -0700 (PDT)
Received: from [192.168.1.115] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id w13sm4562754wre.44.2019.08.07.10.30.09
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 10:30:09 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-10-armbru@redhat.com>
 <b14e627d-d9e0-bd33-9f6f-c3e5cb59f8cd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e529d823-f5db-bd34-197d-a4460938a6dc@redhat.com>
Date: Wed, 7 Aug 2019 19:30:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b14e627d-d9e0-bd33-9f6f-c3e5cb59f8cd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 09/29] Include
 migration/qemu-file-types.h a lot less
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

On 8/7/19 2:25 PM, Philippe Mathieu-Daudé wrote:
> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>> In my "build everything" tree, changing migration/qemu-file-types.h
>> triggers a recompile of some 2600 out of 6600 objects (not counting
>> tests and objects that don't depend on qemu/osdep.h).
>>
>> The culprit is again hw/hw.h, which supposedly includes it for
>> convenience.
>>
>> Include migration/qemu-file-types.h only where it's needed.  Touching
>> it now recompiles less than 200 objects.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/acpi/piix4.c             | 1 +
>>  hw/block/virtio-blk.c       | 1 +
>>  hw/char/virtio-serial-bus.c | 1 +
>>  hw/display/virtio-gpu.c     | 1 +
>>  hw/intc/apic_common.c       | 1 +
>>  hw/nvram/eeprom93xx.c       | 1 +
>>  hw/nvram/fw_cfg.c           | 1 +
>>  hw/pci-host/piix.c          | 1 +
>>  hw/pci/msix.c               | 1 +
>>  hw/pci/pci.c                | 1 +
>>  hw/pci/shpc.c               | 1 +
>>  hw/ppc/spapr.c              | 1 +
>>  hw/s390x/s390-skeys.c       | 1 +
>>  hw/s390x/tod.c              | 1 +
>>  hw/s390x/virtio-ccw.c       | 1 +
>>  hw/scsi/mptsas.c            | 1 +
>>  hw/scsi/scsi-bus.c          | 1 +
>>  hw/scsi/scsi-disk.c         | 1 +
>>  hw/scsi/scsi-generic.c      | 1 +
>>  hw/scsi/virtio-scsi.c       | 1 +
>>  hw/timer/i8254_common.c     | 1 +
>>  hw/timer/twl92230.c         | 1 +
>>  hw/usb/redirect.c           | 1 +
>>  hw/virtio/vhost.c           | 1 +
>>  hw/virtio/virtio-mmio.c     | 1 +
>>  hw/virtio/virtio-pci.c      | 1 +
>>  hw/virtio/virtio.c          | 1 +
>>  include/hw/hw.h             | 1 -
>>  include/migration/cpu.h     | 1 +
>>  target/ppc/kvm.c            | 1 +
>>  30 files changed, 29 insertions(+), 1 deletion(-)
> [...]
>> diff --git a/include/hw/hw.h b/include/hw/hw.h
>> index a4fb2390e8..b399627cbe 100644
>> --- a/include/hw/hw.h
>> +++ b/include/hw/hw.h
>> @@ -11,7 +11,6 @@
>>  #include "exec/memory.h"
>>  #include "hw/irq.h"
>>  #include "migration/vmstate.h"
>> -#include "migration/qemu-file-types.h"
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Oops another miss:

hw/intc/s390_flic_kvm.c: In function 'kvm_flic_save':
hw/intc/s390_flic_kvm.c:395:9: error: implicit declaration of function
'qemu_put_be64' [-Werror=implicit-function-declaration]
         qemu_put_be64(f, FLIC_FAILED);
         ^~~~~~~~~~~~~

>>  void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>>  
>> diff --git a/include/migration/cpu.h b/include/migration/cpu.h
>> index 8424f1631a..21c4fc9eab 100644
>> --- a/include/migration/cpu.h
>> +++ b/include/migration/cpu.h
>> @@ -3,6 +3,7 @@
>>  #define MIGRATION_CPU_H
>>  
>>  #include "exec/cpu-defs.h"
>> +#include "migration/qemu-file-types.h"
>>  
>>  #if TARGET_LONG_BITS == 64
>>  #define qemu_put_betl qemu_put_be64

