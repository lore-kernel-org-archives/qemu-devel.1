Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FF3C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E009E20725
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYs4LjLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E009E20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1LV-0005Om-1o
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL1CP-0005x2-Dh
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:36:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25574
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL1CM-00063z-GR
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600853784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h728GoLixq8UJds+V15FW4ONPpYQ6tZMor/1F82doTw=;
 b=hYs4LjLMbI1x69ZmCdCqMB8Ti/awKECDKPYzP8ZNDNi6B62+lrpagO4x5kA+xGBa+XdfrS
 EWsk+MqWNCsfyD54t3KTWDMEuwbtqF3YclClPPkKywx8lGyroD642lt6UZYQ6dkC3rVgDC
 j21/KWzdc9kBjk+FpIyuKl8vLjGpX74=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-CFZBUJmiN6mzyWkfBG0pug-1; Wed, 23 Sep 2020 05:36:22 -0400
X-MC-Unique: CFZBUJmiN6mzyWkfBG0pug-1
Received: by mail-wm1-f70.google.com with SMTP id c200so1999655wmd.5
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 02:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=h728GoLixq8UJds+V15FW4ONPpYQ6tZMor/1F82doTw=;
 b=PM9Oj6s4MlMjf8ptxcllPJHwdQKktId9QtdMQEfAY2YVnm4u1aYvrSoBGPoqVWYBs+
 zb1tHklThdnJv3okbIFUb10/qYeFEZ9TNzGLerP+owM16sl1UzpovkP38HUgVcvTZtH2
 Re7CGTYwJEwF8geLDp0WJPB7Xa321lTMOizWEAdJkfgk5Z0m6rulSefTGkki8mE5cfOR
 PqyvIU8XGcyL9h9F584RAdOh5CV6lXmuFtEV6EV6Yz10VwcHqNagykqENbh7xPa1PtVd
 uytZHmA2B6WSX2+ULYR1Jum7jbwYdvnaFErh6XR1NusI1GcDescGl0XSJyVctR98Wosf
 9kqw==
X-Gm-Message-State: AOAM531YrjDpdCERC2k1Fy29W0VqPmjVaGVp6qs8UJcY3UhlVRdBc6bf
 Rf/Duv1LFvUB0wMw1yZOvzeJE1GNPIxKZhvayNJN98p5PeoaKHiha85LI7jEBbQOhprNJk7V/kI
 yGS4lq80+NOGsr7Q=
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr5626140wmj.16.1600853781638; 
 Wed, 23 Sep 2020 02:36:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLPSjZlrqaLjyirCafluNU60SwxSigtUH5K2t3+W8bxvAjmSVCcGw3CLkMCgjAoIchLWFflw==
X-Received: by 2002:a7b:c38f:: with SMTP id s15mr5626119wmj.16.1600853781391; 
 Wed, 23 Sep 2020 02:36:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9?
 ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
 by smtp.gmail.com with ESMTPSA id f6sm30045884wro.5.2020.09.23.02.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 02:36:20 -0700 (PDT)
