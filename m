Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:35:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D322074F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRPrmLTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D322074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcA8S-0001qe-Rj
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcA7U-0001PH-0h
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:34:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcA7P-0003bs-Li
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604939648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuTskqG7CeOvGvORNcuUc81r+cD1h1D/Rw69tQidb4w=;
 b=CRPrmLTtbD6MLhXbgwTAiCrwjMeXtbQd6/I33BOmd0DRd5n1I2TpeKRwr+wTiZce77d0vN
 mRJyvFZ/xHoJaWgaX4VfwFTfblIVGYDOg3W2zMAMP3ShQOCHZRQiJ824VlVXOIugTKrbPz
 9S9d7fzXu7+YuoG06EJ1zKXG4iy4IwY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-SvGWh3eaNjy8VZYBi6M06Q-1; Mon, 09 Nov 2020 11:34:05 -0500
X-MC-Unique: SvGWh3eaNjy8VZYBi6M06Q-1
Received: by mail-wr1-f70.google.com with SMTP id t17so4558463wrm.13
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 08:34:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LuTskqG7CeOvGvORNcuUc81r+cD1h1D/Rw69tQidb4w=;
 b=V6nHT/lb63DZ+PNhlP1br0itu93BTHJnIrZeLSKD27sz3PhW9QZSTg4WCKNTSTcS3h
 83VmN5l+ZtwMkTX+DbNdr1LUJICqW7IqTDPk7jwUUNWWLRljPf0AzdSqxoMIlpLFpOdU
 jBKsEDubgg2/bjfCtIe4W7MxFsIEH3RGn7RuU0gIqDIX6O7Q1dkljROPR+wBmUxiSFKn
 MN+kttSozZl0itfX1mukF1sTKR9LAcISqXlbeFxzUmO5Gfe2u7J2FmKDrvb4ZXUeKreh
 wUArPPEgt9lQbea8D5pLRF8JRFwCQN7hojp1lRr27tNtr48/2qy80p/f7bsxwHi0TxZ0
 b3Og==
X-Gm-Message-State: AOAM533d6O62goSD+OoA+kZG0Ll+Q/j1qhLf6obnkmfws0aEeih5O/y6
 xbHOwfHCBoJ6KlZ1OHmrQyxic5VMQd+u8YY/pIzBjYlvR942X44B8Q98RbgI5EIoXgay9mMKQNd
 fkHDfIaXrqkZS4XE=
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr20143wmg.18.1604939643730;
 Mon, 09 Nov 2020 08:34:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBSkVQTmgpLtrGbJ1H7Qhrm/t+BIcrwvuzhgkmHXV8gIUKDSd28vx8U5gMyf+lDNo5x7PiHw==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr20110wmg.18.1604939643505;
 Mon, 09 Nov 2020 08:34:03 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id t15sm13110582wmn.19.2020.11.09.08.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 08:34:02 -0800 (PST)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201106094511.GA23864@merkur.fritz.box> <20201106155013.GX5733@habkost.net>
 <20201106211034.GY5733@habkost.net>
 <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
 <20201109113404.GA24970@merkur.fritz.box>
 <3b711053-e67a-86fb-59e7-c06948dd8928@redhat.com>
 <20201109152125.GZ5733@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <2300fd53-afa1-b957-b33b-cff2986fcb93@redhat.com>
Date: Mon, 9 Nov 2020 17:34:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109152125.GZ5733@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 16:21, Eduardo Habkost wrote:
> On Mon, Nov 09, 2020 at 03:15:26PM +0100, Paolo Bonzini wrote:
>> On 09/11/20 12:34, Kevin Wolf wrote:
>>>> If all properties were like this, it would be okay.  But the API in v2 is
>>>> the one that is most consistent with QOM in general. Here is how this change
>>>> would be a loss in term of consistency:
>>>>
>>>> - you have the field properties split in two (with the property itself in
>>>> one place and the allow-set function in a different place), and also you'd
>>>> have some properties listed as array and some as function calls.
>>>
>>> Why would you have properties defined as function calls for the same
>>> object that uses the array?
>>
>> Because some properties would not be field properties, for example.  For
>> example, any non-scalar property would need to invoke visit_SomeQapiStruct
>> manually and would not be a field property.
> 
> Nothing prevents us from describing those properties inside the
> same property array.

Do you mean adding PropertyInfos for them?  Adding a once-only 
PropertyInfo is worse than writing a custom getter/setter pair, because:

- without (DEFINE_)PROP_* you lose the type safety.

- with (DEFINE_)PROP_* you have much more boilerplate to write

> More precisely, it is
>    device_class_set_props(dc, foo);
> 
> which is supposed to become a one-line wrapper to
> object_class_add_field_properties().

You're right, I'm a few years late.  So that objection is withdrawn.

> (There's also the possibility we let the class provide a default
> allow_set function, and both would become 100% the same)

That's a possibility too.  Though if we ever have a need for multiple 
allow_set functions it would be somewhat complicated to add it back.

Instead of class-wide allow_set, we might as well have a "bool 
constructed" field in Object and remove the function pointer altogether: 
just replace prop->allow_set(obj) with just "!obj->constructed".

>>> I think having different ways for different things (class vs. object) is
>>> better than having different ways for the same things (class in qdev vs.
>>> class in non-qdev).
>>
>> Right, but qdev's DEFINE_PROP_STRING would be easy to change to something
>> like
>>
>> - DEFINE_PROP_STRING("name", ...),
>> + device_class_add_field_property(dc, "name", PROP_STRING(...));
> 
> I'm not worried about this direction of conversion (which is
> easy).  I'm worried about the function call => QAPI schema
> conversion.  Function calls are too flexible and requires parsing
> and executing C code.

Converting DEFINE_PROP_STRING to a schema also requires parsing C code, 
since you can have handwritten Property literals (especially for custom 
PropertyInfo).  Converting DEFINE_PROP_STRING it also requires matching 
the array against calls to object_class_add_field_properties (which 
could be hidden behind helpers such as device_class_set_props).  (Plus 
matching class_init functions against TypeInfo).

So, you don't save any parsing by using arrays.  (In fact I would 
probably skip the parsing, and use your suggestion of *executing* C 
code: write the QAPI schema generator in C, link into QEMU and run it 
just once to generate the QOM schema).

QOM has been using function calls for many years, are there any cases of 
misuse of that flexibility that you have in mind?  I can only think of 
two *uses*, in fact.  One is eepro100_register_types is the only case I 
can remember where types are registered dynamically.  The other is S390 
CPU features.  In fact,

   $ git grep \ object_class_property_add|grep -v '([a-z0-9_]*, \"'

shows some cases where property names are macros (an mst-ism :), but no 
other case where properties are being defined dynamically.

Paolo


