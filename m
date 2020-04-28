Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91015C83004
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2FF206B9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 08:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6msafjk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2FF206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTLws-0004JF-Dx
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 04:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jTLsD-0003cd-AS
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jTLlQ-0004ri-PJ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:39:28 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:43876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jTLXa-0000Ie-Dp
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:24:30 -0400
Received: by mail-lj1-x243.google.com with SMTP id l19so20505426lje.10
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J+vKbsSCHWeD3wg2/Qaw44d6Yuct6qNUHIzJpYXFgCU=;
 b=k6msafjkIgWvI/J++46jdibUWvssVqESBLjs8EuYsKgMmmSL+3t3gbwuWoefdo64AK
 q1OOzV97W1tjocLCMdMmP5qO3cUV52oJJY3gnsDbHEVrJL62KpBVkK7jJ8/v25U0zhUt
 lAQkBLtSC8J5xKzK6i3IUiczSkbmJISI0HPt5kOLSENlkvZtxpWJ1/MQMUbVSoMvIzjy
 2zcmSvfkBEc/6Ytf6GHwZWXfvTnGP5zTr43tmTJpAwWNIiL+jIprzYpMFqtSHvVgVtgD
 sPMM5xiYET6pF/A8ARlsCEb3I9sjl8JCIhIeolYhoePASSxLj00k/xmXgaBQsHivbS9s
 8PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J+vKbsSCHWeD3wg2/Qaw44d6Yuct6qNUHIzJpYXFgCU=;
 b=QaoDWYxhFqhDcC5Ri1waMW8H3Kn4ZJuK0fB3GQ5G2/V4zkIFJS7jUPJbFTHdjpWMto
 cwUkrrCA0tsFk49Brj7IE2DmDiDJVoWg+mLoIlGWtf+D0PEAmS6fn081GLkkRKQqkaNP
 2IMqWjYmzy3LWOvWPdEh5rOgDCiZPisYDT/HjtFPOTXPBrlaZ1WMjLB0ANfRaXdkyMyj
 jdcBu3qrBn0UD65WK3sW8mL2AU9+bRdGqkgHSBBdS6o4vL3ehlZe6jLzwWHmR/g9L9qH
 Y6SZwSuNRHAO9qrBQM7pHJX/g0+m4Z6tPTu0iTsYZbcz0r8+xOJAi8TVIhiVyXJT6jEu
 vReg==
X-Gm-Message-State: AGi0PuYjMo0IwcSYHAfd1+/L+5i/2EvHj7OgnxUey0wDKmsc+N1N4aoi
 fwV8zxw5ancwHjKoXU0CNyEmVUsS7fXE1+eLBsU=
X-Google-Smtp-Source: APiQypKGFaXP7NscPNl6/tnf9pQf+kjHxeLBuzHfzUUwM/OLk3f55ZNjhWgIerIBNWwDFPgLH2uqcok6FNcVqVOWxzk=
X-Received: by 2002:a2e:b4e7:: with SMTP id s7mr16466243ljm.103.1588062268631; 
 Tue, 28 Apr 2020 01:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-7-git-send-email-chenhc@lemote.com>
 <38fe3267-3d1b-26eb-13e5-dd3ed7039e61@amsat.org>
In-Reply-To: <38fe3267-3d1b-26eb-13e5-dd3ed7039e61@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Tue, 28 Apr 2020 16:31:56 +0800
Message-ID: <CABDp7VrYJx0L7tsOh6vJ5SOAz-63YZY-UkC5zjGkUHN8a+0YwQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 7/7] MAINTAINERS: Add myself as Loongson-3
 maintainer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-level <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Tue, Apr 28, 2020 at 2:18 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi Huacai,
>
> On 4/27/20 11:33 AM, Huacai Chen wrote:
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  MAINTAINERS | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index aa9a057..efe840b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1080,6 +1080,12 @@ F: hw/isa/vt82c686.c
> >  F: hw/pci-host/bonito.c
> >  F: include/hw/isa/vt82c686.h
> >
> > +Loongson-3
> > +M: Huacai Chen <chenhc@lemote.com>
> > +S: Maintained
> > +F: hw/mips/mips_loongson3.c
> > +F: hw/pci-host/ls7a.c
>
> I still haven't received the series cover, so I'm not sure if you
> intended to include the LS7A bridge chip here, but if so it seems you
> forgot to include it.
I'm sorry that I've rework the qemu patchset together with Jiaxun
Yang. Now we have dropped LS7A bridge and use GPEX instead. This patch
should also be updated but I forgot.

>
> > +
> >  Boston
> >  M: Paul Burton <pburton@wavecomp.com>
> >  R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> >



--=20
Huacai Chen

