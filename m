Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F34C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A965208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IooVdEDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A965208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFw4-0000Yb-Ni
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFoN-0002pX-Gh
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSFoL-00057r-7O
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602578252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YER42suSzgo1mdCZneD+dAT6C2yg98ryiioL9b4AR5c=;
 b=IooVdEDTQ2Lp9DrRvROC06i0yPLpVYXZpZ7vjrl+L507HZsCea2Aw3ISgzt/FUwUB2VIIw
 QwA9fEi3uNOCkI30JefT/whFhO9c/GDtBlkEhWX1UDSiMrpKJH/wyJ55TsBa23+Fgd2ala
 B4gC37r0Yv6RTgAvn/GgiY1vzjMj6gI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-kU5fanjDOCaspe-_DJE-lQ-1; Tue, 13 Oct 2020 04:37:30 -0400
X-MC-Unique: kU5fanjDOCaspe-_DJE-lQ-1
Received: by mail-wm1-f72.google.com with SMTP id s25so6439135wmj.7
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 01:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YER42suSzgo1mdCZneD+dAT6C2yg98ryiioL9b4AR5c=;
 b=aAJpin9jZuHkGuacXIo7OXyYBHRYZDggdkBffYn0KNW+f7vHfO+dyFcLcEb8HZaaTA
 KNUwtqhf7hTTdtYlMXrlQueQs2cqOvLmH4nzpSnMxSC4hRR4Wz682g1V2qZmsToLDOWM
 NDw4kEz7egQFKGlo1yJh8PKcUtYZc8k29DiLxTzt/0L6R3uCw1cgROB6Q1wWlcf7JvSA
 3cmJhnhEuisOZI2pbIFCbEh4OG1nZworB2+wdCSQ8qaACleO2aMWu+vogNxsq2qlzKsm
 BwJqQr6LMpSwDHIaaG6mKiONJSe0jCx3F07EzOWV8TkaeEYLmYrBoT8JlUhvSm4vM6x7
 /IZg==
X-Gm-Message-State: AOAM530n7i6VFukYul3pZ1OFnqK99A00lCaI7edNDPPRMnKMKE467/A+
 Fo8sbTGfSEU+Ow5x2vfVo3oZSLFG1x5SBc7YpUonTUzK3+D9SdXcXsMBzlI8kavjACd5hKzM3um
 kncCRSpdEMwNFKOU=
X-Received: by 2002:adf:93e5:: with SMTP id 92mr33314277wrp.31.1602578249439; 
 Tue, 13 Oct 2020 01:37:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXqI7kgL0CoevUkym211lbRIfbsZCtGkZlZYRskWOqC5tYS/cdGxbl1sIEDTAHUv1T0D8AgA==
X-Received: by 2002:adf:93e5:: with SMTP id 92mr33314257wrp.31.1602578249250; 
 Tue, 13 Oct 2020 01:37:29 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p67sm26420219wmp.11.2020.10.13.01.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:37:28 -0700 (PDT)
Subject: Re: [PATCH v9 4/5] win32: Simplify gmtime_r detection not depends on
 if _POSIX_C_SOURCE are defined on msys2/mingw
To: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20201012234348.1427-1-luoyonggang@gmail.com>
 <20201012234348.1427-5-luoyonggang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4d300fcc-7ca9-aaa4-7bc4-e513ae558dc0@redhat.com>
