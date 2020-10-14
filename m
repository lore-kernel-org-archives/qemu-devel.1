Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0286DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8120E20BED
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 08:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGsl0684"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8120E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSc8T-0008Ke-HI
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 04:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSc2x-00005h-UX
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:22:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kSc2q-0007ai-00
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 04:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602663717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PP13+ywlO+38F/ZgCkR6WUT0vmlFiTR3LA7lLvFpPwQ=;
 b=iGsl0684tiP0KkJtuQvG7eaEcX4m8w0/KxETqP3nR+bOsN73Hu5lhb+zIq1SxKtfw/n5PN
 LiL/H/JCsXwKO34uOZrFgL5j/sqwLbvJazsB9axrj0IP1C90nE9JI25OUN0gg8ti0LuZHO
 RpaSoqgtZ2p8x71VTySe+vc1qQTDu6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-Gn0KOoJ6PQ-Tmn90aBtThA-1; Wed, 14 Oct 2020 04:21:55 -0400
X-MC-Unique: Gn0KOoJ6PQ-Tmn90aBtThA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 716778015B1;
 Wed, 14 Oct 2020 08:21:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB9D55578D;
 Wed, 14 Oct 2020 08:21:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2E4F443BFB9; Wed, 14 Oct 2020 10:21:50 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] win32: Simplify gmtime_r detection not depends on if
 _POSIX_C_SOURCE are defined on msys2/mingw
Date: Wed, 14 Oct 2020 10:21:44 +0200
Message-Id: <20201014082149.26853-5-kraxel@redhat.com>
In-Reply-To: <20201014082149.26853-1-kraxel@redhat.com>
References: <20201014082149.26853-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

We remove the CONFIG_LOCALTIME_R detection option in configure, and move the check
existence of gmtime_r from configure into C header and source directly by using macro
`_POSIX_THREAD_SAFE_FUNCTIONS`.
Before this patch, the configure script are always assume the compiler doesn't define
_POSIX_C_SOURCE macro at all, but that's not true, because thirdparty library such
as ncursesw may define -D_POSIX_C_SOURCE in it's pkg-config file. And that C Flags will
added -D_POSIX_C_SOURCE into each QEMU_CFLAGS. And that's causing the following compiling error:
n file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../softmmu/main.c:25:
C:/work/xemu/qemu/include/sysemu/os-win32.h:53:12: error: redundant redeclaration of 'gmtime_r' [-Werror=redundant-decls]
   53 | struct tm *gmtime_r(const time_t *timep, struct tm *result);
      |            ^~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
                 from ../softmmu/main.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:284:36: note: previous definition of 'gmtime_r' was here
  284 | __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
      |                                    ^~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../softmmu/main.c:25:
C:/work/xemu/qemu/include/sysemu/os-win32.h:55:12: error: redundant redeclaration of 'localtime_r' [-Werror=redundant-decls]
   55 | struct tm *localtime_r(const time_t *timep, struct tm *result);
      |            ^~~~~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
                 from ../softmmu/main.c:25:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:281:36: note: previous definition of 'localtime_r' was here
  281 | __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
      |                                    ^~~~~~~~~~~
Compiling C object libcommon.fa.p/hw_gpio_zaurus.c.obj
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../hw/i2c/smbus_slave.c:16:
C:/work/xemu/qemu/include/sysemu/os-win32.h:53:12: error: redundant redeclaration of 'gmtime_r' [-Werror=redundant-decls]
   53 | struct tm *gmtime_r(const time_t *timep, struct tm *result);
      |            ^~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
                 from ../hw/i2c/smbus_slave.c:16:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:284:36: note: previous definition of 'gmtime_r' was here
  284 | __forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
      |                                    ^~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:119,
                 from ../hw/i2c/smbus_slave.c:16:
C:/work/xemu/qemu/include/sysemu/os-win32.h:55:12: error: redundant redeclaration of 'localtime_r' [-Werror=redundant-decls]
   55 | struct tm *localtime_r(const time_t *timep, struct tm *result);
      |            ^~~~~~~~~~~
In file included from C:/work/xemu/qemu/include/qemu/osdep.h:94,
                 from ../hw/i2c/smbus_slave.c:16:
C:/CI-Tools/msys64/mingw64/x86_64-w64-mingw32/include/time.h:281:36: note: previous definition of 'localtime_r' was here
  281 | __forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
      |                                    ^~~~~~~~~~~
Compiling C object libcommon.fa.p/hw_dma_xilinx_axidma.c.obj

After this patch, whenever ncursesw or other thirdparty libraries tried to define or not
define  _POSIX_C_SOURCE, the source will building properly. Because now, we don't make any
assumption if _POSIX_C_SOURCE are defined. We solely relied on if the macro `_POSIX_THREAD_SAFE_FUNCTIONS`
are defined in msys2/mingw header.

