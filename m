Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF379C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 993342070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGuYP0Op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993342070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbBV-0006JN-Rm
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbAs-0005pb-Mn
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:07:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdbAr-0000Ld-T0
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590505644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SFTCggL34ZRXwWcjK8gX7i2YinaMnFN7Ht+XA61qDMU=;
 b=OGuYP0OpnybFvzR9Qz5sVmDoK65QgU3GfArA/sCMmlCPw7hsyhp3UJ4Ju8KTP190nhp3m8
 Ryiy+v7vDrbwtk0JsM+ndyWwBcXmJsizYPOyRM8m8liqt06z+Vm/h81LOGxDM7PO4GRQLY
 V1seZgTarGJQ8Uz4g78bSXymVU+AUaY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-3Gby6s-fPcykZsZT8RXwrw-1; Tue, 26 May 2020 11:07:21 -0400
X-MC-Unique: 3Gby6s-fPcykZsZT8RXwrw-1
Received: by mail-ed1-f69.google.com with SMTP id k17so9094464edo.20
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 08:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=SFTCggL34ZRXwWcjK8gX7i2YinaMnFN7Ht+XA61qDMU=;
 b=fsdmh6h/JOsJT3acvlig9sv1czJCv/yctp8T2ndOfVibxfoK+uzfMCMxioZlckErFG
 DyXIB6TzIIVtnMfQLMuFZBx9qM61ySaRvKdmxgrnCwzBvzUt2SsP0SetELF6T0GF+4PC
 OdmvMB3I5BcE9vX5CCcZq1Dvxos5Ks2d2YvZWfyFUMJhCvv00zuc6RWOLg/aLk4OM8BE
 T0k2qEXKVJC9zFErtw4nIMC65LhG1Y79fK+z68NEMrP0pEPpE/B5XJQkajQd5IP7hB2v
 E15vZt6Gy//6sX8l3anVN7wOUUYoPp007wgNkJ/7uP03L35WINTXEB3xaxT3CRbrPi5X
 JSHA==
X-Gm-Message-State: AOAM5339ze1eesqDujqOPgxkZ9oWTSwKgU9byqITdazO5QqhpxMScqHZ
 pT3QizF+ir4D3SUOqaml2OOIrAG769bGJFeO6PfBMr1VC59oIODscWgEG2yFpa+2xCKvhcoK4rs
 1mbqhKHMqxAtsTFI=
X-Received: by 2002:a17:906:4088:: with SMTP id
 u8mr1614609ejj.500.1590505639833; 
 Tue, 26 May 2020 08:07:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH0S9UYV6ZZaX7ObrkSm2flO9TkshDnvlooc2J67zuuGVPDA5Q+HY8LFvblu+97yCDJuRGFw==
X-Received: by 2002:a17:906:4088:: with SMTP id
 u8mr1614561ejj.500.1590505639476; 
 Tue, 26 May 2020 08:07:19 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id s1sm151759ejh.81.2020.05.26.08.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 08:07:18 -0700 (PDT)
Subject: Re: [PATCH RFC 01/32] python/qemu: create qemu.lib module
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-2-jsnow@redhat.com>
 <b4618eb0-5303-40ab-b5e2-5a08d5738a81@virtuozzo.com>
 <20b3fb10-8028-eb12-49a9-a3cc9dd45ed0@redhat.com>
 <07ff57d4-8348-4409-ca8a-ff4c5278b973@virtuozzo.com>
 <45dc0bb0-6b22-1703-0435-9d49d3df9978@redhat.com>
 <e78d3f7a-162a-b08e-ff8a-63b1889b81d7@virtuozzo.com>
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
Message-ID: <64f37a83-4df3-d106-3162-35f696bcb5f7@redhat.com>
Date: Tue, 26 May 2020 17:07:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e78d3f7a-162a-b08e-ff8a-63b1889b81d7@virtuozzo.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 12:54 PM, Vladimir Sementsov-Ogievskiy wrote:
> 19.05.2020 03:27, John Snow wrote:
>>
>>
>> On 5/18/20 3:33 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> 18.05.2020 21:23, John Snow wrote:
>>>>
>>>>
>>>> On 5/18/20 2:14 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 14.05.2020 08:53, John Snow wrote:
>>>>>> move python/qemu/*.py to python/qemu/lib/*.py.
>>>>>>
>>>>>> To create a namespace package, the 'qemu' directory itself shouldn't
>>>>>> have module files in it. Thus, these files will go under a 'lib'
>>>>>> package
>>>>>> directory instead.
>>>>>
>>>>> Hmm..
>>>>>
>>>>> On the first glance, it looks better to have
>>>>>
>>>>>     from qemu import QEMUMachine
>>>>>
>>>>> than
>>>>>       from qemu.lib import QEMUMachine
>>>>>
>>>>> why do we need this extra ".lib" part?
>>>>>
>>>>> Is it needed only for internal use?
>>>>>
>>>>> Assume we have installed qemu package. Can we write
>>>>>
>>>>>     from qemu import QEMUMachine
>>>>>
>>>>> ? Or we still need qemu.lib ?
>>>>>
>>>>> I don't remember any python package, which made me to write "import
>>>>> from
>>>>> package_name.lib ..."
>>>>>
>>>>>
>>>>
>>>> It's a strategy to create "qemu" as a PEP420 namespace package; i.e.
>>>> "qemu" forms a namespace, but you need a name for the actual package
>>>> underneath it.
>>>>
>>>> "qemu.lib" is one package, with qmp, qtest, and machine modules. "qemu"
>>>> isn't really a package in this system, it's just a namespace.
>>>>
>>>> The idea is that this allows us to create a more modular rollout of
>>>> various python scripts and services as desired instead of
>>>> monolithically
>>>> bundling them all inside of a "qemu" package.
>>>>
>>>> It also allows us to fork or split out the sub-packages to separate
>>>> repos, if we wish. i.e., let's say we create a "qemu.sdk"
>>>> subpackage, we
>>>> can eventually fork it off into its own repo with its own installer and
>>>> so forth. These subpackages can be installed and managed separately.
>>>>
>>>
>>> Okay, I understand.. No real objections than.
>>>
>>> Still, maybe, everything should not go into lib, maybe something like
>>>
>>> qemu/vm/  - qmp, QEMUMachine, etc
>>> qemu/qtest/  - qtest

I'm not sure this part is relevant now, as we have not good projection
of what/who/how this package will be consumed.

I suppose by VM you mean VirtualMachine. I find it confusing. Maybe
simply "machine"? We also have 'tools' and 'user-space processes'.

QMP is protocol, common to all. "qemu.core.qmp"?

We also have the gdb(stub) protocol, common to machine(system) & user.

The block layer has its classes, "qemu.block"?

>>>
>>> would be more user friendly? But I'm not sure. I just thought that "lib"
>>> is too generic.
>>>
>>
>> lib is a very generic name, I agree.
>>
>> Splitting accel, qmp and QEMUMachine in one package and keeping qtest in
>> another is fine too. I'm not sure if I like "vm" for the name of that
>> core package, though.
>>
>> I want to avoid using "qemu/sdk" because I have some plans for trying to
>> generate and package a "real" SDK using that namespace.
>>
>> "devkit"? "testkit"? "core"? Naming things is always the worst part.
>>
> 
> I think, "core" sounds good.

Agreed.


