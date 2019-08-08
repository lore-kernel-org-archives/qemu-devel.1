Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E81C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5592184E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 09:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7jGH3u7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5592184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hveQS-0000WO-DG
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 05:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45761)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvePv-0007wu-H9
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvePu-00089V-IH
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:09:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvePu-00087l-8Q
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 05:09:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id r1so94079585wrl.7
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FgkP0WjyvA7wcjKduWocYRrPNBikamqWRucP/WwmwPA=;
 b=C7jGH3u7/pP+0zagiIf0sU6CIQL9bFVkfEXXYTLzAiAa9EA2dQhYMKckPa258KdQcM
 iMrOfdnC6/ZnDhIexn7tVLxkJ3ABgaag4GXab615aMrdzBLfDeH7lpSHvQiTtDkfELTS
 I892Gt0b4PvAL1FJRLW4nF9pke0J7fBkTYjBVuG7kTmZnTR8gMgsK1ZNCWrC2m592CqQ
 qCog/b2BFLtlqQS6rH1fdYVjr/aSPpC9j1yefNYh1EG0QL1CDcSDML0IsedT37CdNwpb
 LPOnSE5dhnHaRBjSnJOnXbV37KaWBLISM2vGEsAfc99GFIln3/KbAcFZhPfPFkE84b2n
 e87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FgkP0WjyvA7wcjKduWocYRrPNBikamqWRucP/WwmwPA=;
 b=CT10RMEnRR/J4bDpChgH5M/OBN0Slx3Ei2xV3QM2CPhmLssCbRmXN5DmSU7ong5Og0
 KFk6eMZC27yOpHqD9Winas7b1tts3FuV0V1WozAs9BAro/UyNa5RUjW2oPIem3zjZhBK
 Ten/TUd6ZULxdZDv+EqhfK4/NZoeASAXYSvrWXS989n92K4zIMjuYJchUqcdMUQ9T+dC
 GZbPrQRpCMl2RngnK3LRC2Q8D41aIrIixI2mioT2Ks+tWVinZrX0hIFWKv0jIaEOVB4L
 X1jpT5zukSvPeDTN30wyisWZlNyoQupod3GmHxgAFqGXRsRa5yI+sbSpKOBFOnoLORup
 vzkg==
X-Gm-Message-State: APjAAAVsyt1vuSTYIUnC0vADwSPUBXQHZogtz0iVocy0RMaflw9+aSTL
 dJT4IHd7lH0NpPdbi8ejsfiNIQ==
X-Google-Smtp-Source: APXvYqxjgiJt/a8FVK8JLlqbAOQKJYR9900xx9S7L6OOR3+ml5S+6yrCZXZRT2XvB8ZFGb+0Wf2AWQ==
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr16192917wrv.157.1565255340661; 
 Thu, 08 Aug 2019 02:09:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z6sm1550389wmz.46.2019.08.08.02.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2019 02:09:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A85111FF87;
 Thu,  8 Aug 2019 10:08:59 +0100 (BST)
References: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
 <1565239479-2130-1-git-send-email-bmeng.cn@gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <1565239479-2130-1-git-send-email-bmeng.cn@gmail.com>
Date: Thu, 08 Aug 2019 10:08:59 +0100
Message-ID: <877e7ohvmc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2] hw: net: cadence_gem: Fix
 build errors in DB_PRINT()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bin Meng <bmeng.cn@gmail.com> writes:

> When CADENCE_GEM_ERR_DEBUG is turned on, there are several
> compilation errors in DB_PRINT(). Fix them.

The first fix should be to ensure the format strings are validated in
normal compilation. This can be achieved by allowing the compiler to
optimise away debug strings with constant folding... for example:

  #define tlb_debug(fmt, ...) do { \
      if (DEBUG_TLB_LOG_GATE) { \
          qemu_log_mask(CPU_LOG_MMU, "%s: " fmt, __func__, \
                        ## __VA_ARGS__); \
      } else if (DEBUG_TLB_GATE) { \
          fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__); \
      } \
  } while (0)

However ultimately most debug printfs are either a) stale leftovers from
original development or b) could be considered for conversion to
tracepoints.

>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> ---
>
> Changes in v2:
> - use HWADDR_PRIx instead of TARGET_FMT_plx for consistency
> - use 'z' modifier to print sizeof(..)
>
>  hw/net/cadence_gem.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index d412085..b6ff2c1 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -983,8 +983,9 @@ static ssize_t gem_receive(NetClientState *nc, const =
uint8_t *buf, size_t size)
>              return -1;
>          }
>
> -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize=
),
> -                rx_desc_get_buffer(s->rx_desc[q]));
> +        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n",
> +                 MIN(bytes_to_copy, rxbufsize),
> +                 rx_desc_get_buffer(s, s->rx_desc[q]));
>
>          /* Copy packet data to emulated DMA buffer */
>          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc=
[q]) +
> @@ -1157,7 +1158,7 @@ static void gem_transmit(CadenceGEMState *s)
>              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
>                                                 (p - tx_packet)) {
>                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x spac=
e " \
> -                         "0x%x\n", (unsigned)packet_desc_addr,
> +                         "0x%zx\n", (unsigned)packet_desc_addr,
>                           (unsigned)tx_desc_get_length(desc),
>                           sizeof(tx_packet) - (p - tx_packet));
>                  break;


--
Alex Benn=C3=A9e

