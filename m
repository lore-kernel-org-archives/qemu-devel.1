Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327B6C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 18:53:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16ED2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 18:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vgee28sq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16ED2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lGb-0006sS-5e
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 14:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lFt-0006IK-Pu
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lFs-0001xp-R1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:52:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46509)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7lFs-0001xe-Jx
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 14:52:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id d17so8999513wrq.13
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oB7yPItBjnhjPYE8d57Cx2CU1SqtY4e1tql+EWAer6M=;
 b=Vgee28squ+RzDWRRnYzYwWhRSPe++oro74qvqARnN/enw2ViEJ5EhMcOG9K6g4a1th
 KHr5I7CA62MoNy/z0Ijy6++OvK+UUB9Plw1YVmbYHOSfFWjDKOmnOHsrmfEB/3Yr6d0a
 AD6skLH52U/HANiA7YbL5e6qkRFvlWiIdB+tU8+GWrUrrZf4VnsJ2sZoZX0zyYMD/D3E
 8dcaZfn/AEZmtndy7ricCaPLWuCDuMltKFyOENRflkAPZglk1TAlGDYnSQHi5q2Y8I6S
 7G3RvyHIy+OJVqfiaSSE6ynPQ2qp56uPZAJekg4WPd/Lejmhsy1rhM0RvyO1j6RegKNB
 mDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oB7yPItBjnhjPYE8d57Cx2CU1SqtY4e1tql+EWAer6M=;
 b=SOxJWS6n5fh8uI+88gR1dCz/0kGbvYiFGYptAN9Bj6tvuvA08ea43RjzUqCvTeneMO
 XgTaQj1vsibBtkyZgDN/DmDQzL529kCgZSdAXb1fWEi+zz6Yb2fyGpMdbsebDkCDyviM
 6hOaE0gaitcEuZBPcMtibR3xvc4AolSazGZoO/8vbRvEkIajZi9wowN9j0Py5ICEXR9e
 bYXGNLIG2BqVuscQxEqDfr1L9rjuWcvCCZRCnwc22KGxUokVaXEnibb3o/UDa4uC+MvV
 YsTSXlLYBkNLHHypan0BGgbD3imv9keB7xpr7IRxE8xsP7oa0xCvdQwZeE4sLdny47gF
 4/TQ==
X-Gm-Message-State: APjAAAV6yX9x14BOakr3pC/CNclT0soSARGZTx3+QvET9hLcuOsLnvFi
 daCq9RkQ9EDkYM5Ojd8TU7NqGw==
X-Google-Smtp-Source: APXvYqwIFz0Rlu2c4ygo+oFYzppZ+59qitWU64OC/d+JZEIgFPQ+zIeR0tWVtzF13egcpQOK1ID5UA==
X-Received: by 2002:a5d:6811:: with SMTP id w17mr23707448wru.181.1568141563566; 
 Tue, 10 Sep 2019 11:52:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h125sm439379wmf.31.2019.09.10.11.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 11:52:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5CF101FF87;
 Tue, 10 Sep 2019 19:52:42 +0100 (BST)
References: <20190910120927.1669283-1-maozhongyi@cmss.chinamobile.com>
 <20190910120927.1669283-2-maozhongyi@cmss.chinamobile.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190910120927.1669283-2-maozhongyi@cmss.chinamobile.com>
Date: Tue, 10 Sep 2019 19:52:42 +0100
Message-ID: <87d0g80yrp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 1/3] tests/migration: mem leak fix
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
Cc: tony.nguyen@bt.com, armbru@redhat.com,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Mao Zhongyi <maozhongyi@cmss.chinamobile.com> writes:

> Cc: armbru@redhat.com
> Cc: laurent@vivier.eu
> Cc: tony.nguyen@bt.com
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>  tests/migration/stress.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index d9aa4afe92..e6c9a6b243 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -181,6 +181,8 @@ static int stressone(unsigned long long ramsizeMB)
>      if (!ram) {
>          fprintf(stderr, "%s (%05d): ERROR: cannot allocate %llu MB of RA=
M: %s\n",
>                  argv0, gettid(), ramsizeMB, strerror(errno));
> +        if (data)
> +            free(data);

I wonder if it's worth using the glib macros here so:

  g_autofree char *data =3D g_malloc(PAGE_SIZE);

and the same for ram. You can then drop the frees.

>          return -1;
>      }
>      if (!data) {


--
Alex Benn=C3=A9e

