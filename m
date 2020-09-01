Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1236DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11EB206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYAvWEfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11EB206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6TG-0006iN-Uo
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1kD6SN-0005nt-Hg; Tue, 01 Sep 2020 09:36:15 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1kD6SL-0007hX-3b; Tue, 01 Sep 2020 09:36:15 -0400
Received: by mail-lj1-x244.google.com with SMTP id v12so1527373ljc.10;
 Tue, 01 Sep 2020 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=IoRTWBDxU7Az7DOFWKIvhImOeuD+WtW8nm5q0utA+5o=;
 b=YYAvWEfJfFh/OIQVZ/XAjXWrGPRoAKDL4UmRNRnMXulKAytQkvue5zl4OWrpB9if4O
 +9Lxl0M8lXW+fBQ/JJfM0J/6RKwlvo59PMhhgPZKG/5HVYo4Dfak3FUwT+9wwc0vuvOM
 z+E1xZe0qFJL75IqRGyO/TxI2sjCWHD0FJ3BF+N7yJrVnigI0PlYoPQWiAaRfyTrqmsZ
 FPw0M9QvXnoa8w0hWESMwX+Ao4S90EEJfTkPFL2RW6EkwvcVqP2H/ZUHZB67mgT0oyeQ
 l5a9fmnUD956FlCGffdX9AUl7QuY4Mm8U5jInxSFLaqhWdDiLdYkjPQ3/x8d+nuQHxVX
 axrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=IoRTWBDxU7Az7DOFWKIvhImOeuD+WtW8nm5q0utA+5o=;
 b=Mnfm++XrKyQlh8W/elzXEIKSnUbd7LfmTZbo1MJXp/sUt/CcR3iQ0CsRaM7AFpLZiq
 xrp7yLKN0j3eOl/yw1TrSjYne2othDMDOGhLKz26fiyAwh23MuhisCyaMGODGF+Bxkzb
 SGqzmvNzr5oLryPuGVwAt7/NQRmfuBkwdYp/r6o3Tn+5/eWTomiuG+xjxMS+fyU7u5wD
 pFn2TxB45M9iNsJusul7to5AsJApL9cx+CQjllv99JicNX5H7CS+FdFbTh+gguvUm6Df
 QU1m8Fs+fvyTM3W/Wp7q5AXxmjqa8CAR9RC3vAt87G6ocU8jgBwA+0YLEHsAuggps5Kc
 Ah0w==
X-Gm-Message-State: AOAM530y/MlkBj79GkPQWN7cNfFmGkUZx6ARLPBd/uT6+mTHO2Ab5+W1
 7peGk75EYRs3OtsxkCamfio=
X-Google-Smtp-Source: ABdhPJzW/3uLvmU+q0OEuiFWOguVFY0qoUKQmpCHhkrfJSlLUdoCPIGWqbh3rSPtB+9NavYUnofHMg==
X-Received: by 2002:a05:651c:1056:: with SMTP id
 x22mr663736ljm.81.1598967369903; 
 Tue, 01 Sep 2020 06:36:09 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 y9sm279551lji.106.2020.09.01.06.36.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Sep 2020 06:36:09 -0700 (PDT)
Date: Tue, 1 Sep 2020 15:36:07 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 1/2] m25p80: Add basic support for the SFDP command
Message-ID: <20200901133606.tytctenwwbnzlgl4@fralle-msi>
References: <20200827091130.3525790-1-clg@kaod.org>
 <20200827091130.3525790-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200827091130.3525790-2-clg@kaod.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cedric,

