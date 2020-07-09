Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD18EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A75CA20708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 05:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S98MxLaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75CA20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtPDs-0003yT-L4
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 01:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtPDL-0003RN-05
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:35:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtPDI-0002iK-1p
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 01:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594272914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=SbE1Qk1ggLUuhb4fkAN2IOqvgWw7QghccEbj7SfvNuc=;
 b=S98MxLaq0A1xYiYrJJffkum3TrHIbAPtjAh67Zts12Ru3NHB4UFGHwSTtfDbzbVTskPsT+
 pt7IjfW7Q2lmNVTVtzktPE1IdIf/Xj5ug1a3f441aghm/K83YTwhoTuoV2kAy9Y1Ngowey
 7BxeJSqRbHC9AEXxNu1q/6MgRRF0xyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-Gk9nfX3CPKODuVdYKBh4dA-1; Thu, 09 Jul 2020 01:35:12 -0400
X-MC-Unique: Gk9nfX3CPKODuVdYKBh4dA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCDCE107ACF3;
 Thu,  9 Jul 2020 05:35:11 +0000 (UTC)
Received: from thuth.com (ovpn-112-106.ams2.redhat.com [10.36.112.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8602810013D0;
 Thu,  9 Jul 2020 05:34:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] Remove the CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE switch
Date: Thu,  9 Jul 2020 07:34:56 +0200
Message-Id: <20200709053456.4900-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

GCC supports "#pragma GCC diagnostic" since version 4.6, and
Clang seems to support it, too, since its early versions 3.x.
That means that our minimum required compiler versions all support
this pragma already and we can remove the test from configure and
all the related #ifdefs in the code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure                 | 29 -----------------------------
 include/ui/gtk.h          |  4 ----
 include/ui/qemu-pixman.h  |  4 ----
 scripts/decodetree.py     | 12 ++++--------
 ui/gtk.c                  |  4 ----
 util/coroutine-ucontext.c |  4 ----
 6 files changed, 4 insertions(+), 53 deletions(-)

diff --git a/configure b/configure
index ee6c3c6792..fbf119bbc0 100755
--- a/configure
+++ b/configure
@@ -5703,31 +5703,6 @@ if compile_prog "" "" ; then
     linux_magic_h=yes
 fi
 
-########################################
-# check whether we can disable warning option with a pragma (this is needed
-# to silence warnings in the headers of some versions of external libraries).
-# This test has to be compiled with -Werror as otherwise an unknown pragma is
-# only a warning.
-#
-# If we can't selectively disable warning in the code, disable -Werror so that
-# the build doesn't fail anyway.
-
-pragma_disable_unused_but_set=no
-cat > $TMPC << EOF
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wstrict-prototypes"
-#pragma GCC diagnostic pop
-
-int main(void) {
-    return 0;
-}
-EOF
-if compile_prog "-Werror" "" ; then
-    pragma_diagnostic_available=yes
-else
-    werror=no
-fi
-
 ########################################
 # check if we have valgrind/valgrind.h
 
@@ -7661,10 +7636,6 @@ if test "$linux_magic_h" = "yes" ; then
   echo "CONFIG_LINUX_MAGIC_H=y" >> $config_host_mak
 fi
 
-if test "$pragma_diagnostic_available" = "yes" ; then
-  echo "CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE=y" >> $config_host_mak
-fi
-
 if test "$valgrind_h" = "yes" ; then
   echo "CONFIG_VALGRIND_H=y" >> $config_host_mak
 fi
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index d1b230848a..eaeb450f91 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -1,15 +1,11 @@
 #ifndef UI_GTK_H
 #define UI_GTK_H
 
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
 /* Work around an -Wstrict-prototypes warning in GTK headers */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wstrict-prototypes"
-#endif
 #include <gtk/gtk.h>
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
 #pragma GCC diagnostic pop
-#endif
 
 #include <gdk/gdkkeysyms.h>
 
diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index 3b7cf70157..87737a6f16 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -7,14 +7,10 @@
 #define QEMU_PIXMAN_H
 
 /* pixman-0.16.0 headers have a redundant declaration */
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wredundant-decls"
-#endif
 #include <pixman.h>
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
 #pragma GCC diagnostic pop
-#endif
 
 /*
  * pixman image formats are defined to be native endian,
diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index 530d41ca62..694757b6c2 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -1327,12 +1327,10 @@ def main():
     # but we can't tell which ones.  Prevent issues from the compiler by
     # suppressing redundant declaration warnings.
     if anyextern:
-        output("#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE\n",
-               "# pragma GCC diagnostic push\n",
-               "# pragma GCC diagnostic ignored \"-Wredundant-decls\"\n",
-               "# ifdef __clang__\n"
+        output("#pragma GCC diagnostic push\n",
+               "#pragma GCC diagnostic ignored \"-Wredundant-decls\"\n",
+               "#ifdef __clang__\n"
                "#  pragma GCC diagnostic ignored \"-Wtypedef-redefinition\"\n",
-               "# endif\n",
                "#endif\n\n")
 
     out_pats = {}
@@ -1347,9 +1345,7 @@ def main():
     output('\n')
 
     if anyextern:
-        output("#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE\n",
-               "# pragma GCC diagnostic pop\n",
-               "#endif\n\n")
+        output("#pragma GCC diagnostic pop\n\n")
 
     for n in sorted(formats.keys()):
         f = formats[n]
diff --git a/ui/gtk.c b/ui/gtk.c
index d4b49bd7da..b0cc08ad6d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1996,14 +1996,10 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
              * proper replacement (native opengl support) is only
              * available in 3.16+.  Silence the warning if possible.
              */
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-#endif
             gtk_widget_set_double_buffered(vc->gfx.drawing_area, FALSE);
-#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
 #pragma GCC diagnostic pop
-#endif
             vc->gfx.dcl.ops = &dcl_egl_ops;
         }
     } else
diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
index f0b66320e1..a4e6446ed9 100644
--- a/util/coroutine-ucontext.c
+++ b/util/coroutine-ucontext.c
@@ -237,19 +237,15 @@ Coroutine *qemu_coroutine_new(void)
 }
 
 #ifdef CONFIG_VALGRIND_H
-#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
 /* Work around an unused variable in the valgrind.h macro... */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wunused-but-set-variable"
-#endif
 static inline void valgrind_stack_deregister(CoroutineUContext *co)
 {
     VALGRIND_STACK_DEREGISTER(co->valgrind_stack_id);
 }
-#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && !defined(__clang__)
 #pragma GCC diagnostic pop
 #endif
-#endif
 
 void qemu_coroutine_delete(Coroutine *co_)
 {
-- 
2.18.1


