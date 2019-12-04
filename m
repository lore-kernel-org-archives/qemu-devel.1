Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA71BC2BBE2
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49FD206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fE5/0J5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49FD206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icRK2-0003rW-Uj
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 04:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1icR2f-00062W-1p
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1icR23-0005DN-45
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:33:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1icR22-0004q6-Cu
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 04:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575451988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EWwlL811nqHOzwEEbPjS7cfietB8hdLHTpFyLp/+y9E=;
 b=fE5/0J5DOyHE+s0dBY/IbsGhB6r07eQyCiCctTbprg9RZdMleQFgwCd6x7XultwnKmp6Og
 aE5Cye7O147hN6NzNtEL0eBcVs+nvxxlBAtSbWhTSzruPDLsAftV8Unpdm/fUwa6/h0M8w
 0DMtu5k3IARya5AzYPdLlwRa4dt0Wic=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-kKb2wEcPNyKF9X23Q-b8CQ-1; Wed, 04 Dec 2019 04:33:05 -0500
Received: by mail-wr1-f72.google.com with SMTP id h30so3365086wrh.5
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 01:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DcM2aJ98/Fg9usqbQJE5tGT+B3fxRz/ty919EFqv248=;
 b=r+KrsPAaXn1Zqe/YcAysdn3rpCRIg4pRvyJbJsbMeMsVlzz911ng/jR9CUjGR35ZSO
 W7qj3jvtAGn2USytI684AfgCq4xzhx0s2a0rPRmHHJISmcr0T4dO0ALY4OMfle005Hzy
 3g3gzXpqiegRQY2i+5bi1mTOujqMjfzg05ql1Zv2XDmAXguDgx5BovPV4qm5bc2yd9mI
 uEfeIAHO4MB8IUrdrGBhUsVZXXhPTZX0g0H5UdM/3ZnEvVQNGL7vzDB6qkguOW4RVDuh
 wUEFc5XqhGUc55cOaIdFt68GHb5j6YOM9ihj1lcZUSAX3R6CWG4/a8lG/uVTzExDI4K8
 2nBw==
X-Gm-Message-State: APjAAAUzGbEusrpcoRCTYaK9vKWjKpu3EYr3UEeXXL+FEuFJ7sRyJKxu
 SOhS2IOE2qDJsS5/AtrO29p3Khv/zmh1SglPxyngr7v/nc5pHvEx7PakLer4JK766/Xwb0N4Fbi
 dxeeXYY6K6QwRyqQ=
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr11355696wml.83.1575451983662; 
 Wed, 04 Dec 2019 01:33:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmZETtAcwMo4R/l8hQqvDK4FgYJHlFNh+J+rsTQGqDiydoAq2T46DtqRlG47HLfBg6Yf6H1A==
X-Received: by 2002:a7b:c93a:: with SMTP id h26mr11355676wml.83.1575451983457; 
 Wed, 04 Dec 2019 01:33:03 -0800 (PST)
Received: from [192.168.43.238] (63.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.63])
 by smtp.gmail.com with ESMTPSA id e16sm7370932wrj.80.2019.12.04.01.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2019 01:33:02 -0800 (PST)
Subject: Re: [PATCH] travis.yml: Drop libcap-dev
To: Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <157544579267.3537077.17459176619888583836.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5baaa10a-bc9d-f7ec-0f16-7495aca48fed@redhat.com>
Date: Wed, 4 Dec 2019 10:33:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157544579267.3537077.17459176619888583836.stgit@bahia.lan>
Content-Language: en-US
X-MC-Unique: kKb2wEcPNyKF9X23Q-b8CQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/4/19 9:01 AM, Greg Kurz wrote:
> Commit b1553ab12fe0 converted virtfs-proxy-helper to using libcap-ng. The=
re
> aren't any users of libcap anymore. No need to install libcap-dev.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>=20
> Yet another follow-up to Paolo's patch to use libcap-ng instead of libcap=
.
> Like with the docker and the gitlab CI patches, if I get an ack from Alex
> I'll gladly merge this in the 9p tree and send a PR as soon as 5.0 dev
> begins. I'll make sure the SHA1 for Paolo's patch remains the same.
>=20
>   .travis.yml |    1 -
>   1 file changed, 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 445b0646c18a..6cb8af6fa599 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -26,7 +26,6 @@ addons:
>         - libaio-dev
>         - libattr1-dev
>         - libbrlapi-dev
> -      - libcap-dev
>         - libcap-ng-dev
>         - libgcc-4.8-dev
>         - libgnutls28-dev
>=20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


