Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2DFC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7DD24676
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdT+gDCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7DD24676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8psG-0003gq-MP
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8prN-0002hj-Bc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8prM-00023c-At
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:32:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54735
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8prL-000238-6q
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583173926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mM7Q8Ll7RE0qsWZovDaAoaqfLmmOIImO3P0GbNxmRsY=;
 b=hdT+gDCPRmLbeO47im062sNYupHLdvRZZlPuqAycpvnSXro1hTVbn6rn8BXoM5oMfkkuiX
 +Sa5xgEo8hBeplMABn472Yj/xr5Zz7jF7KOKJUVrjD9On23fVX3LERkyJ/M8+HeBU/2UTF
 aByj/+Kfu9fPVgRMw/zmBEjbjl2rj5s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-TSXYs8UtNZi3knyP1A7AtQ-1; Mon, 02 Mar 2020 13:32:05 -0500
X-MC-Unique: TSXYs8UtNZi3knyP1A7AtQ-1
Received: by mail-wr1-f72.google.com with SMTP id n7so80655wro.9
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B2jahsqgKJqmH/RqkY4XHSC43r70Wvih3gUU7D/St/4=;
 b=gR1kshuwhXdHvpvcYxeLEYva4kSTCksx+Yz3oX2KuwXAKew6q4KW9VP1MKTI4EvR4F
 4klBCNOex4iaCR2EnXnhIHj/BoC4E1JlxCZNe1a2jo0mWN/H7INdWw2LYg1+v44ZafBL
 3hF5/4WK87y1U02QRjrKTELQw+Q7rSGE4aNsIjPoPbxdCmX1rkLj4iJdLO8L2YQT7ZoX
 2Ph/ps6T392J0ce7gEMpzF9XphOUUKNQzCeNgJdCtSpvcB3xCOcqBecUZzZZmfpYOuON
 Y4dLsd86xtzs7JC502v/OeA6QgF7U3E7QpM1m8Qyx74CujBNIOPPw1SvoZaSBVAXfjs8
 BxUA==
X-Gm-Message-State: ANhLgQ1mp+pVngjBfxOz5sCbppTlRb6EsncpwGTgc11U9dx26WiuePWR
 lIIxyArrNHq2MTUYjv1+FaFycoxal2+NxxU6mR1mYtl67r90BS47hVOQzwG+cKgINN0wqx2BOEi
 zJydwrJMo2zicBG0=
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr802063wrw.319.1583173923788;
 Mon, 02 Mar 2020 10:32:03 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsvG1b95/en/gPJmdGzvIjgjBkJKna8o1Qtq/FKIXtVFwi2n3l5MWyRz/C2KOznQnaRwu4+mA==
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr802048wrw.319.1583173923591;
 Mon, 02 Mar 2020 10:32:03 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id h20sm6686825wrc.47.2020.03.02.10.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 10:32:03 -0800 (PST)
Subject: Re: [PATCH v1 03/10] tests/vm: increased max timeout for vm boot.
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200302181907.32110-1-alex.bennee@linaro.org>
 <20200302181907.32110-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fec62086-03bd-a925-ea38-dcf68354fbb6@redhat.com>
Date: Mon, 2 Mar 2020 19:32:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302181907.32110-4-alex.bennee@linaro.org>
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

On 3/2/20 7:19 PM, Alex Benn=C3=A9e wrote:
> From: Robert Foley <robert.foley@linaro.org>
>=20
> Add change to increase timeout waiting for VM to boot.
> Needed for some emulation cases where it can take longer
> than 5 minutes to boot.
>=20
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20200219163537.22098-4-robert.foley@linaro.org>
> ---
>   tests/vm/basevm.py | 7 +++++++
>   1 file changed, 7 insertions(+)
>=20
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index c99725b8c0d..5ca445e29af 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -57,6 +57,10 @@ class BaseVM(object):
>       poweroff =3D "poweroff"
>       # enable IPv6 networking
>       ipv6 =3D True
> +    # Scale up some timeouts under TCG.
> +    # 4 is arbitrary, but greater than 2,
> +    # since we found we need to wait more than twice as long.
> +    tcg_ssh_timeout_multiplier =3D 4
>       def __init__(self, debug=3DFalse, vcpus=3DNone):
>           self._guest =3D None
>           self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"vm=
-test-",
> @@ -309,6 +313,9 @@ class BaseVM(object):
>           sys.stderr.write("### %s ...\n" % text)
>  =20
>       def wait_ssh(self, seconds=3D300):
> +        # Allow more time for VM to boot under TCG.
> +        if not kvm_available(self.arch):
> +            seconds *=3D self.tcg_ssh_timeout_multiplier
>           starttime =3D datetime.datetime.now()
>           endtime =3D starttime + datetime.timedelta(seconds=3Dseconds)
>           guest_up =3D False
>=20

A clean way might be to use a QMP socket and poll for networking events,=20
then start counting when the network is up.


