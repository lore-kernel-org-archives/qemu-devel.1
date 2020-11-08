Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1690C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 15:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA82C208B6
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 15:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYLSKCpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA82C208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbmxo-0006As-P6
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 10:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbmtx-0003qy-Ni
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 10:46:46 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:47016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbmtv-0007vK-NF
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 10:46:45 -0500
Received: by mail-wr1-x444.google.com with SMTP id d12so4680469wrr.13
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 07:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SkZ0iEW59Mdbq9v04ylQE1zS8+wdDQrMlp8D53C/9Mg=;
 b=SYLSKCpfPWbQY18Q7jjONqdFMRbs+7WjBVGynsVL2loVbd0jqQZyNMYTb6vVLRMDr0
 QJWtUBH4Ja+CoHMDDSKQ10kbtzlE/IKeUA/xuRgKS3idvHKo4y1dxOAXf4QjMm6XrzYz
 TpQCf5FSc7ksb+2qiVt67KisVskrywVTKovdlBSPy2lX0P8qLp0Kt0QfmFbSn7iDMgXh
 uKHX7IM3ANQVoLO8uIRGmaEoLGVYVeJYNjP5YxH8mbJst5z2DqPa79tZsZCCIfk1NtCp
 5Mv2yT6YJCs7PMeVbEa27vf/iqbgcwI8x/IfNeNWpcToBKYDpR/5Ao+TZJEOJOrjsV5a
 FWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SkZ0iEW59Mdbq9v04ylQE1zS8+wdDQrMlp8D53C/9Mg=;
 b=Nc0X/rA8dNyUcAaBJzv5DI+3YXcn2NwhRj3okWZ03rpUO4g7I2yhp8CCR3uTd+GCD9
 jfagkqbY9HK2GoAT4Wioe3dwhjTnFJytuFKS8mKk/S3maXotuWbebP1xSFtqtBkjSgUo
 S6MUhGQLIxKTm+/Q0KNY9NlumD1O9PV6tW9u4kMtNlDJE+7vi+SPqPZK/zatMa7XeaQm
 5T15/L5Xq5YuA14//55nNO4txvs95oJVkXhZBAPZWFAX7/6zSIKOqimtM0BqB3zb/3GX
 LdBNt3kz8eEV+vjVVXSDBQ03+WqYSGej7YbKbSjCG9DI5CI/6QZ+x0X0NBXJWhZoXidq
 Ip2A==
X-Gm-Message-State: AOAM531NyGBnJRtP8PFqGr4Nw+LdWxwiDNZr3+R0o2aFky3dvbT2PCFR
 fSouYE+Oy7xFmRfEacMj2MQ=
X-Google-Smtp-Source: ABdhPJxTd3ZOenpZnnToo3c1ccFl6Wk+Q9bO0CFYhMR7Vqf/IFpNrfmx6VLr9oZhzjVN6H9/Nl1QQQ==
X-Received: by 2002:a5d:62c3:: with SMTP id o3mr1173766wrv.300.1604850401761; 
 Sun, 08 Nov 2020 07:46:41 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 30sm10307129wrs.84.2020.11.08.07.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 07:46:40 -0800 (PST)
Subject: Re: [PATCH v4 4/7] coroutine: add libucontext as external library
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
References: <20201108052605.45840-1-j@getutm.app>
 <20201108052605.45840-5-j@getutm.app>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <80ac1230-b0b2-a3bf-df2b-8183ec6fcfbb@amsat.org>
Date: Sun, 8 Nov 2020 16:46:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201108052605.45840-5-j@getutm.app>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Joelle,

