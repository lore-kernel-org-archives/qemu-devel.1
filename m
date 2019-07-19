Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD510C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB4621849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDb8SeFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB4621849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoSwJ-0006sx-OD
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoSvd-0003xX-8X
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoSvb-0001YR-7U
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:28:05 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoSvZ-0001SW-7O
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:28:03 -0400
Received: by mail-ot1-x343.google.com with SMTP id x21so32697226otq.12
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ECweQ8b5l2IXjTHHRPDiyXHCMEYiAltfuQKVLF+9+Ms=;
 b=vDb8SeFej0bFJaUjtpGy2PwnXz9eirk4pUk8tFijTLZah3re55SESJqP0cEYIXVmxv
 /mUmJgU0gvM/aQAihp+RK3aruLPE4ByBz6Fimlggi76CermZgyZOz4NHObJ4riZcUc+p
 phuSdVV3NjYIbxKUBkdbXTdyU6cTBSXrIngw4QWAktG50jAM5BlpRDWvQvHpN1UZwKke
 U5U8JVsREtu9G22K50zvh4pUaxulsSWUPzObD7+Xnu1CDSKBrWoadTpZfAZ0BkSAnkuS
 UmGlRQdSfNKVhtr9UftcxuG++KRyIAE2gM39kIVuNLW4P732/fCAwq3sNSojH2sv44P1
 LR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ECweQ8b5l2IXjTHHRPDiyXHCMEYiAltfuQKVLF+9+Ms=;
 b=kG3MOymgx/uBRA3oniVLyR7QElC8lZpPdcfLSX/hOykMoMkjK3jE9LAuQNkxzsnOXE
 5zIBJgUYtrof4kgAfS85y9IpX8Lsw8WfFQcxXTkfSd7LErBbJ1HAoarLfW4q4deecq0V
 +asrwtBJWbEpKPyE2wusGgMd3CoJlfsto4s31MtTQgkpNeAYJpf94UWyCUXTvJ+WKlkU
 jHbHJXwbWnofvy09n9PUrhkAq5ECqVL9akTy5aLSxFhlqKlvhsZhuSzRBTXoORY14Xtp
 xuy1DMzy+T4nZq+Hk7WfIRhniXEL8Cf9OgoZ00UIZ6LS/Ynyc+7t64tP3stb1YnoXi56
 +jrQ==
X-Gm-Message-State: APjAAAVy4EjA0B8BKrCuRME8HQs5XyxT6ZoFpF4944JDLcGRsUuybTzi
 LktaZyIz7qI2VEUpCMpYSfgxYRxqoq+GRIwv6bJRFg==
X-Google-Smtp-Source: APXvYqypePzgWa+haxMU3TbByP3/Ib8erdkrKPdFjxIVA+eajSA9rnB58T9ey4EBpOKCNWvlm/Ls3KMIimrm0l6ulc0=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr2895672oti.91.1563542880085; 
 Fri, 19 Jul 2019 06:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190719131425.10835-1-philmd@redhat.com>
 <20190719131425.10835-4-philmd@redhat.com>
In-Reply-To: <20190719131425.10835-4-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 14:27:49 +0100
Message-ID: <CAFEAcA98bsjtbROzG9dew78ibu-QMSww028-vFSXQ389HJOq0A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH-for-4.1 3/7] hw/block/pflash_cfi02: Rewrite
 a fall through comment
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Corey Minyard <minyard@acm.org>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jul 2019 at 14:14, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> GCC9 is confused by this comment when building with CFLAG
> -Wimplicit-fallthrough=3D2:
>
>   hw/block/pflash_cfi02.c: In function =E2=80=98pflash_write=E2=80=99:
>   hw/block/pflash_cfi02.c:574:16: error: this statement may fall through =
[-Werror=3Dimplicit-fallthrough=3D]
>     574 |             if (boff =3D=3D 0x55 && cmd =3D=3D 0x98) {
>         |                ^
>   hw/block/pflash_cfi02.c:581:9: note: here
>     581 |         default:
>         |         ^~~~~~~
>   cc1: all warnings being treated as errors
>
> Rewrite the comment using 'fall through' which is recognized by
> GCC and static analyzers.
>
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index f68837a449..42886f6af5 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -577,7 +577,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
>                  pfl->cmd =3D 0x98;
>                  return;
>              }
> -            /* No break here */
> +            /* fall through */
>          default:
>              DPRINTF("%s: invalid write for command %02x\n",
>                      __func__, pfl->cmd);
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

