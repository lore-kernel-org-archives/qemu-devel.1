Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9E3C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 19:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58212075E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 19:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llVBxWKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58212075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMG7b-0001WR-UZ
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 15:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jMG62-0000nr-CD
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 15:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1jMG61-0001tS-As
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 15:10:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1jMG61-0001sn-57
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 15:10:45 -0400
Received: by mail-wm1-x343.google.com with SMTP id e26so558555wmk.5
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z08W1+Rmw/COrG5G+LMjOuvUonVPZi/EFVP6N0xVZ6M=;
 b=llVBxWKDbUJIS6zS7P3Fr/cYOnRXLDKoSE/AgeMzLXJwHg/2lLWnweNMsVVAJ8rZKq
 p06U8bruUb9TrDg1HkRNHhHeO9qUxb8GSCoyMNPTjCYsCCOfV6KNqF5Sx7C00MNYCfNf
 B4aJyg/U03h+Ah5nZI+uf34uJWNAYJzX0yCJ5SI41zKzZ0OZW2Ra1LZrb8uFTWQ8R8I0
 RYWFy8ooYtCz94vL1J0Ts59xM2QUYl4RJGaBjNkPL0YZ6htyZ2PhxKBbu5JLf+vK7qmJ
 OOk/0v/tSGAMufaaqQjvNdop257gWTygzIEj5bZBph4G3xaayG1t9JJKQUavi2FA5HxR
 N6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z08W1+Rmw/COrG5G+LMjOuvUonVPZi/EFVP6N0xVZ6M=;
 b=QFjfyZ3pF7Uho7J0/VR7cxkYq2JakLO7ssqVTQMh1EcpNAj82TLz5oxLpSX3p5LQXL
 0Y7kDlepwIVYCd+kIBC41EUTEV9fqBm1/YCQYwbGwolfZmw/aTqedA0J4XbG+VKYyfCI
 ed9MwPdDdLJVAur9PxVgOfWNBXMDKvEihAzHP7tornpjxv/3AVVYQ61p4CQ1j9MaeAoX
 L36geU9t59QmK1wiJ3Kq9YVCnLWV56JwJuK1eyOjNOmZEryUg9t6K54lZg/SmRZYPb94
 hWMAOuI+i28FaRv87H+uZn79/Xa3qzBt+6wXPQIG8SsjkwEIYDvQwakzUCaRKnpGg0bW
 FdoQ==
X-Gm-Message-State: AGi0PubqSFX0tStkXs2FWQdUhuo8PrW5rfnLgsA+x8pw1gK6aOWO7A5+
 rDMxIbCuFTMAAuRvmFfd0Oe0yUbwtvbepvR0KTA=
X-Google-Smtp-Source: APiQypKB834DXMy4pT8p80aDnjXAf/TBXnao496i9tBx/r4vUTd3Trqm4JBGB5Uc1ARDe9GQn50GT6XBxaN8gMJQY8Y=
X-Received: by 2002:a1c:e284:: with SMTP id z126mr6400055wmg.32.1586373043658; 
 Wed, 08 Apr 2020 12:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586370737.git.lukasstraub2@web.de>
 <f231c9abc706f5825e41c0fbaa4fc82de1121435.1586370737.git.lukasstraub2@web.de>
In-Reply-To: <f231c9abc706f5825e41c0fbaa4fc82de1121435.1586370737.git.lukasstraub2@web.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 Apr 2020 21:10:30 +0200
Message-ID: <CAJ+F1CKhRfz6pNXSODMRB_PFEN2vqH+nNM443cH3ZG7ibCVo=w@mail.gmail.com>
Subject: Re: [PATCH 2/3] chardev/char.c: Use qemu_co_sleep_ns if in coroutine
To: Lukas Straub <lukasstraub2@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Apr 8, 2020 at 8:37 PM Lukas Straub <lukasstraub2@web.de> wrote:
>
> This will be needed in the next patch.
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  chardev/char.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 04075389bf..51ad0dc6b3 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -38,6 +38,7 @@
>  #include "qemu/module.h"
>  #include "qemu/option.h"
>  #include "qemu/id.h"
> +#include "qemu/coroutine.h"
>
>  #include "chardev/char-mux.h"
>
> @@ -119,7 +120,11 @@ static int qemu_chr_write_buffer(Chardev *s,
>      retry:
>          res =3D cc->chr_write(s, buf + *offset, len - *offset);
>          if (res < 0 && errno =3D=3D EAGAIN && write_all) {
> -            g_usleep(100);
> +            if (qemu_in_coroutine()) {
> +                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 100000);
> +            } else {
> +                g_usleep(100);
> +            }
>              goto retry;

Although we don't have any coroutine code in chardev/, it dos this
kind of coroutine handling indirectly through qio. Thus it should be
fine too here.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>          }
>
> --
> 2.20.1
>


--=20
Marc-Andr=C3=A9 Lureau

