Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA9BC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 22:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37AF5206F5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 22:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2ZmbIPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37AF5206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJmKj-0003Vb-AO
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 18:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jJmJs-00036s-L9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 18:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1jJmJr-0000t6-IB
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 18:58:48 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1jJmJq-0000p4-C2
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 18:58:47 -0400
Received: by mail-pg1-x542.google.com with SMTP id d17so893256pgo.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2020 15:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7L/Bmx/pXWTL+AwA7EFV0IUqNCuvH7eKIV4j9JjDTYA=;
 b=J2ZmbIPNfy5HXZk/8UFj7rho8v93KTbRifWKK2T2xiNZz3djtWRcGLP8jqpj/woIIe
 bPAzkDtNnJ4mkurBcm9KMuv/FWNTwgumPBX/8se2ieVOFI26ozQRjH4ITAr6pSZd2Vk+
 aSbNpcnWGkhSUwNv7RvvVTwAj2f6xv62Jl0e6PKylHLk2GqXIsXjoU0jbRMn07pBLzMZ
 PxTI86FqjWYpnJeElCsOF9iOmMg7wGeL6FgH1fGlInuWYip/gpcFu0cBXpNxDSikkB4c
 B2uuBRP4E1e47cSJrAWdQC2Al9Pdl7B5W6Lpm1PVvr+fd3AiKcSg6+s6iopKJ9WsXYx/
 G+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7L/Bmx/pXWTL+AwA7EFV0IUqNCuvH7eKIV4j9JjDTYA=;
 b=pELS1Z9Up+vo6v8+B3sUS85heWwqOfphcgnQOJLMeYjY2aHUZzrnjTy5uiv1B4lVxW
 t8VONIexZ4KduF/3LGlZ/HuM0gT88lJC+z65S2+7WrUwNP2AEGUnZ+uzuS9XcHKkL9vi
 MCosmdIaVZdsFe0izXexv5Yr4ILkZoD0/kk19/ADUZcbjCamopBeKxYD4HMweCkquCid
 Rc6MzrTxhDFuFXIVclJDQUhcuLSsflAZHQX9EqYeqEB1T+383Bh8LD04ummLpWKoW2N5
 61nBBP+U5mwOme4F5mTTib58zYCrBDG1GE+iEu8oucZ41oOrFo2IDhvO6nHUlCsbSiya
 j/iw==
X-Gm-Message-State: AGi0PuYiarBUxZyPggjKtQAOBX4rBKEAG8b91m0m2/iz/hG3+IoVf2UX
 +/o1MDv60F/wPvku6mUTOoRmd/tc7D+T2riA5eo=
X-Google-Smtp-Source: APiQypJESMm0WGsQvkk4kRsOerDHaV1zsqAEJTY7lAkoM3TU7Nv1MLdO5iOjIIzIpf8kbZaN2UHa1A/MmGpiRyekcYQ=
X-Received: by 2002:a63:8c5b:: with SMTP id q27mr425538pgn.301.1585781922160; 
 Wed, 01 Apr 2020 15:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200401094759.5835-1-alex.bennee@linaro.org>
 <20200401094759.5835-6-alex.bennee@linaro.org>
In-Reply-To: <20200401094759.5835-6-alex.bennee@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 1 Apr 2020 15:58:30 -0700
Message-ID: <CAMo8BfKz3D7zfYD9xQuC7R+xKVS7nDyg=6PqgjW6mheyAR_neA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] target/xtensa: add FIXME for translation memory
 leak
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 1, 2020 at 2:48 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> Dynamically allocating a new structure within the DisasContext can
> potentially leak as we can longjmp out of the translation loop (see
> test_phys_mem). The proper fix would be to use static allocation
> within the DisasContext but as the Xtensa translator imports it's code
> from elsewhere I leave that as an exercise for the maintainer.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/translate.c | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

