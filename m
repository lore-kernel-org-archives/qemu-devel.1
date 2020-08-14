Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC2C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A4820774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8mVhbEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A4820774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6dmo-0006TZ-Nj
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6dlw-0005c5-RC
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:45:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6dlv-00020b-8t
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:45:44 -0400
Received: by mail-wm1-x344.google.com with SMTP id 184so8603805wmb.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5Vm6ppg0yaHf0DAZOWFj2MrFEiLfmDaCE6JLlMprIsk=;
 b=m8mVhbEaxhS3gJi1vfU7fJCLvWLh456y55B/qxqkYbwUned/IE+fESW8xFYtx+DYrT
 mQr6IodPPDJQBIpprtfeFRA9I0yccgjExTGX/LhWU+DTW5+Gh5hix5jXsEaTcrcy0wl6
 XeRXRpQmapqjCeJBStbJeF34+hMcV2Ag1Aerj8oV2R4wwtEPErmdNWy98TsTu1JL8TiN
 FYRsds8TR3qlofoUx8safMXgKGi4MLnt6bBv8U2CJN0uD20ZoMFyazE8NdfFYKHYMrNq
 HhSSLClVrogljksCTVnqAPKWDFuVLRGmlwsFmdgL86Yh8LCl5imHzVMdmpRY5JKXmHnQ
 ZKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Vm6ppg0yaHf0DAZOWFj2MrFEiLfmDaCE6JLlMprIsk=;
 b=ZvIQm+/paaiQZl2N6m50YWHsRY6wR8wvq7cXRx0ZCuqLQupIyHBsDYRo2gTtjyadiD
 RYz/32Ax+PPDAGmvTi2Ggsrsz6Oe8W8dOKsUdsAeU4LqlCLvVzd7K3WeURTXoeHyhJR8
 fFvmpXRLPTUNrVZc/NJJ2BjDtYlL0B6BqZZUJEwjIFWgh59iZtM05DRyCgMcZqiUF4KQ
 UHpQ65+jY29LiC9tOgzcsodL9nGztgyIExQ58Cdq8iy5L/LiQdmR+uMf9AB+3+p05gpi
 9EO2A92aS1P5rcOVkljL/pbRJUq6fETZGaeDRMTbAL5jz7aFXiH3N1ri+qAzg+ncRj7f
 ImCw==
X-Gm-Message-State: AOAM533ZRt77wo3tJ49lAwHpZDpOGJ+i4Z6l0oX9x7JcQEuzZLiR+0nQ
 KpvriP3lUNmk5U7hXBwowRo=
X-Google-Smtp-Source: ABdhPJyUCUy6CRjYNwog/mUebRt1Nn3/Fji5xoTgN/Tqw6yXdeRqNrntY6VJGAo9NAf1KQEgoJxU3w==
X-Received: by 2002:a1c:9c91:: with SMTP id f139mr3667921wme.134.1597427141946; 
 Fri, 14 Aug 2020 10:45:41 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d21sm16748054wmd.41.2020.08.14.10.45.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:45:41 -0700 (PDT)
Subject: Re: [PATCH 01/41] pl1110: Rename PL1110 enum
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-2-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3af41d38-3d5f-bdc3-9624-8848151992ae@amsat.org>
Date: Fri, 14 Aug 2020 19:45:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 12:25 AM, Eduardo Habkost wrote:
> The PL1110 enum value name will conflict with the PL1110 type
> cast checker, when we replace the existing macro with an inline
> function.  Rename it to PL1110_STOCK.

typo s/PL1110/PL110/ in subject and description.

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/display/pl110.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/pl110.c b/hw/display/pl110.c
> index c2991a28d2..4664fde3f2 100644
> --- a/hw/display/pl110.c
> +++ b/hw/display/pl110.c
> @@ -42,7 +42,7 @@ enum pl110_bppmode
>  /* The Versatile/PB uses a slightly modified PL110 controller.  */
>  enum pl110_version
>  {
> -    PL110,
> +    PL110_STOCK,
>      PL110_VERSATILE,
>      PL111

For completeness I'd also rename PL111.

What about:

 enum pl110_version
 {
    PL110_VERSION,
    PL110_VERSATILE_VERSION,
    PL111_VERSION
 }

?

>  };
> @@ -372,12 +372,12 @@ static uint64_t pl110_read(void *opaque, hwaddr offset,
>      case 5: /* LCDLPBASE */
>          return s->lpbase;
>      case 6: /* LCDIMSC */
> -        if (s->version != PL110) {
> +        if (s->version != PL110_STOCK) {
>              return s->cr;
>          }
>          return s->int_mask;
>      case 7: /* LCDControl */
> -        if (s->version != PL110) {
> +        if (s->version != PL110_STOCK) {
>              return s->int_mask;
>          }
>          return s->cr;
> @@ -437,7 +437,7 @@ static void pl110_write(void *opaque, hwaddr offset,
>          s->lpbase = val;
>          break;
>      case 6: /* LCDIMSC */
> -        if (s->version != PL110) {
> +        if (s->version != PL110_STOCK) {
>              goto control;
>          }
>      imsc:
> @@ -445,7 +445,7 @@ static void pl110_write(void *opaque, hwaddr offset,
>          pl110_update(s);
>          break;
>      case 7: /* LCDControl */
> -        if (s->version != PL110) {
> +        if (s->version != PL110_STOCK) {
>              goto imsc;
>          }
>      control:
> @@ -513,7 +513,7 @@ static void pl110_init(Object *obj)
>  {
>      PL110State *s = PL110(obj);
>  
> -    s->version = PL110;
> +    s->version = PL110_STOCK;
>  }
>  
>  static void pl110_versatile_init(Object *obj)
> 


