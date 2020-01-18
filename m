Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188FAC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 08:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D514D206E6
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 08:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWzW7dKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D514D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isjVT-0000E2-T7
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 03:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isjUT-00089A-Fc
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isjUR-0005Go-NI
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:29:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isjUR-0005Fz-J5
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579336194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3SuhExUeLt4/97epXF+Fd2qW3rDWtojAXkO1cF+EX1s=;
 b=BWzW7dKGwmvfX3hA6vqwgbRwjlmns6+K30K/Q325LaXZVAN+D8esOcuKGpAfGzHJhqgBD3
 bbv8rWvDwjrKto9CpogAJ8ah96T2zCDKxtLZNW8wq5RZgyU0SvI1v5XrOGNC+wz9E9gDSy
 LutxrB1Ze749U1ud/k8t05Uk0KvRumk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-OQqTTKd6PdehkNrIDlV5sQ-1; Sat, 18 Jan 2020 03:29:51 -0500
Received: by mail-wm1-f72.google.com with SMTP id n17so1523998wmk.1
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 00:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3SuhExUeLt4/97epXF+Fd2qW3rDWtojAXkO1cF+EX1s=;
 b=bIDbEXRPSxrpKo/ofBDDWNYXINiYd7lKtxlbbF/jYHurqn5amrFuHufJVSLlZCNhCD
 fQrbL71WYa+TrKu+d0qHbVGP3sekZ/WdMqKdLWXlMDgSmRZG283w/5Y/V/DTOuzd/svd
 h3sWvXeWFM8Bkat44jXRwMv18i/xsYP1iey5eaiFm+sclOvdibE12fqbX6BlKTihcArX
 HExKenEnBbmOXuurh1ejrAoJiK5knJtpBQOMYmV5+kBwJZJcwFDuUrOFit+zISiD3pOi
 bIAfyenObIcdjSfysoQxxDz4A0+yvSwrP7D0Gx/oYSoFP63FPpty6FJMv9nye6niwNb4
 r31A==
X-Gm-Message-State: APjAAAUfH3RqGiYwI22uug81sl7qCwH+u7xExID5QLS7N4y8bO/Oy1Q8
 Evj/HW7XB6izFu521XXRoqkYuJ3blDR9CIG8kCY3wlcxxpu0Ve8fIpKlT4IrnM4pxu7Gv5umi4c
 d32gs0O3/HID2vRc=
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr7274990wrn.384.1579336189729; 
 Sat, 18 Jan 2020 00:29:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLP7q7dblw/HypmvlGtMA10Y4JK9NjKxYPkWlzpKNLbmo5Q5XAkUnko3Uk6tCaa77lXlc8qw==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr7274976wrn.384.1579336189479; 
 Sat, 18 Jan 2020 00:29:49 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id z124sm14593627wmc.20.2020.01.18.00.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 00:29:48 -0800 (PST)
Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200116202558.31473-1-armbru@redhat.com>
 <3fb3e411-c5de-fbc1-684b-c7fb1ce2ea7d@redhat.com>
 <875zhapnlt.fsf@dusky.pond.sub.org>
 <a6ea59a5-0877-fdeb-5b37-9ec3f31074a4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dc9826a5-63a8-9529-838b-aec2fbb66ea6@redhat.com>
Date: Sat, 18 Jan 2020 09:29:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a6ea59a5-0877-fdeb-5b37-9ec3f31074a4@redhat.com>
Content-Language: en-US
X-MC-Unique: OQqTTKd6PdehkNrIDlV5sQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>, thuth@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <cleber@redhat.com>,
 qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 8:41 PM, John Snow wrote:
> On 1/17/20 2:07 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>
>>> On 1/16/20 3:25 PM, Markus Armbruster wrote:
>>>> Recent commit 3e7fb5811b "qapi: Fix code generation for empty modules"
>>>> modules" switched QAPISchema.visit() from
>>>>
>>>>      for entity in self._entity_list:
>>>>
>>>> effectively to
>>>>
>>>>      for mod in self._module_dict.values():
>>>>          for entity in mod._entity_list:
>>>>
>>>> Visits in the same order as long as .values() is in insertion order.
>>>> That's the case only for Python 3.6 and later.  Before, it's in some
>>>> arbitrary order, which results in broken generated code.
>>>>
>>>> Fix by making self._module_dict an OrderedDict rather than a dict.
>>>>
>>>> Fixes: 3e7fb5811baab213dcc7149c3aa69442d683c26c
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>   scripts/qapi/schema.py | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>>>> index 0bfc5256fb..5100110fa2 100644
>>>> --- a/scripts/qapi/schema.py
>>>> +++ b/scripts/qapi/schema.py
>>>> @@ -795,7 +795,7 @@ class QAPISchema(object):
>>>>           self.docs = parser.docs
>>>>           self._entity_list = []
>>>>           self._entity_dict = {}
>>>> -        self._module_dict = {}
>>>> +        self._module_dict = OrderedDict()
>>>>           self._schema_dir = os.path.dirname(fname)
>>>>           self._make_module(None) # built-ins
>>>>           self._make_module(fname)
>>>>
>>>
>>> This problem has bitten me *many* times. I'm wondering if there's a
>>> prescription that isn't just "Wait until we can stipulate 3.6+".
>>
>> No clue.
>>
>> 3.5 EOL is scheduled for 2020-09-13.
>> https://devguide.python.org/#status-of-python-branches
>>
>> We support 3.5 because we support Debian 9.
>>
>> We'd normally drop support for Debian 9 two years after Debian 10,
>> i.e. July 2021.  Assuming Debian supports it that far.  Whether they can
>> truly support Python 3.5 after uptstream EOL seems doubtful.
>>
> 
> We should decide whether we consider Debian LTS to be adequately
> supported, yes-or-no.
> 
> We should use a rule of "two years after successor, or End-of-Support,
> whichever comes first."
> 
> For Debian, is end of support three years after it comes out, or is it
> when the LTS is EOL?
> 
> In this specific case, do we trust that Debian 9 LTS will continue to
> patch Python3.5 all the way up until July 2021?

This broke 29 of the 32 Travis jobs we have:

https://travis-ci.org/qemu/qemu/builds/637999366

Since we started to use Travis CI, it catched quite some bugs...

I think it is important to add in the equation we also depend of our CIs.


