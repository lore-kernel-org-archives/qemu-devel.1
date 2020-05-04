Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4030EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F00A206B9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OX0s+Kmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F00A206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcYO-00080Z-5p
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVcWx-0005l1-Sy; Mon, 04 May 2020 10:57:16 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jVcWv-0002vp-Mj; Mon, 04 May 2020 10:57:14 -0400
Received: by mail-lj1-x244.google.com with SMTP id g4so9989927ljl.2;
 Mon, 04 May 2020 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ahp4fnyRnrL8Druo+hPCRIyKLsfKFpDywTu0QTqLkyw=;
 b=OX0s+Kmyf6gdeAuS0aGjr83oD8yNj6a5SKX7JmVq0Yx3VsL7lbQTuJm3CoLT/vd0GZ
 XodHmSeRP2qpjsXP0eyNnvFMZJgNnImtrr8zQ5kcWXoux9rG0uIZJrw3K7XkfykqT9EF
 zfAtZXfhw2cEqOMyIM3Wn+KD3NM6CXg72eVzjGVVjZ9iPa25EjnMkNvSxNNCj7R/khum
 WG6qQsnu2D3vorZxq1Y7FOLzG0yIF7M08N86FivZVJsEqHy9UceWSlyLbN4YoR93hIiK
 Yx5lnTqlCIoGC+oxH69jeecXpqQ59LC5xMEG2ojA3vOzXhNXNi6NqLeG6e5IRY/DqNhW
 wLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ahp4fnyRnrL8Druo+hPCRIyKLsfKFpDywTu0QTqLkyw=;
 b=oO9I0JqUyPvOWuaLYqQuwuR4vxWYc/f62Y4XwTfKKeW9a+7rHbGDG84/zO1tpNw/em
 febf50CfJgoyoh41Is14IFo0AdRDgkJ2yNrIO9sEwKBK/eH+nd2DVyhhwR8jO8vFskIu
 AY0FI1X3iUp3rCnT8Z1PUIEq8N3YPaphXrei5+nFr6S7m2g7Yk2X2vOyQeW0Ei3fn4fE
 CWsKzLcta/CZBS5/7736P+XZ8AMGRmD+xKDDxtZAc9B7Z96cj0uXVeg2K7TmzAeyViFx
 HNdJfNxqg5lX5JE7aP3EGSgAu54vPZAkjOou8wY81kke0FR9cd03gn0fMXT3B6qhxySQ
 2JHQ==
X-Gm-Message-State: AGi0PubMOylDEvuSp67iMYB1BaMvlsQQQ0FYBl4oIs1l5l1Kjs2HS7TT
 1w/bUwpFYPBAMrbe9x5VQv0=
X-Google-Smtp-Source: APiQypJLlvoKlaPdv7ZvVoV710fMvXzN/8hiyi7iLJ545gf2QbHDmdyRzu4rseBkvMdHTAJMdpHUpg==
X-Received: by 2002:a05:651c:403:: with SMTP id
 3mr10214393lja.231.1588604231538; 
 Mon, 04 May 2020 07:57:11 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id y21sm8416959ljg.66.2020.05.04.07.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:57:10 -0700 (PDT)
Date: Mon, 4 May 2020 16:57:10 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 04/10] net: cadence_gem: Define access permission for
 interrupt registers
Message-ID: <20200504145710.GD5519@toto>
References: <1588601168-27576-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1588601168-27576-5-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588601168-27576-5-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Tong Ho <tong.ho@xilinx.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Ramon Fried <rfried.dev@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 07:36:02PM +0530, Sai Pavan Boddu wrote:
> Q1 to Q7 ISR's are clear-on-read, IER/IDR registers
> are write-only, mask reg are read-only.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index a930bf1..c532a14 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -458,6 +458,7 @@ static const uint8_t broadcast_addr[] = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
>   */
>  static void gem_init_register_masks(CadenceGEMState *s)
>  {
> +    unsigned int i;
>      /* Mask of register bits which are read only */
>      memset(&s->regs_ro[0], 0, sizeof(s->regs_ro));
>      s->regs_ro[GEM_NWCTRL]   = 0xFFF80000;
> @@ -470,10 +471,19 @@ static void gem_init_register_masks(CadenceGEMState *s)
>      s->regs_ro[GEM_ISR]      = 0xFFFFFFFF;
>      s->regs_ro[GEM_IMR]      = 0xFFFFFFFF;
>      s->regs_ro[GEM_MODID]    = 0xFFFFFFFF;
> +    for (i = 0; i < s->num_priority_queues; i++) {
> +        s->regs_ro[GEM_INT_Q1_STATUS + i] = 0xFFFFFFFF;
> +        s->regs_ro[GEM_INT_Q1_ENABLE + i] = 0xFFFFE319;
> +        s->regs_ro[GEM_INT_Q1_DISABLE + i] = 0xFFFFE319;

Shouldn't these be 0xfffff319?
Perhaps I'm looking at old specs but mine says bits upper bits [31:12]
are reserved and read-only.


With that fixed:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>





> +        s->regs_ro[GEM_INT_Q1_MASK + i] = 0xFFFFFFFF;

> +    }
>  
>      /* Mask of register bits which are clear on read */
>      memset(&s->regs_rtc[0], 0, sizeof(s->regs_rtc));
>      s->regs_rtc[GEM_ISR]      = 0xFFFFFFFF;
> +    for (i = 0; i < s->num_priority_queues; i++) {
> +        s->regs_rtc[GEM_INT_Q1_STATUS + i] = 0x00000CE6;
> +    }
>  
>      /* Mask of register bits which are write 1 to clear */
>      memset(&s->regs_w1c[0], 0, sizeof(s->regs_w1c));
> @@ -485,6 +495,10 @@ static void gem_init_register_masks(CadenceGEMState *s)
>      s->regs_wo[GEM_NWCTRL]   = 0x00073E60;
>      s->regs_wo[GEM_IER]      = 0x07FFFFFF;
>      s->regs_wo[GEM_IDR]      = 0x07FFFFFF;
> +    for (i = 0; i < s->num_priority_queues; i++) {
> +        s->regs_wo[GEM_INT_Q1_ENABLE + i] = 0x00000CE6;
> +        s->regs_wo[GEM_INT_Q1_DISABLE + i] = 0x00000CE6;
> +    }
>  }
>  
>  /*
> -- 
> 2.7.4
> 

