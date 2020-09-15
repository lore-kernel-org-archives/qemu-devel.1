Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8388C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DC920829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScH5+Rey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DC920829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAnC-0001gd-1n
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIAZN-0008JV-Ky
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:00:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIAZL-0005yr-3g
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 09:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600174821;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Kr25UJD/dw4wntuUz0tkyiG70er4SHYBGD7E0ZONqkI=;
 b=ScH5+Reyg4+0RDBaftSPpjJBSnXL3R1RtPEQ+NnD/8WpTW90j7lNVV06qjPnNLfDCb64Ye
 Y8L2xYCMiZgeNXJSXaDFM/vqUwO8xuGuhbhcrNPK8TjOCqaqMWcKQ7OzSb82tga94uMeBQ
 AbIbvXoA277HYJlJCMOY/f2jPrz/t6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-oOfcpGRvNuaJaa5BBlAvTg-1; Tue, 15 Sep 2020 09:00:15 -0400
X-MC-Unique: oOfcpGRvNuaJaa5BBlAvTg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A1B6801AE4;
 Tue, 15 Sep 2020 13:00:13 +0000 (UTC)
Received: from redhat.com (ovpn-113-234.ams2.redhat.com [10.36.113.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6383C1002D42;
 Tue, 15 Sep 2020 13:00:04 +0000 (UTC)
Date: Tue, 15 Sep 2020 14:00:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v9 04/26] win32: Simplify gmtime_r detection direct base
 on _POSIX_THREAD_SAFE_FUNCTIONS.
Message-ID: <20200915130001.GG1502912@redhat.com>
References: <20200915121318.247-1-luoyonggang@gmail.com>
 <20200915121318.247-5-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200915121318.247-5-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 08:12:56PM +0800, Yonggang Luo wrote:
> First, this reduce the size of configure, configure are tending to removal in future,
> and this didn't introduce any new feature or remove any exist feature.
> Second, the current localtime_r detection are conflict with ncursesw detection in
> mingw, when ncursesw detected, it will provide the following compile flags
> pkg-config --cflags ncursesw
> -D_XOPEN_SOURCE=600 -D_POSIX_C_SOURCE=199506L -IC:/CI-Tools/msys64/mingw64/include/ncursesw
> And the compile flag _POSIX_C_SOURCE will always cause _POSIX_THREAD_SAFE_FUNCTIONS to
> be defined, in new version of mingw, that's will cause localtime_r to be defined.
> But the configure script didn't provide _POSIX_C_SOURCE macro, and that's will result
> localtime_r not detected because localtime_r are defined in forceinline manner.

ncursesw is just one of the three curses impls we can select for
building against, so it doesn't feel right to make an assumption
that _POSIX_C_SOURCE is always defined.

> 
> And finally cause conflict between QEMU defined localtime_r
> struct tm *localtime_r(const time_t *timep, struct tm *result);
> with mingw defined localtime_r
> 
> ```
> #if defined(_POSIX_C_SOURCE) && !defined(_POSIX_THREAD_SAFE_FUNCTIONS)
> #define _POSIX_THREAD_SAFE_FUNCTIONS 200112L
> #endif
> 
> #ifdef _POSIX_THREAD_SAFE_FUNCTIONS
> __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
>   return localtime_s(_Tm, _Time) ? NULL : _Tm;
> }
> __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
>   return gmtime_s(_Tm, _Time) ? NULL : _Tm;
> }
> __forceinline char *__CRTDECL ctime_r(const time_t *_Time, char *_Str) {
>   return ctime_s(_Str, 0x7fffffff, _Time) ? NULL : _Str;
> }
> __forceinline char *__CRTDECL asctime_r(const struct tm *_Tm, char * _Str) {
>   return asctime_s(_Str, 0x7fffffff, _Tm) ? NULL : _Str;
> }
> #endif
> ```
> 
> So I suggest remove this configure script, and restrict msys2/mingw version to easy to maintain.
> And use _POSIX_THREAD_SAFE_FUNCTIONS to guard the localtime_r and counterpart functions
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  configure                 | 34 ----------------------------------
>  include/sysemu/os-win32.h |  4 ++--
>  util/oslib-win32.c        |  2 +-
>  3 files changed, 3 insertions(+), 37 deletions(-)
> 
> diff --git a/configure b/configure
> index dc4b7a2e55..bac48b5b49 100755
> --- a/configure
> +++ b/configure
> @@ -2496,37 +2496,6 @@ if test "$vhost_net" = ""; then
>    test "$vhost_kernel" = "yes" && vhost_net=yes
>  fi
>  
> -##########################################
> -# MinGW / Mingw-w64 localtime_r/gmtime_r check
> -
> -if test "$mingw32" = "yes"; then
> -    # Some versions of MinGW / Mingw-w64 lack localtime_r
> -    # and gmtime_r entirely.
> -    #
> -    # Some versions of Mingw-w64 define a macro for
> -    # localtime_r/gmtime_r.
> -    #
> -    # Some versions of Mingw-w64 will define functions
> -    # for localtime_r/gmtime_r, but only if you have
> -    # _POSIX_THREAD_SAFE_FUNCTIONS defined. For fun
> -    # though, unistd.h and pthread.h both define
> -    # that for you.
> -    #
> -    # So this #undef localtime_r and #include <unistd.h>
> -    # are not in fact redundant.
> -cat > $TMPC << EOF
> -#include <unistd.h>
> -#include <time.h>
> -#undef localtime_r
> -int main(void) { localtime_r(NULL, NULL); return 0; }
> -EOF
> -    if compile_prog "" "" ; then
> -        localtime_r="yes"
> -    else
> -        localtime_r="no"
> -    fi
> -fi
> -
>  ##########################################
>  # pkg-config probe
>  
> @@ -7088,9 +7057,6 @@ if [ "$bsd" = "yes" ] ; then
>    echo "CONFIG_BSD=y" >> $config_host_mak
>  fi
>  
> -if test "$localtime_r" = "yes" ; then
> -  echo "CONFIG_LOCALTIME_R=y" >> $config_host_mak
> -fi
>  if test "$qom_cast_debug" = "yes" ; then
>    echo "CONFIG_QOM_CAST_DEBUG=y" >> $config_host_mak
>  fi
> diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
> index d8978e28c0..3ac8a53bac 100644
> --- a/include/sysemu/os-win32.h
> +++ b/include/sysemu/os-win32.h
> @@ -48,12 +48,12 @@
>  #define siglongjmp(env, val) longjmp(env, val)
>  
>  /* Missing POSIX functions. Don't use MinGW-w64 macros. */
> -#ifndef CONFIG_LOCALTIME_R
> +#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
>  #undef gmtime_r
>  struct tm *gmtime_r(const time_t *timep, struct tm *result);
>  #undef localtime_r
>  struct tm *localtime_r(const time_t *timep, struct tm *result);
> -#endif /* CONFIG_LOCALTIME_R */
> +#endif
>  
>  static inline void os_setup_signal_handling(void) {}
>  static inline void os_daemonize(void) {}
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index c654dafd93..f2fa9a3549 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -106,7 +106,7 @@ void qemu_anon_ram_free(void *ptr, size_t size)
>      }
>  }
>  
> -#ifndef CONFIG_LOCALTIME_R
> +#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
>  /* FIXME: add proper locking */
>  struct tm *gmtime_r(const time_t *timep, struct tm *result)
>  {
> -- 
> 2.28.0.windows.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


