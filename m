Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61214C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D3423E20
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eg1DwKrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D3423E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpuwZ-0001ir-Ex
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpuvR-0001AD-HP
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:38:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30487
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jpuvO-0000iO-NK
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593441501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cLOOyvaytaqcDtH/vAVhEV8MPLcv4a6nZ6cc6VeYoGQ=;
 b=eg1DwKrqhHKlnH5VDSUkU1Fyvkeh3ZpeERL2u1GORdUNDn121fIvXWQyrdiFxZczM8+DKw
 v7PUMdLTG/Hs4USQIFOLSf7NzJo3MsCmFp6UR957U48tye5jpmOkdHnJEXL9oU9tttjrOv
 T21GEr8e/2iYXkbN8jMLDHd5Nlgc6gQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-AsUfiR2-ObC3cz6Bl2BkFQ-1; Mon, 29 Jun 2020 10:38:19 -0400
X-MC-Unique: AsUfiR2-ObC3cz6Bl2BkFQ-1
Received: by mail-ej1-f69.google.com with SMTP id l18so3037943ejn.17
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 07:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=cLOOyvaytaqcDtH/vAVhEV8MPLcv4a6nZ6cc6VeYoGQ=;
 b=iDFXrC191FBZRELh2bM06dqWcKz3M8yC+ZPIaUCjTldMVvMNta87QAKaCLb7VpY54n
 C64xDnOc2RT6VuJeBsPWQTS5wA5Ch185Rk6/GArw3ZZsobaPSbeSLVuz8ypHmaL3I8Mz
 fbwXgM7/L4hj4HB4ZW2hC57e8pEfo18yvHsg6OifLWQ+kveyE6qqO+C+Ig//sUvMQEzn
 kZHaSy9dJPkfegn6XHhFBDTwPc5BRlXB69Dx9TDQ1ZTmBJKzOkWJ6bHhMQ+YEjVzA8M4
 drcCzwWlST3rAbhdwb07t1n+zpSYY3t9KNYUispzshRTrsc3rRGllTymUgBsfQ6M6qOk
 y5TQ==
X-Gm-Message-State: AOAM531cK0qIXnu9VQHy0T6UZQh0E40HO2a0T116Yq+fYnV27NrzOppk
 cIfwx5H6EiR1dgw3gtMgFAaORC6JQOnFE3beiYOIuwN6G+2aOmVPC7OpDqMywOBa6GIE84ynyhu
 CKBnB0vWJ+FeyPg0=
X-Received: by 2002:a17:906:ad9:: with SMTP id
 z25mr14265652ejf.53.1593441498508; 
 Mon, 29 Jun 2020 07:38:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz4eUQIawiA2bZBn+5iZQxLkULd2UQX12SJqcCDEw1MOQO7zKo08cXXXGEiSqIFtzd2rWu3Q==
X-Received: by 2002:a17:906:ad9:: with SMTP id
 z25mr14265617ejf.53.1593441498124; 
 Mon, 29 Jun 2020 07:38:18 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id fi29sm12822318ejb.83.2020.06.29.07.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 07:38:17 -0700 (PDT)
Subject: Re: [PATCH 34/46] qom: Don't handle impossible
 object_property_get_link() failure
To: Markus Armbruster <armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-35-armbru@redhat.com>
 <4c1644b4-4d30-9831-9484-dc32081f41db@redhat.com>
 <87d05nxjv3.fsf@dusky.pond.sub.org>
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
Message-ID: <fcbda85c-32ef-5fa4-bf87-1b5060f33421@redhat.com>
Date: Mon, 29 Jun 2020 16:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87d05nxjv3.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 5:09 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 6/24/20 6:43 PM, Markus Armbruster wrote:
>>> Don't handle object_property_get_link() failure that can't happen
>>> unless the programmer screwed up, pass &error_abort.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  hw/arm/bcm2835_peripherals.c |  7 +------
>>>  hw/arm/bcm2836.c             |  7 +------
>>>  hw/display/bcm2835_fb.c      |  8 +-------
>>>  hw/dma/bcm2835_dma.c         |  9 +--------
>>>  hw/gpio/bcm2835_gpio.c       | 15 ++-------------
>>>  hw/intc/nios2_iic.c          |  8 +-------
>>>  hw/misc/bcm2835_mbox.c       |  9 +--------
>>>  hw/misc/bcm2835_property.c   | 17 ++---------------
>>>  hw/usb/hcd-dwc2.c            |  9 +--------
>>>  9 files changed, 11 insertions(+), 78 deletions(-)
>>>
>>> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
>>> index 8313410ffe..3c40bda91e 100644
>>> --- a/hw/arm/bcm2835_peripherals.c
>>> +++ b/hw/arm/bcm2835_peripherals.c
>>> @@ -134,12 +134,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
>>>      uint64_t ram_size, vcram_size;
>>>      int n;
>>>  
>>> -    obj = object_property_get_link(OBJECT(dev), "ram", &err);
>>> -    if (obj == NULL) {
>>> -        error_setg(errp, "%s: required ram link not found: %s",
>>> -                   __func__, error_get_pretty(err));
>>> -        return;
>>> -    }
>>> +    obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
>> [...]
>>
>> Should we now add an assert(errp) in object_property_get_link()?
>> Basically this would force forks to adapt their code when
>> rebasing.
> 
> Functions should not place additional restrictions @errp arguments
> without a compelling reason.

My compelling reason is you spent quite some time cleaning, then we'll
merge old patches based on examples previous your cleanup, and either
you'll have to clean again, or the codebase will get inconsistent again.

> What if you want genuinely don't need the
> error details when object_property_get_link() fails?  Passing null is
> better than passing &err only to error_free(err).

So what about:

-- >8 --
--- a/qom/object.c
+++ b/qom/object.c
@@ -1372,9 +1372,11 @@ void object_property_set_link(Object *obj, Object
*value,
 Object *object_property_get_link(Object *obj, const char *name,
                                  Error **errp)
 {
-    char *str = object_property_get_str(obj, name, errp);
+    char *str;
     Object *target = NULL;

+    assert(errp == NULL || errp == &error_abort || errp == &error_fatal);
+    str = object_property_get_str(obj, name, errp);
     if (str && *str) {
         target = object_resolve_path(str, NULL);
         if (!target) {
---

> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks!
> 


