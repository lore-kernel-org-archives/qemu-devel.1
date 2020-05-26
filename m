Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F50C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A38207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 06:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifj6oD5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A38207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdSj2-0007kD-1x
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 02:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSi6-0006r8-OK
 for qemu-devel@nongnu.org; Tue, 26 May 2020 02:05:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdSi5-0007rP-BZ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 02:05:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id u13so1997345wml.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kCi4EdmhdJ4q32CGFynkXnKFhYeAe0d/o8KieadKzTk=;
 b=ifj6oD5mkVeM+zx3RleAm4FAPKYfQA1alw9EHv2+sH2v6aFMTEcj+LNPNTeqSEyaBN
 NRuaH4AxWtuibmhlja4nCoR4SR+udNHYFgWgBK7jaJpgeiohRmnkykquYprwbLtJucYP
 qGspKevebEu4ZP4gOkxbAXnWgvbyLekk89Ja5wR4AOhV0fWrXZ0f2/7yGs5t+HP9vXCF
 eWU1bI4/W/ZtA3w1zrhxh9RTy44l3cGe1OchzkXbp8Y0/d3kRDMKA5JY65OR/GivS+gV
 1F2UYNH70v1JIBrUVuP7TzwkV/3UeAXv0mtDymhlGUBkk2uQd4sDJBhskfhad6b89J/4
 EW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kCi4EdmhdJ4q32CGFynkXnKFhYeAe0d/o8KieadKzTk=;
 b=iCfShhWxOHQ1BEJXZ934Cn55TvMzfwii1U5iism0RPpCxSIrwrCleFkQYWzAOpoPsT
 A5ECU/cEZ49SyojipZkK8wHzHXay6ltDPfIyhiIwlzzuvwArP4gXpb9TARPcQxu9E4sy
 KxeMIkJwy1yYepZLRgElq8Ix3K5iaYTYJ5LVKr6GbdzRN6uQxowb21s+MF3VFU0KhRc7
 PpfCmzKmPO8qsbMgQ/C3vSZD56s4QYZsIaos8oXiX91F6+i5BJehMDLq6Yvo7ceKq/v8
 w0bU3Wlz8I3i0K7VEOo71njP0fG3DYTexT8iHgwu+iI1+njWf5TXC7n+Sdrdk3zCp6Uh
 uX8Q==
X-Gm-Message-State: AOAM531Mv2nwU4+T9fPzYVNTpxtl6NYwNXA+mVtJuL/0+WPXBUPPUqs4
 E8yGGXsJj1O9pARZI1p7Nxs=
X-Google-Smtp-Source: ABdhPJwFm9CvuKfnvzIgXG0OJCu1mBkT5VI97gecw0iMB5eR1ixNRVXPMGGGn26Uw1aspUK+UtvfEQ==
X-Received: by 2002:a1c:98cc:: with SMTP id a195mr21521630wme.32.1590473107850; 
 Mon, 25 May 2020 23:05:07 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id l17sm6168428wmi.3.2020.05.25.23.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 23:05:07 -0700 (PDT)
Subject: Re: [PATCH] hw/audio/gus: Use AUDIO_HOST_ENDIANNESS definition from
 'audio/audio.h'
To: qemu-devel@nongnu.org
References: <20200505100750.27332-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <294dc94e-2403-cac6-ffdb-fe746cd8c419@amsat.org>
Date: Tue, 26 May 2020 08:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505100750.27332-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping...

On 5/5/20 12:07 PM, Philippe Mathieu-Daudé wrote:
> Use the generic AUDIO_HOST_ENDIANNESS definition instead
> of a custom one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Who/what machine is using this device anyway?
> ---
>  hw/audio/gus.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/hw/audio/gus.c b/hw/audio/gus.c
> index eb4a803fb5..c8df2bde6b 100644
> --- a/hw/audio/gus.c
> +++ b/hw/audio/gus.c
> @@ -41,12 +41,6 @@
>  #define ldebug(...)
>  #endif
>  
> -#ifdef HOST_WORDS_BIGENDIAN
> -#define GUS_ENDIANNESS 1
> -#else
> -#define GUS_ENDIANNESS 0
> -#endif
> -
>  #define TYPE_GUS "gus"
>  #define GUS(obj) OBJECT_CHECK (GUSState, (obj), TYPE_GUS)
>  
> @@ -256,7 +250,7 @@ static void gus_realizefn (DeviceState *dev, Error **errp)
>      as.freq = s->freq;
>      as.nchannels = 2;
>      as.fmt = AUDIO_FORMAT_S16;
> -    as.endianness = GUS_ENDIANNESS;
> +    as.endianness = AUDIO_HOST_ENDIANNESS;
>  
>      s->voice = AUD_open_out (
>          &s->card,
> 

