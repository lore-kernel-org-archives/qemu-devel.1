Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECC1C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886D72053B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xH3vD3dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886D72053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHnH-0008Hv-JY
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipHaK-0007Dl-T6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipHaI-000794-Sy
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:05:44 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36216)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipHaI-00077i-Nj
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:05:42 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so243670wma.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 12:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aoZmBCHq8KdFyuYwAZ29pK8yo9t5oHzC7+ZipSOnK4o=;
 b=xH3vD3drbsAplx28P//fQaNZ69lvMTMtOaSA31IQ1LlkVvvKFkHTsJqlYOu3yLvKvN
 aZ3EGuvSIeHQ8dJayblsPz4g4G+9lyYHja5rLxlzl+Kj28Vp7GlKbVPdWZfBMcpDDLJE
 RvAKY7G6GPJoT7neR9cazwMijmTOHooJeSFC1jJ3nH/sT4iJCnEqP1jdQb5V+Lzk6iV+
 iBAAKyOxMYz/pN78nDzuXo1Bf2BWZDB8eC4rgRdovOoG3tQAB9CrJwUqwYtESuqHXUYW
 MkcBvjcc560fFhrCkqG4Qpu6yiYaBaV4RoK68K2WUmhgtqm1+yTrVBczc6FPUgp47bcD
 InEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aoZmBCHq8KdFyuYwAZ29pK8yo9t5oHzC7+ZipSOnK4o=;
 b=piafaAV6I6SMg0sjqVTh48zU1lpYXvVGkL8b69TxbfEGKlDlLEi6MZBPO/ceALGu4P
 znNMKzyPDS+MaHFZu6GWRgakyZM0B2BVap4O/mD74hDuYZQVL+d/4SZcxTcZc70yUftf
 Mi8R0gSa9rpG2iU02WRZN9PE7m/qxaO8cqr0eO+HpCnzTT8NbnTBXN3yoQpMOc78A7/9
 M5Pyn9WzOhxvjKhTOes5IAu3q/Z9FAFiWXDq5pv0fNIVw+q4apFUL4C9oIHZhV6eDjhJ
 3vutUGybJZ9As2Xgs25Viw2sWxx16NPBMSJ6okV0tzCkL/x//J4g8R3aNjmglGsN1ceA
 L5ig==
X-Gm-Message-State: APjAAAXSubw77eO7zfUiFA5bjX3p1mZhiRD6LeuFenjT9yxLqAvcubRs
 mJYvS+gVIjuZlZe8l0NMJ5bdqdhFlC8=
X-Google-Smtp-Source: APXvYqxQOd/CT6GuhQ5W7OLEVnUKro7qH1GUHWinp7c66KcmagTClyqKF2JChvnEzvyTZfmD5UwAzQ==
X-Received: by 2002:a7b:c949:: with SMTP id i9mr335569wml.131.1578513940140;
 Wed, 08 Jan 2020 12:05:40 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f127sm239202wma.4.2020.01.08.12.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 12:05:39 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6D2AD1FF87;
 Wed,  8 Jan 2020 20:05:38 +0000 (GMT)
References: <20200108192402.19672-1-thuth@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] include/sysemu/sysemu.h: Remove usused variable no_quit
In-reply-to: <20200108192402.19672-1-thuth@redhat.com>
Date: Wed, 08 Jan 2020 20:05:38 +0000
Message-ID: <874kx5k92l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-trivial@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> The no_quit variable has been removed in commit 78782712a62d56 ("vl: drop
> no_quit variable"), so let's remove the extern declaration in the header
> now, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/sysemu/sysemu.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 80c57fdc4e..686f4217a6 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -44,7 +44,6 @@ extern int alt_grab;
>  extern int ctrl_grab;
>  extern int cursor_hide;
>  extern int graphic_rotate;
> -extern int no_quit;
>  extern int no_shutdown;
>  extern int old_param;
>  extern int boot_menu;


--=20
Alex Benn=C3=A9e

