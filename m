Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F56C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DBA206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSTcaVdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DBA206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juz4T-0002ih-BK
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juz3Z-0001xD-LL
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:03:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60434
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1juz3W-0005PG-Vc
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594649022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7zPX19sUYchG2FofyZ+b8NMnkur7C9atkXirnTVnG04=;
 b=PSTcaVdPPErYAsiFEjrVBHUeCFSNzWjaBBQMWNOHFwfoqPM4VeXxigmYyFXos7WkENRB5a
 f79Z9ARsthT/GpgRj96fJ4gXDeNybAMy7L06Kw6CCle9eKg7SzhsAJ6APoGA9/Ylom/bdr
 fe14HIDfV8D/8hD6ebwsJsd6KNMeU/0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-_ETpZjZBMkCjz9TuJB0lwA-1; Mon, 13 Jul 2020 10:03:40 -0400
X-MC-Unique: _ETpZjZBMkCjz9TuJB0lwA-1
Received: by mail-ed1-f70.google.com with SMTP id j15so21190077edq.11
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7zPX19sUYchG2FofyZ+b8NMnkur7C9atkXirnTVnG04=;
 b=gOTCrfi9tKb1GPGrX/sEfSSkfXY2bMqy8dAOzsTMCtr2E24X/kxHAr/Rf6lXYrfABh
 nCKTLO3ZjoSv9Wms548UQBUgELC4ZQJGUE30dVlJ6BNBhMhgaroRzqYtCMXkuQm3+JBz
 jTpD59waK9DZILXJUk3q9pFT8qgTiGhngkgjKeY5G2BU5j/RhhHZP7iQ+uQWzl7ICndb
 tmQXwrDG/5oLeUOPJLv1+4SL3T9kPP8HTs5mU9qbVulpEBE/d/AMF0JX1+BktZYMy6t+
 Z3Q/xrLxABJh9sLBeFjjs/+xLP8/XfSVJJs5GOQnHP/ksFogWTz2wxicJXZGAyQZka2q
 nDdw==
X-Gm-Message-State: AOAM530WJz6O81jVNMl2a1BOWkUjnnWZkJj7F0UWH3yyzKL6H1weKuZS
 w4pnrTczpS216NPOf/IT4dSG4tMPVZwQ6KZFgIi+R4/0r3cjBvLlj1fDl6ucnZfW2vie1c8C/2D
 AYk5B45UIz3l5O58=
X-Received: by 2002:aa7:dad6:: with SMTP id x22mr78307725eds.310.1594649018719; 
 Mon, 13 Jul 2020 07:03:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQtjx92UJ3BCuErkaqDvSJtOwtIj3DUoewEkjX3VnQ0lzsQJ2J5gL+8AyASHrGhXsZRGHOCQ==
X-Received: by 2002:aa7:dad6:: with SMTP id x22mr78307701eds.310.1594649018461; 
 Mon, 13 Jul 2020 07:03:38 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d22sm9709099ejc.90.2020.07.13.07.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 07:03:37 -0700 (PDT)
Subject: Re: [PATCH 1/1] MAINTAINERS: Add Python library stanza
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20200710215718.13034-1-jsnow@redhat.com>
 <20200710215718.13034-2-jsnow@redhat.com> <87365v1qsx.fsf@linaro.org>
 <e07c2650-7582-753c-ed66-dad43389e552@redhat.com>
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
Message-ID: <d4bcca31-b689-eee0-d8ab-12760af79de4@redhat.com>
Date: Mon, 13 Jul 2020 16:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e07c2650-7582-753c-ed66-dad43389e552@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 3:59 PM, John Snow wrote:
> On 7/13/20 9:35 AM, Alex Bennée wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>>> I'm proposing that I split the actual Python library off from the other
>>> miscellaneous python scripts we have and declare it maintained. Add
>>> myself as a maintainer of this folder, along with Cleber.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  MAINTAINERS | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 6aa54f7f8f..fe1dcd5a76 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2280,11 +2280,18 @@ S: Maintained
>>>  F: include/sysemu/cryptodev*.h
>>>  F: backends/cryptodev*.c
>>>  
>>> +Python library
>>> +M: John Snow <jsnow@redhat.com>
>>> +M: Cleber Rosa <crosa@redhat.com>
>>> +R: Eduardo Habkost <ehabkost@redhat.com>
>>> +S: Maintained
>>> +F: python/*
>>
>> I don't think that's equivalent to what you drop bellow:
>>
>>     F:	drivers/net/	all files in and below drivers/net
>>     F:	drivers/net/*	all files in drivers/net, but not below
>>
>> So I think you should drop the *

I can fix that if I do the next python pull req.

>>
> 
> I didn't realize that, thanks for correcting it.
> 
>>> +T: git https://gitlab.com/jsnow/qemu.git python
>>> +
>>>  Python scripts
>>>  M: Eduardo Habkost <ehabkost@redhat.com>
>>>  M: Cleber Rosa <crosa@redhat.com>
>>>  S: Odd fixes
>>> -F: python/qemu/*py
>>>  F: scripts/*.py
>>>  F: tests/*.py
>>
>> Otherwise:
>>
>> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>
> 
> I swear I talked to Cleber and Eduardo before sending this, we'll wait
> for them to say hi :)
> 


