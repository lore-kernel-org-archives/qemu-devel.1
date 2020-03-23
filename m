Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684CAC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED0620719
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkMsD66X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED0620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPyy-0007fQ-Ak
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGPyK-0006nn-4c
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:30:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGPyI-0000KV-69
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:30:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44839)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGPyH-0000KI-TK
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584981037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsoWqsUzolV7qLWRquUBpqElEOZi211cZmzFf0ECedg=;
 b=ZkMsD66XDmDWMFCyPk0But4GXyBKLtzvqH74FMdGLhyOvGymv/xxYpAEOV5ajURYfwHyEH
 NrowoGd+volZtp/9QuEnTNphDZbVMiGubzGAspLoWbmqKmH+05AI/W003wD9TN470HC2Uz
 ego/YuRZQi616OVbgk2Q9ktXSscO+HE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-AGASz3jAMTi_f2GMA-IDzw-1; Mon, 23 Mar 2020 12:30:33 -0400
X-MC-Unique: AGASz3jAMTi_f2GMA-IDzw-1
Received: by mail-wm1-f70.google.com with SMTP id g9so200072wmh.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 09:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oKfDkeKye4bf15jmAoiMTOaA/r/xUZsZEpuMYuaVz/o=;
 b=K1phDiBpT9hXR5Xs0i2ZK+JBuFKSCHD4X35+c4Hr0eENRa5S5I64814Wawy+e/32q9
 jfS+ne+/x05IY1272qepHwgzoZOFdxEFn0/L3SVF8U45FOe3DWKEdCYM73QpZQxYnaik
 Bp209+EKwtVtEMRd8AntdxvRvOH2obf9LKfXkLIhJ3FrAcdBrNnEJtEmckc/SYc0kGbk
 thn7TPaXK4Hcq6NXLkpQ+JTtUHR5rrwpFS6cAX+rzjYGHHsp7wgNI81oY0efo+lSoCUv
 qQYO/N+hOgAxrQcqPDq7Sr64lU/AfaBgLCxck1gyGGYaTozYQXefv0zLSn4JC3kUsCAl
 U+Yg==
X-Gm-Message-State: ANhLgQ2I/QXOq82XKFFOxdpls73mSgeIGzo9iPmP6DN56nMWkMez1ZZR
 2j0jGusGd8i4vdfKgaXHEaQkwtzXrj9y7jm40PUlK//lQn07hMPmo0er02w+s5VY9NBMYabr0uQ
 d0c58S8DgMoS+7r4=
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr40357wmc.153.1584981032031; 
 Mon, 23 Mar 2020 09:30:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv4nuNPJDfZb5UictSacuVd4sswukCpWyXREPvQvO6RLIo+LGvr/sQM833x26aj8mXdBp7Beg==
X-Received: by 2002:a05:600c:a:: with SMTP id g10mr40337wmc.153.1584981031789; 
 Mon, 23 Mar 2020 09:30:31 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id j6sm22424760wrb.4.2020.03.23.09.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2020 09:30:31 -0700 (PDT)
Subject: Re: [PATCH v1 06/11] configure: disable MTTCG for MIPS guests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200323161514.23952-1-alex.bennee@linaro.org>
 <20200323161514.23952-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9c5ecb31-2dc8-c437-6100-267722d10dba@redhat.com>
Date: Mon, 23 Mar 2020 17:30:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323161514.23952-7-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/23/20 5:15 PM, Alex Benn=C3=A9e wrote:
> While debugging check-acceptance failures I found an instability in
> the mips64el test case. Briefly the test case:
>=20
>    retry.py -n 100 -c -- ./mips64el-softmmu/qemu-system-mips64el \
>      -display none -vga none -serial mon:stdio \
>      -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
>      -cpu I6400 -smp 8 -vga std \
>      -append "printk.time=3D0 clocksource=3DGIC console=3Dtty0 console=3D=
ttyS0 panic=3D-1" \
>      --no-reboot
>=20
> Reports about a 9% failure rate:
>=20
>    Results summary:
>    0: 91 times (91.00%), avg time 5.547 (0.45 varience/0.67 deviation)
>    -6: 9 times (9.00%), avg time 3.394 (0.02 varience/0.13 deviation)
>    Ran command 100 times, 91 passes
>=20
> When re-run with "--accel tcg,thread=3Dsingle" the instability goes
> away.
>=20
>    Results summary:
>    0: 100 times (100.00%), avg time 17.318 (249.76 varience/15.80 deviati=
on)
>    Ran command 100 times, 100 passes
>=20
> Which seems to indicate there is some aspect of the MIPS MTTCG fixes
> that has been missed. Ideally we would fix that but I'm afraid I don't
> have time to investigate and am not super familiar with the
> architecture anyway. In lieu of someone tracking down the failure lets
> disable it for now.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>=20
> ---
> v2
>    - only drop mip64le

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 4f12cd01777..a83c6450840 100755
> --- a/configure
> +++ b/configure
> @@ -7885,7 +7885,7 @@ case "$target_name" in
>       TARGET_SYSTBL_ABI=3Dn32
>     ;;
>     mips64|mips64el)
> -    mttcg=3D"yes"
> +    mttcg=3D"no"
>       TARGET_ARCH=3Dmips64
>       TARGET_BASE_ARCH=3Dmips
>       echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
>=20


