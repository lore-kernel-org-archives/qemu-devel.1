Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB464C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 15:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEDF206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 15:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT8LeGFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEDF206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imJiX-0002Kv-EA
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 10:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imJhZ-0001h8-1x
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imJhW-0005LU-Ke
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:44:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40445
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imJhW-0005F8-2d
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 10:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577807093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbZZJ/R4wmvA/nMH4niMi4LpfQsoml/bJkkg149ysBA=;
 b=fT8LeGFT6HM42AheIIdHp1jEOaWcM+RtdtmH3xjjLPD8ZTQLLEJwdJsjJl3VbgNopmuyLr
 WQcI9QS6ZT1zpeTL8s0PlH5x0ujvFOYTzjJ0AGL04TN+pDhmulxhQq77blE+O9rlT9NVo8
 O1AkA4HWfKE5AhTq7x0/wZDJib9RYe8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-9d7E8d0QOsCAAcXHwE8dlA-1; Tue, 31 Dec 2019 10:44:51 -0500
Received: by mail-wm1-f72.google.com with SMTP id l11so360769wmi.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 07:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IlahKJY1EnNLF3W4agZu6tMprUUFx+bhKF8HI1x7WQs=;
 b=JpY18fW37dwyY82Qw8re0ZW/T+wAhXd5JIXVIlrwsys3/mMq372bI847iIY11gZoKf
 6WfcCz0whRN1/vKww1ziwZgD/TkGfaBm7t6+RAO3hTP+Wokfj7/8574oWKF6ZwOgRPvg
 NGo0znneedQZJjzvtLeFmCovvpVGaSeXTEj28Od136KFaOhBFcN6DqkKCNOVKlMHaMpG
 rODrvZfBkdU+h4kxyZhRD5hnFwy/kICfTneFcBQfbdLBviI6k0LBhLxG0WBAqk/RPKbv
 bCEWYzkr6z0e4qNDhvt8R7enWgk6keZUy0lH5ZDVRPs4YOLHuX7BRXU4CQK3SOZg5890
 8A/A==
X-Gm-Message-State: APjAAAURrpdzgQxctCgBzejKSdw+CXz95+tiljcNg8JxX3Y2lqBoOv8x
 j63//1XQIK2azYdtabY0E27DQWF40g2aZcJrx12PkLYEBz1MMlpctpcfi+3gS9kXMkwdSswH8eC
 +AUj26+agB3+mPfE=
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr5137270wma.89.1577807090532; 
 Tue, 31 Dec 2019 07:44:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFBmu+u3vZ9QgnVlMaXffdDHEmCTiffZADtWmTuW+d9daNjEXFtKFrAVtyRjimm3KcGxWHVQ==
X-Received: by 2002:a7b:cc97:: with SMTP id p23mr5137255wma.89.1577807090342; 
 Tue, 31 Dec 2019 07:44:50 -0800 (PST)
Received: from ?IPv6:2a01:cb18:8372:6b00:691b:aac5:8837:d4da?
 ([2a01:cb18:8372:6b00:691b:aac5:8837:d4da])
 by smtp.gmail.com with ESMTPSA id x16sm2848443wmk.35.2019.12.31.07.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Dec 2019 07:44:49 -0800 (PST)
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
Date: Tue, 31 Dec 2019 16:44:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577797450-88458-44-git-send-email-imammedo@redhat.com>
Content-Language: en-US
X-MC-Unique: 9d7E8d0QOsCAAcXHwE8dlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/31/19 2:03 PM, Igor Mammedov wrote:
> If user provided non-sense RAM size, board will complain and
> continue running with max RAM size supported.
> Also RAM is going to be allocated by generic code, so it won't be
> possible for board to fix things up for user.
>=20
> Make it error message and exit to force user fix CLI,
> instead of accepting non-sense CLI values.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/hppa/machine.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 5d0de26..25f5afc 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *machine)
>  =20
>       /* Limit main memory. */
>       if (ram_size > FIRMWARE_START) {
> -        machine->ram_size =3D ram_size =3D FIRMWARE_START;
> +        error_report("RAM size more than %d is not supported", FIRMWARE_=
START);

$ qemu-system-hppa -m 3841m
qemu-system-hppa: invalid accelerator kvm
qemu-system-hppa: falling back to tcg
qemu-system-hppa: RAM size more than -268435456 is not supported

Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned format,=20
we can simply use "RAM size more than 3840m is not supported". Is that=20
OK with you?

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

With correct output:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +        exit(EXIT_FAILURE);
>       }
>  =20
>       /* Main memory region. */
>=20


