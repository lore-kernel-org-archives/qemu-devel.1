Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B82C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798112072C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 08:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd2gd3yR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798112072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEqmi-0004ht-K4
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 04:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEqm9-0004IA-2g
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEqm7-0006Nq-L6
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:43:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:41235)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEqm7-0006NG-HZ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 04:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584607414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8ZQqYkhcEYhw+M2bVBClBKrINQ/xOW5BuuEacsqnks=;
 b=Vd2gd3yRmqKKkVsBsvtXB4B9571XPRp4ygZWPdNLmuto0+gydSSlW9Cs1qiEVo8ExN73c9
 NOdxVHO/fdn2q6XIwGrleUFHDPWtn5A2AkLSHH2elSMLzqayTLTJrfKO2o/dom1zor6hRs
 OWSWCONwP3qyWrm4BP6xCDAE2TvcCoI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-l9PQo22hN_CxZrGMPvVSlw-1; Thu, 19 Mar 2020 04:43:33 -0400
X-MC-Unique: l9PQo22hN_CxZrGMPvVSlw-1
Received: by mail-wr1-f71.google.com with SMTP id t4so665922wrr.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 01:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z8ZQqYkhcEYhw+M2bVBClBKrINQ/xOW5BuuEacsqnks=;
 b=NPViBdhDk93Bb6t0XRM/JnRV05R+BgX9za7o8gfPmKrgLeTXI8/xRsuZ64nFhkj8t5
 NnLv5/Rg/Sm2MpVINk+oAJBkcEPTkmJKyetJzh4o3V3C7YgGbTCDLy/Ts3B3Q5jWhiWA
 dmMOTzqc1DJXdf37VD/99udGUnbZZRlsUb9KVIn5P5sEE8ttYziQaR1wNd/Tsvrvn8Vb
 GAs0OQ9v4l/3d4ltksCFlFPuyiEDXM/PKci2Swq0RoO5daO03rK9p2MsHlm1CzYzE6Kx
 WXlU4esX8s95BkT44Ae41vmlVa2W+bpR1CHosw43YaSYPzkcT7EOR8R/GDGX8V8n/UtI
 DTuw==
X-Gm-Message-State: ANhLgQ1pCyw0PxX+851B8UMTy/ipXhKMPWPX7VTqvtKriF2ygcqziS/K
 sdcKPfN8DjZIt2SScCTdhH4NH0qq4404D/YSaRFAXi5FfBPJEp6AOpMQzyxw9ESG3AsBDf+l5ib
 R+MYFH3pVQIOyrbY=
X-Received: by 2002:a5d:4c48:: with SMTP id n8mr923316wrt.414.1584607411820;
 Thu, 19 Mar 2020 01:43:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtKVk9kNTz3f/Fx7E5wrRL5ktfxC9Oi4ustwpoPd8Jcw4NW7RWJlwE8/VgVK1FSSNLX8e5YXA==
X-Received: by 2002:a5d:4c48:: with SMTP id n8mr923278wrt.414.1584607411503;
 Thu, 19 Mar 2020 01:43:31 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id i8sm2346449wrw.55.2020.03.19.01.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 01:43:30 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] mac_via: fix incorrect creation of mos6522 device
 in mac_via
To: Markus Armbruster <armbru@redhat.com>
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <20200305065422.12707-3-pannengyuan@huawei.com>
 <CAFEAcA_twjUHpvf5ZpzA_bKyf8MZ4BuSY0MvNTgSEyVTYf9mXQ@mail.gmail.com>
 <0b2d3222-d122-e0db-db04-1c4e3028f8f8@huawei.com>
 <CAFEAcA9PQd=PwuF+j=3kOA_eCiRd_8TLEwPx8qB-jWvV_9CcMQ@mail.gmail.com>
 <0c3ae5aa-36c3-a809-4a42-159348f44780@huawei.com>
 <CAFEAcA8_RkECOT=YJ3ML0wxBrKiqVw=CssORU=jyryfcNueB0w@mail.gmail.com>
 <871rq08tn9.fsf@dusky.pond.sub.org>
 <eca27715-554d-2c2e-5e58-ffd01abb654c@ilande.co.uk>
 <e1ae65dd-f9cd-b0ee-0ea6-f3c2b010fdab@redhat.com>
 <87tv2p8y5j.fsf@dusky.pond.sub.org>
 <3f512e33-5875-eee4-bbe8-61e7b313743d@redhat.com>
 <87mu8g3kgj.fsf@dusky.pond.sub.org>
 <bd83fe53-6541-b04d-04d9-76ddd29e2b99@redhat.com>
 <875zf1ak9e.fsf@dusky.pond.sub.org>
 <d94927af-eb46-f704-6658-e3f321c4d8ed@redhat.com>
 <87d0997lei.fsf@dusky.pond.sub.org>
 <37da8765-267e-948b-a96f-24c43be7573f@redhat.com>
 <87v9n025hc.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ae352b1-2653-c69f-f2b7-73e86b804d13@redhat.com>
Date: Thu, 19 Mar 2020 09:43:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87v9n025hc.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/03/20 08:01, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 18/03/20 16:06, Markus Armbruster wrote:
>>>> - object initialization should cause no side effects outside the subtree
>>>> of the object
>>>
>>> object_initialize_child() and its users like sysbus_init_child_obj()
>>> violate this rule: they add a child property to the subtree's parent.
>>> Correct?
>>
>> At least object_initialize_child() adds the property to the object
>> itself, so it's fine.
> 
> It seems to
> 
> 1. Initialize @childobj
> 2. Set a bunch of properties
> 3. Add the child property to @parentobj
> 4. Call .complete() if it's a TYPE_USER_CREATABLE
> 5. Adjust reference count
> 
> Step 3. modifies outside the sub-tree rooted at @childobj.  What am I
> missing?
> 
> Hmm, maybe this: using object_initialize_child() when initializing
> @parentobj is fine; while object_initialize_child() leaves the sub-tree
> rooted at @childobj, it still stays within the sub-tree rooted at
> @parentobj.
> 
> If this is how the function must be used, its contract should spell it
> out!

Yes, this is what I meant.

>>>> - realization can also cause side effects outside the subtree of the
>>>> object, but if unrealization is possible, they must be undone by
>>>> unrealization. if an object is realized and unrealization is not
>>>> possible, finalization will never run (and in that case, side effects of
>>>> realization need not be undone at all).
>>>
>>> One possible answer the question what should be done in realize() is
>>> whatever must not be done earlier.  Is that the best we can do?
>>
>> That's the lower bound of descriptivity.  The upper bound is anything
>> that is visible from the guest.  The truth could be in the middle.
> 
> Can we set aside a bit of time to write docs/devel/qom.rst together?  I
> know object.h is lovingly commented, but unless you already know how QOM
> works, you're drowning in detail there.  You'd have to provide most of
> the contents, I'm afraid, because you know so much more about it.  Could
> save you time in the long run, though: fewer questions to answer, fewer
> mistakes to correct.

Yes, this is sorely needed.  I will do it; if you have more random
questions you'd like an answer for, that can help.  I can then stitch
them together in a coherent text.

Paolo


