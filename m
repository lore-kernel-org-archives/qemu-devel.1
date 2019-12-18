Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31DAC3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C908218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3fRKKTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C908218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgtM-00041y-LO
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihgsc-0003OY-G4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:29:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ihgsX-0002il-JL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:29:14 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ihgsX-0002hV-4T; Wed, 18 Dec 2019 16:29:09 -0500
Received: by mail-oi1-x241.google.com with SMTP id 18so1251227oin.9;
 Wed, 18 Dec 2019 13:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/wTMVe3mHFcJ+GRI7GSpvgLdvogiRtHuB4BVxZXVU9s=;
 b=O3fRKKTGyd4E2NdolzDIwvJANQqdz1yhDuM/LCkaqacqt/xC1yXbyg3lngBdkpoIwr
 KhyCRTNwkjKwy582TvLU9ZDxhMP4oBvQXtExSqEuuOcvenloNKuTPURaQctNMO5LXk58
 OdzqM8+llpqFlbaJoKGsFJb4tq8wUw+DLGxHceSsdTcIjb4opR6xU5CQVoqR2d9JQCet
 JzDm2W6zq9eK8Y6OBD6SZMceBIl7+vwp6DUkNNiYjPtrDXEooalmUWHmuZu694k50NPw
 GM0zVT79BCPVUmu2LZL6t9jXEiXSj/JBWtIYJNFyWQUs1A2Nye/osNkOPjDgRPmcBMUd
 D1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/wTMVe3mHFcJ+GRI7GSpvgLdvogiRtHuB4BVxZXVU9s=;
 b=cM5KB6Zu7nI+sTNFFcwdQLRAGUucM7ab8MjvKL59niGrSJQO8Q9ScjAvq8gqYiKSMf
 hqMocF0vijZMv4gxcpcS7Py4x++GeLnCg7G+MZ4P/KsHIESRofSMtHNJvCwsffAGH5z9
 k24Rgi+NT7cjm5YsZ/TRq+LCpfrB7Nzy5WtkfaNG45bLrNlsKNIzUKBV1CJRZoN4ImWi
 l+GOndO8XA9FSWoUIBuzAVCBVvrvRCFqhy44mOeNd2tPYStiCjFNk3oPbI2XrNQgmk+V
 HlOeAfC2+UcUAogMc15GkRJngCyyfzI8JTy1gHK9AGSaKf5Ke6ouFLa7jTbiMVKFAwK6
 TWyw==
X-Gm-Message-State: APjAAAW/+vHpNWLi+rWp9RTlOlXjlpc+3PXEBiEDx+h2ehKuqSWBlzsh
 5c3/DH2udlb2XnpPxJOPxZz85mO8pxuNLWDfKJo=
X-Google-Smtp-Source: APXvYqwLdJjQeX2pO+HZdDCCv/Syb0ahbil8ZJgKSyWjb0VmGWROe2BhXihCULqjAqo8fUt0/NziUX53p0u7w7t9d0c=
X-Received: by 2002:a05:6808:2d5:: with SMTP id
 a21mr1548161oid.62.1576704548297; 
 Wed, 18 Dec 2019 13:29:08 -0800 (PST)
MIME-Version: 1.0
References: <20191218192526.13845-1-philmd@redhat.com>
 <20191218192526.13845-7-philmd@redhat.com>
In-Reply-To: <20191218192526.13845-7-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 18 Dec 2019 22:28:57 +0100
Message-ID: <CAL1e-=gOWYMNRo2rQ=eawnnM9+L6-mPAgTE-8ndO_etyZssLJA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/6] hw/pci-host/designware: Remove unuseful
 FALLTHROUGH comment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 "open list:Stellaris" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 8:29 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> We don't need to explicit this obvious switch fall through.
> Stay consistent with the rest of the codebase.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

I see you covered two cases of such comment (in patches 5 and 6).

But why didn't you than cover the following cases:

block/vhdx.c:            case PAYLOAD_BLOCK_NOT_PRESENT: /* fall through */
block/vhdx.c:            case PAYLOAD_BLOCK_NOT_PRESENT: /* fall through */

hw/net/rtl8139.c:    case 1: /* fall through */
hw/net/rtl8139.c:    case 2: /* fall through */

contrib/vhost-user-scsi/vhost-user-scsi.c:    case 1: /* fall through */
(this one needs full switch block reformatting, but can this be
changed, since it is in "contrib"?)

?

Thanks,
Aleksandar



> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/pci-host/designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index 71e9b0d9b5..dd245516dd 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -182,7 +182,7 @@ designware_pcie_root_config_read(PCIDevice *d, uint32=
_t address, int len)
>          break;
>
>      case DESIGNWARE_PCIE_ATU_CR1:
> -    case DESIGNWARE_PCIE_ATU_CR2:          /* FALLTHROUGH */
> +    case DESIGNWARE_PCIE_ATU_CR2:
>          val =3D viewport->cr[(address - DESIGNWARE_PCIE_ATU_CR1) /
>                             sizeof(uint32_t)];
>          break;
> --
> 2.21.0
>
>

