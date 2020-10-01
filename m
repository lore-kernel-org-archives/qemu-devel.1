Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C998FC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FF620759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqEM/erH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FF620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1C2-0002y6-IK
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO0pn-00049c-VX
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO0pl-0005C1-Qw
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601567366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ff1d5BbPcg5H7B2Vhm0pnCgFm0nkBZG1PxeecPHHbUg=;
 b=gqEM/erH19YYNLTmi5SquuzHPvt9wp0cxVQSKITEq93g/78Va6upTXih9iBFsoaC69thrx
 JykKNh2akBvE1tOUDvVRmANCUrxn0BDiRLicF/VJUT+tde3Zp6VUlYkIk7CWTtSwZCVt6X
 o+2uOXwVjFmNvqOVDCEe9W7LHEtZ2hM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-8sKe-jigPjSbyxEiWzo3Vg-1; Thu, 01 Oct 2020 11:49:24 -0400
X-MC-Unique: 8sKe-jigPjSbyxEiWzo3Vg-1
Received: by mail-wr1-f71.google.com with SMTP id g6so2228548wrv.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ff1d5BbPcg5H7B2Vhm0pnCgFm0nkBZG1PxeecPHHbUg=;
 b=FwJIdoLx8RvwJOUKwOEg9TKloQBbW1t48c0yFpArY+bNvN1LuCi0ux4ItsnHxtZ/Az
 PZe3jILSgf1goSrSB0q6eOmP0zTCyLoQ6yoiveHPRN087fFR/LTGVUsIo2qcUhN+SeUg
 vTMUAXOldlILaeGMzovHTErkLHk+ArMmKevwsIYpd5dEQtfe7FIukQnxRJVkK6/HYYdI
 VKuhsACHV5f3PNsBTYH6EX4lIBvU4jrJ4olDb6fCzAfqUNKg4ka3hCUcRKMKJitY1VMK
 nZ5andvXJ9pCi+O7SCa9QSyPvgbKRGJvF9wbsfa85a/K27xG1VbeSveLHE/K2ecB+acD
 pgSQ==
X-Gm-Message-State: AOAM530/TvqdFOdnr7PlWX0L9MmUDfRc+fdWjthEG7Q7BexOzllUxgaT
 KmYpNbn9Qd1vVs3UxHYfH8764JQ0McbfJcNDMgH88+mmJqiDIl3du1eBBaSXm9y5lSHPf5Y9G5K
 JOuGtu7PTjdSM6wE=
X-Received: by 2002:a7b:c393:: with SMTP id s19mr703581wmj.78.1601567362885;
 Thu, 01 Oct 2020 08:49:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyon1b9e8FsFIDIJWQz8gWUKpVCZCLoP+RVYbBRGhC8re1SA/GRB8xV7PeCy5NxS11jBwFo0w==
X-Received: by 2002:a7b:c393:: with SMTP id s19mr703556wmj.78.1601567362641;
 Thu, 01 Oct 2020 08:49:22 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t10sm539681wmi.1.2020.10.01.08.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 08:49:21 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add Python library stanza
To: John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20200922230505.4089701-1-jsnow@redhat.com>
 <20200922230505.4089701-2-jsnow@redhat.com>
 <87wo0k34qp.fsf@dusky.pond.sub.org>
 <ce23c70a-2e0e-0ca1-5260-812d713f04a8@redhat.com>
 <20200923153707.GP3312949@habkost.net>
 <f0e34f41-ba30-770e-068f-dc6ccc92ed33@redhat.com>
 <8ce21cbd-2b7a-dbb7-46e3-026621ad0568@redhat.com>
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
Message-ID: <066ea3d8-156f-b1fd-93ea-dd3372962f81@redhat.com>
Date: Thu, 1 Oct 2020 17:49:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8ce21cbd-2b7a-dbb7-46e3-026621ad0568@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: peter.maydell@linaro.org, crosa@redhat.com, alex.bennee@linaro.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 5:27 PM, John Snow wrote:
> On 9/23/20 12:49 PM, Philippe Mathieu-Daudé wrote:
>> On 9/23/20 5:37 PM, Eduardo Habkost wrote:
>>> On Wed, Sep 23, 2020 at 11:17:01AM -0400, John Snow wrote:
>>>> On 9/23/20 11:14 AM, Markus Armbruster wrote:
>>>>> John Snow <jsnow@redhat.com> writes:
>>>>>
>>>>>> I'm proposing that I split the actual Python library off from the
>>>>>> other
>>>>>> miscellaneous python scripts we have and declare it maintained. Add
>>>>>> myself as a maintainer of this folder, along with Cleber.
>>>>>>
>>>>>> v2: change python/* to python/, thanks Alex.
>>>>>>
>>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>>>> Acked-by: Cleber Rosa <crosa@redhat.com>
>>>>>> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>>> ---
>>>>>>    MAINTAINERS | 9 ++++++++-
>>>>>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 3d17cad19a..c0222ee645 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -2355,11 +2355,18 @@ S: Maintained
>>>>>>    F: include/sysemu/cryptodev*.h
>>>>>>    F: backends/cryptodev*.c
>>>>>> +Python library
>>>>>> +M: John Snow <jsnow@redhat.com>
>>>>>> +M: Cleber Rosa <crosa@redhat.com>
>>>>>> +R: Eduardo Habkost <ehabkost@redhat.com>
>>>>>> +S: Maintained
>>>>>> +F: python/
>>>>>> +T: git https://gitlab.com/jsnow/qemu.git python
>>>>>> +
>>>>>>    Python scripts
>>>>>>    M: Eduardo Habkost <ehabkost@redhat.com>
>>>>>>    M: Cleber Rosa <crosa@redhat.com>
>>>>>>    S: Odd fixes
>>>>>> -F: python/qemu/*py
>>>>>>    F: scripts/*.py
>>>>>>    F: tests/*.py
>>>>>
>>>>> Separate sections just so you can have the appropriate S:, or is
>>>>> there a
>>>>> deeper logic behind the split?
>>>>>
>>>>
>>>> Yes, different intended levels of support. I don't currently have the
>>>> bandwidth to promise support for the miscellaneous Python scripts in
>>>> ./scripts, but I do promise to support to a higher level the code in
>>>> ./python.
>>>>
>>>> Over time, I intend to migrate things into ./python, but there are some
>>>> series that need to happen first before I start doing that.
>>>
>>> Also, the actual owners for most scripts in ./scripts are already
>>> listed elsewhere.  I believe we shouldn't really have M: lines
>>> for the scripts/*.py section, just R:.
>>
>> Agreed. Maybe worth a comment in the section although.
>>
> 
> *in* the section? There is no precedent for that. Is this really so
> important?

Well if this file is only consumed by scripts, and no human reads it,
then it is pointless indeed.

> 
> I'll give you a commit message blurb.

That sometime works, thanks.

> 
> --js
> 


