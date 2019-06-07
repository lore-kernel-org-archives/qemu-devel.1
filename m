Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08957C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0CA20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 10:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJUXJiWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0CA20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZCLa-0007So-2F
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 06:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48598)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hZBGG-0000WN-9l
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hZBGE-0004I7-FE
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:34:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hZBGC-0003iH-8U
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 05:34:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id w9so3649100wmd.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 02:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1V0A3lLlFR+/W3I7GyrZzT1wbmEG8To+8XsecQQAU4s=;
 b=NJUXJiWYFgmT51A9TGkaBXTbdR3xJ7ohzKIlL7LjBHZYbdc/UnK5rRMQ33AIFCEAws
 l2j/5K/62IIyuJuNejDWpHu0CVpCOpTmywLJmtzU4LOlrSxQf0xZ0FnSfmWpspP2ehIV
 +cAydtGz9uwx19ZBa9lLiYfryJUmK13bvpjJMaypuJLctVCb24FPjJi1qWfDdqcrIvcZ
 xlmVoXme8JGnH5153asJLvLB3Tswyx84iJXcayjsj3LISEi6SmFkAbspKlil5sI2k6i3
 db1dOXWBOYRS0h9bNKWGGFmp+HbXKSi8kBD6sx6PWxwp6DT/blSDXUUyplT88t0R+hcJ
 GxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1V0A3lLlFR+/W3I7GyrZzT1wbmEG8To+8XsecQQAU4s=;
 b=HGcvtpRo3ON9DcqCZHPoUKvtv5TM5c3oLDFrQBNkikijGnyZJ3d0lhH01y8kh/JAPY
 jKtacgAaDfbvpN2WWBmwvFk29m4FxBrgFVgf3oDAUrjTZHsHRyvz6xvqRgzc/uYP5UmZ
 VteHs1lmZmql9IyZk/nwRrF/cKu0iWzoeIN0jDiaKsUSYIC6+sSl4td3rDXmkzif4JJV
 mcjSVk5W8Hfzs7XeA+as0XEVi0f4FcUutPa3xLlXHoCN/SNeAs9zuJC/HdwQ+RZJEzwz
 3NofV0KVq/9ukuRgGbhLe2WQB1aYDuY3zFyqZGMjivXSCwnay5mlfcld41eMmosDT3Pi
 8NxQ==
X-Gm-Message-State: APjAAAWkIsZorHxLGfAS2YcqS0GuRdUkCJ/xF6LpTp0QK04HQUkhB3Dn
 JGTrR8mi96/nYKG3M4g2odEOn+V9kPo=
X-Google-Smtp-Source: APXvYqyvpV36/Xqqn/iIfM40pCHnRNfIN9YRWMVDawEXUAS5uNYDqcEbTmeiioztzmMWWV2ls8Xthw==
X-Received: by 2002:a1c:cfc3:: with SMTP id f186mr2719646wmg.134.1559900030739; 
 Fri, 07 Jun 2019 02:33:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c7sm1483173wrp.57.2019.06.07.02.33.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 07 Jun 2019 02:33:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9BEB51FF8C;
 Fri,  7 Jun 2019 10:33:49 +0100 (BST)
References: <20190530101603.22254-1-alex.bennee@linaro.org>
 <20190530101603.22254-4-alex.bennee@linaro.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190530101603.22254-4-alex.bennee@linaro.org>
Date: Fri, 07 Jun 2019 10:33:49 +0100
Message-ID: <87imthsps2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 03/26] tests: Run the iotests during
 "make check" again
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> People often forget to run the iotests before submitting patches or
> pull requests - this is likely due to the fact that we do not run the
> tests during our mandatory "make check" tests yet. Now that we've got
> a proper "auto" group of iotests that should be fine to run in every
> environment, we can enable the iotests during "make check" again by
> running the "auto" tests by default from the check-block.sh script.
>
> Some cases still need to be checked first, though: iotests need bash
> and GNU sed (otherwise they fail), and if gprof is enabled, it spoils
> the output of some test cases causing them to fail. So if we detect
> that one of the required programs is missing or that gprof is enabled,
> we still have to skip the iotests to avoid failures.

Thomas,

I've dropped this from the latest PR because I'm still seeing problems
in some places. One of the issues is tests failing when the underlying
file system doesn't support O_DIRECT. Some tests seem to have explicit
feature checks for this but others just fail.

--
Alex Benn=C3=A9e