The _POSIX_THREAD_SAFE_FUNCTIONS are defined in mingw header like this:

```
#if defined(_POSIX_C_SOURCE) && !defined(_POSIX_THREAD_SAFE_FUNCTIONS)
#define _POSIX_THREAD_SAFE_FUNCTIONS 200112L
#endif

#ifdef _POSIX_THREAD_SAFE_FUNCTIONS
__forceinline struct tm *__CRTDECL localtime_r(const time_t *_Time, struct tm *_Tm) {
  return localtime_s(_Tm, _Time) ? NULL : _Tm;
}
__forceinline struct tm *__CRTDECL gmtime_r(const time_t *_Time, struct tm *_Tm) {
  return gmtime_s(_Tm, _Time) ? NULL : _Tm;
}
__forceinline char *__CRTDECL ctime_r(const time_t *_Time, char *_Str) {
  return ctime_s(_Str, 0x7fffffff, _Time) ? NULL : _Str;
}
__forceinline char *__CRTDECL asctime_r(const struct tm *_Tm, char * _Str) {
  return asctime_s(_Str, 0x7fffffff, _Tm) ? NULL : _Str;
}
#endif
```

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20201012234348.1427-5-luoyonggang@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure                 | 34 ----------------------------------
 include/sysemu/os-win32.h |  4 ++--
 util/oslib-win32.c        |  4 ++--
 3 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/configure b/configure
index 71a574f718fa..9a87685517ee 100755
--- a/configure
+++ b/configure
@@ -2386,37 +2386,6 @@ if test "$vhost_net" = ""; then
   test "$vhost_kernel" = "yes" && vhost_net=yes
 fi
 
-##########################################
-# MinGW / Mingw-w64 localtime_r/gmtime_r check
-
-if test "$mingw32" = "yes"; then
-    # Some versions of MinGW / Mingw-w64 lack localtime_r
-    # and gmtime_r entirely.
-    #
-    # Some versions of Mingw-w64 define a macro for
-    # localtime_r/gmtime_r.
-    #
-    # Some versions of Mingw-w64 will define functions
-    # for localtime_r/gmtime_r, but only if you have
-    # _POSIX_THREAD_SAFE_FUNCTIONS defined. For fun
-    # though, unistd.h and pthread.h both define
-    # that for you.
-    #
-    # So this #undef localtime_r and #include <unistd.h>
-    # are not in fact redundant.
-cat > $TMPC << EOF
-#include <unistd.h>
-#include <time.h>
-#undef localtime_r
-int main(void) { localtime_r(NULL, NULL); return 0; }
-EOF
-    if compile_prog "" "" ; then
-        localtime_r="yes"
-    else
-        localtime_r="no"
-    fi
-fi
-
 ##########################################
 # pkg-config probe
 
@@ -6610,9 +6579,6 @@ if [ "$bsd" = "yes" ] ; then
   echo "CONFIG_BSD=y" >> $config_host_mak
 fi
 
-if test "$localtime_r" = "yes" ; then
-  echo "CONFIG_LOCALTIME_R=y" >> $config_host_mak
-fi
 if test "$qom_cast_debug" = "yes" ; then
   echo "CONFIG_QOM_CAST_DEBUG=y" >> $config_host_mak
 fi
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index d8978e28c03f..5346d51e890e 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -48,12 +48,12 @@
 #define siglongjmp(env, val) longjmp(env, val)
 
 /* Missing POSIX functions. Don't use MinGW-w64 macros. */
-#ifndef CONFIG_LOCALTIME_R
+#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
 #undef gmtime_r
 struct tm *gmtime_r(const time_t *timep, struct tm *result);
 #undef localtime_r
 struct tm *localtime_r(const time_t *timep, struct tm *result);
-#endif /* CONFIG_LOCALTIME_R */
+#endif /* _POSIX_THREAD_SAFE_FUNCTIONS */
 
 static inline void os_setup_signal_handling(void) {}
 static inline void os_daemonize(void) {}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 051afb217bc0..e99debfb8dd4 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -106,7 +106,7 @@ void qemu_anon_ram_free(void *ptr, size_t size)
     }
 }
 
-#ifndef CONFIG_LOCALTIME_R
+#ifndef _POSIX_THREAD_SAFE_FUNCTIONS
 /* FIXME: add proper locking */
 struct tm *gmtime_r(const time_t *timep, struct tm *result)
 {
@@ -130,7 +130,7 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
     }
     return p;
 }
-#endif /* CONFIG_LOCALTIME_R */
+#endif /* _POSIX_THREAD_SAFE_FUNCTIONS */
 
 static int socket_error(void)
 {
-- 
2.27.0


