Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAD3C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD5FA2080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 19:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKTNRYoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5FA2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iouP4-0004P1-Ut
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 14:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iouFG-0007Vg-Kd
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iouFE-00018v-Qx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:10:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22925
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iouFE-00018T-HA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 14:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578424224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DxkSyfkoE/UEqShzX/UQsg9E7/HXMQ9NdqUnYstX7Dg=;
 b=DKTNRYozwSqamhYaSjjKPj/fM/7vqO4YUHC93cWervanLbrmbJLvb8MVW2SRaLBkBdANQh
 ZDDgQDuZ2ES3BlnbheQxt2AjEGEpmKVVt73hG1uUrfrVEkRB85yiULE0Di4PY6oMEJU8Dc
 wN8hrtAR+YC3UgX5GTXCkgOQfY0GsnE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-rnE5r-XrNU2fEAjlquUYNA-1; Tue, 07 Jan 2020 14:10:22 -0500
Received: by mail-wr1-f72.google.com with SMTP id c17so347148wrp.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 11:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H4D+IQeHeBAFSAfk7sgUp01/2xHcZnO2vsGjQUEiLhA=;
 b=Zc6aO6hYonPkalAcOTwt5qd0k02CaVHXSNGA85D6CurjxfuAXlnCnHUb5zj0alDOfy
 NS9pDO7IksNg6JmiNF/2hcFBxywopv0XBXfFXxZUTy/Ncun29i18QkdFzP/Ushm9V+qG
 FtaIEHowUTN7XcxeBe/hUK3jLoHIeIQfQzHtkxHwyLth+sSgY6hV5qTK+D4LQqWXpF2S
 83nqYE39KH+DYJKj+CoOpKohvzGfWjlLFo3+QbVgBlXyS3LAm+mLBnVQBh3yJFrExuKH
 TjXAR0eNcXIBafvYQWeXmIUX/Fc4opuHS7GskMyFOcgWhPh5RlwZ5G0ocmJcf2Szdcw/
 UTKQ==
X-Gm-Message-State: APjAAAVinGpNwSrT/KWSZeHCMYFhPBiNrxR69DGZzrYFISYTNZ6mX8GF
 Z+MaXbZ8sW7Cs5D7oy5cq8NGUpXXG2XEWjmpNzcTUwIpDR9FwIMY7FMS7ADzaung/Q2KhcIUSRG
 kqSDaiHjqpbFf7Xo=
X-Received: by 2002:adf:8541:: with SMTP id 59mr552578wrh.307.1578424221605;
 Tue, 07 Jan 2020 11:10:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6MzHM863ywO1XWE8fEC1lYSC+VfHNKul8A6t7Tb8rK3NoNv7b7G4WrwPtZu23d/6r3l1YGw==
X-Received: by 2002:adf:8541:: with SMTP id 59mr552553wrh.307.1578424221394;
 Tue, 07 Jan 2020 11:10:21 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id n3sm927022wrs.8.2020.01.07.11.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 11:10:20 -0800 (PST)
Subject: Re: [PATCH v1 6/6] travis: install homebrew python for OS X
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200107135311.5215-1-alex.bennee@linaro.org>
 <20200107135311.5215-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cf1af57a-c397-9503-cc49-a93dc58a2cc0@redhat.com>
Date: Tue, 7 Jan 2020 20:10:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200107135311.5215-7-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: rnE5r-XrNU2fEAjlquUYNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 2:53 PM, Alex Benn=C3=A9e wrote:
> Our python3 requirements now outstrip those of the build.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   .travis.yml | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 848a2714efe..a86ca34f79d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -57,6 +57,7 @@ addons:
>         - glib
>         - pixman
>         - gnu-sed
> +      - python
>       update: true
>  =20

This doesn't seem enough, I'm getting:

./configure --disable-docs --disable-tools
ERROR: Cannot use '/usr/local/bin/python', Python >=3D 3.5 is required.

        Use --python=3D/path/to/python to specify a supported Python.

Apparently we don't set this in PATH ourselves.


