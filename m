Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4200FC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FAA205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+D7767T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FAA205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDVfM-0002j6-Jt
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 11:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDVWM-0006j9-H6
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDVWK-000104-JT
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:49:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDVWK-0000wl-EQ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 11:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584287384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONEdoUwTx+c86S7WZmJiL1bqdlmcyzfMSspXJm6+Z4w=;
 b=S+D7767TSBLzNg0hRBjYlmNtVomdVyPEGO7+4vHpEENVqSnP+bNgPs+CmpUq2xZMoCzDXb
 lz/qPRoXHBUJlIf615tpB8oKsuOFczsKd2OTUx825RWCmCt8v3WS3w17OZoTgcrm8/v0yj
 RabSd+fdalp0EExN3G36BhtdAyVQz3I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-TFdnjJeBOYi4Bl8pHz7Thg-1; Sun, 15 Mar 2020 11:49:40 -0400
X-MC-Unique: TFdnjJeBOYi4Bl8pHz7Thg-1
Received: by mail-wm1-f69.google.com with SMTP id y7so4616404wmd.4
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 08:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ONEdoUwTx+c86S7WZmJiL1bqdlmcyzfMSspXJm6+Z4w=;
 b=ejVdjHdgQRrQDk4Irx1eGV0IQQm+4aDCQbYkpw2BPZKqCO+EZsSFKZ9Wo5m9Mdrd8D
 pcr74QxI6b8YrcW+INHFlHtmzh4jcDXKoPJqvrNfKvxMCzgC117Yxas4s5NXObiO7dPg
 7yDWcT9VridaDMxNHY6cYxzOl+TCKfLClX5Hf4LHy7htlzRkJ2feuAXjgnjJvmvDs+J5
 Kf7zMT68rJ6tbssmlaisYkCt1uRpJbiio1iaYFyZBE0RDJO217s2kKbRcwcSTyMzdZSL
 6Wap/qCdU56qMj+tbVvM/pLjtOreu+rnJsnNXZp3fN8cTwu/zLcaitr0jqd4hf2ggl04
 Tf3w==
X-Gm-Message-State: ANhLgQ1VeddcPXzBv8Q+Bb9rkDtZKlEqFKunZLCwuFOQxII+7ydYLgF7
 yWzPMBgC9628OnaLDuPqoltc19EqzP3KTX0qRtRSONWVDp0rgVLgvyD1UKE+VeVXg3mEz5AeAws
 Vzlxiy2dV4DOJoNs=
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr23227606wmf.4.1584287379489; 
 Sun, 15 Mar 2020 08:49:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuZYs2RhsdVu/VpZ+r6AyEQ9rDDr2i4kUKf82Hoyo5Ox3a/Qrdho3EL494xOh5izIU/O+PpBg==
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr23227595wmf.4.1584287379240; 
 Sun, 15 Mar 2020 08:49:39 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id b202sm732078wmd.15.2020.03.15.08.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 08:49:38 -0700 (PDT)
Subject: Re: [PATCH v3 25/34] qapi: New special feature flag "deprecated"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200315144653.22660-1-armbru@redhat.com>
 <20200315144653.22660-26-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6af79067-2631-c12d-5643-fbc78bfb1bcf@redhat.com>
Date: Sun, 15 Mar 2020 16:49:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315144653.22660-26-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 3:46 PM, Markus Armbruster wrote:
> Unlike regular feature flags, the new special feature flag
> "deprecated" is recognized by the QAPI generator.  For now, it's only
> permitted with commands, events, and struct members.  It will be put
> to use shortly.

What about using a '@DeprecatedSince' tag?
Ah, that would apply to the whole structure and not a particular member...

