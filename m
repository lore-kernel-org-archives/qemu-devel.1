Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E0DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 07:14:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE1221019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 07:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXUIr6c0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE1221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i13mf-0002YA-Gg
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 03:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i13lk-00026X-6g
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 03:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i13lj-0000JU-3D
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 03:13:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39951)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i13li-0000IZ-Qi
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 03:13:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id c3so7626002wrd.7
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 00:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OGP2RfRUu5J/xTFavr40S0xzJkIpJ/fMjuA2W+JS8V8=;
 b=BXUIr6c0Bj0Q29OJa1F8uDvqj95rWW7KsRHaWQdvqhZNgWOg1O0sWC8devEaY1YojT
 9xIVgYALxMA4wF9UBbFGQtOiTdeDwWOrdUoZOPNTo890bX05umcc9PLJPbr+lLONRJ0d
 KwJzK/g33p6bSlkRUHV0ZX6krsBW/tbCKY8s1njvhP8FQRxIAC5eW1pvkGwEuxnp5Sql
 tEEZ8YR8dr3LIPZQZ24m9thO6bBLDxsjokZONign40GjSy0itbMmx7uVZnwuZxMr3nJS
 vUHnoPxAFLZ103+44STeanhc/fc4s7pFgRGJOKiTDTDcNyNofPWlRcqdIwH4RDevrEgD
 ztLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OGP2RfRUu5J/xTFavr40S0xzJkIpJ/fMjuA2W+JS8V8=;
 b=f6vgCYLpZ1hVSCIv3irTr6+UKP+JMpIdR315+e+2SXnlCr8gMuYu3Pd6CoZFLwlEu0
 Fbhl30GdIhBf5UwF0iSWBV0sMmK8+Mqkj+p59RoW5RjjVGNMzWULGVtl0zOn37hZoKvX
 u1kseLzXbxtuxM/4jRH2eKcnIVe6/d5e4QWf5Tfkukp38p2IruW1iFeln6zvNCA1cGL6
 n3txxj3a3CGSTM8l6Px/uGnFRnlZcRtPvyRd7TIt37miykVds6KgKnMnYbXRpCDyIXzQ
 XTlFBz9s/zFKKHrvXrIvPHoTMyqr2/dSZexb6SSuzw0F50lRwWmO/XT3l48qdpQbnyMu
 V+dw==
X-Gm-Message-State: APjAAAWWHO84VgXIr7ApCXb5gCsIAcJkG0L7VXMdh4/0Y19wqen4bo5E
 L/Gz8Fy8Ri7RRoLxNVRYLgQeq+5mlIbTamFvSXE=
X-Google-Smtp-Source: APXvYqzJCCkhS+MVRO7n96C78Ey0uEuTYuJJHXiCpr/DEZ9/ntVuCqiDtGSiTv9WpxS6P0GqPzQQld/BlHPWA9YHuT4=
X-Received: by 2002:a5d:6744:: with SMTP id l4mr3069626wrw.186.1566544432323; 
 Fri, 23 Aug 2019 00:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Aug 2019 11:13:40 +0400
Message-ID: <CAJ+F1CJ9Gc9iYvQHNzbvXtiB4PpDfpbm-pkxuhF-CQkgqJeNcw@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH] modules-test: fix const cast
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 9:42 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tests/modules-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/modules-test.c b/tests/modules-test.c
> index 3aef0e5..a8118e9 100644
> --- a/tests/modules-test.c
> +++ b/tests/modules-test.c
> @@ -4,7 +4,7 @@
>  static void test_modules_load(const void *data)
>  {
>      QTestState *qts;
> -    const char **args =3D data;
> +    const char **args =3D (const char **)data;
>
>      qts =3D qtest_init(NULL);
>      qtest_module_load(qts, args[0], args[1]);
> --
> 1.8.3.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