On 11/8/20 6:26 AM, Joelle van Dyne wrote:
> iOS does not support ucontext natively for aarch64 and the sigaltstack is
> also unsupported (even worse, it fails silently, see:
> https://openradar.appspot.com/13002712 )
> 
> As a workaround we include a library implementation of ucontext and add it
> as a build option.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  configure                 | 23 ++++++++++++++++++++---
>  meson.build               | 28 +++++++++++++++++++++++++++-
>  util/coroutine-ucontext.c |  9 +++++++++
>  .gitmodules               |  3 +++
>  libucontext               |  1 +
>  meson_options.txt         |  2 ++
>  6 files changed, 62 insertions(+), 4 deletions(-)
>  create mode 160000 libucontext
...

> diff --git a/meson.build b/meson.build
> index 8894171bd1..e62324d5ac 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1259,9 +1259,34 @@ if not fdt.found() and fdt_required.length() > 0
>    error('fdt not available but required by targets ' + ', '.join(fdt_required))
>  endif
>  
> +ucontext = not_found
> +if get_option('ucontext').enabled()
> +  if not fs.is_dir(meson.current_source_dir() / 'libucontext/arch' / cpu)
> +    error('libucontext is wanted but not implemented for host ' + cpu)
> +  endif
> +  arch = host_machine.cpu()
> +  ucontext_cargs = ['-DG_LOG_DOMAIN="ucontext"', '-DCUSTOM_IMPL']
> +  ucontext_files = [
> +    'libucontext/arch' / arch / 'getcontext.S',
> +    'libucontext/arch' / arch / 'setcontext.S',
> +    'libucontext/arch' / arch / 'makecontext.c',
> +    'libucontext/arch' / arch / 'startcontext.S',
> +    'libucontext/arch' / arch / 'swapcontext.S',
> +  ]
> +
> +  ucontext_inc = include_directories('libucontext/include')
> +  libucontext = static_library('ucontext',
> +                               sources: ucontext_files,
> +                               c_args: ucontext_cargs,
> +                               include_directories: ucontext_inc)
> +  ucontext = declare_dependency(link_with: libucontext,
> +                                include_directories: ucontext_inc)
> +endif
> +
>  config_host_data.set('CONFIG_CAPSTONE', capstone.found())
>  config_host_data.set('CONFIG_FDT', fdt.found())
>  config_host_data.set('CONFIG_SLIRP', slirp.found())
> +config_host_data.set('CONFIG_LIBUCONTEXT', ucontext.found())
>  
>  #####################
>  # Generated sources #
> @@ -1477,7 +1502,7 @@ util_ss.add_all(trace_ss)
>  util_ss = util_ss.apply(config_all, strict: false)
>  libqemuutil = static_library('qemuutil',
>                               sources: util_ss.sources() + stub_ss.sources() + genh,
> -                             dependencies: [util_ss.dependencies(), m, glib, socket, malloc])
> +                             dependencies: [util_ss.dependencies(), m, glib, socket, malloc, ucontext])
>  qemuutil = declare_dependency(link_with: libqemuutil,
>                                sources: genh + version_res)
>  
> @@ -2135,6 +2160,7 @@ if targetos == 'windows'
>    summary_info += {'QGA MSI support':   config_host.has_key('CONFIG_QGA_MSI')}
>  endif
>  summary_info += {'seccomp support':   config_host.has_key('CONFIG_SECCOMP')}
> +summary_info += {'libucontext support': ucontext.found()}
>  summary_info += {'coroutine backend': config_host['CONFIG_COROUTINE_BACKEND']}
>  summary_info += {'coroutine pool':    config_host['CONFIG_COROUTINE_POOL'] == '1'}
>  summary_info += {'debug stack usage': config_host.has_key('CONFIG_DEBUG_STACK_USAGE')}
> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
> index 904b375192..1e1dd43512 100644
> --- a/util/coroutine-ucontext.c
> +++ b/util/coroutine-ucontext.c
> @@ -23,7 +23,16 @@
>  #undef _FORTIFY_SOURCE
>  #endif
>  #include "qemu/osdep.h"
> +#if defined(CONFIG_LIBUCONTEXT)
> +#include <libucontext.h>
> +#define ucontext_t libucontext_ucontext_t
> +#define getcontext libucontext_getcontext
> +#define setcontext libucontext_setcontext
> +#define swapcontext libucontext_swapcontext
> +#define makecontext libucontext_makecontext
> +#else
>  #include <ucontext.h>
> +#endif
>  #include "qemu/coroutine_int.h"

Trying on Ubuntu 20.04 I'm getting:

/usr/bin/ld: libqemuutil.a(util_coroutine-ucontext.c.o): in function
`qemu_coroutine_new':
util/coroutine-ucontext.c:203: undefined reference to
`libucontext_getcontext'
/usr/bin/ld: util/coroutine-ucontext.c:254: undefined reference to
`libucontext_swapcontext'
/usr/bin/ld: libucontext.a(libucontext_arch_x86_64_makecontext.c.o): in
function `libucontext_makecontext':
libucontext/arch/x86_64/makecontext.c:54: undefined reference to
`_start_context'
collect2: error: ld returned 1 exit status

Regards,

Phil.

