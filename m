Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F7FC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C4A20936
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1kNPZpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C4A20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7z6-0000rz-Ib
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL7xf-0008IY-3f
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:49:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL7xd-00054P-5V
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600879780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vBsQStf8WZVHaKPVvu7Hk+4N1eau+FJv08TEwBchv1U=;
 b=M1kNPZpF81IYtz4Rs1gpDmLh56/BDUJxixufbcK728EFpntRgXLAdKK0HyXszyQLIlGDRt
 v3fD8gdnZMp1hxdKtOggpPgyiA/XJsDAxoF9aPGUnJlRxNHp9IS3AHO73+2kajWKaP+M+/
 RAElhNJoxSeN4MIVLHTyvaUpdNXzj7U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-Uu5Lb0JrN2SmnNN0EVNISg-1; Wed, 23 Sep 2020 12:49:38 -0400
X-MC-Unique: Uu5Lb0JrN2SmnNN0EVNISg-1
Received: by mail-wr1-f70.google.com with SMTP id b7so69491wrn.6
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 09:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vBsQStf8WZVHaKPVvu7Hk+4N1eau+FJv08TEwBchv1U=;
 b=SCZpY/3PJ2IBoAMlrkZmhattyMamintnqbHaLuZWQuRoRsRhvv2w4lNTxc0kk5V5WF
 irUE5aDdd7uUFXhFNkvuV2Y/10w52enm1PjZDmvCgPuK5WPfctcTbIM5ar5lJauxGVSD
 yZitgf9AIutnWWZaQKcYJtWVQpKWI1BAUEoAAu79jEnaYT0aBCOSxWYRWy9949ShrcaM
 sCPwXut4fxbhmg19JgL9QA7Wrztn1ti+qWaBWq6xELrt8yoCsk2ilpPrG2jnTZ09OjzA
 WMjGGFxrF7QFM+KPUWKaU8gVEa7p6QVAkLBzy9zur9ZCH6K+54c4Nyqlo/nU0VoVSYpe
 8qtw==
X-Gm-Message-State: AOAM530xqB5KbN8WN00jN1xn2+qd8ERe2KCV7bExxczJBQqQskwAoPR2
 UM3VdNrn4QP3E+ftGoVO156deXadvczBIJ2B58nTIxVWr4/tLrK/PTUj1uFIOqp5BPWvG53Gw/x
 q0+fiu4mxey9oU/8=
X-Received: by 2002:adf:e907:: with SMTP id f7mr555784wrm.169.1600879777114;
 Wed, 23 Sep 2020 09:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSeWRZZYvEYp6rpAUS4OrsZtUGR01kGb4x0YBTNkyO2BkqPhbACRNyC53oUgFXxkh4N+bkBg==
X-Received: by 2002:adf:e907:: with SMTP id f7mr555760wrm.169.1600879776896;
 Wed, 23 Sep 2020 09:49:36 -0700 (PDT)
Received: from [192.168.1.34] (234.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.234])
 by smtp.gmail.com with ESMTPSA id h76sm428991wme.10.2020.09.23.09.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 09:49:36 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] MAINTAINERS: Add Python library stanza
To: Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>
References: <20200922230505.4089701-1-jsnow@redhat.com>
 <20200922230505.4089701-2-jsnow@redhat.com>
 <87wo0k34qp.fsf@dusky.pond.sub.org>
 <ce23c70a-2e0e-0ca1-5260-812d713f04a8@redhat.com>
 <20200923153707.GP3312949@habkost.net>
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
Message-ID: <f0e34f41-ba30-770e-068f-dc6ccc92ed33@redhat.com>
Date: Wed, 23 Sep 2020 18:49:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923153707.GP3312949@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: peter.maydell@linaro.org, crosa@redhat.com, alex.bennee@linaro.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 5:37 PM, Eduardo Habkost wrote:
> On Wed, Sep 23, 2020 at 11:17:01AM -0400, John Snow wrote:
>> On 9/23/20 11:14 AM, Markus Armbruster wrote:
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>>> I'm proposing that I split the actual Python library off from the other
>>>> miscellaneous python scripts we have and declare it maintained. Add
>>>> myself as a maintainer of this folder, along with Cleber.
>>>>
>>>> v2: change python/* to python/, thanks Alex.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>> Acked-by: Cleber Rosa <crosa@redhat.com>
>>>> Acked-by: Eduardo Habkost <ehabkost@redhat.com>
>>>> ---
>>>>   MAINTAINERS | 9 ++++++++-
>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 3d17cad19a..c0222ee645 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -2355,11 +2355,18 @@ S: Maintained
>>>>   F: include/sysemu/cryptodev*.h
>>>>   F: backends/cryptodev*.c
>>>> +Python library
>>>> +M: John Snow <jsnow@redhat.com>
>>>> +M: Cleber Rosa <crosa@redhat.com>
>>>> +R: Eduardo Habkost <ehabkost@redhat.com>
>>>> +S: Maintained
>>>> +F: python/
>>>> +T: git https://gitlab.com/jsnow/qemu.git python
>>>> +
>>>>   Python scripts
>>>>   M: Eduardo Habkost <ehabkost@redhat.com>
>>>>   M: Cleber Rosa <crosa@redhat.com>
>>>>   S: Odd fixes
>>>> -F: python/qemu/*py
>>>>   F: scripts/*.py
>>>>   F: tests/*.py
>>>
>>> Separate sections just so you can have the appropriate S:, or is there a
>>> deeper logic behind the split?
>>>
>>
>> Yes, different intended levels of support. I don't currently have the
>> bandwidth to promise support for the miscellaneous Python scripts in
>> ./scripts, but I do promise to support to a higher level the code in
>> ./python.
>>
>> Over time, I intend to migrate things into ./python, but there are some
>> series that need to happen first before I start doing that.
> 
> Also, the actual owners for most scripts in ./scripts are already
> listed elsewhere.  I believe we shouldn't really have M: lines
> for the scripts/*.py section, just R:.

Agreed. Maybe worth a comment in the section although.


