Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FD9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A9124673
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOfu3CSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A9124673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuH3A-00005I-Jw
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuH2C-00082C-HE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuH2B-0005rN-GT
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:31:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuH2B-0005rB-CY
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579703466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIrJCsgAFj1IC1oBVsYuhnWPUJOsAwo6ljpfDhFZC/U=;
 b=cOfu3CSLioLAVRvjO3nXP64vb820mnkuPDy3bRZw4FhuYRsL3HI6Bjn6bg8DGd81gzdyIR
 i915JgGuov5MQU3600ohCgqhMpH29B8H5boH2dkkUUef7Q0qlK/zLUsPP2d9Ay+VSs9C6n
 67oxgCy2Lodaps/bU1ERuWITk5cFgAs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-9AjhT47WMOas3VLccgdWlw-1; Wed, 22 Jan 2020 09:31:04 -0500
Received: by mail-wm1-f69.google.com with SMTP id o24so1458194wmh.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 06:31:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zIrJCsgAFj1IC1oBVsYuhnWPUJOsAwo6ljpfDhFZC/U=;
 b=AQZ+JQ/vcasbKuHQz5MzLw9dai/ShjRBBfZQIuOZfXvRIha+wulh+B9fnw/NClWuzf
 bZ4WqY9rRUqxf92L9AQFOsEm1q3y1Xx7z4fpzYCPsBf6lnatBNipvLs8jL9f/tsqsVGE
 aHNsB17ZsaDZaKX77j4VF6KY9U+V7sp3l5/Wvu06SSQ7Q8tXH2uNnlqCaggIqsinvr7l
 K4vD2smZgjxTGrhOAB5peCuIvcTO9zE64NynXZvJgGJ1h5H91revgFTLpTXIYLqlcR+b
 mrcXRJa+DWw8tgN+3jlAHZCO2TzU/AoeWlnZqEXk3Q43YqmM0oLRYG90DtrL8gro2pB7
 gcZg==
X-Gm-Message-State: APjAAAXqpR4road+k4FFGntcRelLs2ghBtLD36PUWcFn4al4CQfVhIFF
 RI98ZCMHSTztQYuLACqKboPY86EY3AcrN60rAZTG2xN+6O7ZH/vu+k6DEjk+2wE7DUhnAnFYhoF
 Ymt3UaGVWWiJggYM=
X-Received: by 2002:a5d:480f:: with SMTP id l15mr11221705wrq.305.1579703463143; 
 Wed, 22 Jan 2020 06:31:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5oko7oRevU9TE0HFFoX92Xgi6kSi3Gjw53NrZ+NVvkDt60pnn9wQz9X/LzQxxFkIkFKqttA==
X-Received: by 2002:a5d:480f:: with SMTP id l15mr11221675wrq.305.1579703462780; 
 Wed, 22 Jan 2020 06:31:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id t25sm4226602wmj.19.2020.01.22.06.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 06:31:02 -0800 (PST)
Subject: Re: [RFC PATCH] qapi: Incorrect attempt to fix building with
 MC146818RTC=n
To: Markus Armbruster <armbru@redhat.com>
References: <20191231184916.10235-1-philmd@redhat.com>
 <875zhfzc9l.fsf@dusky.pond.sub.org>
 <a06fd97c-b149-2f24-1180-4e4efa8ff79d@redhat.com>
 <87wo9ll5on.fsf@dusky.pond.sub.org>
 <b0559940-7b97-901b-5729-587d8649eede@redhat.com>
 <87lfq0c2jq.fsf@dusky.pond.sub.org>
 <CABgObfaPrbbx6Bw0Cj14evAvA_TSUo-+iOCkBzEBfPVn6qDLBg@mail.gmail.com>
 <87tv4oyrnj.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b991266-de2a-a9a6-ef68-1791f7bd838b@redhat.com>
Date: Wed, 22 Jan 2020 15:30:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87tv4oyrnj.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: 9AjhT47WMOas3VLccgdWlw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/01/20 06:41, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Il mar 21 gen 2020, 15:22 Markus Armbruster <armbru@redhat.com> ha scritto:
>>
>>>> To see it a different way, these are the "C bindings" to QMP, just that
>>>> the implementation is an in-process call rather than RPC.  If the QAPI
>>>> code generator was also able to generate Python bindings and the like,
>>>> they would have to be the same for all QEMU binaries, wouldn't they?
>>>
>>> Ommitting the kind of #if we've been discussing is relatively harmless
>>> but what about this one, in qapi-types-block-core.h:
>>>
>>>     typedef enum BlockdevDriver {
>>>         BLOCKDEV_DRIVER_BLKDEBUG,
>>>         [...]
>>>     #if defined(CONFIG_REPLICATION)
>>>         BLOCKDEV_DRIVER_REPLICATION,
>>>     #endif /* defined(CONFIG_REPLICATION) */
>>>         [...]
>>>         BLOCKDEV_DRIVER__MAX,
>>>     } BlockdevDriver;
>>>
>>
>> Well, I don't think this should be conditional at all. Introspection is a
>> tool to detect unsupported features, not working features.
> 
> Isn't this what it does?  To detect "replication" is unsupported, check
> whether it's absent, and "supported" does not imply "works".

Indeed...

>>                                                            KVM will be
>> present in introspection data even if /dev/kvm doesn't exist on your
>> machine or you don't have permission to access it.
> 
> Yes.
> 
> QAPI/QMP introspection is compile-time static by design.  It can't tell
> you more than "this QEMU build supports X".

... and I think it would be fine even if it told you less: "this QEMU
will not give a parse error if X appears in QMP syntax".  For example,
QEMU could accept "replication" even if CONFIG_REPLICATION is not
defined and therefore using it would always fail.  This would allow
limiting even more use of conditional compilation.

Paolo