Subject: Re: [PATCH v2] module: silence errors for module_load_qom_all().
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200923091217.22662-1-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fdd8b613-4a49-0dc0-9a82-ad4b2d56380b@redhat.com>
Date: Wed, 23 Sep 2020 11:36:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923091217.22662-1-kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 05:08:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/20 11:12, Gerd Hoffmann wrote:
> Add mayfail bool parameter to module loading functions.  Set it to true
> for module_load_qom_all() because device modules might not load into all
> system emulation variants.  qemu-system-s390x for example will not load
> qxl because it lacks vga support.  Makes "make check" less chatty.
> 
> Drop module_loaded_qom_all check in module_load_qom_one to make sure we
> see errors for explicit load requests, i.e. module_load_qom_one("qxl")
> failing will log an error no matter whenever module_load_qom_all() was
> called before or not.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/qemu/module.h |  8 ++++----
>  softmmu/qtest.c       |  2 +-
>  util/module.c         | 20 ++++++++++----------
>  3 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 9121a475c1b6..944d403cbd15 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -61,15 +61,15 @@ typedef enum {
>  #define fuzz_target_init(function) module_init(function, \
>                                                 MODULE_INIT_FUZZ_TARGET)
>  #define migration_init(function) module_init(function, MODULE_INIT_MIGRATION)
> -#define block_module_load_one(lib) module_load_one("block-", lib)
> -#define ui_module_load_one(lib) module_load_one("ui-", lib)
> -#define audio_module_load_one(lib) module_load_one("audio-", lib)
> +#define block_module_load_one(lib) module_load_one("block-", lib, false)
> +#define ui_module_load_one(lib) module_load_one("ui-", lib, false)
> +#define audio_module_load_one(lib) module_load_one("audio-", lib, false)
>  
>  void register_module_init(void (*fn)(void), module_init_type type);
>  void register_dso_module_init(void (*fn)(void), module_init_type type);
>  
>  void module_call_init(module_init_type type);
> -bool module_load_one(const char *prefix, const char *lib_name);
> +bool module_load_one(const char *prefix, const char *lib_name, bool mayfail);
>  void module_load_qom_one(const char *type);
>  void module_load_qom_all(void);
>  
> diff --git a/softmmu/qtest.c b/softmmu/qtest.c
> index 4e439caec7e9..6f697c8a6987 100644
> --- a/softmmu/qtest.c
> +++ b/softmmu/qtest.c
> @@ -670,7 +670,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          g_assert(words[1] && words[2]);
>  
>          qtest_send_prefix(chr);
> -        if (module_load_one(words[1], words[2])) {
> +        if (module_load_one(words[1], words[2], false)) {
>              qtest_sendf(chr, "OK\n");
>          } else {
>              qtest_sendf(chr, "FAIL\n");
> diff --git a/util/module.c b/util/module.c
> index 34772e7d87eb..1535e7da4c06 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -109,7 +109,7 @@ void module_call_init(module_init_type type)
>  }
>  
>  #ifdef CONFIG_MODULES
> -static int module_load_file(const char *fname)
> +static int module_load_file(const char *fname, bool mayfail)
>  {
>      GModule *g_module;
>      void (*sym)(void);
> @@ -133,8 +133,10 @@ static int module_load_file(const char *fname)
>  
>      g_module = g_module_open(fname, G_MODULE_BIND_LAZY | G_MODULE_BIND_LOCAL);
>      if (!g_module) {
> -        fprintf(stderr, "Failed to open module: %s\n",
> -                g_module_error());
> +        if (!mayfail) {
> +            fprintf(stderr, "Failed to open module: %s\n",
> +                    g_module_error());
> +        }
>          ret = -EINVAL;
>          goto out;
>      }
> @@ -166,7 +168,7 @@ out:
>  }
>  #endif
>  
> -bool module_load_one(const char *prefix, const char *lib_name)
> +bool module_load_one(const char *prefix, const char *lib_name, bool mayfail)
>  {
>      bool success = false;
>  
> @@ -222,7 +224,7 @@ bool module_load_one(const char *prefix, const char *lib_name)
>      for (i = 0; i < n_dirs; i++) {
>          fname = g_strdup_printf("%s/%s%s",
>                  dirs[i], module_name, CONFIG_HOST_DSOSUF);
> -        ret = module_load_file(fname);
> +        ret = module_load_file(fname, mayfail);
>          g_free(fname);
>          fname = NULL;
>          /* Try loading until loaded a module file */
> @@ -279,13 +281,11 @@ void module_load_qom_one(const char *type)
>      if (!type) {
>          return;
>      }
> -    if (module_loaded_qom_all) {
> -        return;
> -    }
>      for (i = 0; i < ARRAY_SIZE(qom_modules); i++) {
>          if (strcmp(qom_modules[i].type, type) == 0) {
>              module_load_one(qom_modules[i].prefix,
> -                            qom_modules[i].module);
> +                            qom_modules[i].module,
> +                            false);
>              return;
>          }
>      }
> @@ -306,7 +306,7 @@ void module_load_qom_all(void)
>              /* one module implementing multiple types -> load only once */
>              continue;
>          }
> -        module_load_one(qom_modules[i].prefix, qom_modules[i].module);
> +        module_load_one(qom_modules[i].prefix, qom_modules[i].module, true);
>      }
>      module_loaded_qom_all = true;
>  }
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


