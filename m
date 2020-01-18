Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD41AC33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 08:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7631A2468B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 08:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFp629zE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7631A2468B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38231 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isjYX-0001fy-Pb
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 03:34:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isjXj-00019k-6D
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isjXh-0007RQ-Lp
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:33:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isjXh-0007Qq-IC
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 03:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579336396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1l0MrpRTHkS/9+BvGvgF+cURr+eI/FDoJ2clwWVTkkY=;
 b=MFp629zER5YsI9u1ZuBKrZMYapf1nIwIpH6qZO1tg1WKufq380NtQko234jMgFG9FsxljM
 f/HTLeVg/5SPhk7Z3VUODyaR3Em371m/oLj7dYVIvdUUCsLezUlZAQTYbXyCtxcMLZGqjf
 XJZ59DqHIjc45q7zJDkdbsEbP2vOa7g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-fw2CvG9XOgmWIDUdcg60kA-1; Sat, 18 Jan 2020 03:33:15 -0500
Received: by mail-wr1-f72.google.com with SMTP id h30so11516653wrh.5
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 00:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kuskk9ov2UY/hkgnITN+yfWnJlZL1V+YxAJltuSIzK8=;
 b=oFmJgJLQ5e70jpzgIqRFLegAUibcOCERORkmJF1MZob7eesusDu2KTAqaLKRAaA7nf
 vzMLN+wnh9cfBC0azx8jBcq5qH6nFrI4SZzkBQHY0UhYSUUREbwsMa6H5jHLAigZ7xKC
 fGXiJQ6nBixmOMOGYWFNsvP9GCOgHnfLRt80otxu0rqlQ+ElqwNKoC064i0Vxje4cfmI
 a1wdn7RFE7LUqmcEZ5xGItSbrI2olnNti7z8rL4t76IQ/VFA2m6qxVrCk6drCDTfHMi1
 WEVoGiwUCcU/wql2KVqx8jNrXA3fAXhyQjSSVlj2r+EfWzwTVKuGCpbB9EbVliqIEvrm
 5oVA==
X-Gm-Message-State: APjAAAUUIOro7v3Tr3TqHTFibP+2zcWWB1UkjIOAFg/yGL503boSvdzH
 75uthWcKMHtP3Mfr40Bh4r6WPIATxjWaS4kGs0N1aRmtXugb0lZ0GYcfFSh4Ur+wVCazUX8QVbf
 wl8pWipOa2EX03Vk=
X-Received: by 2002:a05:6000:1047:: with SMTP id
 c7mr7488590wrx.341.1579336393729; 
 Sat, 18 Jan 2020 00:33:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwic4R08ZG+bDuXmdOlPiTMkeQoD/EAv+fpbdWvE/VA8qhUVcbvhZ5cG/gBRMkL8VQluZF7rw==
X-Received: by 2002:a05:6000:1047:: with SMTP id
 c7mr7488577wrx.341.1579336393476; 
 Sat, 18 Jan 2020 00:33:13 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d10sm38688315wrw.64.2020.01.18.00.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 00:33:12 -0800 (PST)
Subject: Re: [PATCH] qapi: Fix code generation with Python 3.5
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20200116202558.31473-1-armbru@redhat.com>
 <163735a5-b8d0-e657-86b2-a3921d754381@redhat.com>
 <87tv4ul5nd.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8976470-1fe3-f380-8bde-af2d7c29c9ab@redhat.com>
Date: Sat, 18 Jan 2020 09:33:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87tv4ul5nd.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-MC-Unique: fw2CvG9XOgmWIDUdcg60kA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 11:49 AM, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 16/01/2020 21.25, Markus Armbruster wrote:
>>> Recent commit 3e7fb5811b "qapi: Fix code generation for empty modules"
>>> modules" switched QAPISchema.visit() from
>>>
>>>      for entity in self._entity_list:
>>>
>>> effectively to
>>>
>>>      for mod in self._module_dict.values():
>>>          for entity in mod._entity_list:
>>>
>>> Visits in the same order as long as .values() is in insertion order.
>>> That's the case only for Python 3.6 and later.  Before, it's in some
>>> arbitrary order, which results in broken generated code.
>>>
>>> Fix by making self._module_dict an OrderedDict rather than a dict.
>>>
>>> Fixes: 3e7fb5811baab213dcc7149c3aa69442d683c26c
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   scripts/qapi/schema.py | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>>> index 0bfc5256fb..5100110fa2 100644
>>> --- a/scripts/qapi/schema.py
>>> +++ b/scripts/qapi/schema.py
>>> @@ -795,7 +795,7 @@ class QAPISchema(object):
>>>           self.docs =3D parser.docs
>>>           self._entity_list =3D []
>>>           self._entity_dict =3D {}
>>> -        self._module_dict =3D {}
>>> +        self._module_dict =3D OrderedDict()
>>>           self._schema_dir =3D os.path.dirname(fname)
>>>           self._make_module(None) # built-ins
>>>           self._make_module(fname)
>>>
>>
>> Thanks, this fixes the problems on Travis for me!
>>
>> Tested-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>> Peter, could you maybe apply this directly to the master branch as a
>> build fix?
>=20
> The commit message isn't quite right: s/Visits in the same order/Visits
> modules in the same order/.  Peter, want me to respin for that?

Since it is a single patch, it shouldn't be too much work to respin :)

I agree this patch is candidate for direct fix on /master.

Thanks,

Phil.


