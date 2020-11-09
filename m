Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70021C5517A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08242065D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUZLiw5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08242065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcCpv-0006sF-1R
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 14:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcCpH-0006Qd-WA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcCpC-0007me-JU
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 14:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604950047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9gmQbYqnhuFlpWBc8RPXaIWVHHk5+Qz4AUTu4B4Dck=;
 b=RUZLiw5O6quaomWjYfMzCCaeIjE6MRiKkJskzJHtTmph2bLI6EvX6n5krdRcCK7q1BeFul
 7CB1VRMj+A6ct7g0/kYK7vBgSLC/vCplNBM4IBstp9XG8+B+BMdm5XkqGHIqGtMEXwLjee
 kaRDHyVw/4kvBJE8SgwqhQYvOdAMPwE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-983ewky4O7K1199-koBbIA-1; Mon, 09 Nov 2020 14:27:25 -0500
X-MC-Unique: 983ewky4O7K1199-koBbIA-1
Received: by mail-wr1-f71.google.com with SMTP id b6so4684706wrn.17
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 11:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s9gmQbYqnhuFlpWBc8RPXaIWVHHk5+Qz4AUTu4B4Dck=;
 b=JcFusde4Sdqlrfav3A3rw3fwjPgiSp9b2KgtxA/GADPD2EtUAiHMgzgfCRxNM4wJgR
 pviZE4HVp5Y1M2sLUAVc1BADrK3Fny+EJrpi3BrxkQz3xzChD6cN1lJgkwfe25xmi0Yt
 OpKAU4fJb7bzhNnUUcJmbxlAZjm6mTUIXV1u0HrOjOJeexFq7MaSyUlYt7u9xY+RCQMZ
 vISn8xeyCtgs1Jjk0HfmVL+5F/cunfofy08E50CGMtgbx215cnGjrdWgs82QW/Zc4q0M
 JOkpd2csSavG1qPupgZycXXwTGdmb1KzXBgh/ZAq5UN6BPIpsifeVVHjOMXr+22xDdbU
 i59g==
X-Gm-Message-State: AOAM533iIkC6Y/Kk1dG2eYnA1BdN+Gja8nZ+pzADwLcuXYj9ETVv2aP7
 VUpYziNv2VXeZOCRflRGorzbBVS7+Nq0tdiqRUagAClZOKeoppqN4PSB2NSz4FTWzWsazPaTxF1
 kEJlsAhytmgWQmYA=
X-Received: by 2002:adf:a39e:: with SMTP id l30mr11644522wrb.195.1604950044188; 
 Mon, 09 Nov 2020 11:27:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVyNUmj+2rkLKNixzPa03ol7G7uh2WoDO7h9JQGLK2fZA+iRhRNkzFSnj3Z4rNbB5YZRWMpw==
X-Received: by 2002:adf:a39e:: with SMTP id l30mr11644495wrb.195.1604950043935; 
 Mon, 09 Nov 2020 11:27:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id i10sm5524216wrs.22.2020.11.09.11.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 11:27:23 -0800 (PST)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201106094511.GA23864@merkur.fritz.box>
 <20201106155013.GX5733@habkost.net> <20201106211034.GY5733@habkost.net>
 <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
 <20201109113404.GA24970@merkur.fritz.box>
 <3b711053-e67a-86fb-59e7-c06948dd8928@redhat.com>
 <20201109152125.GZ5733@habkost.net>
 <2300fd53-afa1-b957-b33b-cff2986fcb93@redhat.com>
 <20201109171618.GA5733@habkost.net>
 <098ca211-3ad5-b194-e9f5-678291fe641e@redhat.com>
 <20201109185558.GB5733@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <9659e726-7948-4e02-f303-abcbe4c96148@redhat.com>
Date: Mon, 9 Nov 2020 20:27:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109185558.GB5733@habkost.net>
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

On 09/11/20 19:55, Eduardo Habkost wrote:
> On Mon, Nov 09, 2020 at 06:33:04PM +0100, Paolo Bonzini wrote:
>> On 09/11/20 18:16, Eduardo Habkost wrote:
>>> I mean extending the API to let custom setters and getters appear
>>> on the Property array, not using the existing API.
>>
>> That seems like conflicting goals.  The field property API is based on
>> getters and setters hidden in PropertyInfo.  The "other" property API is
>> based on getters and setters in plain sight in the declaration of the
>> property.
> 
> There's nothing that prevents a
>    void object_class_add_properties(oc, Property *props);
> function from supporting both.

