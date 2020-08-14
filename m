Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4052CC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:02:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A98620771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLuA96Dp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A98620771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6e2Q-0006U3-A8
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e0b-0004bK-KP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:00:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e0a-0003jW-6M
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:00:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id 9so8162009wmj.5
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 11:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R5Gdza+ElQrzCj9ShIMK7rozY7qDx/PrHAaTaHDiBfM=;
 b=lLuA96Dpvq7jjO4bVMLYjbyI6sod1Jsc9/FSBJcGQ+MT4kK3o2/e3MMONGr5suhcLg
 whwE3b6/FJ5s/TrsWvTGE5FhRHtMIHcNogxR/IylB7Cpn83NDSJOMJsgxAUpizpdSUOH
 iJo7DZ832T1/twT43z0jCaCX2JM1pVszSevIsJdMzao4Q7IQyHSTFrwvcq8Ae1MfIP5W
 c3fJvFVoArX6nhicBcTh61J3gEVB0MDti8BdBo97ZGJCBnBPRtyqz+8r4RUGv9ob7/gt
 JMGbIdXbhE9Yx8lt3cIV1cliZmEQElv3PAOMDm1SdBuF1q7Lmhe5+QLRb6sZJMEE2/d+
 EfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R5Gdza+ElQrzCj9ShIMK7rozY7qDx/PrHAaTaHDiBfM=;
 b=sczXFz6g7anex+/ROF2LCC/xZYOb5W8gE3Byn+jmz723Ws98Gl4RGPSH4rqfQFFU5p
 X3fAaNjZ0Ix+GS8q39BJ/AHdenZUzo2Z41JG5cmXqdDRTDgsadS3ngXd4LMCHVeaqPFw
 wZVfBo8K5nwISzLv3KYfepOdONiFkzLldxbSqTGtUh8cg8OMRJLNamYnguzgInajAjYy
 kvXGwyKBdO0laVl4g8OfzUiEG5TichS9gVZkE7cWTMZgkQhzpOYsFhCDLdSq1Bxb/JpY
 lcTQcsqEvd5fAbCGY7cXBsEP0rNw/J4qPaub/fZMOcAFJRtCjNGmOZ6QB7z2q8KtpDcu
 YiNw==
X-Gm-Message-State: AOAM532Xzgrgx60BMoRpjmO3idMGqvaMloCExeu3ySowDcHp2J179bvU
 xJ4gB/1ieiuC7Eit3dnf+rYKAVp2crg=
X-Google-Smtp-Source: ABdhPJxr/31f7t3kWj6FYZw7gtOAQGRP2/Z6ZfsgMq9RsQ+CerUheN95T/rcYbZ9zzDh9uSAjoSGiw==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr3687406wmh.118.1597428050730; 
 Fri, 14 Aug 2020 11:00:50 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m14sm16864579wrx.76.2020.08.14.11.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:00:50 -0700 (PDT)
Subject: Re: [PATCH 14/41] hcd-dwc2: Rename USB_*CLASS macros for consistency
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-15-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c329e66-e40d-6bb4-b25a-4288e4832ba8@amsat.org>
Date: Fri, 14 Aug 2020 20:00:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-15-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
> Rename the DWC2_CLASS to DWC2_USB_CLASS and DWC2_GET_CLASS to
> DWC2_USB_GET_CLASS, for consistency with the DWC2_USB macro.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/usb/hcd-dwc2.h | 4 ++--
>  hw/usb/hcd-dwc2.c | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
> index 4ba809a07b..54111d835e 100644
> --- a/hw/usb/hcd-dwc2.h
> +++ b/hw/usb/hcd-dwc2.h
> @@ -182,9 +182,9 @@ struct DWC2Class {
>  #define TYPE_DWC2_USB   "dwc2-usb"
>  #define DWC2_USB(obj) \
>      OBJECT_CHECK(DWC2State, (obj), TYPE_DWC2_USB)
> -#define DWC2_CLASS(klass) \
> +#define DWC2_USB_CLASS(klass) \
>      OBJECT_CLASS_CHECK(DWC2Class, (klass), TYPE_DWC2_USB)
> -#define DWC2_GET_CLASS(obj) \
> +#define DWC2_USB_GET_CLASS(obj) \
>      OBJECT_GET_CLASS(DWC2Class, (obj), TYPE_DWC2_USB)
>  
>  #endif
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> index 56f91f6bee..97688d21bf 100644
> --- a/hw/usb/hcd-dwc2.c
> +++ b/hw/usb/hcd-dwc2.c
> @@ -1155,7 +1155,7 @@ static void dwc2_work_timer(void *opaque)
>  
>  static void dwc2_reset_enter(Object *obj, ResetType type)
>  {
> -    DWC2Class *c = DWC2_GET_CLASS(obj);
> +    DWC2Class *c = DWC2_USB_GET_CLASS(obj);
>      DWC2State *s = DWC2_USB(obj);
>      int i;
>  
> @@ -1239,7 +1239,7 @@ static void dwc2_reset_enter(Object *obj, ResetType type)
>  
>  static void dwc2_reset_hold(Object *obj)
>  {
> -    DWC2Class *c = DWC2_GET_CLASS(obj);
> +    DWC2Class *c = DWC2_USB_GET_CLASS(obj);
>      DWC2State *s = DWC2_USB(obj);
>  
>      trace_usb_dwc2_reset_hold();
> @@ -1253,7 +1253,7 @@ static void dwc2_reset_hold(Object *obj)
>  
>  static void dwc2_reset_exit(Object *obj)
>  {
> -    DWC2Class *c = DWC2_GET_CLASS(obj);
> +    DWC2Class *c = DWC2_USB_GET_CLASS(obj);
>      DWC2State *s = DWC2_USB(obj);
>  
>      trace_usb_dwc2_reset_exit();
> @@ -1382,7 +1382,7 @@ static Property dwc2_usb_properties[] = {
>  static void dwc2_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> -    DWC2Class *c = DWC2_CLASS(klass);
> +    DWC2Class *c = DWC2_USB_CLASS(klass);
>      ResettableClass *rc = RESETTABLE_CLASS(klass);
>  
>      dc->realize = dwc2_realize;
> 


