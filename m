Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDA721872
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCe1354P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDA721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUaig-0003f4-Ho
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 13:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUahH-0002nE-4M
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:15:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUahE-0008QM-Kd
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:15:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21351
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUahE-0008Py-Gp
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573582519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z2kV4bgB3Kt8d3doWvMF/1U6nS/1sXhYK9iHIqH0u1k=;
 b=HCe1354Pq+Z0BHDPIoAP5YFz+l1s0tEbtl+gv9aMyEInr1P/O1dzlRM7nvok0V/D9MWtZz
 K9RzoNB0OGnl3zfLGl6F+77uFs14oRajfzZJvpxNNhbd8fP4kCn2OT8vqk8EqcSmanfA1P
 VyIjYi1PYxWoehCvzSqcsvBe77x2+j0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-46fkVoOCNPKYN_3iKgT56w-1; Tue, 12 Nov 2019 13:15:16 -0500
Received: by mail-wr1-f72.google.com with SMTP id 92so12453566wro.14
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 10:15:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E/su7BECqHJSJlTrUQrP5nwzf0jEfOkcU1V5I6cKnd8=;
 b=oeGGCIYuHU22luYosVt7EL92R4LkBRKigiKXUlhllqZV38ADSfapeB3PnOI7Bx1mBj
 3G3DISMaQ+uzuv/PAPYfmr2Pp0oifV4OGNeVuyYwcxQI/CBw+F2whGLQpnom9UH5wFq0
 hoJusEyzWTnXyES1TBipCXzXyr1cxWkRUr+mE31IFmejSb5FPhKifeOWpYhhWDvHegeK
 CpfkUIodrBcmBGGkNx7oAGwYO1aDLer0+ke7JMS1ocubD3QnLAxwULDg1BO2arCPIs7U
 ZLb5A0E8DkmdyzhdIlwNPjHF4VwB7+812VZ3mqst90JtfSLYUkQl7V7dC/cgUjo9vhHj
 HBMA==
X-Gm-Message-State: APjAAAWTQ7ih432qDME4qPka/89jPSqgQagBvfXw05sMZ3rFOOzeTSfZ
 LqhY4qMugdSwpaiAE0fnm1Q/zN+69wCDfRuB/UYAxPlPeWeKndU0Oj3DCAQLnicKG4Jc19Fg6tL
 yIqQsJ1B1iMLLcOg=
X-Received: by 2002:a1c:808d:: with SMTP id b135mr4959140wmd.175.1573582515464; 
 Tue, 12 Nov 2019 10:15:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUM5BJz2eUgqst4NOsziroWcD6U+k0CwRQwdPb00g3ndX4SwQtPmNREK1ddAMwZZhbJfTRzg==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr4959106wmd.175.1573582515230; 
 Tue, 12 Nov 2019 10:15:15 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id z4sm4309921wmf.36.2019.11.12.10.15.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 10:15:14 -0800 (PST)
Subject: Re: [PATCH v7 3/8] Acceptance tests: use avocado tags for machine type
To: Cleber Rosa <crosa@redhat.com>
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-4-crosa@redhat.com>
 <b1730ec3-51ce-719b-81ca-e24194283ec7@redhat.com>
 <20191111214957.GC19559@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ebd5af02-c0cc-813b-1fd0-5e9768833e9d@redhat.com>
Date: Tue, 12 Nov 2019 19:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191111214957.GC19559@localhost.localdomain>
Content-Language: en-US
X-MC-Unique: 46fkVoOCNPKYN_3iKgT56w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/11/19 10:49 PM, Cleber Rosa wrote:
> On Fri, Nov 08, 2019 at 02:20:45PM +0100, Philippe Mathieu-Daud=E9 wrote:
>>> @@ -310,7 +302,7 @@ class BootLinuxConsole(Test):
>>>        def test_arm_emcraft_sf2(self):
>>>            """
>>>            :avocado: tags=3Darch:arm
>>> -        :avocado: tags=3Dmachine:emcraft_sf2
>>> +        :avocado: tags=3Dmachine:emcraft-sf2
>>
>> Maybe add a comment about this change, "Since avocado 72(?) we can ... s=
o
>> use ..."
>>
>=20
> You mean on this specific test docstring?  I'm confused if there's a

No! Just in the commit description :)

> special reason for doing it here, of if you're suggesting adding a
> similar command to all tag entries which make use of the extended
> character set (which I think would be too verbose, repetitve, and hard
> to maintain).
>=20
>>> diff --git a/tests/acceptance/cpu_queries.py b/tests/acceptance/cpu_que=
ries.py
>>> index af47d2795a..293dccb89a 100644
>>> --- a/tests/acceptance/cpu_queries.py
>>> +++ b/tests/acceptance/cpu_queries.py
>>> @@ -20,8 +20,8 @@ class QueryCPUModelExpansion(Test):
>>>        def test(self):
>>>            """
>>>            :avocado: tags=3Darch:x86_64
>>> +        :avocado: tags=3Dmachine:none
>>
>> Not to confuse with None :)
>>
>=20
> Yep! :)
>=20
> - Cleber.
>=20


