Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C714EC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:29:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDCB206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y73XA8z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDCB206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV0CZ-0003sr-Nh
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 16:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iV0B2-0002P0-Kj
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iV0B1-0005Yk-7Y
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:27:48 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:42053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iV0B1-0005YC-1n
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:27:47 -0500
Received: by mail-ot1-x332.google.com with SMTP id b16so2957941otk.9
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 13:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qPVGGNgY24scUobX0gUW+fBmCYd69HkeJKYQn0M3JP8=;
 b=y73XA8z2bp+SMZ7qa5/1nnq1DQBK8sEP8hikU6/MHqzA4rBX/mrVrQ/0phDSIc/BAM
 7BxEJTVfmM1anZuo6cezi8/QsFibw91Kg7hNKpOn+/cFGCkv61ahYIT5IOelSI03HzUu
 CVVDXfDbf7QCxUshBrhPMo9AL6w9yMwWnfRcHUXNJ2NrALtdSS2k8s0uCyaTvo+Oh2yE
 CJHViDjxAiHqK6i/31q3lgoaJplFkDUp+aqdYWCGd81aHARvoVusVlDJYfxCoR+0oxKC
 qJm5jw1gGmXTUwdbH1AseocYahQgqNZxHQXV8szu19U69lKd/xkxqaZLuq1B0Co1p9kh
 NSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qPVGGNgY24scUobX0gUW+fBmCYd69HkeJKYQn0M3JP8=;
 b=IdRjfjo0xTLunXTOwSHMX8KpLyaccAuPsgujK5nNo3a2mGDOvGoxkwfJ/5i1EwoCJc
 9nf7nRGpGB8UjytlKHEAI4/HwpAPf7u+MuUrvoLl+vD2aSSV4cICK3bKznmt+YjN84Qh
 c/5iR9REc6CpUoIfUbtSbBmPi8AEwQrM5OF0fyVYFK1zjjsaESzZpe8JLDXstJ9OBJFv
 7m9dT3evyG3B1UTog7wUoZnKAkVBqVx8Fyq+XYMn3urbFFEl6fmq9Zh0D+yQL4vqlUzl
 2vYJgYDKbjhhF6hIyO/aHQGIUO8WhGkB0uIMY9P+n6FwZz0WhZBgtPibc4+FMN7uEB4D
 qiZQ==
X-Gm-Message-State: APjAAAVxuhM6+Pr1EQHUR/f1/xPzI9MDUTUSOKY00/YR6r0gsorvItd5
 jQwI6Rh5w5IQKKegEAPWXSdPnueZ9BDx8YxSsEEdSQ==
X-Google-Smtp-Source: APXvYqy2hd7cjkWdK+9yfPxr9B1yY5Elgcx4p8vJbIhHcICk+eCBvkiPGDRcBC5ixwfm0ltlVIV3LTVvEjmCUQEkVJw=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr5258550otg.232.1573680466422; 
 Wed, 13 Nov 2019 13:27:46 -0800 (PST)
MIME-Version: 1.0
References: <BYAPR02MB48863165DEE32E5C563E93F4DE650@BYAPR02MB4886.namprd02.prod.outlook.com>
 <CAL1e-=jvmJNiZR4iLDL-97qm=v+2s0cwn5YTzJQ=JZ_gwOe4tQ@mail.gmail.com>
 <BYAPR02MB4886C8D82898F1E406C124F8DE7E0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <BYAPR02MB48865884056A88B660B620FCDE770@BYAPR02MB4886.namprd02.prod.outlook.com>
 <87d0dw83uz.fsf@linaro.org>
In-Reply-To: <87d0dw83uz.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Nov 2019 21:27:35 +0000
Message-ID: <CAFEAcA8h=NajDccd7o2zRt3_zBLbrmOjP0qpyd07aEMbUe-FxQ@mail.gmail.com>
Subject: Re: QEMU for Qualcomm Hexagon - KVM Forum talk and code available
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: Alessandro Di Federico <ale@rev.ng>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Niccol=C3=B2_Izzo?= <izzoniccolo@gmail.com>,
 Taylor Simpson <tsimpson@quicinc.com>, "nizzo@rev.ng" <nizzo@rev.ng>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 13 Nov 2019 at 10:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> I don't see including flex/bison as a dependency
> being a major issue (in fact we have it in our docker images so I guess
> something uses it).

They're used by the dtc submodule, so only in setups where you
need to use the submodule rather than the system libfdt.
In fact I think that dtc doesn't require them for building
libfdt, but its build machinery complains about them being
missing (it needs them for building the 'dtc' binary, which
we don't try to build), so providing them shuts up the
misleading warning.

thanks
-- PMM

