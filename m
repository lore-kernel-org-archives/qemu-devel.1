Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45204C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0968820661
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 14:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGS8hOm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0968820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT51c-0002ak-4T
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 10:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT4xB-0003j7-BW
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jT4x9-0000fb-0m
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:41:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56755
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jT4x8-0000b6-H6
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 10:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587998505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LTwE1w8j+9u5wO0DlK1I4oOJCf5xejwbfBeRhgAEjA=;
 b=GGS8hOm52yuqO7UQBuG2m/Bd7Nj49239c0rasS5Rj5+1OXLroYpThZo+ZWmUoty7EFZeJm
 WtoEu4zcAtXbsfHcA3Z4X2Dms2JyzXoC/hBiGT7T9icuWdNPmf3j+ghF6mAQTdZdjRSX58
 T0Q4PApwEPH/3BD+FSbWrGtlxl9XaDM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-mgzudmVKNpiXCUjEsIBQ1A-1; Mon, 27 Apr 2020 10:41:43 -0400
X-MC-Unique: mgzudmVKNpiXCUjEsIBQ1A-1
Received: by mail-wm1-f72.google.com with SMTP id 71so8759574wmb.8
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 07:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rUbwZ57pRsc+UZppZ0WcGMMmfi6R7DKlILXz3S0q32I=;
 b=d6O1ebSdKZaNOX49PYC+3h9MO0CUTO7ed94KzCXzOj2QOHMl0LVguQDTFr3ZNo/0sM
 aMVQnX+NyJ9r1WxlmanqbZMjaq44EDkCXpEUlKRglIOSAdsrjzd8csRUIL2DcnNE0mTV
 qanLtPQnzxZeLcTXcMQdO0Yw7GFGYIyoG8A5VBsEhcaqGK2V5wDTkgBO6imEKQUb1s1f
 KsqxvtAlv75DPCn0fNc7ZUeh+0t/3UDAXm47FQya+qimEOjxsAjkBV99lmXougPnTZ0W
 HUXtlU3E4iK1zf0Pltq01JWdirW+nWDDXtoeaNP8Ms/DVDa4BmEm17qxy2hyDcDUmxCO
 zBjQ==
X-Gm-Message-State: AGi0PuamsMrw2eBJcxROTZGtHoCt2qkZD+/suiheFTI45pTLu4R4K7U3
 trWiLkXmEHkEZ+V0gNENee9cgFK8O04Ah95PgAkmTIiPMb8KrBsCAzmkgKasCuD3qSdmU7J4Aw8
 dDMk3iAYyuzADliI=
X-Received: by 2002:a1c:2d02:: with SMTP id t2mr26508797wmt.98.1587998502001; 
 Mon, 27 Apr 2020 07:41:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKJKjdFxoXGhDUtyhm3b+D327jFaTjFXN+a4nzlgG439n6xKcpiXfUXpFfkS57C3H0onqEi4Q==
X-Received: by 2002:a1c:2d02:: with SMTP id t2mr26508699wmt.98.1587998500710; 
 Mon, 27 Apr 2020 07:41:40 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id j13sm22091845wrq.24.2020.04.27.07.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 07:41:40 -0700 (PDT)
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA8Lw94_=kY+Fv-cFW2Tk5RD62EjODjKdGf2-mLdDw7FuQ@mail.gmail.com>
 <1182067639.1655516.1584421185287.JavaMail.zimbra@redhat.com>
 <CAFEAcA-zRw7kzwzXxPmLaUqwOrQLwW9BymOJ34iJOOTCUAf=xg@mail.gmail.com>
 <20200317141257.GA5724@localhost.localdomain>
 <CAFEAcA9W4KXN6dcT0CNyD_mQ3xY5wDmJ7i0wowhaG2XPmyMYng@mail.gmail.com>
 <87sgi49uf6.fsf@dusky.pond.sub.org>
 <CAFEAcA_dcVneQ4Hj61GAkYRCUSMrA=QjwnAXccoBwjUjOE-wSQ@mail.gmail.com>
 <529508877.9650370.1587661453005.JavaMail.zimbra@redhat.com>
 <20200423171322.GJ1077680@redhat.com>
 <69e77a6e-8db8-f617-bfe6-1c8f39ec81b4@redhat.com>
 <20200427011210.745db351@redhat.com>
 <05670290-5ba0-8be0-624b-da1c95f3e820@redhat.com>
 <20200427102835.6f625859@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <48b0d8e6-3b9d-981d-c6a3-bdee5580f701@redhat.com>
Date: Mon, 27 Apr 2020 16:41:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427102835.6f625859@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer Moschetta <wmoschet@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 4:28 PM, Cleber Rosa wrote:
> On Mon, 27 Apr 2020 12:51:36 +0200
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 4/27/20 7:12 AM, Cleber Rosa wrote:
>>> On Thu, 23 Apr 2020 23:28:21 +0200
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>> [...]
>>>> In some cases custom runners are acceptable. These runners won't be
>>>> "gating" but can post informative log and status.
>>>>
>>>
>>> Well, I have the feeling that some people maintaining those runners
>>> will *not* want to have them as "informational" only.  If they
>>> invest a good amount of time on them, I believe they'll want to
>>> reap the benefits such as other not breaking the code they rely on.
>>>   If their system is not gating, they lose that and may find
>>> breakage that CI did not catch.  Again, I don't think "easily
>>> accessible" hardware should be the only criteria for
>>> gating/non-gating status.
>>>
>>> For instance, would you consider, say, a "Raspberry Pi 4 Model
>>> B", running KVM jobs to be a reproducible runner?  Would you blame a
>>> developer that breaks a Gating CI job on such a platform and says
>>> that he can not reproduce it?
>>
>> I'm not sure I understood the problem, as I'd answer "yes" but I
>> guess you expect me to say "no"?
>>
>=20
> What I mean is: would you blame such a developer for *not* having a
> machine himself/herself that he/she can try to reproduce the failure?
> And would you consider a "Raspberry Pi 4 Model B" an easily available
> hardware?

My view on this is if someone merged code in mainstream QEMU and=20
maintains it, and if it is not easy to reproduce the setup (for a bug=20
reported by a CI script), then it is the responsibility of the=20
maintainer to resolve it. Either by providing particular access to the=20
hardware, or be ready to spend a long debugging session over email and=20
multiple time zones.

If it is not possible, then this specific code/setup can not claim for=20
gating CI, and eventually mainstream isn't the best place for it.

>> [...]


