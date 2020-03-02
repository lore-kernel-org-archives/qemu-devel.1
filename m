Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE33AC3F2D7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:30:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8E224676
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpyDaL3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8E224676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8ppi-0000bd-A9
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:30:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8pou-00006m-2y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8pos-00019D-4w
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:29:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8pos-00018r-1I
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583173773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xENLVUo8rBArLiFGrmSxFv8kTLvay15iCVpIgL7FFTU=;
 b=cpyDaL3rfyhF6liLj6qjXKF9GUXWecyMk+fDZELGLCJzUY5krHAjeeLTThXvJKhTzchEhu
 5Yv3+H5EIsgbYj/GW1pczh90RdSC6JHeZfHAQPOlNL5x69z6Kvdw3ZJ2wa2Uw4fdTJlWKJ
 ahmDaHWuE4Dc4x4UP094l4VNbLnTjrE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-Zu0nk7GKM-y0KeuVGzNRTA-1; Mon, 02 Mar 2020 13:29:32 -0500
X-MC-Unique: Zu0nk7GKM-y0KeuVGzNRTA-1
Received: by mail-wm1-f72.google.com with SMTP id m4so74456wmi.5
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=T8oKM+NnnMHrd0iLqLpJ6QH/oueRqI6Hbgsp5BRig2w=;
 b=uFcjfOB0GQqIzt8FKNSRX51qGPIJhAvaOQvT1xadWr9g4cBx2O+8i+jqdNW1oEPpX1
 mKwxy7+Tt0FPPkAHfaVqxf6kqEesRtgcNYEjsIvrh7zlwFMEmYUnibvTzwxL9TXVcOM2
 A4WascBgDrcgohY4Bs0dDomvl+409cHjoLmnvLHlAyFniS7G/lnmPzaY+sM1oR9HMFcz
 EnOnnwm9EAzAQnBHLVgSA6MFwDQa+zakUhhj0gS72X1eYjoCSovVRMCiJkgdcnfomhZK
 O6g+46SYMd8WUZWyZdGyhQnaciVaCWoFUuZHwUDsNRDigwPY2xUVrUQ8urqs7/y1DvxM
 eJgw==
X-Gm-Message-State: ANhLgQ2vi1KAdVcT4Qq03Uux+7b2+2IP/8610lZ0Df5Ifoo2kMMv+5JW
 MCEcsDVIcQ3oZ7nPJSWa9UETCr6xDg91Y/Gzglu7mi7GBvAtuP3zWNTVsbCitkRd/8wgqg69uWv
 r3XSmMCaXKlCEfKo=
X-Received: by 2002:a1c:9602:: with SMTP id y2mr322519wmd.23.1583173770768;
 Mon, 02 Mar 2020 10:29:30 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvDmV/lyMICyoOpXwnAiuVjaPF/6U5Ll0yCjuH9AQlxt5ew56tsZfHXILpr453VBxvSdK+K2Q==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr322503wmd.23.1583173770530;
 Mon, 02 Mar 2020 10:29:30 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id f127sm364589wma.4.2020.03.02.10.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 10:29:29 -0800 (PST)
Subject: Re: [PATCH v1 01/10] tests/vm: use $(PYTHON) consistently
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200302181907.32110-1-alex.bennee@linaro.org>
 <20200302181907.32110-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2f430da1-6429-746c-92e0-58b1fed5ffcb@redhat.com>
Date: Mon, 2 Mar 2020 19:29:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302181907.32110-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 7:18 PM, Alex Benn=C3=A9e wrote:
> From: Robert Foley <robert.foley@linaro.org>
>=20
> Change Makefile.include to use $(PYTHON) so for vm-boot-ssh to be
> consistent with other cases like vm-build.

So what you are trying to fix here is when you have two python3=20
installed (one from the distribution and one manually built), and you=20
want to use the manually built?

>=20
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20200219163537.22098-2-robert.foley@linaro.org>
> ---
>   tests/vm/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 9e7c46a4735..778e5067554 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -80,7 +80,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
>  =20
>   vm-boot-ssh-%: $(IMAGES_DIR)/%.img
>   =09$(call quiet-command, \
> -=09=09$(SRC_PATH)/tests/vm/$* \
> +=09=09$(PYTHON) $(SRC_PATH)/tests/vm/$* \
>   =09=09$(if $(J),--jobs $(J)) \
>   =09=09--image "$<" \
>   =09=09--interactive \
>=20


