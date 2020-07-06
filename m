Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539B6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:44:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211762073E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 08:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuEp+CFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211762073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsMkC-0004KS-Bs
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 04:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsMjb-0003uP-2V
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:44:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:36079)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsMjZ-0000Wr-Iu
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 04:44:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id k6so39909601wrn.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 01:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QJ7Sob5RQuUZR/JJNvVKN2Nzn61CJXXpvkhneEm4+KQ=;
 b=BuEp+CFPcpw9NQA3fxDO+FeN8vHjrHBjLToxsJSaOEBqbdbxBcuepZjJQij7bsvYzK
 6Luf/LcdLD1PbcEiiOB1vfaNyN2a5ee7pzgh4YnsbNgME2h5RZVrbmS+JHGIcXLsgHW1
 PBZuuh+EntWjkFPkVdXexv9DVWDBUp6kT7h9VGih7wkvKxLa4iKOWHvHFqelbDaTzuEg
 WyqveKdkglcDi2JeVYtYV0HdgDpT+F/W1cnkx6CU/w0TY1SiKAbhhLzWE04QPcH3SD7g
 p9PdeAh7MMf1A2Y1GcHvKFZyTjHLA90KhxS1IroEb/IG4POpODsimUb+wSTj8gLGEguR
 oQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QJ7Sob5RQuUZR/JJNvVKN2Nzn61CJXXpvkhneEm4+KQ=;
 b=aAE3TShlOXLpKdyiHsBRumBFa+v9P8AeZGMvJqq9BmiPWAaP+w6Nbr4L3RxHdUDtNO
 scg80vHrqsZ/zCHB6r9P9cwGCbGnvKGXtl0Mfh26Mm6iAXkz7lypKfX29RkAUXf2TCu9
 LYaH5DG8jSJFv4eSWx0BFPs1ofB2YC5bM5avELcN2CpuiDjuIg7IEvZgDT58m7sTl96C
 2Kye6e6iKoLZ2txxUkpk4Ce+jw9DpGnyij97VvHeO8IQ64g99Q1n3XrYivthUeLzdbjV
 SYb5ELXvH3uftxpzAx1IZOHgHUtBRR4TFChsihaEaMxC2muMVp0Q+myJUA9h4HEf/bRZ
 +/7w==
X-Gm-Message-State: AOAM533CC9FcSgwH+ANUhXoWrgwAHvLyEBjFW5wlTkiMtKxNWZh+EoRb
 JM4nPZwyIana8GPZUzriwlE=
X-Google-Smtp-Source: ABdhPJyDhnhIavLkM1Xcq8Ms+3/BF34HHbliPRcGhAdgcnvZKb9+X0aF7wejgd+lzIJfo7kMb8CFaQ==
X-Received: by 2002:a5d:5270:: with SMTP id l16mr47245106wrc.122.1594025056048; 
 Mon, 06 Jul 2020 01:44:16 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id v3sm23434254wrq.57.2020.07.06.01.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2020 01:44:15 -0700 (PDT)
Subject: Re: [PULL 36/37] qdev: remove QDEV_PROP_PTR
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200107150442.1727958-1-marcandre.lureau@redhat.com>
 <20200107150442.1727958-37-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <13c91f97-a7e6-adbd-9c23-2464f2b1b46e@amsat.org>
Date: Mon, 6 Jul 2020 10:44:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200107150442.1727958-37-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 4:04 PM, Marc-André Lureau wrote:
> No longer used in the tree. The comment about user_creatable is still
> quite relevant, but there is already a similar comment in qdev-core.h.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/qdev-properties.h | 22 ----------------------
>  hw/core/qdev-properties.c    | 18 ------------------
>  2 files changed, 40 deletions(-)
> 
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 16837ab5dd..a90a9cec80 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -18,7 +18,6 @@ extern const PropertyInfo qdev_prop_size;
>  extern const PropertyInfo qdev_prop_string;
>  extern const PropertyInfo qdev_prop_chr;
>  extern const PropertyInfo qdev_prop_tpm;
> -extern const PropertyInfo qdev_prop_ptr;
>  extern const PropertyInfo qdev_prop_macaddr;
>  extern const PropertyInfo qdev_prop_on_off_auto;
>  extern const PropertyInfo qdev_prop_losttickpolicy;
> @@ -171,25 +170,6 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
>  #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
>      DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
>  
> -/*
> - * Please avoid pointer properties.  If you must use them, you must
> - * cover them in their device's class init function as follows:
> - *
> - * - If the property must be set, the device cannot be used with
> - *   device_add, so add code like this:
> - *   |* Reason: pointer property "NAME-OF-YOUR-PROP" *|
> - *   DeviceClass *dc = DEVICE_CLASS(class);
> - *   dc->user_creatable = false;
> - *
> - * - If the property may safely remain null, document it like this:
> - *   |*
> - *    * Note: pointer property "interrupt_vector" may remain null, thus
> - *    * no need for dc->user_creatable = false;
> - *    *|
> - */
> -#define DEFINE_PROP_PTR(_n, _s, _f)             \
> -    DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, void*)

So the replacement is DEFINE_PROP_LINK()? It is not documented, but
it takes a TYPENAME argument, so I assume we can only LINK QOM types.
Can the documentation be improved?

Yet another sneaky way to force forks to either update to QOM or die...

> -
>  #define DEFINE_PROP_CHR(_n, _s, _f)             \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharBackend)
>  #define DEFINE_PROP_STRING(_n, _s, _f)             \
> @@ -262,8 +242,6 @@ void qdev_prop_set_drive(DeviceState *dev, const char *name,
>  void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
>                             const uint8_t *value);
>  void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
> -/* FIXME: Remove opaque pointer properties.  */
> -void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value);
>  
>  void qdev_prop_register_global(GlobalProperty *prop);
>  int qdev_prop_check_globals(void);
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index ac28890e5a..6ca7697599 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -501,13 +501,6 @@ const PropertyInfo qdev_prop_string = {
>      .set   = set_string,
>  };
>  
> -/* --- pointer --- */
> -
> -/* Not a proper property, just for dirty hacks.  TODO Remove it!  */
> -const PropertyInfo qdev_prop_ptr = {
> -    .name  = "ptr",
> -};
> -
>  /* --- mac address --- */
>  
>  /*
> @@ -1165,17 +1158,6 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
>                              name, &error_abort);
>  }
>  
> -void qdev_prop_set_ptr(DeviceState *dev, const char *name, void *value)
> -{
> -    Property *prop;
> -    void **ptr;
> -
> -    prop = qdev_prop_find(dev, name);
> -    assert(prop && prop->info == &qdev_prop_ptr);
> -    ptr = qdev_get_prop_ptr(dev, prop);
> -    *ptr = value;
> -}
> -
>  static GPtrArray *global_props(void)
>  {
>      static GPtrArray *gp;
> 


