Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19873C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3DF20708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 09:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2Yesv4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3DF20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTKz-00018q-3n
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 05:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtTJz-0000Fh-9M
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:58:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtTJu-0004N1-7h
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 05:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594288701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TsiVhAjIKg+FB5XMXfehrSKXHq3EBQMHfqa05YX+yN0=;
 b=I2Yesv4nW23awZdnReFSbbjNDXqkWUnMBj3ctrJZo/DWig1IgkADrkAB9rHo0YKFnNz+JK
 5RG5wGu92Cd6aFeMTwDdbq5Ql7bE8vwc/QkXlxOxJcUxv6fEQsQ5CS3WYR18e79XVpjv8E
 ZqlYPfn8m37hbHw2KYUkCyU4Nx4bMMs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-eFQP07maP7ee71cgw3fMnw-1; Thu, 09 Jul 2020 05:58:19 -0400
X-MC-Unique: eFQP07maP7ee71cgw3fMnw-1
Received: by mail-wr1-f71.google.com with SMTP id b14so1594697wrp.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 02:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TsiVhAjIKg+FB5XMXfehrSKXHq3EBQMHfqa05YX+yN0=;
 b=n+TNhFKK6Y0dVBq5Yns0ulP1Kd7fLLzFTJWj8nifcb9H28EG0CDSahI30FShxXIaX8
 ib7T4rXedeGD/WxS+HgJY+9DAXzx6j/b/Tjok+xJfYjsgpj0KamR7aKHlk2SdEXMikJm
 KhYScJvIwKLoj+wztCjavpu/Qz8vT0MTuht/3uM9iQwwi/oicH0xAy/iO+022NdWHyZU
 HC6PfrbHEm4/mcZC/O6dY3fPQWJuP+u7j63BMRqvsJN8NIl7L7p8q8qPvdmVTLtFOA88
 nO6u2SgwknMlGcoFx9gWInAKzWQchvomG/sTNafx34JgowS2ETS7ybx5NoYrU57HBavw
 eFIg==
X-Gm-Message-State: AOAM530dN2z06zGRNzkCKbU66cWNYYFxm2TFH6gX2fELThuPE30qGyeh
 zOvlxHrtTQnERDByMxQJ4aaIMKqHzaNWVmNwF3ACTQZodxdpZYh5DMBOuMbWjT9pZ40oHeY9YJy
 YFZUaucIHEvyyCm4=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr67805491wrm.271.1594288697650; 
 Thu, 09 Jul 2020 02:58:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOy6v8BQ8JbEsJF5dXlATGTZUDurHSE9tmMnzGFWkzd6nkiVy4AHLvq41egKvGd5AUGDaEPw==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr67805475wrm.271.1594288697336; 
 Thu, 09 Jul 2020 02:58:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id y6sm4212596wmy.0.2020.07.09.02.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 02:58:16 -0700 (PDT)
Subject: Re: [PATCH] Remove the CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE switch
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200709053456.4900-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27814bf4-a370-f8c0-4820-37c027b46b03@redhat.com>
Date: Thu, 9 Jul 2020 11:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709053456.4900-1-thuth@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/07/20 07:34, Thomas Huth wrote:
> GCC supports "#pragma GCC diagnostic" since version 4.6, and
> Clang seems to support it, too, since its early versions 3.x.
> That means that our minimum required compiler versions all support
> this pragma already and we can remove the test from configure and
> all the related #ifdefs in the code.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure                 | 29 -----------------------------
>  include/ui/gtk.h          |  4 ----
>  include/ui/qemu-pixman.h  |  4 ----
>  scripts/decodetree.py     | 12 ++++--------
>  ui/gtk.c                  |  4 ----
>  util/coroutine-ucontext.c |  4 ----
>  6 files changed, 4 insertions(+), 53 deletions(-)

Cc: qemu-trivial@nongnu.org

Looks good, thanks!

Paolo

