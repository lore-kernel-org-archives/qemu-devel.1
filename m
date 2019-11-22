Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B6CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A10920704
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wk+DngiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A10920704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7Jt-0003Mr-8o
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY7IH-0001qa-VR
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:40:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY7IG-0000GG-Su
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:40:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55229
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY7IG-0000GA-PF
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574422808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rgRqYnoVwssbHUsLICzQ/P0YJsJlsM6d6V+mTRrdI0=;
 b=Wk+DngiTnIMRCImbuCVRkhsNHGjGZBryX+VfXfl0h2LfV+C8pnqP8bhL2qRmqjSXhVfIrr
 HBqxieBqyOtThzpJOmrQokOhfF5Y37jY+lz/ca4ydxCWaJZByN5c/Yr2DagOthXk0uElNV
 pnCtTExlo7kZLn9pqRcWjh/CidOLEzQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-xxbXWU0sOtyRGy1FYDoLew-1; Fri, 22 Nov 2019 06:40:02 -0500
Received: by mail-wm1-f69.google.com with SMTP id y14so3288527wmi.4
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O5c/8slUv1WqXEUCkTV5ehTITQ3SD6IW1QH9FT5y0og=;
 b=LGbJp7Ct4nQw4c34bCaD0DwXKEYYiktrvPfrLjdkc/sqCaZqHO28IyRUrGvVxHM4Kv
 TRX6CnN1oB6gZwKMWXRQmel14Z3/aq3SmS5FBPajqpDU8IZHcz4wqgoKT5zqYHZDymlu
 ITCRxInHZoW0Q3+Lgj5E001IIIBF/AjCGHoB4lLEnGjGxyZ03APM8X9l0DxFJYCbzdB7
 TgAbFnpVJ4+j0tIHfwo1cnI+fBvdiM++zWjRDzx1xZ4/6izkp2zlFfQrGh0ullkjKyoj
 CGH4AbIDDKwyXbgH3BZOrfzaagFnCjiQm0oNS+qcWtRH2yJ6+SfTuCpocahX6HrjdLzc
 lT+g==
X-Gm-Message-State: APjAAAViX9klJbT5zhACw7os5YYUCDT68hPyB2V4q+VLta+yceChujCv
 2LLX+EgtLmhGwovdGNtqbanhihaU6B6AjGKS+SLsASj+o+CDnHhA11inyyzpozc0pnzFVgjml1G
 KGCTKnfdQKlmXmts=
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr16199240wrg.24.1574422801719; 
 Fri, 22 Nov 2019 03:40:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5BNckMAYSqHb/w5+kntyOl/XA3RM+kcwsNnV11uQyIxNuCDWqALISq4OxYLnpUe+divZEGA==
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr16199225wrg.24.1574422801519; 
 Fri, 22 Nov 2019 03:40:01 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id h140sm3417786wme.22.2019.11.22.03.40.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 03:40:01 -0800 (PST)
Subject: Re: [PATCH v1 2/3] tests/vm/ubuntu: include language pack to silence
 locale warnings
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191122112231.18431-1-alex.bennee@linaro.org>
 <20191122112231.18431-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7d0b16ee-7378-f980-6786-ccfd27b31a7f@redhat.com>
Date: Fri, 22 Nov 2019 12:39:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122112231.18431-3-alex.bennee@linaro.org>
Content-Language: en-US
X-MC-Unique: xxbXWU0sOtyRGy1FYDoLew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 12:22 PM, Alex Benn=C3=A9e wrote:
> The iotests in particular don't like the output being spammed with
> warnings about locales.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/vm/ubuntu.i386 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> index 38f740eabf7..18b1ea2b72c 100755
> --- a/tests/vm/ubuntu.i386
> +++ b/tests/vm/ubuntu.i386
> @@ -84,7 +84,7 @@ class UbuntuX86VM(basevm.BaseVM):
>           self.ssh_root_check("sed -ie s/^#\ deb-src/deb-src/g /etc/apt/s=
ources.list")
>           self.ssh_root_check("apt-get update")
>           self.ssh_root_check("apt-get build-dep -y qemu")
> -        self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
> +        self.ssh_root_check("apt-get install -y libfdt-dev flex bison la=
nguage-pack-en")
>           self.ssh_root("poweroff")
>           self.wait()
>           os.rename(img_tmp, img)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


