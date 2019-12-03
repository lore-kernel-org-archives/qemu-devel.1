Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ACEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AEE206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMhxz3mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AEE206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic5Gr-00087K-0P
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 05:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ic5CV-0006QS-UK
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ic5CR-0004vG-C6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:14:33 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41448)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ic5CO-0004mz-MF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:14:29 -0500
Received: by mail-wr1-x444.google.com with SMTP id b18so2890491wrj.8
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 02:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=o7iIMVUWwSDaCtXcwAYV2by/y8tsscNYndU0yx7cnhU=;
 b=FMhxz3mLd8sjLKVsVm37tzq0axBnjFRp2FlSQ8XN5+yOL98sMoSEzn4aIC0dmHW1Dy
 3GVp8dzXFJ04EI+W2C/wNQJaKmxIzdzKcoxQOVApNkuelN7uCUShDiLtDIloCgUOpjCx
 SvpDJM+VGsNgETcY+mvrpWS1UPG5a5/eTT4LZ3Ky6sn5ifn+ZXZjSm61iHHXvvwjufDE
 LVfOI9h7W/8zHLatU0M9fkRP+UI7MZrFxsiSBHB4gMWFiytztwxHgr2Vgnpoaz8zEtZl
 EJnasPS3mAOqUNcbOfmj0Vr5lQAHAWP1Nc7fevTH/jb/0f8I75vBshZiVCCwvte0KPbO
 azTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=o7iIMVUWwSDaCtXcwAYV2by/y8tsscNYndU0yx7cnhU=;
 b=AQMG4sAcd4XUPlTTKQgWog9KQE6BKPLT6irSvPekgCH1W4NhSklJL92Fypi9Sx6Frh
 CDHe9SeecWTssUCS1O9BSb5xTVwRy7l/tgKXz2262W8c4186rm4XT+nImqzAo6B86cN3
 PyzTA6NRtlP4jUtbKhS1TQFcMDEwutVVATkLMMC2vmPIH4UW9XFIVQxiel7LlB8xFqu3
 MwXKCT/JZML5nVV63MKAJ1gBjMJPO1tgJ8nd5hRSZwqk+1jYQCOXMItOXKZOFvq6Fs0/
 XmMnd/IZQ0o8Qy754+xm+KA8WOb11V6BTscFMxvnRfak877CcAh/7b4VhffBO4qQCzbE
 xrbw==
X-Gm-Message-State: APjAAAUIeMdNuQ2fy4V24IcFrrfVxbAqY3J3DgHSm8YyppAfFFnzAQo3
 aaotQyfKUN6ThB6ujwGxL47kmw==
X-Google-Smtp-Source: APXvYqyjK+IwOFVneGjQ2/0JjM3NQXnt4CvqbDmnthlgWfrkROTefEgwr47XgJu6QaIbnUWMqfShfA==
X-Received: by 2002:a5d:68c5:: with SMTP id p5mr4285823wrw.193.1575368065154; 
 Tue, 03 Dec 2019 02:14:25 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g23sm2353577wmk.14.2019.12.03.02.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 02:14:23 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 25B9B1FF87;
 Tue,  3 Dec 2019 10:14:23 +0000 (GMT)
References: <20191202101631.10003-1-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/3] iotests: Check for the possibility to create large
 files
In-reply-to: <20191202101631.10003-1-thuth@redhat.com>
Date: Tue, 03 Dec 2019 10:14:23 +0000
Message-ID: <87o8wpbts0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Travis recently added the possibility to test on ppc64le, arm64 and s390x
> hosts, too. However, the containers are very restricted there and do not
> allow the creation of large files, so that the tests 060 and 079 are
> currently failing there. So let's add some proper checks to these tests
> first.

These look good to me, do you want them to go via my testing/next or are
Kevin and Max going to take it via their tree?

>
> Thomas Huth (3):
>   iotests: Provide a function for checking the creation of huge files
>   iotests: Skip test 060 if it is not possible to create large files
>   iotests: Skip test 079 if it is not possible to create large files
>
>  tests/qemu-iotests/005       |  5 +----
>  tests/qemu-iotests/060       |  3 +++
>  tests/qemu-iotests/079       |  3 +++
>  tests/qemu-iotests/220       |  6 ++----
>  tests/qemu-iotests/common.rc | 10 ++++++++++
>  5 files changed, 19 insertions(+), 8 deletions(-)


--=20
Alex Benn=C3=A9e