> diff --git a/configure b/configure
> index ee6c3c6792..fbf119bbc0 100755
> --- a/configure
> +++ b/configure
> @@ -5703,31 +5703,6 @@ if compile_prog "" "" ; then
>      linux_magic_h=yes
>  fi
>  
> -########################################
> -# check whether we can disable warning option with a pragma (this is needed
> -# to silence warnings in the headers of some versions of external libraries).
> -# This test has to be compiled with -Werror as otherwise an unknown pragma is
> -# only a warning.
> -#
> -# If we can't selectively disable warning in the code, disable -Werror so that
> -# the build doesn't fail anyway.
> -
> -pragma_disable_unused_but_set=no
> -cat > $TMPC << EOF
> -#pragma GCC diagnostic push
> -#pragma GCC diagnostic ignored "-Wstrict-prototypes"
> -#pragma GCC diagnostic pop
> -
> -int main(void) {
> -    return 0;
> -}
> -EOF
> -if compile_prog "-Werror" "" ; then
> -    pragma_diagnostic_available=yes
> -else
> -    werror=no
> -fi
> -
>  ########################################
>  # check if we have valgrind/valgrind.h
>  
> @@ -7661,10 +7636,6 @@ if test "$linux_magic_h" = "yes" ; then
>    echo "CONFIG_LINUX_MAGIC_H=y" >> $config_host_mak
>  fi
>  
> -if test "$pragma_diagnostic_available" = "yes" ; then
> -  echo "CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE=y" >> $config_host_mak
> -fi
> -
>  if test "$valgrind_h" = "yes" ; then
>    echo "CONFIG_VALGRIND_H=y" >> $config_host_mak
>  fi
> diff --git a/include/ui/gtk.h b/include/ui/gtk.h
> index d1b230848a..eaeb450f91 100644
> --- a/include/ui/gtk.h
> +++ b/include/ui/gtk.h
> @@ -1,15 +1,11 @@
>  #ifndef UI_GTK_H
>  #define UI_GTK_H
>  
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
>  /* Work around an -Wstrict-prototypes warning in GTK headers */
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wstrict-prototypes"
> -#endif
>  #include <gtk/gtk.h>
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
>  #pragma GCC diagnostic pop
> -#endif
>  
>  #include <gdk/gdkkeysyms.h>
>  
> diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
> index 3b7cf70157..87737a6f16 100644
> --- a/include/ui/qemu-pixman.h
> +++ b/include/ui/qemu-pixman.h
> @@ -7,14 +7,10 @@
>  #define QEMU_PIXMAN_H
>  
>  /* pixman-0.16.0 headers have a redundant declaration */
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wredundant-decls"
> -#endif
>  #include <pixman.h>
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
>  #pragma GCC diagnostic pop
> -#endif
>  
>  /*
>   * pixman image formats are defined to be native endian,
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 530d41ca62..694757b6c2 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -1327,12 +1327,10 @@ def main():
>      # but we can't tell which ones.  Prevent issues from the compiler by
>      # suppressing redundant declaration warnings.
>      if anyextern:
> -        output("#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE\n",
> -               "# pragma GCC diagnostic push\n",
> -               "# pragma GCC diagnostic ignored \"-Wredundant-decls\"\n",
> -               "# ifdef __clang__\n"
> +        output("#pragma GCC diagnostic push\n",
> +               "#pragma GCC diagnostic ignored \"-Wredundant-decls\"\n",
> +               "#ifdef __clang__\n"
>                 "#  pragma GCC diagnostic ignored \"-Wtypedef-redefinition\"\n",
> -               "# endif\n",
>                 "#endif\n\n")
>  
>      out_pats = {}
> @@ -1347,9 +1345,7 @@ def main():
>      output('\n')
>  
>      if anyextern:
> -        output("#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE\n",
> -               "# pragma GCC diagnostic pop\n",
> -               "#endif\n\n")
> +        output("#pragma GCC diagnostic pop\n\n")
>  
>      for n in sorted(formats.keys()):
>          f = formats[n]
> diff --git a/ui/gtk.c b/ui/gtk.c
> index d4b49bd7da..b0cc08ad6d 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1996,14 +1996,10 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
>               * proper replacement (native opengl support) is only
>               * available in 3.16+.  Silence the warning if possible.
>               */
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
> -#endif
>              gtk_widget_set_double_buffered(vc->gfx.drawing_area, FALSE);
> -#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
>  #pragma GCC diagnostic pop
> -#endif
>              vc->gfx.dcl.ops = &dcl_egl_ops;
>          }
>      } else
> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
> index f0b66320e1..a4e6446ed9 100644
> --- a/util/coroutine-ucontext.c
> +++ b/util/coroutine-ucontext.c
> @@ -237,19 +237,15 @@ Coroutine *qemu_coroutine_new(void)
>  }
>  
>  #ifdef CONFIG_VALGRIND_H
> -#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
>  /* Work around an unused variable in the valgrind.h macro... */
>  #pragma GCC diagnostic push
>  #pragma GCC diagnostic ignored "-Wunused-but-set-variable"
> -#endif
>  static inline void valgrind_stack_deregister(CoroutineUContext *co)
>  {
>      VALGRIND_STACK_DEREGISTER(co->valgrind_stack_id);
>  }
> -#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
>  #pragma GCC diagnostic pop
>  #endif
> -#endif
>  
>  void qemu_coroutine_delete(Coroutine *co_)
>  {
> 


