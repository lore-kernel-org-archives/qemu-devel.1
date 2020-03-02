Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B74C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2802146E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCo58Ovw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2802146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pbC-0000No-9z
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8paP-0008Dp-SC
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8paO-0006Ru-QJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:14:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28811
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8paO-0006RW-Mz
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583172876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHBCMZtqvNBr4Ms9PiAVSk8txUFHJPJZAO/Afk+vEpw=;
 b=RCo58Ovw7vkkwfIYAvywLbXHviwU1jR6K3vSNCvwq1TjxNxkMaRPRVQGBZIskewtMZfo0c
 gCgQlsjfSpRBXz7xGuJk7NBegtTF9tw74YjtbKB9597TRvhxeSJ23N+9ANfQxbV3olaidB
 nmXmE+boI7Uzr8NGFYk/eWyMynBb/iE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-wPTfj6vhPTy3F11-BeNacg-1; Mon, 02 Mar 2020 13:14:34 -0500
X-MC-Unique: wPTfj6vhPTy3F11-BeNacg-1
Received: by mail-wr1-f69.google.com with SMTP id d9so45637wrv.21
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=trl2BkOELJFdWOmrWPJUgbdnUYlsAGi2aoGSLHy121Y=;
 b=SvrMkVE/s4k/+G0UtIfLrczrnl5DD90HkiRhumelk/J2ofwsh8HL61HEamFebLp93W
 Brn4ejfErxnBhMB1PVKN8hZx/gtcbByu/vDslnZd68+KLfdYIo66eQOyi+M8j4TenW2V
 eCVJFYObqfl+b2O0pVujr28OW3tGTArGuLQP9vwMn74KpmEZyQn8+iKhOorHULWZgHbG
 +UGI3hS6RwcF5ZQ4c1nuMW4ALgdE7ynrna4i6tOVn8ooJed4F20+0WnUZHj/vzPSWLPE
 fQNWezgyKQbkkZzLERCpOzENB4aiVZtclYWtMeE6puGKe0uQMhZcrbqjFEfZUXgXDOYt
 qBZA==
X-Gm-Message-State: ANhLgQ2AXV1NEqR/4qqG1L4Z6M+i+D4PBkRTzewMPR5vcbxn75dnWGi9
 ks74FXmOt5F/PUjpSlWQnl80O6RWXNDsyUJVDK6Ol/oq+5YJ4c4GiZZgL9J7MWcLW6kTZMUT/Wa
 U7RwZQz5nrKyByiU=
X-Received: by 2002:a1c:bd45:: with SMTP id n66mr245156wmf.167.1583172873247; 
 Mon, 02 Mar 2020 10:14:33 -0800 (PST)
X-Google-Smtp-Source: ADFU+vscwBZmRqPzw3qMzQfxgkDtfnPZ3cQ9ZzdnbGHp7ql1bgNaooMJj9b3IYdc+kEBEHXRq0eXqQ==
X-Received: by 2002:a1c:bd45:: with SMTP id n66mr245143wmf.167.1583172873010; 
 Mon, 02 Mar 2020 10:14:33 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id b7sm28671330wrs.97.2020.03.02.10.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 10:14:32 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance: move @skipUnless decoration to test
 itself
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200302180937.24148-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c6f8e8b0-e391-67a7-4fcb-b88464285f65@redhat.com>
Date: Mon, 2 Mar 2020 19:14:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302180937.24148-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Aurelien Jarno <aurelien@aurel32.net>, f4bug@amsat.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 7:09 PM, Alex Benn=C3=A9e wrote:
> It appears ignore the decoration if just applied to the class.

Odd I remember testing this, this might be a feature supported by a=20
newer Avocado version than the one available on Travis-CI.

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   tests/acceptance/machine_mips_malta.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/acceptance/machine_mips_malta.py b/tests/acceptance/ma=
chine_mips_malta.py
> index 92b4f28a112..b8fac2a44d5 100644
> --- a/tests/acceptance/machine_mips_malta.py
> +++ b/tests/acceptance/machine_mips_malta.py
> @@ -30,14 +30,14 @@ except ImportError:
>       CV2_AVAILABLE =3D False
>  =20
>  =20
> -@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> -@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>   class MaltaMachineFramebuffer(Test):
>  =20
>       timeout =3D 30
>  =20
>       KERNEL_COMMON_COMMAND_LINE =3D 'printk.time=3D0 '
>  =20
> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>       def do_test_i6400_framebuffer_logo(self, cpu_cores_count):
>           """
>           Boot Linux kernel and check Tux logo is displayed on the frameb=
uffer.
>=20

Unfortunately you have to also add it to the 7/8cores tests.


