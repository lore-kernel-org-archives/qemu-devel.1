Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D767AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C71E206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSf8sKd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C71E206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jObPu-0008SC-QJ
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jObMF-00052a-Nv
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jObME-00087y-Ag
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 02:17:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jObM2-000838-6u; Wed, 15 Apr 2020 02:16:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id d77so15935487wmd.3;
 Tue, 14 Apr 2020 23:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0HpAA/yPCHUHpxQzs3SbNfMD74dBQ85M+x8zVY5gA9E=;
 b=ZSf8sKd38Za5DbhnV4BmuKAAh2/1FiT7njp8u+N9mUwTXP0/B2MjDgP6/FEG8jPAJF
 gPo2Fj7F3b1eUtDvqhYr4q4Lu3nGrYQkiTLpG3xCD4DwE2vGL1c1cG99PsWd2/6uf8RS
 s8X8eVGajzn18KgEomlDYxAoDGm7Ft0XNBZ0qkclZRS4Y/gr1d4PLXctDA/g5msakG0C
 PzOh6ME1e2oH7AfbOTTNc3k7gimpDwkRZvWy0wAajyz6znR5nTp/zcClVA7qQFU7rpDl
 eMklJQsYIBzba9uYbeMZ2Ll023qcdwtcQeq9nEJNrWemHlSbcTUPROnQpd/QH4luoQI7
 LdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0HpAA/yPCHUHpxQzs3SbNfMD74dBQ85M+x8zVY5gA9E=;
 b=ofSHYOoc9FaCxLbOYG2TC8XzNcPOFVQ7aYD29zl5SqdNCD+LIz6d0ToRwM0E0LqNWy
 7LiTIJ77LQ6qLRuAyEtuGvLZNm0Ehx0j9c9J0OyyQDJ2NHvkrd6hvsNrgQQfMxuFrkm/
 9/hWJFNntSbjhFBq0TFVaKUo8wkUbZ+dYFP3PyiTFhqs0t5yXGPb/EsOqLlmV4Iqc4T/
 9DFHU+iHNr3Heab5EarspZ+D0ud2wBN23Lt6EBL4zFp6qDoAvVJx/Hjog5NlNR/0h6Dh
 f3tkPZWqCJo1vqj1R0oPWITyVNyRsJEiRvmIUPlUFx+tziFfr6/GhYEcBb0TrEG3z3y4
 3Fkw==
X-Gm-Message-State: AGi0PuaqBuJ0kA3MNx38WpmFiPZpKGAOcgZf5AFBS3alX6W8JiThVwbF
 S0x/meX9DBpJgHXqvIoosmg=
X-Google-Smtp-Source: APiQypIbpLgJpdbpeYWo9ZAUxgCZWkG9tUrGULixnigRrb29PE2oLJLRqMxndIz35mYPDkr5aIwcKw==
X-Received: by 2002:a1c:4409:: with SMTP id r9mr3558645wma.165.1586931416766; 
 Tue, 14 Apr 2020 23:16:56 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q4sm22814647wmj.1.2020.04.14.23.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 23:16:55 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v3 02/24] scripts/coccinelle: Script to simplify
 DeviceClass error propagation
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-3-f4bug@amsat.org> <875ze2tfvc.fsf@dusky.pond.sub.org>
 <23ad6d04-1f42-29b8-caa6-6506cf1b7422@redhat.com>
 <87k12iqk9x.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <a7d6f3be-3e27-82e6-2828-7afc44aa3b52@amsat.org>
Date: Wed, 15 Apr 2020 08:16:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87k12iqk9x.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 3:17 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 4/14/20 2:24 PM, Markus Armbruster wrote:
>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>
>>>> When a device uses an Error* with data not modified before realize(),
>>>> this call can be moved to init(). Add a Coccinelle patch to find such
>>>> uses.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>   ...implify-init-realize-error_propagate.cocci | 69 +++++++++++++++++++
>>>>   MAINTAINERS                                   |  1 +
>>>>   2 files changed, 70 insertions(+)
>>>>   create mode 100644 scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>>>>
>>>> diff --git a/scripts/coccinelle/simplify-init-realize-error_propagate.cocci b/scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>>>> new file mode 100644
>>>> index 0000000000..2e3ec4d98a
>>>> --- /dev/null
>>>> +++ b/scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>>>> @@ -0,0 +1,69 @@
>>>> +// Find error-propagation calls that don't need to be in DeviceClass::realize()
>>>> +// because they don't use information user can change before calling realize(),
>>>> +// so they can be moved to DeviceClass:initfn() where error propagation is not
>>>> +// needed.
>>>> +//
>>>> +// Copyright: (C) 2020 Philippe Mathieu-Daudé
>>>> +// This work is licensed under the terms of the GNU GPLv2 or later.
>>>> +//
>>>> +// spatch \
>>>> +//  --macro-file scripts/cocci-macro-file.h \
>>>> +//  --sp-file \
>>>> +//    scripts/coccinelle/simplify-init-realize-error_propagate.cocci \
>>>> +//  --timeout 60
>>>> +//
>>>> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg692500.html
>>>> +
>>>> +
>>>> +@ match_class_init @
>>>> +TypeInfo info;
>>>> +identifier class_initfn;
>>>> +@@
>>>> +    info.class_init = class_initfn;
>>>> +
>>>> +
>>>> +@ match_instance_init @
>>>> +TypeInfo info;
>>>> +identifier instance_initfn;
>>>> +@@
>>>> +    info.instance_init = instance_initfn;
>>>> +
>>>> +
>>>> +@ match_realize @
>>>> +identifier match_class_init.class_initfn;
>>>> +DeviceClass *dc;
>>>> +identifier realizefn;
>>>> +@@
>>>> +void class_initfn(...)
>>>> +{
>>>> +    ...
>>>> +    dc->realize = realizefn;
>>>> +    ...
>>>> +}
>>>
>>> I'm afraid this misses realize() methods of DeviceClass subclasses.
>>> Consider PCI device "i6300esb" (picked just because it's simple).
>>>
>>> pci_device_class_init() sets DeviceClass method realize() to
>>> pci_qdev_realize().  pci_qdev_realize() does the work common to all PCI
>>> devices, and calls PCIDeviceClass method realize() for the work specific
>>> to the PCI device at hand.
>>>
>>> i6300esb_class_init() sets PCIDeviceClass method realize() to
>>> i6300esb_realize().
>>>
>>> Your first rule should match i6300esb_info alright, and thus identify
>>> i6300esb_class_init() as a class_init() method.
>>>
>>> But your third rule can't match i6300esb_class_init()'s
>>>
>>>      k->realize = i6300esb_realize;
>>>
>>> because @k is a PCIDeviceClass, not a DeviceClass.
>>>
>>> I think it also misses cases that have a realize(), but no
>>> instance_init().
>>>
>>> Finding only some instances of an anti-pattern can still be useful.  But
>>> you should explain the script's limitations then, both in the script and
>>> the commit message.
>>
>> OK.
>>
>>>
>>>> +
>>>> +
>>>> +@ propagate_in_realize @
>>>> +identifier match_realize.realizefn;
>>>> +identifier err;
>>>> +identifier errp;
>>>> +identifier func_with_errp =~ "(?!object_property_set_link)";
>>>
>>> What are you trying to accomplish with this lookahead assertion?
>>
>> "match all func_with_errp() except object_property_set_link()"?
> 
> What's wrong with
> 
>     identifier func_with_errp != object_property_set_link

Nothing wrong, I didn't know this form by the time I wrote this script.

> 
> ?
> 
> [...]
> 

