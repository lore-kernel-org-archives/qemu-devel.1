Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C1EC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C74A207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BD17TmyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C74A207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtqb-0006M0-79
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAtd3-00084k-Lk
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAtd1-0001IX-TK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:25:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAtd1-0001H3-IT
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:25:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id v8so2526625wrt.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ksqPaSvT/Z7IK9AS5pVSJVleJ8F5p8sjOHedTb/ht0M=;
 b=BD17TmyJwLxLESPq+w9cm/GYKEJobv9CmAVIcoUS2pFSmBZEascb7Mf4bFlu34j9gC
 +IPNg6EgVy4tt/WNPOTBHEyiBiZqczrCswRTZP238J403w7KvQypgBXw8T3tXryzSVR0
 txiV6XzZYXfQ3rugY+1CeLQrAHxL0aLbTa+u3wO5A+xRJ5akmPEUNRDo6gfxpm3JPs+k
 gFGnnbxE5SfH68+u7jUd8rlKAZL6he53PA/M6P/IrOUB+vARYTogHOsD+8fop1oh6+5s
 az22wngeW+ctNhIAu6ff0Arm2GvTElKDQZHscOHTsuR670ArWcRNzIJA6Ik6lZI89ydB
 zuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ksqPaSvT/Z7IK9AS5pVSJVleJ8F5p8sjOHedTb/ht0M=;
 b=OrDGoYMC2HxBzVqrWQmwZrRV4Xi4e8DDN2kSX6cce+4pTD0/3wFn7RzZKbmDxds6c4
 BO8rOJTfuHoccqFH2CNoApkz877S/OaZczhmzH3IgNAYb8V/qY3wj9EilfoDBEKHHJos
 5+0raZ3WVs+rproKSE5l6meL700Z4kOjrlWPNT1KL8w95U1+erMewX/mED642nu8EpEg
 qCXCaQKkq1fqB8jt63rRpeI4/1fxURbR7AZuHVhhiMqkwoJiNRKv+gG/G3c/S6oq7WV2
 iMpPhlcTMxOPdXSXQJuUZjJK8qEICM6H5vvG2mzfUn2cS8bf2JCQRaBhKgnDJWsb2pGZ
 WPKw==
X-Gm-Message-State: APjAAAXGVLaCuUet03Z4Px/zbUPSQ/mPGrfjrEnBjK1xSbGJpS4dKxiJ
 PjNHklC3Zv3kdPr+D6h6hs8x0w==
X-Google-Smtp-Source: APXvYqw/gGIuI9mE9UiuoGZhVqE4nwVN1zHeV41zr02HYU9o4UBp4x6L2TEcdmAf0m7FhcUEhhjhxg==
X-Received: by 2002:adf:f790:: with SMTP id q16mr6813753wrp.164.1568888733857; 
 Thu, 19 Sep 2019 03:25:33 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z189sm7924729wmc.25.2019.09.19.03.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 03:25:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 820661FF87;
 Thu, 19 Sep 2019 11:25:32 +0100 (BST)
References: <20190913154952.27724-1-peter.maydell@linaro.org>
 <20190913154952.27724-13-peter.maydell@linaro.org>
 <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <9ede7068-7f92-3e1a-c1f8-c0994eddf671@redhat.com>
Date: Thu, 19 Sep 2019 11:25:32 +0100
Message-ID: <87r24czioz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PULL 12/12] qemu-ga: Convert invocation
 documentation to rST
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Eric Blake <eblake@redhat.com> writes:

> On 9/13/19 10:49 AM, Peter Maydell wrote:
>> The qemu-ga documentation is currently in qemu-ga.texi in
>> Texinfo format, which we present to the user as:
>>  * a qemu-ga manpage
>>  * a section of the main qemu-doc HTML documentation
>>
>> Convert the documentation to rST format, and present it to
>> the user as:
>>  * a qemu-ga manpage
>>  * part of the interop/ Sphinx manual
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Message-id: 20190905131040.8350-1-peter.maydell@linaro.org
>> ---
>
> In an incremental build on Fedora 30, I'm now seeing:
>
> 	CHK version_gen.h
>   GEN     docs/interop/qemu-ga.8
> No filename or title
> make: *** [/home/eblake/qemu/rules.mak:394: docs/interop/qemu-ga.8]
> Error 255
>
> and suspect this patch introduced it.  It may be that I just need to
> nuke intermediate artifacts rather than an actual problem with the
> patch, but I'd welcome help in identifying the problem.

It did - it's also the commit that has broken shippable builds. Once I
reverted they started working again. However I'm finding it hard to
trigger in the same containers on my setup so I'm confused as to how it
breaks.

--
Alex Benn=C3=A9e

