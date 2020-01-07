Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C615C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228AF206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4Ckp/Tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228AF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionmM-00026Y-Db
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iommn-0007Cy-AC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iomml-0007zR-QH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:12:32 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40592)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iomml-0007zA-JB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:12:31 -0500
Received: by mail-wr1-x443.google.com with SMTP id c14so53452259wrn.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=p/mxcnKh3Ij21LnEcqIOG2hSh5TJSoDxWyTgFECzGVQ=;
 b=B4Ckp/TpgBx4q5p8sBGL+jECkwae3Hfh2lMA67bbeKh6cG0nQOEFFafJLnAgPyDUdN
 +2Wi0Y95WNMskxI5ZItyDS0ev1SFDrRDNM3lttyD5q7TeN189QoynQlnKxhUjT+knyme
 6uGcb5tGRHIbbAAWjIVIN5D3Afqvf1pkSr0kFAqfioQSiRm+KzSEWrqyPinuXJcq+/Nh
 6S1zl8wV9J7tW8UCnrdttRpYzohLVZklDIy4ZyNImaHgYLuYOpKC9hqU7d6KvVCk0+rk
 Wly5JLK/TXAUK5oXZBgRAXeu+9nm1kWKM6X1TBhKvcahocd5N1/1MEZPiGIyJYR0pTRt
 POnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=p/mxcnKh3Ij21LnEcqIOG2hSh5TJSoDxWyTgFECzGVQ=;
 b=chsHwIC6suuFR5LZCXHOLHnd+DJ1Fi1sxhjn2DtkVBiVP4go+DnczyG5FyA7WVkEbK
 DQCWXpqzZeSVG+YT6FZM2CDhbd/q35BZNPJyDafcgdobP2km+w7o9YNOsXovLv3TgqG1
 8LaE/VU9FF3inf/G7HWXtZoZAZPuyjgCrzRkBAF8+jzoodDYj3nrio/dnnTW0Q/wA3DJ
 O+GegeZC5vUQVR0KnYxp6Gc8GrfUMxR+nDu3CVkU6lrCFFE6VNbJ6Xl59Uu6BpbE0qQG
 HUj7cyr75BwOFzD2P+BY9PwsbGC0KX7BOzpxz7SFwEuj+RCRkMpbqdm3Il62nLIH5NkS
 pdiA==
X-Gm-Message-State: APjAAAU2N5W7e7mSZmTNQqgf394Fcb71f9b4KvN+9bu9ZhTzQC5aluz8
 DZ7PVMsUrcFdHxWIjf/4jdsEHQ==
X-Google-Smtp-Source: APXvYqxksGyLnRpM9W+sxGEYQtUy5n59OUiSRU+J7NPApLYwedFDlZfgQFgOwD4xGGjrLSccArwWNg==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr107305940wru.65.1578395550493; 
 Tue, 07 Jan 2020 03:12:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c9sm25666507wmc.47.2020.01.07.03.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 03:12:29 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B4B21FF87;
 Tue,  7 Jan 2020 11:12:28 +0000 (GMT)
References: <20191018102443.26469-1-kraxel@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] tests/vm: update openbsd to release 6.6
In-reply-to: <20191018102443.26469-1-kraxel@redhat.com>
Date: Tue, 07 Jan 2020 11:12:28 +0000
Message-ID: <875zhn5xlv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Queued to testing/next, thanks.

> ---
>  tests/vm/openbsd | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index b92c39f89a6f..9f82cd459fde 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -22,8 +22,8 @@ class OpenBSDVM(basevm.BaseVM):
>      name =3D "openbsd"
>      arch =3D "x86_64"
>=20=20
> -    link =3D "https://cdn.openbsd.org/pub/OpenBSD/6.5/amd64/install65.is=
o"
> -    csum =3D "38d1f8cadd502f1c27bf05c5abde6cc505dd28f3f34f8a941048ff9a54=
f9f608"
> +    link =3D "https://cdn.openbsd.org/pub/OpenBSD/6.6/amd64/install66.is=
o"
> +    csum =3D "b22e63df56e6266de6bbeed8e9be0fbe9ee2291551c5bc03f3cc2e4ab9=
436ee3"
>      size =3D "20G"
>      pkgs =3D [
>          # tools


--=20
Alex Benn=C3=A9e

