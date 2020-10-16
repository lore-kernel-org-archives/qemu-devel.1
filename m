Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF7FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B952083B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBx8/62X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B952083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTOTI-0004zB-25
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 08:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODh-0000Sp-Qc
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODf-0002ow-GY
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMj42FWSGHuJJJLkm1CZE9pM8UgSJdaDfP2mKTx9JUY=;
 b=fBx8/62XSs6Gj8mH1Y08/8nmuDVlxWvMh8BQmIOaDrD1L3omjVjjMTKyNaAbM+PoD1n8xh
 G4WOuUnCIbZd+DevlDF7c2T6f+9xXwGP6rM/WOVwW7CjmPXlDZjwEy1eu1CW8mfYrv/tmQ
 sRxoJlPtcD4LVk9SN1JyJGlcml0ycuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-bozp9oWoOT2uzQsPa8Ityg-1; Fri, 16 Oct 2020 07:48:20 -0400
X-MC-Unique: bozp9oWoOT2uzQsPa8Ityg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 155DD1084C86
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:48:20 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D52015C1BD
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:48:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/22] meson: cleanup curses/iconv test
Date: Fri, 16 Oct 2020 07:48:05 -0400
Message-Id: <20201016114814.1564523-14-pbonzini@redhat.com>
In-Reply-To: <20201016114814.1564523-1-pbonzini@redhat.com>
References: <20201016114814.1564523-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Skip the test if it is system emulation is not requested, and
differentiate errors for lack of iconv and lack of curses.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 85 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/meson.build b/meson.build
index c1c45e9845..15732f4701 100644
--- a/meson.build
+++ b/meson.build
@@ -455,40 +455,40 @@ if targetos == 'linux' and have_tools and not get_option('mpath').disabled()
 endif
 
 iconv = not_found
-if not get_option('iconv').disabled()
-  libiconv = cc.find_library('iconv',
-                             required: false,
-                             static: enable_static)
-  if cc.links('''
-    #include <iconv.h>
-    int main(void) {
-      iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
-      return conv != (iconv_t) -1;
-    }''', dependencies: [libiconv])
-    iconv = declare_dependency(dependencies: [libiconv])
-  endif
-endif
-if get_option('iconv').enabled() and not iconv.found()
-  error('Cannot detect iconv API')
-endif
-
 curses = not_found
-if iconv.found() and not get_option('curses').disabled()
-  curses_libname_list = ['ncursesw', 'ncurses', 'cursesw', 'pdcurses']
-  curses_test = '''
-    #include <locale.h>
-    #include <curses.h>
-    #include <wchar.h>
-    int main(void) {
-      wchar_t wch = L'w';
-      setlocale(LC_ALL, "");
-      resize_term(0, 0);
-      addwstr(L"wide chars\n");
-      addnwstr(&wch, 1);
-      add_wch(WACS_DEGREE);
-      return 0;
-    }'''
-  foreach curses_libname : curses_libname_list
+if have_system and not get_option('curses').disabled()
+  if not get_option('iconv').disabled()
+    libiconv = cc.find_library('iconv',
+                               required: false,
+                               static: enable_static)
+    if cc.links('''
+      #include <iconv.h>
+      int main(void) {
+        iconv_t conv = iconv_open("WCHAR_T", "UCS-2");
+        return conv != (iconv_t) -1;
+      }''', dependencies: [libiconv])
+      iconv = declare_dependency(dependencies: [libiconv])
+    endif
+  endif
+  if get_option('iconv').enabled() and not iconv.found()
+    error('Cannot detect iconv API')
+  endif
+  if iconv.found()
+    curses_libname_list = ['ncursesw', 'ncurses', 'cursesw', 'pdcurses']
+    curses_test = '''
+      #include <locale.h>
+      #include <curses.h>
+      #include <wchar.h>
+      int main(void) {
+        wchar_t wch = L'w';
+        setlocale(LC_ALL, "");
+        resize_term(0, 0);
+        addwstr(L"wide chars\n");
+        addnwstr(&wch, 1);
+        add_wch(WACS_DEGREE);
+        return 0;
+      }'''
+    foreach curses_libname : curses_libname_list
       libcurses = dependency(curses_libname,
                              required: false,
                              method: 'pkg-config',
@@ -510,13 +510,18 @@ if iconv.found() and not get_option('curses').disabled()
           break
         endif
       endif
-  endforeach
-endif
-if get_option('curses').enabled() and not curses.found()
-  if not iconv.found()
-    error('Cannot detect iconv API')
-  else
-    error('Cannot detect curses API')
+    endforeach
+  endif
+  if not curses.found()
+    if iconv.found()
+      if get_option('curses').enabled()
+        error('Cannot find curses')
+      endif
+    elif get_option('curses').enabled()
+      error('iconv required for curses UI but not available')
+    else
+      warning('iconv required for curses UI but not available, disabling')
+    endif
   endif
 endif
 
-- 
2.26.2



