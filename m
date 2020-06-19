Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB42C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C60821852
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXxlKqlg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C60821852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIeV-00021R-KO
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmIdv-0001XE-N1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:09:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37709
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jmIdt-0007Y5-U9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592579361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vcYoFh2EYlkKZTJtdihxj62sogQ/N0J7k/b86uhRPiQ=;
 b=AXxlKqlgEaf1IJvaDl7lLLjOyqS6t/jP83J0ylo52ro7khQNwz0Mpxrw2OUKAfRyTRG/Hc
 LzlbQkM2827r2YD5z/XGYYM22/GmIFC1qFljawHKqL12wlf8qimoUMr48J5SjFnc7wWHFa
 3wJbzwNAov4/nwQ3+KIh0Iqr8C5rSHs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-4khPhDY9OsyNWBfCAbChwQ-1; Fri, 19 Jun 2020 11:09:19 -0400
X-MC-Unique: 4khPhDY9OsyNWBfCAbChwQ-1
Received: by mail-wr1-f69.google.com with SMTP id w4so4409354wrl.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vcYoFh2EYlkKZTJtdihxj62sogQ/N0J7k/b86uhRPiQ=;
 b=pXHLioGx0ZJ01Cpiv5NcGZ33ZsC34ZULU1+V5Pbe5WU9VRSjFZh5qQn4RppLl/da8U
 YjkFEW70ENiWFYrEGKeT8ywy9qETdNK2TORPRGoKsa7Vuyz/liONVNtel0PBXjKcAAfW
 1Sf70j/Oi6254jpFjioFZf1DscQG61BBQFf8ztbAvcgrSBpdseedGBGK/XQbZa7hzCnW
 gUKiW9ZaUjQgcSXr86PVjBymKlssYpT9OTxbmeRTkqcALfEcNYRrWkRTwEzp/8DYOGwH
 RGPkOVPvFv8F9OITMTjcEiqKpzHhAL+imMpQLitONpi7k3Av0BPSUvRNS1rnU5jNTbvU
 zp6g==
X-Gm-Message-State: AOAM533n7QEcyOyfbGdtsL2mhCGQKuLN+dQn5YhtIMhLSbYbkPeIeg2P
 4frwVw5xUQkSYKjDwI8CKDcmCCTsXnd2O0lGrO0o+J7HLHtIIdx/w/GX4Eyo5OTolzeHzg0b5fC
 wT/CzWseE64hAp+M=
X-Received: by 2002:a5d:6749:: with SMTP id l9mr4522366wrw.63.1592579358212;
 Fri, 19 Jun 2020 08:09:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbxq8S/9dIl6J1KaQ+hR3p4cQUpdCSd3IGF418LdM0/bxbwrpHuIS22cnD5+BqwIdNhw1ugg==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr4522341wrw.63.1592579357878;
 Fri, 19 Jun 2020 08:09:17 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id t8sm6868822wmi.46.2020.06.19.08.09.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 08:09:17 -0700 (PDT)
Subject: Re: [PATCH 0/7] python: create installable package
To: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>
References: <20200603001523.18085-1-jsnow@redhat.com>
 <20200617195241.GA434320@localhost.localdomain>
 <32791435-4aa4-7eaa-e2c6-b53165f2e28d@redhat.com>
 <20200618092319.GA6012@linux.fritz.box>
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
Message-ID: <95eb7bb7-577e-045f-3285-ae41194ff0bc@redhat.com>
Date: Fri, 19 Jun 2020 17:09:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200618092319.GA6012@linux.fritz.box>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 11:23 AM, Kevin Wolf wrote:
> Am 17.06.2020 um 22:27 hat John Snow geschrieben:
>>> In the Avocado project, we have a `make develop` rule that does that
>>> for the main setup.py file, and for all plugins we carry on the same
>>> tree, which is similar in some regards to the "not at the project root
>>> directory" situation here with "qemu/python/setup.py".
>>>
>>
>> Ah, yeah. If we're going this far, I'd prefer using a VENV over
>> modifying the user's environment. That way you can blast it all away
>> with a `make distclean`.
>>
>> Maybe the "make develop" target could even use the presence of a .venv
>> directory to know when it needs to make the environment or not ...
> [..]
>> For QEMU developers, installing with develop is going to be the smart
>> way to go. When your git tree is updated, your package will be updated
>> along with it. You can do it once and then probably forget about it.
> 
> I don't think we can make this a manual step at all. Building QEMU
> requires running some Python scripts (e.g. the QAPI generator), so the
> setup needs to be done either in configure or in a Makefile target that
> is specified as a dependency of any rule that would run a Python script.
> Building QEMU once would then be enough.
> 
> Doing it automatically also means that we have to keep things local to
> the QEMU directory rather than installing them globally into the user
> directory. This is desirable anyway: Most of us deal with more than one
> QEMU source tree, so conflicts would be inevitable.

Indeed. Each of the source tree I use has its own virtual environment.
I personally stopped using the distribution packages, they don't make
sense when you develop, the tree changes too quickly.

Distributions use stable releases, so IMO it only makes sense to
generate a package along with releases. Else use venv.


