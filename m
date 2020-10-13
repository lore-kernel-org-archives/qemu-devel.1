Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0729C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 147E62068E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsgMLhVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147E62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFst-0006P4-To
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFme-0000gI-T4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFmb-0004vV-2s
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602578144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CJFkuCAyQHgxXFK9YMzyhkkG7Cv7Kn+akgm7ccvpB6g=;
 b=IsgMLhVMuhrSzUwQu1tbhoEOZKfH5Sh3UM9xCqF4T8mQXr8U+Mtzw1WZELb21BUhE9mzF0
 pJDd5HHIjVPcikNRfwG1tagmNOPD29d8qJVzDXkrgqS0vgnVuDCG0Bei0zQT9kEyk2SdVY
 mB1wWFbh46GTpN6L9o1rT1MABquUzsU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-F9ZwdY1dN7S7z33faZh9vQ-1; Tue, 13 Oct 2020 04:35:43 -0400
X-MC-Unique: F9ZwdY1dN7S7z33faZh9vQ-1
Received: by mail-wm1-f71.google.com with SMTP id 65so489773wmz.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 01:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CJFkuCAyQHgxXFK9YMzyhkkG7Cv7Kn+akgm7ccvpB6g=;
 b=fXAb9AVM5WDgYeUK9wI/Lsa6Ey7VVFUwj/PmhDK1usiB6U3kvA6Dt5QK+5BEOFb3Wa
 HgK72DTrFK9vPO2qE0k96c9MzCRn0+1wrzyiFmNdKUBsvA5djKSr8UUSIX8gEM03BywY
 B6/FPRfq/5B+y+cmyMRi+d7sGf6x7ptlZJmAB0Fq7o6f63+e+zhcwNIEgcEA8dqKa693
 bUO/eVxKMZiqjY7+FISiUXhrVxEQSrdfSSdHGvLBgfRSrsEgWBfxCMWjwiA27ZnfliMT
 sm92VLh9EEZO8MMYuspkSmciknSUSpjNTiUSVX0s3X02NoNYUEwu9SnB/Ntj+/rQ2Gby
 BHCA==
X-Gm-Message-State: AOAM531hpcjOG+4eJxjmsBRTrnbwjTJWLckSQS7JeLh9iBs7VJYN0Mda
 DQJvY+habovNZOVGOAArNbLIUes3OBgdObqTdsaXQ10ZyXLGxUB8hlPnjM/thuGu3CrnlY5UA6N
 UUShGuB2QXsAnNuI=
X-Received: by 2002:adf:ecc1:: with SMTP id s1mr33952113wro.120.1602578141045; 
 Tue, 13 Oct 2020 01:35:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwm2x9wnGX98W/PbFl9LXZR0hHqc+UuiJ+Ivhgu6Ljb8QMzQkC9imBFt9qJcrar/v/FIN7SXQ==
X-Received: by 2002:adf:ecc1:: with SMTP id s1mr33952084wro.120.1602578140780; 
 Tue, 13 Oct 2020 01:35:40 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id d2sm18277013wrq.34.2020.10.13.01.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:35:40 -0700 (PDT)
Subject: Re: [PATCH v9 2/5] curses: Fixes compiler error that complain don't
 have langinfo.h on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201012234348.1427-1-luoyonggang@gmail.com>
 <20201012234348.1427-3-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd59aaba-d75e-fab5-5c07-d6b552ff2684@redhat.com>
Date: Tue, 13 Oct 2020 10:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012234348.1427-3-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 1:43 AM, Yonggang Luo wrote:
> msys2/mingw lacks the POSIX-required langinfo.h.
> 
> gcc test.c -DNCURSES_WIDECHAR -I/mingw64/include/ncursesw -pipe -lncursesw -lgnurx -ltre -lintl -liconv
> test.c:4:10: fatal error: langinfo.h: No such file or directory
>      4 | #include <langinfo.h>
>        |          ^~~~~~~~~~~~
> compilation terminated.
> 
> So we using g_get_codeset instead of nl_langinfo(CODESET)
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   configure   |  5 +----
>   ui/curses.c | 10 +++++-----
>   2 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/configure b/configure
> index 1b63488521..71a574f718 100755
> --- a/configure
> +++ b/configure
> @@ -3530,17 +3530,14 @@ if test "$curses" != "no" ; then
>   #include <locale.h>
>   #include <curses.h>
>   #include <wchar.h>
> -#include <langinfo.h>
>   int main(void) {
> -  const char *codeset;
>     wchar_t wch = L'w';
>     setlocale(LC_ALL, "");
>     resize_term(0, 0);
>     addwstr(L"wide chars\n");
>     addnwstr(&wch, 1);
>     add_wch(WACS_DEGREE);
> -  codeset = nl_langinfo(CODESET);
> -  return codeset != 0;
> +  return 0;
>   }
>   EOF
>     IFS=:
> diff --git a/ui/curses.c b/ui/curses.c
> index a59b23a9cf..12bc682cf9 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -30,7 +30,6 @@
>   #endif
>   #include <locale.h>
>   #include <wchar.h>
> -#include <langinfo.h>
>   #include <iconv.h>
>   
>   #include "qapi/error.h"
> @@ -526,6 +525,7 @@ static void font_setup(void)
>       iconv_t nativecharset_to_ucs2;
>       iconv_t font_conv;
>       int i;
> +    g_autofree gchar *local_codeset = g_get_codeset();
>   
>       /*
>        * Control characters are normally non-printable, but VGA does have
> @@ -566,14 +566,14 @@ static void font_setup(void)
>         0x25bc
>       };
>   
> -    ucs2_to_nativecharset = iconv_open(nl_langinfo(CODESET), "UCS-2");
> +    ucs2_to_nativecharset = iconv_open(local_codeset, "UCS-2");
>       if (ucs2_to_nativecharset == (iconv_t) -1) {
>           fprintf(stderr, "Could not convert font glyphs from UCS-2: '%s'\n",
>                           strerror(errno));
>           exit(1);
>       }
>   
> -    nativecharset_to_ucs2 = iconv_open("UCS-2", nl_langinfo(CODESET));
> +    nativecharset_to_ucs2 = iconv_open("UCS-2", local_codeset);
>       if (nativecharset_to_ucs2 == (iconv_t) -1) {
>           iconv_close(ucs2_to_nativecharset);
>           fprintf(stderr, "Could not convert font glyphs to UCS-2: '%s'\n",
> @@ -581,7 +581,7 @@ static void font_setup(void)
>           exit(1);
>       }
>   
> -    font_conv = iconv_open(nl_langinfo(CODESET), font_charset);
> +    font_conv = iconv_open(local_codeset, font_charset);
>       if (font_conv == (iconv_t) -1) {
>           iconv_close(ucs2_to_nativecharset);
>           iconv_close(nativecharset_to_ucs2);
> @@ -602,7 +602,7 @@ static void font_setup(void)
>       /* DEL */
>       convert_ucs(0x7F, 0x2302, ucs2_to_nativecharset);
>   
> -    if (strcmp(nl_langinfo(CODESET), "UTF-8")) {
> +    if (strcmp(local_codeset, "UTF-8")) {
>           /* Non-Unicode capable, use termcap equivalents for those available */
>           for (i = 0; i <= 0xFF; i++) {
>               wchar_t wch[CCHARW_MAX];
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