I am wondering because sometimes we deprecate something for 2 releases 
but then once the deadline passed we forgot to remove it. Having the 
release version deadline along with deprecation would help automating 
removal checks.
Maybe we can use a tag with release version, such 'deprecated_since:5.0'?

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/devel/qapi-code-gen.txt                    | 6 ++++++
>   scripts/qapi/schema.py                          | 6 ++++++
>   tests/Makefile.include                          | 1 +
>   tests/qapi-schema/features-deprecated-type.err  | 2 ++
>   tests/qapi-schema/features-deprecated-type.json | 3 +++
>   tests/qapi-schema/features-deprecated-type.out  | 0
>   tests/qapi-schema/qapi-schema-test.json         | 6 +++---
>   tests/qapi-schema/qapi-schema-test.out          | 6 +++---
>   8 files changed, 24 insertions(+), 6 deletions(-)
>   create mode 100644 tests/qapi-schema/features-deprecated-type.err
>   create mode 100644 tests/qapi-schema/features-deprecated-type.json
>   create mode 100644 tests/qapi-schema/features-deprecated-type.out
> 
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index a1ef1cfd61..823adbabda 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -683,6 +683,12 @@ Intended use is to have each feature string signal that this build of
>   QEMU shows a certain behaviour.
>   
>   
> +==== Special features ====
> +
> +Feature "deprecated" makes a command, event, or struct member as
> +deprecated.  It is not supported elsewhere so far.
> +
> +
>   === Naming rules and reserved names ===
>   
>   All names must begin with a letter, and contain only ASCII letters,
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 6ee3677215..78309a00f0 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -193,6 +193,12 @@ class QAPISchemaType(QAPISchemaEntity):
>               return None
>           return self.name
>   
> +    def check(self, schema):
> +        QAPISchemaEntity.check(self, schema)
> +        if 'deprecated' in [f.name for f in self.features]:
> +            raise QAPISemError(
> +                self.info, "feature 'deprecated' is not supported for types")
> +
>       def describe(self):
>           assert self.meta
>           return "%s type '%s'" % (self.meta, self.name)
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 67e8fcddda..d1340301b2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -242,6 +242,7 @@ qapi-schema += event-case.json
>   qapi-schema += event-member-invalid-dict.json
>   qapi-schema += event-nest-struct.json
>   qapi-schema += features-bad-type.json
> +qapi-schema += features-deprecated-type.json
>   qapi-schema += features-duplicate-name.json
>   qapi-schema += features-if-invalid.json
>   qapi-schema += features-missing-name.json
> diff --git a/tests/qapi-schema/features-deprecated-type.err b/tests/qapi-schema/features-deprecated-type.err
> new file mode 100644
> index 0000000000..af4ffe20aa
> --- /dev/null
> +++ b/tests/qapi-schema/features-deprecated-type.err
> @@ -0,0 +1,2 @@
> +features-deprecated-type.json: In struct 'S':
> +features-deprecated-type.json:2: feature 'deprecated' is not supported for types
> diff --git a/tests/qapi-schema/features-deprecated-type.json b/tests/qapi-schema/features-deprecated-type.json
> new file mode 100644
> index 0000000000..4b5bf5b86e
> --- /dev/null
> +++ b/tests/qapi-schema/features-deprecated-type.json
> @@ -0,0 +1,3 @@
> +# Feature 'deprecated' is not supported for types
> +{ 'struct': 'S', 'data': {},
> +  'features': [ 'deprecated' ] }
> diff --git a/tests/qapi-schema/features-deprecated-type.out b/tests/qapi-schema/features-deprecated-type.out
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
> index f576c337af..6b1f05afa7 100644
> --- a/tests/qapi-schema/qapi-schema-test.json
> +++ b/tests/qapi-schema/qapi-schema-test.json
> @@ -258,7 +258,7 @@
>     'data': { 'foo': 'int' },
>     'features': [] }
>   { 'struct': 'FeatureStruct1',
> -  'data': { 'foo': { 'type': 'int', 'features': [ 'member-feature1' ] } },
> +  'data': { 'foo': { 'type': 'int', 'features': [ 'deprecated' ] } },
>     'features': [ 'feature1' ] }
>   { 'struct': 'FeatureStruct2',
>     'data': { 'foo': 'int' },
> @@ -308,7 +308,7 @@
>     'features': [] }
>   
>   { 'command': 'test-command-features1',
> -  'features': [ 'feature1' ] }
> +  'features': [ 'deprecated' ] }
>   { 'command': 'test-command-features3',
>     'features': [ 'feature1', 'feature2' ] }
>   
> @@ -322,4 +322,4 @@
>                                                 'defined(TEST_IF_COND_2)'] } ] }
>   
>   { 'event': 'TEST-EVENT-FEATURES1',
> -  'features': [ 'feature1' ] }
> +  'features': [ 'deprecated' ] }
> diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
> index cd863ae966..891b4101e0 100644
> --- a/tests/qapi-schema/qapi-schema-test.out
> +++ b/tests/qapi-schema/qapi-schema-test.out
> @@ -359,7 +359,7 @@ object FeatureStruct0
>       member foo: int optional=False
>   object FeatureStruct1
>       member foo: int optional=False
> -        feature member-feature1
> +        feature deprecated
>       feature feature1
>   object FeatureStruct2
>       member foo: int optional=False
> @@ -419,7 +419,7 @@ command test-features0 q_obj_test-features0-arg -> None
>       gen=True success_response=True boxed=False oob=False preconfig=False
>   command test-command-features1 None -> None
>       gen=True success_response=True boxed=False oob=False preconfig=False
> -    feature feature1
> +    feature deprecated
>   command test-command-features3 None -> None
>       gen=True success_response=True boxed=False oob=False preconfig=False
>       feature feature1
> @@ -440,7 +440,7 @@ command test-command-cond-features3 None -> None
>           if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
>   event TEST-EVENT-FEATURES1 None
>       boxed=False
> -    feature feature1
> +    feature deprecated
>   module include/sub-module.json
>   include sub-sub-module.json
>   object SecondArrayRef
> 


