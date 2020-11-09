Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1875C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677F420674
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/ffNnRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677F420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc88l-0006BD-B4
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7xK-0000ue-Ep
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:15:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kc7xE-0004Ti-Uu
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604931330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NaSp7Bh9QQ4DPDIisOAZjOlCIiXchQ7pjnLwgOZrjS4=;
 b=U/ffNnRRcYpP3BYzaF4v5rpzC+E0k0EnbPKKARsH56Ed05Jc4zQBdfOnHYQNznW8jI5HeH
 n5Tf4b4S4QiXujYTDo9CVkyc4S8P4LH2WpHA0B9wNB2N8sBtOY3f13XUORupNT6pgZy3gY
 wiC54cTs6sCmkye2XbcRjkQxR2uPKis=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-m6T3sKWdPtSFsVDHy4n9hg-1; Mon, 09 Nov 2020 09:15:29 -0500
X-MC-Unique: m6T3sKWdPtSFsVDHy4n9hg-1
Received: by mail-wm1-f70.google.com with SMTP id e15so2081195wme.4
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NaSp7Bh9QQ4DPDIisOAZjOlCIiXchQ7pjnLwgOZrjS4=;
 b=r2aEKO/BXxRxwOR7ZjMQyvO837sKvw2PycZp2x54W9XONvsLwKjasSXXmJmuhZKckM
 Ek4xiqU+NLUtKHDvp6IP1ScbnVihUijvKGqypaGvH6KTTiIqckAIPgvLYcLVrXDHhHgz
 hnZUeN5ksMLcVl8WDTB1huIpWB0HfPd7cLvmQnBELwQLV2Irlw+7hsFDoyPeI7EoYudK
 OhGQDdlAYQK3Kj3qJVkOO1/mbq+JOhNgOCt7ad8+wh222ezXw6jDAUqZp1Tir6/BB1+X
 ZmzcwKAvYRHbhs97SDn0rxMeKOPN2UNLg33P2exFENZfqvEsDv6HOlRePyMvurbH3Ajo
 LEtQ==
X-Gm-Message-State: AOAM533doGyAyo4943dJ06lBxLl2qPvgCisDlERAwLtOPQXrIJAO50xL
 OFQIWEQDxpd5i8xIsx4uNaH9VPERG0XYRUAsYn182eZToKzXQomCtueKMjSwWWRv11ELKC2uU7G
 3ArkMgMsMq8WyYk8=
X-Received: by 2002:a1c:1906:: with SMTP id 6mr14401894wmz.87.1604931328143;
 Mon, 09 Nov 2020 06:15:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPYUjbIKjISM5qezNJhnaZziIOv2RY7v5LEJX11UVHPuJkbx8rdHibH6d9ZuaGeCO80ZKoxw==
X-Received: by 2002:a1c:1906:: with SMTP id 6mr14401876wmz.87.1604931327946;
 Mon, 09 Nov 2020 06:15:27 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id v9sm13253612wrp.11.2020.11.09.06.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 06:15:27 -0800 (PST)
To: Kevin Wolf <kwolf@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201106094511.GA23864@merkur.fritz.box> <20201106155013.GX5733@habkost.net>
 <20201106211034.GY5733@habkost.net>
 <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
 <20201109113404.GA24970@merkur.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <3b711053-e67a-86fb-59e7-c06948dd8928@redhat.com>
Date: Mon, 9 Nov 2020 15:15:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109113404.GA24970@merkur.fritz.box>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 12:34, Kevin Wolf wrote:
>> If all properties were like this, it would be okay.  But the API in v2 is
>> the one that is most consistent with QOM in general. Here is how this change
>> would be a loss in term of consistency:
>>
>> - you have the field properties split in two (with the property itself in
>> one place and the allow-set function in a different place), and also you'd
>> have some properties listed as array and some as function calls.
> 
> Why would you have properties defined as function calls for the same
> object that uses the array?

Because some properties would not be field properties, for example.  For 
example, any non-scalar property would need to invoke 
visit_SomeQapiStruct manually and would not be a field property.

> I'm not entirely sure what you mean with allow-set. The only things I
> can find are related to link properties, specifically the check()
> callback of object_class_property_add_link(). If it's this, what would
> be the problem with just adding it to DEFINE_PROP_LINK instead of
> using a separate function call to define link properties?

Eduardo's series is adding allow-set functions to field properties as 
well.  If it's be specified in the function call to 
object_class_add_field_properties, you'd have part of the property 
described in the array and part in the object_class_add_field_properties.

>> - we would have different ways to handle device field properties (with
>> dc->props) compared to object properties.
> 
> You mean dynamic per-object properties, i.e. not class properties?

No, I mean that device properties would be handled as

    dc->props = foo;

while object properties would be handled as

    object_class_add_field_properties(oc, foo, prop_allow_set_always);

There would be two different preferred ways to do field properties in 
qdev vs. non-qdev.

> I think having different ways for different things (class vs. object) is
> better than having different ways for the same things (class in qdev vs.
> class in non-qdev).

Right, but qdev's DEFINE_PROP_STRING would be easy to change to 
something like

- DEFINE_PROP_STRING("name", ...),
+ device_class_add_field_property(dc, "name", PROP_STRING(...));

>> The choice to describe class properties as function calls was made in 2016
>> (commit 16bf7f522a, "qom: Allow properties to be registered against
>> classes", 2016-01-18); so far I don't see that it has been misused.
> 
> This was the obvious incremental step forward at the time because you
> just had to replace one function call with another function call. The
> commit message doesn't explain that not using data was a conscious
> decision. I think it would probably have been out of scope then.
> 
>> Also, I don't think it's any easier to write an introspection code generator
>> with DEFINE_PROP_*.  You would still have to parse the class init function
>> to find the reference to the array (and likewise the TypeInfo struct to find
>> the class init function).
> 
> I don't think we should parse any C code. In my opinion, both
> introspection and the array should eventually be generated by the QAPI
> generator from the schema.

That'd be a good plan, and I'd add generating the property description 
from the doc comment.  (Though there's still the issue of how to add 
non-field properties to the introspection.  Those would be harder to 
move to the QAPI generator).

But at that point the array vs. function call would not change anything 
(if anything the function call would be a tiny bit better), so that's 
another reason to stay with the API that Eduardo has in v2.

Paolo