Sorry but I don't believe this until I see it.  The two APIs are just 
too different.  And at some point the complexity of DEFINE_PROP becomes:

1) harder to document

2) just as hard to parse and build a QAPI schema from

And in the final desired result where QAPI generators are what generates 
the list of properties, it's pointless to shoehorn both kinds of 
properties in the same array if different things can just generate 
calls to different functions.

>>> Parsing an array containing a handful of macros (a tiny subset of
>>> C) isn't even comparable to parsing and executing C code where
>>> object*_property_add*() calls can be buried deep in many levels
>>> of C function calls (which may or may not be conditional).
>>
>> Finding the array would also require finding calls buried deep in C code,
>> wouldn't they?
> 
> Yes, but I don't expect this to happen if the API doesn't
> encourage that.

Out of 700 calls to object_class_property_add*, there are maybe 5 that 
are dynamic.  So on one hand I understand why you want an API that makes 
those things harder, but on the other hand I don't see such a big risk 
of misuse, and it won't even matter at all if we later end up with 
properties described in a QAPI schema.

>>> (Also, I don't think we should allow handwritten Property literals.)
>>
>> How would you do custom setters and getters then---without separate
>> PropertyInfos, without Property literals, and without an exploding number of
>> macros?
> 
> Prop with no struct field, and custom setter/getter:
> 
>    DEFINE_PROP("myproperty", prop_type_uint32,
>                .custom_getter = my_getter,
>                .custom_setter = my_setter)

It would have to use all the Visitor crap and would be even harder to 
use than object_class_property_add_str.  Thanks but no thanks. :)

>>> we can't be sure the [set of QOM properties]
>>> doesn't depend on configure flags or run time
>>> checks inside class_init.
>>
>> We can use grep or Coccinelle or manual code review to identify problematic
>> cases.
> 
> We can, but I believe it is better and simpler to have an API
> that enforces (or at least encourages) this.

I don't see how

     if (...) {
         object_class_add_field_properties(oc, props);
     }

is discouraged any more than

     if (...) {
         object_class_add_field_property(oc, "prop1",
                                         PROP_STRING(...));
         object_class_add_field_property(oc, "prop2",
                                         PROP_STRING(...));
         object_class_add_field_property(oc, "prop3",
                                         PROP_STRING(...));
         object_class_add_field_property(oc, "prop4",
                                         PROP_STRING(...));
     }

(If anything, the former is more natural and less ugly than the latter).

> I'd like us to convert instance-level properties to an API that
> is easy to use and where the same problems won't happen again.

I agree.  I just don't think that arrays are enough to make sure the 
same problems won't happen again.

>>> You are also ignoring the complexity of the code path that leads
>>> to the object*_property_add*() calls, which is the main problem
>>> on most cases.
>>
>> I would like an example of the complexity of those code paths.  I don't see
>> much complexity, as long as the object exists at all, and I don't see how it
>> would be simpler to find the code paths that lead to
>> object_class_add_field_properties.
> 
> Possibly the most complex case is x86_cpu_register_bit_prop().
> The qdev_property_add_static() calls at arm_cpu_post_init() are
> tricky too.

The problem with those code paths is that there's a reason why they look 
like they do.  For x86_cpu_register_feature_bit_props, for example 
either you introduce duplication between QOM property definitions and 
feat_names array, or you resort to run-time logic like that.

If you want to make those properties introspectable (i.e. known at 
compilation time) you wouldn't anyway use DEFINE_PROP*, because it would 
cause duplication.  Instead, you could have a plug-in parser for 
qapi-gen, reading files akin to target/s390x/cpu_features_def.h.inc. 
The parser would generate both QAPI schema and calls to 
x86_cpu_register_bit_prop().

To sum up: for users where properties are heavily dependent on run-time 
logic, the solution doesn't come from providing a more limited API.  A 
crippled API will simply not solve the problem that prompted the usage 
of run-time logic, and therefore won't be used.

(I don't know enough of the ARM case to say something meaningful about it).

> If object*_property_add*() is hidden behind a function call or a
> `if` statement, it's already too much complexity to me.

You want to remove hiding behind a function call, but why is it any 
better to hide behind layers of macros?  Just the example you had in 
your email included DEFINE_PROP, DEFINE_FIELD_PROP, DEFINE_PROP_UINT32. 
  It's still impossible to figure out without either parsing or 
executing C code.

Paolo


