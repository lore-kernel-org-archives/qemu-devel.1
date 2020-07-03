Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C11C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6B020936
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGM9Pl9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6B020936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJRh-0008Mh-9U
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 07:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrJQq-00079W-Em
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:00:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22341
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrJQn-0000xl-Lg
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593774032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rTNIzhaoBchyTkWYudp0oPId1KCU/mxL83twpGFjZWo=;
 b=WGM9Pl9P+hCwMXs4OGECBLVgDlco/GNqqn57+IzFpr5B1uy79VTYULReMmUoZtHLoOcK9K
 F+mvTk+REhS0JqN8hRJbmtsZY46xZ4r153gGJQeEDBgsyPLPAODm4dXO57PIXrKSVO2T4V
 ftZm9wJiT1deJHOd+Su5JoYyAoYOdAE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-WESM4ae6MU2XoWty6UhMiA-1; Fri, 03 Jul 2020 07:00:30 -0400
X-MC-Unique: WESM4ae6MU2XoWty6UhMiA-1
Received: by mail-wm1-f72.google.com with SMTP id v6so32438561wmg.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 04:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rTNIzhaoBchyTkWYudp0oPId1KCU/mxL83twpGFjZWo=;
 b=dM0QfcZVO1NqktlgbEpPhd5ysxB5nwk9CFDI9d10b9+3/XxF1GzCJUTZq9kJ90l/N8
 8+MEgN6NV9V3SCVEc0as5NUo14dDzsG0pr5LXold9ExM3CZ3C0GNgOfehAG77jNmL6H0
 12tFxudan+vJOui9ltLPl/8nOV+J6AFHmV/F6qCH/0FXpnQJN+gixxy5SqFeuX3tImwB
 tJTObRAssidaxGnDY77QyXmb4Ld5+uE2CmDzM+7ARKETeMHfhcHbIsSRWDdx2ouL8hAZ
 INCC71gMDxU0Q7CjRxnMfUu7BwxhOGmDKoV2xCi9I8iZwF39WxZwKplsSZ9jXf+ixIUZ
 5bRA==
X-Gm-Message-State: AOAM532HhpfkGy9fMvLuJLzVFU4D8YOokr3YpdDUAQUceYLb64tElEaE
 GQPQid0tIIxSGpYZQ5D3bCHcI110aMT+aeD3jMknTyKntaN5SiSLSnapspGEBJOnHnADeZ6XCj0
 S+mS2MIyTwEyJCmQ=
X-Received: by 2002:a5d:4051:: with SMTP id w17mr34622560wrp.183.1593774029691; 
 Fri, 03 Jul 2020 04:00:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF0NSrs1DUrniIBJxYZrIfIg6m2vVw9RyEACThPoKCbsOfEoSj4vt1cLw4H+bRV4lkIDEvgQ==
X-Received: by 2002:a5d:4051:: with SMTP id w17mr34622544wrp.183.1593774029461; 
 Fri, 03 Jul 2020 04:00:29 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g14sm9831280wrw.83.2020.07.03.04.00.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 04:00:28 -0700 (PDT)
Subject: Re: [PATCH v2 14/18] hw/block/nvme: support identify namespace
 descriptor list
To: Klaus Jensen <its@irrelevant.dk>
References: <20200703063420.2241014-1-its@irrelevant.dk>
 <20200703063420.2241014-15-its@irrelevant.dk>
 <1a1e7fdf-6e87-aa6b-f687-cc6d98297efe@redhat.com>
 <20200703100002.aufq55fja2gktfl6@apples.localdomain>
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
Message-ID: <b5b4fcaa-293b-4b87-338d-240da908ce4e@redhat.com>
Date: Fri, 3 Jul 2020 13:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200703100002.aufq55fja2gktfl6@apples.localdomain>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 12:00 PM, Klaus Jensen wrote:
> On Jul  3 10:27, Philippe Mathieu-Daudé wrote:
>> On 7/3/20 8:34 AM, Klaus Jensen wrote:
>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>
>>> Since we are not providing the NGUID or EUI64 fields, we must support
>>> the Namespace UUID. We do not have any way of storing a persistent
>>> unique identifier, so conjure up a UUID that is just the namespace id.
>>>
>>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>>> Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
>>> ---
>>>  hw/block/nvme.c       | 41 +++++++++++++++++++++++++++++++++++++++++
>>>  hw/block/trace-events |  1 +
>>>  2 files changed, 42 insertions(+)
>>>
>>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>>> index 8230e0e3826b..65c2fa3ac1f4 100644
>>> --- a/hw/block/nvme.c
>>> +++ b/hw/block/nvme.c
>>> @@ -971,6 +971,45 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, NvmeIdentify *c)
>>>      return ret;
>>>  }
>>>  
>>> +static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c)
>>> +{
>>> +    uint32_t nsid = le32_to_cpu(c->nsid);
>>> +    uint64_t prp1 = le64_to_cpu(c->prp1);
>>> +    uint64_t prp2 = le64_to_cpu(c->prp2);
>>> +
>>> +    uint8_t list[NVME_IDENTIFY_DATA_SIZE];
>>> +
>>> +    struct data {
>>> +        struct {
>>> +            NvmeIdNsDescr hdr;
>>> +            uint8_t v[16];
>>
>> You might consider to use QemuUUID from "qemu/uuid.h". The benefits
>> are you can use qemu_uuid_parse() qemu_uuid_unparse*() for tracing,
>> and DEFINE_PROP_UUID() in case you want to set a particular UUID
>> from command line, it case it is important to the guest.
>>
> 
> Yes, definitely. Niklas also does this in his patch for namespace types
> support. And I think that it's very important that it can be made
> persistent, which would require a device property.
> 
> Thus, if it is OK with the rest of you, I would like to defer this to
> when we merge the multiple namespaces patch and add "uuid" as a nvme-ns
> device property there. Then, we do not have to add the uuid property on
> the nvme device now and then have to keep it around when the namespace
> related properties moves to the nvme-ns device.

No objection, it was a simple suggestion to consider for later ;)