On [2020 Aug 27] Thu 11:11:29, Cédric Le Goater wrote:
> JEDEC STANDARD JESD216 for Serial Flash Discovery Parameters (SFDP)
> provides a mean to describe the features of a serial flash device
> using a set of internal parameter tables.
> 
> This is the initial framework for the RDSFDP command giving access to
> a private SFDP area under the flash. This area now needs to be
> populated with the flash device characteristics, using a new 'sfdp'
> pointer under FlashPartInfo.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  hw/block/m25p80_sfdp.h | 15 +++++++++++++++
>  hw/block/m25p80.c      | 33 +++++++++++++++++++++++++++++++++
>  hw/block/trace-events  |  1 +
>  3 files changed, 49 insertions(+)
>  create mode 100644 hw/block/m25p80_sfdp.h
> 
> diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
> new file mode 100644
> index 000000000000..b75fd0b0c13f
> --- /dev/null
> +++ b/hw/block/m25p80_sfdp.h
> @@ -0,0 +1,15 @@
> +/*
> + * M25P80 SFDP
> + *
> + * Copyright (c) 2020, IBM Corporation.
> + *
> + * This code is licensed under the GPL version 2 or later. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_M25P80_SFDP_H
> +#define HW_M25P80_SFDP_H
> +
> +#define M25P80_SFDP_AREA_SIZE 0x100
> +
> +#endif
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 82270884416e..32925589ec7a 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -33,6 +33,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "trace.h"
> +#include "m25p80_sfdp.h"
>  
>  /* Fields for FlashPartInfo->flags */
>  
> @@ -72,6 +73,7 @@ typedef struct FlashPartInfo {
>       * This field inform how many die is in the chip.
>       */
>      uint8_t die_cnt;
> +    const uint8_t *sfdp;
>  } FlashPartInfo;
>  
>  /* adapted from linux */
> @@ -333,6 +335,7 @@ typedef enum {
>      BULK_ERASE = 0xc7,
>      READ_FSR = 0x70,
>      RDCR = 0x15,
> +    RDSFDP = 0x5a,
>  
>      READ = 0x03,
>      READ4 = 0x13,
> @@ -398,6 +401,7 @@ typedef enum {
>      STATE_COLLECTING_DATA,
>      STATE_COLLECTING_VAR_LEN_DATA,
>      STATE_READING_DATA,
> +    STATE_READING_SFDP,
>  } CMDState;
>  
>  typedef enum {
> @@ -619,6 +623,8 @@ static inline int get_addr_length(Flash *s)
>      }
>  
>     switch (s->cmd_in_progress) {
> +   case RDSFDP:
> +       return 3;
>     case PP4:
>     case PP4_4:
>     case QPP_4:
> @@ -744,6 +750,17 @@ static void complete_collecting_data(Flash *s)
>                            " by device\n");
>          }
>          break;
> +
> +    case RDSFDP:
> +        if (s->cur_addr < M25P80_SFDP_AREA_SIZE) {

Is perhaps M25P80_SFDP_AREA_SIZE a limit for the micron flashes in patch
2 (and not sfdp)? An option might be to change .sfdp to a
'.sfdp_read' function decoding the address internally (for the
micron flashes it could just return the array value in case the address is
less than M25P80_SFDP_AREA_SIZE or 0xFF else). It might become easier
to add flashes containing parameter tables in higher addresses (the
function could then decode the address into a specific table/area).

> +            s->state = STATE_READING_SFDP;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "M25P80: Invalid SFDP address %#" PRIx32 "\n",
> +                          s->cur_addr);
> +        }
> +        break;
> +
>      default:
>          break;
>      }
> @@ -1160,6 +1177,16 @@ static void decode_new_cmd(Flash *s, uint32_t value)
>      case RSTQIO:
>          s->quad_enable = false;
>          break;
> +    case RDSFDP:
> +        if (s->pi->sfdp) {
> +            s->needed_bytes = get_addr_length(s) + 1 ; /* SFDP addr + dummy */

Should above be changed to:

s->needed_bytes = get_addr_length(s) + 8;  /* SFDP addr + dummy */

(I think it might fail else when the flashes are operating in 2 lines and
4 lines and are generating 8 dummy cycles for the RDSFDP)

Best regards,
Francisco Iglesias

> +            s->pos = 0;
> +            s->len = 0;
> +            s->state = STATE_COLLECTING_DATA;
> +            break;
> +        }
> +        /* Fallthrough */
> +
>      default:
>          s->pos = 0;
>          s->len = 1;
> @@ -1256,6 +1283,12 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>              }
>          }
>          break;
> +    case STATE_READING_SFDP:
> +        assert(s->pi->sfdp);
> +        r = s->pi->sfdp[s->cur_addr];
> +        trace_m25p80_read_sfdp(s, s->cur_addr, (uint8_t)r);
> +        s->cur_addr = (s->cur_addr + 1) & (M25P80_SFDP_AREA_SIZE - 1);
> +        break;
>  
>      default:
>      case STATE_IDLE:
> diff --git a/hw/block/trace-events b/hw/block/trace-events
> index 958fcc5508d1..53d377ca2b46 100644
> --- a/hw/block/trace-events
> +++ b/hw/block/trace-events
> @@ -152,5 +152,6 @@ m25p80_page_program(void *s, uint32_t addr, uint8_t tx) "[%p] page program cur_a
>  m25p80_transfer(void *s, uint8_t state, uint32_t len, uint8_t needed, uint32_t pos, uint32_t cur_addr, uint8_t t) "[%p] Transfer state 0x%"PRIx8" len 0x%"PRIx32" needed 0x%"PRIx8" pos 0x%"PRIx32" addr 0x%"PRIx32" tx 0x%"PRIx8
>  m25p80_read_byte(void *s, uint32_t addr, uint8_t v) "[%p] Read byte 0x%"PRIx32"=0x%"PRIx8
>  m25p80_read_data(void *s, uint32_t pos, uint8_t v) "[%p] Read data 0x%"PRIx32"=0x%"PRIx8
> +m25p80_read_sfdp(void *s, uint32_t addr, uint8_t v) "[%p] Read SFDP 0x%"PRIx32"=0x%"PRIx8
>  m25p80_binding(void *s) "[%p] Binding to IF_MTD drive"
>  m25p80_binding_no_bdrv(void *s) "[%p] No BDRV - binding to RAM"
> -- 
> 2.25.4
> 

