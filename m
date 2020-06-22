Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E7DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:25:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F5620809
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAPcShqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F5620809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHlO-0003L5-45
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnHkh-0002qv-3q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:24:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21983
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnHkf-0007zK-Ec
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592814264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=olmBm1B0dOr4/7POEIO8nSJduhPZJAyeGPGnQRKBPKs=;
 b=aAPcShqOGaQknZxq5b4Mt3zvf1fGwUGcXyF8rflW9g55KzhI237dwaBSxFwvJZTeM7FG7i
 PYdzzACdAfffZw3xYLZ+WX9fs9/6soHD+NCCnZnG6+jPtkixUQ0y9AWEMv3gkhCjCwwe7L
 t+m0cXidUnvg+t1GUOwHFuo76AaAf9g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-clcKIY2KP6uaWxTN91WIXA-1; Mon, 22 Jun 2020 04:24:20 -0400
X-MC-Unique: clcKIY2KP6uaWxTN91WIXA-1
Received: by mail-wr1-f71.google.com with SMTP id o1so10463095wrm.17
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 01:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=olmBm1B0dOr4/7POEIO8nSJduhPZJAyeGPGnQRKBPKs=;
 b=sIeZH0fsIcWmZWTUfA6Rdy3WsTgNHGtDQOMg45pvzVmdoD1/Ko9eJyH5spk69A/tgT
 EINichDDtGcv8CfU73ORJW6qMZq+kwrm8PWPflut/kIxC9nIw3PHxnFfRlmof96q935w
 WBuV3P3qIaKb1b8+zJfI8LFA9gIDK98OZ4d66v80n3GWpgePIinUIKIjFLArepbB8CBE
 T3TXiqSByOU/D5AacSgcpAVXebP+m40dmnt31HgEQNQKCsMa/RhNslVQqo3X9o0PNh7r
 fDYmT66mGscEqUMN3hXmmLL8NRlOdSMv9CRs63vEJqmGs7Yb1jPR0rH0zsK3lyzTRgDJ
 TZ+g==
X-Gm-Message-State: AOAM530D4KApTafw3qYJsYT9wz1y9Znn96valu9fx7pozinbSz4Or0rm
 wH6PSjiFmu/DOvkUnK14NeKOts0cklJEDdJcLnKMYt9O4zKNt+ZblsIeXpY9Sd/1aeBQQ1NhZ00
 VkJo9c2LSnZyDVCM=
X-Received: by 2002:adf:958a:: with SMTP id p10mr16793874wrp.323.1592814259752; 
 Mon, 22 Jun 2020 01:24:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLT3zoFr45ti6Zk8Ouy0DY8vRE7L9b76xKG7fnWSbPffipOSJueKzSN7s8sOL5oGuXhNin9Q==
X-Received: by 2002:adf:958a:: with SMTP id p10mr16793855wrp.323.1592814259463; 
 Mon, 22 Jun 2020 01:24:19 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d13sm5917696wrq.89.2020.06.22.01.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 01:24:18 -0700 (PDT)
Subject: Re: [PATCH] ppc/pnv: Silence missing BMC warning with qtest
To: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Thomas Huth <thuth@redhat.com>
References: <159280903824.485572.831378159272329707.stgit@bahia.lan>
 <47741f1f-0070-4325-9690-9549211f266c@kaod.org>
 <20200622095312.0919cfc4@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <e2b5e91c-fb8a-e007-ef1f-fbea886d6ae5@redhat.com>
Date: Mon, 22 Jun 2020 10:24:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200622095312.0919cfc4@bahia.lan>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 9:53 AM, Greg Kurz wrote:
> On Mon, 22 Jun 2020 09:13:46 +0200
> Cédric Le Goater <clg@kaod.org> wrote:
> 
>> On 6/22/20 8:57 AM, Greg Kurz wrote:
>>> The device introspect test in qtest emits some warnings with the
>>> the pnv machine types during the "nodefaults" phase:
>>>
>>> TEST check-qtest-ppc64: tests/qtest/device-introspect-test
>>> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
>>> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
>>> one
>>> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
>>> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
>>> one
>>> qemu-system-ppc64: warning: machine has no BMC device. Use '-device
>>> ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' to define
>>> one
>>>
>>> This is expected since the pnv machine doesn't create the internal
>>> BMC simulator fallback when "-nodefaults" is passed on the command
>>> line, but these warnings appear in ci logs and confuse people.
>>>
>>> Not having a BMC isn't recommended but it is still a supported
>>> configuration, so a straightforward fix is to just silent this
>>> warning when qtest is enabled.
>>>
>>> Fixes: 25f3170b0654 ("ppc/pnv: Create BMC devices only when defaults are enabled")
>>> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>
>> It looks good but could you reproduce ? 
>>
> 
> Yup, this test is only run in "slow" mode, eg:
> 
>     make check-qtest-ppc64 SPEED=slow

Indeed:
https://gitlab.com/qemu-project/qemu/-/jobs/603546723#L3337

See in .gitlab-ci.yml:

  build-disabled:
   ...
   - make -j"$JOBS"
   - make -j"$JOBS" check-qtest SPEED=slow

Thomas, FYI this job is now timeouting most of the time.

> 
> 
>> C.
>>
>>> ---
>>>  hw/ppc/pnv.c |    9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 806a5d9a8d34..1622d29b4ba7 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -21,6 +21,7 @@
>>>  #include "qemu-common.h"
>>>  #include "qemu/units.h"
>>>  #include "qapi/error.h"
>>> +#include "sysemu/qtest.h"
>>>  #include "sysemu/sysemu.h"
>>>  #include "sysemu/numa.h"
>>>  #include "sysemu/reset.h"
>>> @@ -587,9 +588,11 @@ static void pnv_reset(MachineState *machine)
>>>      bmc = pnv_bmc_find(&error_fatal);
>>>      if (!pnv->bmc) {
>>>          if (!bmc) {
>>> -            warn_report("machine has no BMC device. Use '-device "
>>> -                        "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
>>> -                        "to define one");
>>> +            if (!qtest_enabled()) {
>>> +                warn_report("machine has no BMC device. Use '-device "
>>> +                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
>>> +                            "to define one");
>>> +            }
>>>          } else {
>>>              pnv_bmc_set_pnor(bmc, pnv->pnor);
>>>              pnv->bmc = bmc;
>>>
>>>
>>
> 


