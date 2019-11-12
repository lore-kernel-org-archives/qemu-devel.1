Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2218C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D38D214E0
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gR6cQtUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D38D214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUZUb-000236-KJ
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56842)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUZTZ-0001bd-D0
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUZTX-0001Z3-UL
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:57:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUZTX-0001Yv-N9
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:57:07 -0500
Received: by mail-wm1-x344.google.com with SMTP id b17so3753347wmj.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=V0ieRzPcfLRi3/b+6rd0KhvVIupFsmItBCV5/R0sKaU=;
 b=gR6cQtUyeerqxOPjXdlm8SSXby14oclRE0NAjvZdWy9mHdnQrf47WttpZQZ3daOYm0
 zX6CUPvmyDoyjPidaoEPQAM7GrPw1B7WQUySr7gkwzelmzHIPChzph5O/wkJ5xr0tIwF
 ozOPsPaDKGzVTtZOe1bKlYihmotyZX6bjgUuGyp+B2b5RR/4v5d9Udr2coi26HPKhpCH
 hceqVwz9HNkODyUiBgjVShZp6NBOBpFOpU8ozhQWUC0mZTNbyKm+shBHhGzswqWNcJuy
 gDQ3PFDJiKfbGRDhj27GIGb/Z5hb8qSS7vfNefYxV3stOKhE6xehwZmWmlFJBtcwGE34
 94fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=V0ieRzPcfLRi3/b+6rd0KhvVIupFsmItBCV5/R0sKaU=;
 b=YBru7ixlRLY8YJEP6/LgevVqFvZsdokTMDEfwYV2i9rTEFQ938AoFCa6lgWugwNaP+
 d48wAqvmV3W+ueirtyx9N+T0ZcodmPI9VwHCqwGPudOmfd3+A2/iZJg0uoN8IX8hhMTl
 FqWQNMPps/2bddpHB06PRw25TxqLzbXVdQS/ztC+pPq4iiLnbmqMLsyyHMAJ3H/vBq1f
 JUnAW/YQgXsMj7panggITDgS+rduIniCMO/A2zMkrnTkNwfx4mQmNWFMypsMKhair89o
 2bv5jIpiy5qATWM4hUB3haWx+EiBDpHUx2NvFuweRlE+EE7T3t3SBnRRnWGrm3Whcse8
 PaXw==
X-Gm-Message-State: APjAAAWd0OqX2rinyHNRNgJrAfvptSDXBU8xEkdvsqg6Mr+eNLuopFvf
 H7+0d/chkfY9XYJGGzA8EoKL/Q==
X-Google-Smtp-Source: APXvYqzqdZh1Ab61bK9XTdK1sJNag1q2ajBl0wCmD5dBRJTNTNkD2uXUYLtD9moS10blzBWahrLs+Q==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr5219520wme.92.1573577825764; 
 Tue, 12 Nov 2019 08:57:05 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j3sm18471318wrs.70.2019.11.12.08.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 08:57:04 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E9B201FF87;
 Tue, 12 Nov 2019 16:57:03 +0000 (GMT)
References: <1573240249-6966-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573240249-6966-2-git-send-email-aleksandar.markovic@rt-rk.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH 1/5] MAINTAINERS: Add a section on git infrastructure
In-reply-to: <1573240249-6966-2-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Tue, 12 Nov 2019 16:57:03 +0000
Message-ID: <87tv79823k.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, aleksandar.rikalo@rt-rk.com,
 philmd@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> There should be a patient person maintaining gory details of
> git-related files, and there is no better person for that role
> than Philippe. Alex should be the reviewer for some relations
> with gitdm.

I'm not sure about this. The .gitignore files are best updated by people
responsible for the various parts of the tree. Once out-of-tree builds
become standard we should be able to eliminate them all together. As far
as .mailmap is concerned I think people are quite capable of updating it
themselves without putting the changes through a maintainer tree.

>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  MAINTAINERS | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4964fbb..be43ccb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2664,6 +2664,23 @@ M: Daniel P. Berrange <berrange@redhat.com>
>  S: Odd Fixes
>  F: scripts/git-submodule.sh
>
> +GIT infrastructure
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> +R: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +S: Maintained
> +F: .mailmap
> +F: scripts/git.orderfile
> +F: .gitignore
> +F: tests/fp/.gitignore
> +F: tests/fp/berkeley-softfloat-3/.gitignore
> +F: tests/fp/berkeley-testfloat-3/.gitignore
> +F: tests/migration/.gitignore
> +F: tests/multiboot/.gitignore
> +F: tests/qemu-iotests/.gitignore
> +F: tests/tcg/.gitignore
> +F: tests/uefi-test-tools/.gitignore
> +F: ui/keycodemapdb/tests/.gitignore
> +
>  Sphinx documentation configuration and build machinery
>  M: Peter Maydell <peter.maydell@linaro.org>
>  S: Maintained


--
Alex Benn=C3=A9e

