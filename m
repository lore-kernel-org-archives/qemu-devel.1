Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57632CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD7A21D82
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EatJlTRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD7A21D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1wF-0007Vn-9t
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO11d-0004mT-Ky
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO11c-0001iZ-Dz
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:57:13 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO11c-0001iF-8Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:57:12 -0400
Received: by mail-ot1-x342.google.com with SMTP id 94so2246864oty.8
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PzFBIOtrYGHD8aILwNW9Y8nczxSGhZHqE5zG7McmJGQ=;
 b=EatJlTRFjWxhuoPIxF3O/Uhj3cBl9uvFUF4VvhRZRh/WD4LlBlkwexMyQP+oGma7ew
 bj6CIbsiVk+1g9Hq1n5bm2xgmAfi769fY2Z9J4Grp8TSuxB6hQ+A1dKOdDWkWofzoc/2
 Rok9M0gvPkPQauE9nfbpZWABLgTospt0ZEVctQ3B7RhulZckkXvg7a+teM0Dy/TK2EsE
 MIYh31ZUZsVlPL2ONNQXvAALqdMOqegihT39ZaCcPWOFU+a9UT6zIV5mJ5+ZNjtkkp0a
 n2NJC8Yq7OWET8oqiYwJZOVX2KFbF5zukidx9GL6a36eHdmNSOZOGO0bmXRKu0i7Zi+m
 XWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PzFBIOtrYGHD8aILwNW9Y8nczxSGhZHqE5zG7McmJGQ=;
 b=Okd2xoaURCEORTMfO+kPJtsH+R02AJR14djklOfxB35y69/gBm2eaTqrUQolJmUvPg
 FS4gTuSwbPfGd8DJM9LeU/Or2YLnR1QzOzNcJuAqheAzsQa793ilRA1T86++l77sEO+n
 0H8ewxTzH/M04zeZ/K/ZLRm+LT8nd2Kz/0XSgQ83onEc1xmq3DAR1ERlxjUQXaxeMLlH
 ZnT5SOLZWI9iPOlhVGI7YpID3aO6dk/wLoezbf2qGHrmorTxHgPxZHpu1zZxu9YRcVlB
 sIwrgEvGjNmW91pYVRVEKnZmg1t1FaiBd5pL6FPfOTt8xLnOE3psCx0xYveooSkFkYD9
 sy2Q==
X-Gm-Message-State: APjAAAX0Dsr82Y0EM82CTzvf8PimI4j1ROdSXs/Xc1PRjfhLOw484KIb
 2y5NOv7nvnc7UiB8VEJHhnTl4FNBqTsOXevfMbEnMQ==
X-Google-Smtp-Source: APXvYqwfYkbRgVWdfonQICnVWP9LuSPkxyE21Vg51U6VYGFxcTjQjjLGoxBwNvWLJ9NbVTW7H8dl8makxPg45Vy28AM=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr1690774otj.135.1572015431419; 
 Fri, 25 Oct 2019 07:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191025134611.25920-1-kwolf@redhat.com>
In-Reply-To: <20191025134611.25920-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 15:57:00 +0100
Message-ID: <CAFEAcA_z1A3yTZUTmXqAYo=kyxXkaoCkjOBx-AkRamW66se3tw@mail.gmail.com>
Subject: Re: [PULL 0/7] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 14:46, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 7bc8f9734213b76e76631a483be13d6737c2adbc:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20191025' into staging (2019-10-25 13:12:16 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 5e9785505210e2477e590e61b1ab100d0ec22b01:
>
>   qcow2: Fix corruption bug in qcow2_detect_metadata_preallocation() (2019-10-25 15:18:55 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2: Fix data corruption bug that is triggered in partial cluster
>   allocation with default options
> - qapi: add support for blkreplay driver
> - doc: Describe missing generic -blockdev options
> - iotests: Fix 118 when run as root
> - Minor code cleanups
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

