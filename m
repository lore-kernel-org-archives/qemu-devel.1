Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302F3C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09FE20726
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpU0woxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09FE20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAEVS-00071q-77
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 10:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAEUs-0006bm-4a
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAEUn-0004Cu-10
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:02:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32684
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAEUm-0004A2-Sy
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583506955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LAbzIvEU3IFjt+Pj9bB3Ul0mwDFzKOVtWh6m6P4atW4=;
 b=gpU0woxcCVa4KXk4m7h0Ldo2r3k7HtGrSHz0BXlvnXAiVIIHuFw1YFYYZpoVhsWD286qGv
 J91vapwkiNon5+YnSUsanoB9x2cd/rJ1juIRk8gRaWwjLD/2wQqUYlbpPJ9e6AOTylM+GR
 cIZZoq3BF2I71jjFA/CqtadAzd67GCI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-7aSzt9BJNpeCLFHxTO3otQ-1; Fri, 06 Mar 2020 10:02:33 -0500
X-MC-Unique: 7aSzt9BJNpeCLFHxTO3otQ-1
Received: by mail-wm1-f72.google.com with SMTP id p17so755902wmc.9
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 07:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BNUEw94ouFBGadzQ44/wlbVc0MSORycz9oKgoU5n92o=;
 b=kpj1TKiG/oUvCvIyMnGR4MdTLKPVOX1DRFQsZY2R2Mfpn7jEt3hbuVmxAKjN1wNQvw
 tVr1h7MEGbbPd1604/3wdr/CcMrk2ZEnIk6jedYlR6myeO/bhgCY14SL/cyYNdrsua/n
 FNVpj6PDPDO2+Tmha75/o7gg8wvHmq2UPVVgt7NhoCyXQ85DlPGAWGzRdCT+eagdMIAm
 tbh+HCbiy4D6xZdqABfE1t28h9/gtXBY+W5qDttUVhDZssQOp42v5BLvJun7+RTPHAlz
 JnQL0RO7aVIbXsWaMK0xSGmrhj/NfqiCESeMGSTc7X4M0vEeIoDYIWHLcM/oA551sBr5
 rddw==
X-Gm-Message-State: ANhLgQ2KPGVfz+3lTiQuyCrt/VHokkcmHG2T7nv/Ky2S1g0C+5UzqixD
 ilV4U74ZoSdZ16EK8yoyCmqeNLeWuINwdhxcwt5S35fPF6pvZpYqgY7qNWSBS/KCT03px9h6zMu
 umnVDW1zFxeJplUc=
X-Received: by 2002:a05:6000:12cc:: with SMTP id
 l12mr4472487wrx.304.1583506952608; 
 Fri, 06 Mar 2020 07:02:32 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuu8tsyXLsNrYfhQu2WJkx4F9A99UPdktbh9ajZY9MZOBe4JbvunzV7ciYL29ZQXVt9zyypZw==
X-Received: by 2002:a05:6000:12cc:: with SMTP id
 l12mr4472467wrx.304.1583506952309; 
 Fri, 06 Mar 2020 07:02:32 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q6sm5473294wmj.6.2020.03.06.07.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2020 07:02:31 -0800 (PST)
Subject: Re: [PATCH] qemu.nsi: Install Sphinx documentation
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200306134751.2572-1-peter.maydell@linaro.org>
 <70e18816-1d16-93a1-5e49-2f54132602fb@redhat.com>
 <CAFEAcA_wowY8fhsLXGZeHbdRP+1G58KmDUsLbB5WYw91KoF8+w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5d9f2189-fa75-32ab-2042-14eeab92fbf7@redhat.com>
Date: Fri, 6 Mar 2020 16:02:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_wowY8fhsLXGZeHbdRP+1G58KmDUsLbB5WYw91KoF8+w@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Stefan Weil <sw@weilnetz.de>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/6/20 3:54 PM, Peter Maydell wrote:
> On Fri, 6 Mar 2020 at 14:32, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>>
>> On 3/6/20 2:47 PM, Peter Maydell wrote:
>>> The old qemu-doc.html is no longer built, so update the Windows
>>> installer to install the new Sphinx manual sets.
>>>
>>> We install all five of the manuals, even though some of them
>>> (notably the user-mode manual) will not be very useful to Windows
>>> users, because skipping some of them would mean broken links
>>> in the top level 'index.html' page.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> I've tested this (building it via the fedora docker image
>>> and installing into a Windows VM) but I don't know anything
>>> much about the installer so there might be neater ways to do it...
>>>
>>> NB: I didn't realize that patchew included a test of building
>>> the Windows installer, so until we get this (or some variant)
>>> into master I'm afraid patchew will be emailing failure reports
>>> to every submitted patchseries. Sorry about that :-(
>>> ---
>>>    qemu.nsi | 22 +++++++++++++++++++---
>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/qemu.nsi b/qemu.nsi
>>> index 0c29ba359cd..1a0112265b0 100644
>>> --- a/qemu.nsi
>>> +++ b/qemu.nsi
>>> @@ -177,9 +177,20 @@ SectionEnd
>>>    !ifdef CONFIG_DOCUMENTATION
>>>    Section "Documentation" SectionDoc
>>>        SetOutPath "$INSTDIR"
>>
>> Now that we have multiple files installed, I'd move them into a separate
>> directory: ${INSTDIR}/docs/ seems appropriate. Can be done later.
>>
>>> -    File "${BINDIR}\qemu-doc.html"
>>> +    File "${BINDIR}\index.html"
>>> +    SetOutPath "$INSTDIR\interop"
>>> +    FILE /r "${BINDIR}\interop\*.*"
>>> +    SetOutPath "$INSTDIR\specs"
>>> +    FILE /r "${BINDIR}\specs\*.*"
>>> +    SetOutPath "$INSTDIR\system"
>>> +    FILE /r "${BINDIR}\system\*.*"
>>> +    SetOutPath "$INSTDIR\tools"
>>> +    FILE /r "${BINDIR}\tools\*.*"
>>> +    SetOutPath "$INSTDIR\user"
>>> +    FILE /r "${BINDIR}\user\*.*"
>>> +    SetOutPath "$INSTDIR"
>>
>> The last SetOutPath seems alone (copy/paste mistake I suppose).
>> Otherwise looks good.
>=20
> No, it's deliberate. I wanted to put the output path back
> to what it was at the start of this section, because I
> wasn't sure if any of the commands below this point
> implicitly depended on it.

Ah good point.

As this patch unbreaks patchew:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>>>        CreateDirectory "$SMPROGRAMS\${PRODUCT}"
>>> -    CreateShortCut "$SMPROGRAMS\${PRODUCT}\User Documentation.lnk" "$I=
NSTDIR\qemu-doc.html" "" "$INSTDIR\qemu-doc.html" 0
>>> +    CreateShortCut "$SMPROGRAMS\${PRODUCT}\User Documentation.lnk" "$I=
NSTDIR\index.html" "" "$INSTDIR\index.html" 0
>>>    SectionEnd
>>>    !endif
>=20
> thanks
> -- PMM
>=20


