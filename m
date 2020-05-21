Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0209EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:11:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B540D206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 14:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYuFbAhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B540D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbluy-0006CE-W5
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 10:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbltD-0003rp-Ci
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:09:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34290
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbltC-0004A3-Ed
 for qemu-devel@nongnu.org; Thu, 21 May 2020 10:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590070177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBYyQ6OzhERguYaOlfLv7XIgmRbGFK/607WiYjHeRmU=;
 b=SYuFbAhQnDEK3P8sA9t5+TC7EYuv5H5KpuPXziPQ92oVPmSC3sJ6UOcnio3jYdUO3DaGwR
 l6m+MHlyPXAHVg5dyrFzLoIQ5mh2EkRyY5xIch+tHHCGfV/Cy/kyeymO4Yy5CtZMXij+FK
 vlCLKOVA6f/ji8zJikHMuS/84l8FhV8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-4k0S9YutOkaXP3fQ9YsbRQ-1; Thu, 21 May 2020 10:09:36 -0400
X-MC-Unique: 4k0S9YutOkaXP3fQ9YsbRQ-1
Received: by mail-wr1-f71.google.com with SMTP id e14so2953973wrv.11
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 07:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rBYyQ6OzhERguYaOlfLv7XIgmRbGFK/607WiYjHeRmU=;
 b=E7OWBAz1FMqfZCzr0KBUc6E27+VUPVHgY4maLvHGc4JLXjinzCyX93aH+iaRGl9lZV
 16TfVhd5Ib5vPOQ9akq1RZ6vovvssfAVogext9cTCi7wJJON5pzI3ZBHjiBE4tmDnZj1
 SfYpLduFRuLr2Fycl9qXiaCLz0K/0pEE3RAGs3SNzPaZpcyEN7MVNr4Pa0dAZ1xtW1DS
 llo1bOaSb90b/8oZqpOc5Rpr38nILtIG5Q73ZxQmfUN9FqikXTpq0VE2ucmODAjog3lL
 b5AnUZ7VBCFVP4xCSe8J36Gqxg1F1bGMQwSO2PyDsH6GxeuGs4D0xASLwon8KdZ0tEFN
 x2VA==
X-Gm-Message-State: AOAM53226j5PMpH0yoNMLOh2TgmXiVVnf0TTq+SghBn+ycIwrlHUkv3u
 Pmu/XGqJHy764PuQnIVlZBN+Kf8gwqNDdQNJInTQOGPkgdl+K63kz9j5kX5eBrjo5acU61BilNT
 7LhPfTbsj7kjZkm4=
X-Received: by 2002:a1c:e188:: with SMTP id y130mr9782826wmg.105.1590070173825; 
 Thu, 21 May 2020 07:09:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1uWslumefdZoQFaq158o65hgdCXU5Bcibtacpkp/qJfbNukv4AMetCvjZdMmUCguVL31eJQ==
X-Received: by 2002:a1c:e188:: with SMTP id y130mr9782813wmg.105.1590070173643; 
 Thu, 21 May 2020 07:09:33 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 88sm3785384wre.45.2020.05.21.07.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 07:09:33 -0700 (PDT)
Subject: Re: [PATCH 4/6] sm501: Clean up local variables in sm501_2d_operation
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <cover.1589981990.git.balaton@eik.bme.hu>
 <f9557de4f9d30e5af4b1e7cd66f3e5a044705fba.1589981990.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a194c42a-d0ef-a120-f450-486e02cd02c7@redhat.com>
Date: Thu, 21 May 2020 16:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f9557de4f9d30e5af4b1e7cd66f3e5a044705fba.1589981990.git.balaton@eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 3:39 PM, BALATON Zoltan wrote:
> Make variables local to the block they are used in to make it clearer
> which operation they are needed for.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/display/sm501.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 97660090bb..5ed57703d8 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -699,28 +699,19 @@ static inline void hwc_invalidate(SM501State *s, int crt)
>   
>   static void sm501_2d_operation(SM501State *s)
>   {
> -    /* obtain operation parameters */
>       int cmd = (s->twoD_control >> 16) & 0x1F;
>       int rtl = s->twoD_control & BIT(27);
> -    int src_x = (s->twoD_source >> 16) & 0x01FFF;
> -    int src_y = s->twoD_source & 0xFFFF;
> -    int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
> -    int dst_y = s->twoD_destination & 0xFFFF;
> -    int width = (s->twoD_dimension >> 16) & 0x1FFF;
> -    int height = s->twoD_dimension & 0xFFFF;
> -    uint32_t color = s->twoD_foreground;
>       int format = (s->twoD_stretch >> 20) & 0x3;
>       int rop_mode = (s->twoD_control >> 15) & 0x1; /* 1 for rop2, else rop3 */
>       /* 1 if rop2 source is the pattern, otherwise the source is the bitmap */
>       int rop2_source_is_pattern = (s->twoD_control >> 14) & 0x1;
>       int rop = s->twoD_control & 0xFF;
> -    uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
> +    int dst_x = (s->twoD_destination >> 16) & 0x01FFF;
> +    int dst_y = s->twoD_destination & 0xFFFF;
> +    int width = (s->twoD_dimension >> 16) & 0x1FFF;
> +    int height = s->twoD_dimension & 0xFFFF;
>       uint32_t dst_base = s->twoD_destination_base & 0x03FFFFFF;
> -
> -    /* get frame buffer info */
> -    uint8_t *src = s->local_mem + src_base;
>       uint8_t *dst = s->local_mem + dst_base;
> -    int src_pitch = s->twoD_pitch & 0x1FFF;
>       int dst_pitch = (s->twoD_pitch >> 16) & 0x1FFF;
>       int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
>       int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
> @@ -758,6 +749,13 @@ static void sm501_2d_operation(SM501State *s)
>   
>       switch (cmd) {
>       case 0x00: /* copy area */
> +    {
> +        int src_x = (s->twoD_source >> 16) & 0x01FFF;
> +        int src_y = s->twoD_source & 0xFFFF;
> +        uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
> +        uint8_t *src = s->local_mem + src_base;
> +        int src_pitch = s->twoD_pitch & 0x1FFF;
> +
>   #define COPY_AREA(_bpp, _pixel_type, rtl) {                                   \
>           int y, x, index_d, index_s;                                           \
>           for (y = 0; y < height; y++) {                              \
> @@ -793,8 +791,11 @@ static void sm501_2d_operation(SM501State *s)
>               break;
>           }
>           break;
> -
> +    }
>       case 0x01: /* fill rectangle */
> +    {
> +        uint32_t color = s->twoD_foreground;
> +
>   #define FILL_RECT(_bpp, _pixel_type) {                                      \
>           int y, x;                                                           \
>           for (y = 0; y < height; y++) {                            \
> @@ -819,7 +820,7 @@ static void sm501_2d_operation(SM501State *s)
>               break;
>           }
>           break;
> -
> +    }
>       default:
>           qemu_log_mask(LOG_UNIMP, "sm501: not implemented 2D operation: %d\n",
>                         cmd);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