Date: Tue, 13 Oct 2020 10:37:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012234348.1427-5-luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
> We remove the CONFIG_LOCALTIME_R detection option in configure, and move the check
> existence of gmtime_r from configure into C header and source directly by using macro
> `_POSIX_THREAD_SAFE_FUNCTIONS`.
> Before this patch, the configure script are always assume the compiler doesn't define
> _POSIX_C_SOURCE macro at all, but that's not true, because thirdparty library such
> as ncursesw may define -D_POSIX_C_SOURCE in it's pkg-config file. And that C Flags will
> added -D_POSIX_C_SOURCE into each QEMU_CFLAGS. And that's causing the following compiling error:
> n file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
>                   from ../softmmu/main.c:25:
> C:/work/xemu/qemu/include/sysemu/os-win32.h:53:12: error: redundant redeclaration of 'gmtime_r' [-Werror=redundant-decls]
>     53 | struct tm *gmtime_r(const time_t *timep, struct tm *result);
>        |            ^~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
>                   from ../softmmu/main.c:25:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:284:36: note: previous definition of 'gmtime_r' was here
>    284 | __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
>        |                                    ^~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
>                   from ../softmmu/main.c:25:
> C:/work/xemu/qemu/include/sysemu/os-win32.h:55:12: error: redundant redeclaration of 'localtime_r' [-Werror=redundant-decls]
>     55 | struct tm *localtime_r(const time_t *timep, struct tm *result);
>        |            ^~~~~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
>                   from ../softmmu/main.c:25:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:281:36: note: previous definition of 'localtime_r' was here
>    281 | __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
>        |                                    ^~~~~~~~~~~

^^^ very verbose but OK.

vvv This part is duplicated, can you remove?

> Compiling C object libcommon.fa.p/hw_gpio_zaurus.c.obj
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
>                   from ../hw/i2c/smbus_slave.c:16:
> C:/work/xemu/qemu/include/sysemu/os-win32.h:53:12: error: redundant redeclaration of 'gmtime_r' [-Werror=redundant-decls]
>     53 | struct tm *gmtime_r(const time_t *timep, struct tm *result);
>        |            ^~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
>                   from ../hw/i2c/smbus_slave.c:16:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:284:36: note: previous definition of 'gmtime_r' was here
>    284 | __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
>        |                                    ^~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
>                   from ../hw/i2c/smbus_slave.c:16:
> C:/work/xemu/qemu/include/sysemu/os-win32.h:55:12: error: redundant redeclaration of 'localtime_r' [-Werror=redundant-decls]
>     55 | struct tm *localtime_r(const time_t *timep, struct tm *result);
>        |            ^~~~~~~~~~~
> In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
>                   from ../hw/i2c/smbus_slave.c:16:
> C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:281:36: note: previous definition of 'localtime_r' was here
>    281 | __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
>        |                                    ^~~~~~~~~~~
> Compiling C object libcommon.fa.p/hw_dma_xilinx_axidma.c.obj
> 
> After this patch, whenever ncursesw or other thirdparty libraries tried to define or not
> define  _POSIX_C_SOURCE, the source will building properly. Because now, we don't make any
> assumption if _POSIX_C_SOURCE are defined. We solely relied on if the macro `_POSIX_THREAD_SAFE_FUNCTIONS`
> are defined in msys2/mingw header.
> 
> The _POSIX_THREAD_SAFE_FUNCTIONS are defined in mingw header like this:
> 
> ```
> #if defined(_POSIX_C_SOURCE) && !defined(_POSIX_THREAD_SAFE_FUNCTIONS)
> #define _POSIX_THREAD_SAFE_FUNCTIONS 200112L
> #endif
> 
> #ifdef _POSIX_THREAD_SAFE_FUNCTIONS
> __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
>    return localtime_s(_Tm, _Time) ? NULL : _Tm;
> }
> __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
>    return gmtime_s(_Tm, _Time) ? NULL : _Tm;
> }
> __forceinline char *__CRTDECL ctime_r(const time_t *_Time, char *_Str) {
>    return ctime_s(_Str, 0x7fffffff, _Time) ? NULL : _Str;
> }
> __forceinline char *__CRTDECL asctime_r(const struct tm *_Tm, char * _Str) {
>    return asctime_s(_Str, 0x7fffffff, _Tm) ? NULL : _Str;
> }
> #endif
> ```
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   configure                 | 34 ----------------------------------
>   include/sysemu/os-win32.h |  4 ++--
>   util/oslib-win32.c        |  4 ++--
>   3 files changed, 4 insertions(+), 38 deletions(-)


