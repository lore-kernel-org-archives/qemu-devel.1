Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11275C0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA88521855
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 07:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA88521855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huXee-0008UV-0P
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 03:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42121)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1huXeA-00084n-Rg
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1huXe9-0000Jr-Q2
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:43:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1huXe9-0000IV-K6
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 03:43:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so83400241wrs.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 00:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vOkxCvJqDop4xCjYiMZcQPBjNJoTK7PcqXqvfYA4nO0=;
 b=OJPVaZUmoQ6TFEqvesvPelEplidg295TVIbliPnXgSFl79b1DKQxkSzh1bU7X06AbI
 jrNBdy99/gyqCIxwW/HDCkZMteGXA9gaIDJ0b4y99eiFRXJgE5YtOH0Axv9JGBirAJMQ
 D7N6DA/GvSYCJliOf5dMDPW2UhnSWKGZiWAzUdliKJEyhISIyi5kHWgL7eA8c3v285gw
 S9jWoUkjbdFvnV2UEmwjqjqhLglIU7DhWL3TakouEBUTXSjTLwwv2tUmrh9n9G5l9QMU
 EJ8wl2NLewgSHmSI3NifhWrvy1jeov+oFD+9TkStmKBjagQXYX7qR6PFvfbgOzqfHm0v
 zOQg==
X-Gm-Message-State: APjAAAVwXpIWcbvmc/uthNAFR2HAk3ggvlYrYF2K/bh7a9djzgU1uhRW
 8wt9LJxOpvaNaQwgVSVGgAkRYA==
X-Google-Smtp-Source: APXvYqwNozJPaUmdBI8OHKUOfemqUU8yQHmw96IufDIWqRf47jWUx5fTfHaklxwx3PaCnph/IGmg1g==
X-Received: by 2002:adf:c508:: with SMTP id q8mr28229183wrf.148.1564990987770; 
 Mon, 05 Aug 2019 00:43:07 -0700 (PDT)
Received: from [192.168.178.40] ([151.21.165.91])
 by smtp.gmail.com with ESMTPSA id z1sm85671725wrp.51.2019.08.05.00.43.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 00:43:07 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190805071038.32146-1-alxndr@bu.edu>
 <20190805071038.32146-2-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7d90f16e-d77f-077e-5291-ae4d5ee3d668@redhat.com>
Date: Mon, 5 Aug 2019 09:43:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805071038.32146-2-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/17] fuzz: Move initialization
 from main to qemu_init
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
Cc: "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/08/19 09:11, Oleinik, Alexander wrote:
> Using this, we avoid needing a special case to break out of main(),
> early, when initializing the fuzzer, as we can just call qemu_init.
> There is still a #define around main(), since it otherwise conflicts
> with the libfuzzer main().
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  include/sysemu/sysemu.h |  5 +++++
>  vl.c                    | 25 +++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 984c439ac9..a63d5ccce3 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -184,6 +184,8 @@ QemuOpts *qemu_get_machine_opts(void);
>  
>  bool defaults_enabled(void);
>  
> +int qemu_init(int argc, char **argv, char **envp);
> +
>  extern QemuOptsList qemu_legacy_drive_opts;
>  extern QemuOptsList qemu_common_drive_opts;
>  extern QemuOptsList qemu_drive_opts;
> @@ -197,4 +199,7 @@ extern QemuOptsList qemu_global_opts;
>  extern QemuOptsList qemu_mon_opts;
>  extern QemuOptsList qemu_semihosting_config_opts;
>  
> +#ifdef CONFIG_FUZZ
> +int real_main(int argc, char **argv, char **envp);
> +#endif
>  #endif
> diff --git a/vl.c b/vl.c
> index 130a389712..914bb9b2de 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -130,6 +130,10 @@ int main(int argc, char **argv)
>  #include "sysemu/iothread.h"
>  #include "qemu/guest-random.h"
>  
> +#ifdef CONFIG_FUZZ
> +#include "tests/libqtest.h"
> +#endif

Why is this #include needed?

If you leave out the changes to introduce real_main, the patch can be
committed independent of the rest.  Those can be introduced in patch 2
or even 12 ("Add fuzzer skeleton").

Paolo

>  #define MAX_VIRTIO_CONSOLES 1
>  
>  static const char *data_dir[16];
> @@ -2854,7 +2858,7 @@ static void user_register_global_props(void)
>                        global_init_func, NULL, NULL);
>  }
>  
> -int main(int argc, char **argv, char **envp)
> +int qemu_init(int argc, char **argv, char **envp)
>  {
>      int i;
>      int snapshot, linux_boot;
> @@ -4453,7 +4457,7 @@ int main(int argc, char **argv, char **envp)
>      if (vmstate_dump_file) {
>          /* dump and exit */
>          dump_vmstate_json_to_file(vmstate_dump_file);
> -        return 0;
> +        exit(0);
>      }
>  
>      if (incoming) {
> @@ -4470,6 +4474,23 @@ int main(int argc, char **argv, char **envp)
>      accel_setup_post(current_machine);
>      os_setup_post();
>  
> +    return 0;
> +}
> +#ifdef CONFIG_FUZZ
> +/*
> + * Without this, the compiler complains about all of the unused
> + * cleanup and shutdown() functions
> + */
> +int real_main(int argc, char **argv, char **envp)
> +#else
> +int main(int argc, char **argv, char **envp)
> +#endif
> +{
> +    int ret = qemu_init(argc, argv, envp);
> +    if (ret != 0) {
> +        return ret;
> +    }
> +
>      main_loop();
>  
>      gdbserver_cleanup();
> 


