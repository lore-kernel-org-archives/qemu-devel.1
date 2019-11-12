Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9554EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B7421872
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvkH4ht9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B7421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaj1-00044W-AJ
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 13:17:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUaho-00039x-PG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUahn-0000Cg-0K
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:15:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23606
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUahm-0000CE-RH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573582553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4RSF5GKVtU2l8Jvie1oWby9QKZ55C48C1QxOZ4BZDQ=;
 b=cvkH4ht9pzO7Nom8greJZoTcYCU3sATuYm80q8sPQ+g9555Gp3YLuey8gB5RGtvLSSOVE3
 vzBz/FCSFm/Pbz+EFBhiJc9HGlhBOwskFfKMp9BWDD6hbjR2+YV3Ydy72d6OAwI7He/xo/
 Q/TuzdLUihcetLbGHAQB4e1hMhtZzl0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-Xb3a0DyLMp6E-X4p6qM0Ig-1; Tue, 12 Nov 2019 13:15:50 -0500
Received: by mail-wr1-f70.google.com with SMTP id v6so12313966wrm.18
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 10:15:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RX+/cypJ2/KnGf/e4sLCstDkho92zHLDDhgkqC7O+44=;
 b=RvH5qQSMMRuYhv038jlFNO9JehFPf7kGEdvBHpi85+7tMmZqQEOJ46/k4nveBE24jM
 PAZBJYjwkWXTwtPEQ9NlEH6GrPNOakhSgW/pa5JwVNPHmDhrtEq2ZcuiPeGfmqqkLFZC
 qlhEBsLOOyfMibWG0vkdhlUP/j+rYphIEQ+9CTB3KPAB0HRqqAa7hWqbgLeEAqqcFLUo
 feujnHsX6fF7N5pbX360VTgjFBYF2IrE0qBGy1Yq2fV9v7rK6KfZw5u3aMJ1cewUmlXb
 rnE4jNc88eB7rMsZ3s8g0BIkWRYitxwS8Ba+b+OgWPv+ZbcE7ZvkETUba0seUjO+7Mtv
 E0JA==
X-Gm-Message-State: APjAAAWhRGlVMD8SpnMKN6n8v2TOF3vRd4+CvsNEw+CIv7rO/DU9W4zx
 h4Cp1GI6hrf6evJCEBImOOj9pWEE0dThJmsTfB3+JuvSK1HoJoQ4vmYoS1Hj2HFNa1usiruR1Ym
 lPGVthxzoz4AyDg4=
X-Received: by 2002:a1c:740a:: with SMTP id p10mr4888189wmc.49.1573582549309; 
 Tue, 12 Nov 2019 10:15:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhd+So2f0DyzoEuneRWSkpK6XQFhQIn5MCKJevh4fX+lP5fanDe62ALL+hwKKLYrLvM8DViw==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr4888168wmc.49.1573582549109; 
 Tue, 12 Nov 2019 10:15:49 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id s9sm3473179wmj.22.2019.11.12.10.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 10:15:48 -0800 (PST)
Subject: Re: [PATCH v7 3/8] Acceptance tests: use avocado tags for machine type
To: Cleber Rosa <crosa@redhat.com>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-4-crosa@redhat.com>
 <b1730ec3-51ce-719b-81ca-e24194283ec7@redhat.com>
 <20191112015948.GA23968@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <132dfae0-9301-78ed-57e2-b8a4a7fd1840@redhat.com>
Date: Tue, 12 Nov 2019 19:15:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191112015948.GA23968@localhost.localdomain>
Content-Language: en-US
X-MC-Unique: Xb3a0DyLMp6E-X4p6qM0Ig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Beraldo Leal <bleal@redhat.com>, Jan Richter <jarichte@redhat.com>,
 qemu-devel@nongnu.org, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/19 2:59 AM, Cleber Rosa wrote:
> On Fri, Nov 08, 2019 at 02:20:45PM +0100, Philippe Mathieu-Daud=E9 wrote:
>> On 11/4/19 4:13 PM, Cleber Rosa wrote:
>>>            """
>>> -        self.vm.set_machine('none')
>>>            self.vm.add_args('-S')
>>>            self.vm.launch()
>>> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_=
initrd.py
>>> index c61d9826a4..3a0ff7b098 100644
>>> --- a/tests/acceptance/linux_initrd.py
>>> +++ b/tests/acceptance/linux_initrd.py
>>> @@ -20,6 +20,7 @@ class LinuxInitrd(Test):
>>>        Checks QEMU evaluates correctly the initrd file passed as -initr=
d option.
>>>        :avocado: tags=3Darch:x86_64
>>> +    :avocado: tags=3Dmachine:pc
>>
>> For some tests we can run on multiple machines (here q35), I was tempted=
 to
>> use multiple tags. How could I do that now?
>>
>=20
> I missed this comment: you can add many tag values here to *classify*
> the test as being "q35 machine type capable".
>=20
> But, Avocado will only run a test multiple times with a varianter
> plugin active.  In that case, a "machine" *parameter* with different
> values will be passed to the tests.  This tag value is being used
> as a default value for the parameter, so it has a lower precedence.
>=20
> We have a pending task[1] to create an initial CIT file for arch and
> machine types.
>=20
> CC'ing Jan Richter, who is supposed to start working on it soon.
>=20
> - Cleber.
>=20
> [1] - https://trello.com/c/1wvzcxHY/105-create-cit-parameter-for-acceptan=
ce-tests

Good news, thanks for the trello link.


