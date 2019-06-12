Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEECC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 18:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FAF2080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 18:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZMRd/II"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FAF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34270 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb7dw-0005RQ-HR
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 14:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47291)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hb7aX-0003ty-IZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 14:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hb7aV-0002RD-5N
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 14:03:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hb7aT-0002OK-FD
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 14:03:05 -0400
Received: by mail-wr1-x442.google.com with SMTP id d18so17897960wrs.5
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 11:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Q9EvNrXFTEmV9zWhum3wXdynxpxJCkAB0NkLv7AlOhQ=;
 b=hZMRd/IIdp7z2jhqh0YxEBnMjgUcDQy3O8BduTbMrf71WJrmKZdjzXRrmfjViJKERt
 L7Ka/p5wG9l8dYHieRBDhG/74zA8Zt98MchZ9WNgVuEqAkrTSugRWwj70QsbZchgjx0q
 P9mQdK6BRiMmC3wJmeutcYyFGCeKIfj9Z91W1tVi6m4azm+pC/ES0l8+k9Y9uwATo4ls
 UQbS56sr8CNUPhZqbng+wR3N7TDLQpsVHppSyGMaPvGx8eB54rHUS2D2AX1wyXPXssvA
 MsRvMtmn2z+uYsDU45lkiBAOH9ZCXtzKXiilBS2pVnlS3mjMwuCzbE+rMhkpa3Yn8gy/
 exMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Q9EvNrXFTEmV9zWhum3wXdynxpxJCkAB0NkLv7AlOhQ=;
 b=XJALTZVG7RMHaC+fC9aB6izE4mwF7orwUoAIPDQCXR2BQ8yk9PeCMwcZvSaH9vwUMD
 xoNZCr0AT8iClONWmdBcO3rSLHpKdBKJq5e2UF20jIHQD47+ytsmuW4jJet/zirQ4ezd
 JGD+QZTP7/NJayMP9sk1Uh2k/l3EyGIDCIqDjAh0k/4mH24JYn1WVNKh58tSApheEzR/
 LqTL1MaX56UqZHL0a1f6zKNxdtlfZDVjHCSHSZDUElGP7RFVrvi/ANLcRKOIPv+LUU3d
 Rs8ZonpcSiAR/LMiyl4+qF9Ppe8wVou1Ph7xApx58URDnttZVWYr8sbdKz/AD3yimBkX
 uk7g==
X-Gm-Message-State: APjAAAV1XrpnEWYpJQGGHPZc6Wuhp7yVq+Rsy2sUG1d9btHfxxE8hqF7
 jg43441qGNiF/elQwrF8WjWdhw==
X-Google-Smtp-Source: APXvYqweBIYRwTkKT6LN2Ur48ZGIAIJV+0dAP5JDbE4ZJycV4/pDHP/PmYfJiIX9af+NDDZd9p6yew==
X-Received: by 2002:a5d:494d:: with SMTP id r13mr2364918wrs.152.1560362583190; 
 Wed, 12 Jun 2019 11:03:03 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y9sm2905381wma.1.2019.06.12.11.03.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 12 Jun 2019 11:03:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A6641FF87;
 Wed, 12 Jun 2019 19:03:02 +0100 (BST)
References: <20190611145556.12940-1-rfried.dev@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190611145556.12940-1-rfried.dev@gmail.com>
Date: Wed, 12 Jun 2019 19:03:02 +0100
Message-ID: <87o932el61.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2] net: cadence_gem: fix
 compilation error when debug is on
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, Ramon Fried <rfried.dev@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ramon Fried <rfried.dev@gmail.com> writes:

> defining CADENCE_GEM_ERR_DEBUG causes compilation
> errors, fix that.

It would be worth doing something like:

#ifdef CADENCE_GEM_ERR_DEBUG
#define CADENCE_GEM_GATE 1
#else
#define CADENCE_GEM_GATE 0
#endif

#define DB_PRINT(...) do { \
    if (CADENCE_GEM_GATE) { \
        fprintf(stderr,  ": %s: ", __func__); \
        fprintf(stderr, ## __VA_ARGS__); \
    } \
} while (0)

So these format strings don't go stale in and only get detected on
--debug builds.

While your at it I suspect the fprintf debug would be better of as:

  qemu_log("%s: " fmt, __func__, ## args);


>
> Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> ---
> v2: change %lx to HWADDR_PRIx and %lx to %zdx
>
>  hw/net/cadence_gem.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 7f63411430..e9b1b1e2eb 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -982,8 +982,8 @@ static ssize_t gem_receive(NetClientState *nc, const =
uint8_t *buf, size_t size)
>              return -1;
>          }
>
> -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize=
),
> -                rx_desc_get_buffer(s->rx_desc[q]));
> +        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n", MIN(bytes_to_c=
opy, rxbufsize),
> +                rx_desc_get_buffer(s, s->rx_desc[q]));
>
>          /* Copy packet data to emulated DMA buffer */
>          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc=
[q]) +
> @@ -1156,7 +1156,7 @@ static void gem_transmit(CadenceGEMState *s)
>              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
>                                                 (p - tx_packet)) {
>                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x spac=
e " \
> -                         "0x%x\n", (unsigned)packet_desc_addr,
> +                         "0x%zdx\n", (unsigned)packet_desc_addr,
>                           (unsigned)tx_desc_get_length(desc),
>                           sizeof(tx_packet) - (p - tx_packet));
>                  break;


--
Alex Benn=C3=A9e

