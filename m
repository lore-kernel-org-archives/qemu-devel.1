Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7479AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 347B2206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzZWCgMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347B2206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblxk-00015Q-EW
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jblx1-0008SI-R5
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:13:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jblx0-0004mi-TY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590070413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C5yv7MTDr84AsxE38fa5gtDCBjScVB7vEOFo83X48Rg=;
 b=KzZWCgMkihJOS3hPSFb1IC+wPoFaFP7/1TvTgPKMWkU4lMWj8xipnTQySCAfnRyYhBf4a3
 7tUA5VeCxqdXXwI7F8GzXwKQWwJ14l0/b9eysjFY1n2pbdGNGhVPdY+z6RS5oZ5lUZS6AJ
 ztd1Ek+0OLwTfxnko9YTyFfmf13fRGU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-e0L4oJOKMpO6EkZL5MTgaA-1; Thu, 21 May 2020 10:13:31 -0400
X-MC-Unique: e0L4oJOKMpO6EkZL5MTgaA-1
Received: by mail-wr1-f71.google.com with SMTP id h6so2117518wrx.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C5yv7MTDr84AsxE38fa5gtDCBjScVB7vEOFo83X48Rg=;
 b=JcSQczcGAeUUlcJxlMj4rrrL4LyhumdMFAKPi6KO42dzkPqSiVItX6bHatCQtPw+fc
 OBU03YO7ygOaP94rD313pWt2YsvmIb76clS7FzP4Dzm1B222OpwlTs4vxuR/zNMZ8pwA
 WTm9nahoByvFRNDDGqXRiXsv0rc15frWW6hXjEjoE7qBzZBUSmXdeqDjMr5DnP11VXE7
 zRcUZFTzKOM0rLq1fEcWZXQCXs1EZLJ78ZIl8aXz7EpJzXSXKo7c0+T9X7QAMcmAXDt9
 ssnMmn4iAOvl/QIY4HwxzunYN89D9HwG0SFAQXRXwwEQA9bFyzVE+N2l71i+cD9kA8Ud
 i9CA==
X-Gm-Message-State: AOAM530khWXdNcWl1kzZTJ2bdB+huvfp4arjMwKHOfHL6+9+Csfru6Mq
 B8ReKh8wyw56RbZJ78l8ZSfI/bBfdTf7EbeMPSNDPv0H0kCTRqnFz06vYhCODGXZF9fZgLU9no7
 d3jsM275CZZgIAiA=
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr8533534wmj.146.1590070410075; 
 Thu, 21 May 2020 07:13:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgnluUCn7TsekzVgu25Z44qLNjC75uK18sZVsQGRi3dZn6ZDo3xcsfEqOW2UM7+m4pdjxE/A==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr8533520wmj.146.1590070409839; 
 Thu, 21 May 2020 07:13:29 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
 by smtp.gmail.com with ESMTPSA id w18sm6530110wro.33.2020.05.21.07.13.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:13:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] qom/object: Move Object typedef to
 'qemu/typedefs.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20200504115656.6045-1-f4bug@amsat.org>
 <20200504115656.6045-2-f4bug@amsat.org> <87wo5drasi.fsf@dusky.pond.sub.org>
 <CAAdtpL4wpqv8vMOFgRubghr53fJyoXJ+DcGwi84wp0PiczyUpg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bbbe4a93-a990-01ef-6316-1ce31dccd582@redhat.com>
Date: Thu, 21 May 2020 16:13:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAAdtpL4wpqv8vMOFgRubghr53fJyoXJ+DcGwi84wp0PiczyUpg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/20 09:00, Philippe Mathieu-Daudé wrote:
> On Fri, May 15, 2020 at 8:07 AM Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>
>>> We use the Object type all over the place.
>>> Forward declare it in "qemu/typedefs.h".
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>>  include/qemu/typedefs.h   | 1 +
>>>  include/qom/object.h      | 2 --
>>>  include/qom/qom-qobject.h | 2 --
>>>  include/sysemu/sysemu.h   | 1 -
>>>  4 files changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
>>> index 375770a80f..b03ec9f40a 100644
>>> --- a/include/qemu/typedefs.h
>>> +++ b/include/qemu/typedefs.h
>>> @@ -75,6 +75,7 @@ typedef struct NetFilterState NetFilterState;
>>>  typedef struct NICInfo NICInfo;
>>>  typedef struct NodeInfo NodeInfo;
>>>  typedef struct NumaNodeMem NumaNodeMem;
>>> +typedef struct Object Object;
>>>  typedef struct ObjectClass ObjectClass;
>>>  typedef struct PCIBridge PCIBridge;
>>>  typedef struct PCIBus PCIBus;
>>> diff --git a/include/qom/object.h b/include/qom/object.h
>>> index 784c97c0e1..1edc12e64c 100644
>>> --- a/include/qom/object.h
>>> +++ b/include/qom/object.h
>>> @@ -20,8 +20,6 @@
>>>  struct TypeImpl;
>>>  typedef struct TypeImpl *Type;
>>>
>>> -typedef struct Object Object;
>>> -
>>>  typedef struct TypeInfo TypeInfo;
>>>
>>>  typedef struct InterfaceClass InterfaceClass;
>>> diff --git a/include/qom/qom-qobject.h b/include/qom/qom-qobject.h
>>> index 77cd717e3f..82136e6e80 100644
>>> --- a/include/qom/qom-qobject.h
>>> +++ b/include/qom/qom-qobject.h
>>> @@ -13,8 +13,6 @@
>>>  #ifndef QEMU_QOM_QOBJECT_H
>>>  #define QEMU_QOM_QOBJECT_H
>>>
>>> -#include "qom/object.h"
>>> -
>>>  /*
>>>   * object_property_get_qobject:
>>>   * @obj: the object
>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>> index ef81302e1a..ca4458e451 100644
>>> --- a/include/sysemu/sysemu.h
>>> +++ b/include/sysemu/sysemu.h
>>> @@ -5,7 +5,6 @@
>>>  #include "qemu/timer.h"
>>>  #include "qemu/notify.h"
>>>  #include "qemu/uuid.h"
>>> -#include "qom/object.h"
>>>
>>>  /* vl.c */
>>
>> How did you identify the inclusions to drop?
> 
> Nothing very strict I'm afraid. I suppose I had the files opened in my editor.

Looks like all of these are affected:

 accel/accel.c             | 1 -
 block/throttle-groups.c   | 1 -
 hw/audio/soundhw.c        | 1 -
 hw/block/vhost-user-blk.c | 1 -
 hw/pci-host/pam.c         | 1 -
 hw/ppc/spapr_drc.c        | 1 -
 hw/scsi/vhost-user-scsi.c | 1 -
 include/hw/display/edid.h | 1 -
 include/hw/misc/pvpanic.h | 1 -
 include/hw/timer/hpet.h   | 1 -
 io/task.c                 | 1 -
 memory.c                  | 1 -
 stubs/qmp_memory_device.c | 1 -
 target/arm/kvm.c          | 1 -
 tests/test-io-task.c      | 1 -

Patch 3 doesn't apply anymore, I queued the first two.

Paolo


