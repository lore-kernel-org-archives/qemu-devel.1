Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803ABC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:07:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E018221973
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 08:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QA3kr0oU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E018221973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kISSw-00078X-Lz
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 04:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kISSH-0006jG-5U
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kISSE-0003FF-Ss
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 04:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600243574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=liyeG8gHMAYbtq4juBgYSCD8yA0foSFdSeydiiakjg8=;
 b=QA3kr0oUpK/sv77/wqd9AfRGuekBNHutn+VMKMb/RfbvukCjWp6Dp+Jp7GO4qtJlHkx23B
 zIhif5hRRsu5iffKio2euvY20atdP+2K0tEuu8TW8kD6OA7V40NGMWmw1CiVodDviuL23l
 WBRDytfy53jXQZro+4FVaYaB2uGHsLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-PwNg6MhpOimLipsuE_Ev5A-1; Wed, 16 Sep 2020 04:06:10 -0400
X-MC-Unique: PwNg6MhpOimLipsuE_Ev5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 262BC1017DC3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 08:06:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0F4768D6E;
 Wed, 16 Sep 2020 08:06:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: move malloc_trim/tcmalloc/jemalloc to meson
Date: Wed, 16 Sep 2020 04:06:08 -0400
Message-Id: <20200916080608.17689-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because LIBS is not used anymore, tcmalloc/jemalloc does
not work with binaries whose description is in Meson.
The fix is simply to move them to Meson too.

For consistency with other configure options, specifying
--enable-malloc-trim together with --enable-{tc,je}malloc
becomes a fatal error.

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         | 84 +++++------------------------------------------
 meson.build       | 28 +++++++++++++---
 meson_options.txt |  5 +++
 3 files changed, 38 insertions(+), 79 deletions(-)

diff --git a/configure b/configure
index ce27eafb0a..13f53ba231 100755
--- a/configure
+++ b/configure
@@ -540,7 +540,7 @@ skip_meson=no
 gettext=""
 
 bogus_os="no"
-malloc_trim=""
+malloc_trim="auto"
 
 deprecated_features=""
 
@@ -1222,9 +1222,9 @@ for opt do
   ;;
   --enable-tcg) tcg="yes"
   ;;
-  --disable-malloc-trim) malloc_trim="no"
+  --disable-malloc-trim) malloc_trim="disabled"
   ;;
-  --enable-malloc-trim) malloc_trim="yes"
+  --enable-malloc-trim) malloc_trim="enabled"
   ;;
   --disable-spice) spice="no"
   ;;
@@ -4428,77 +4428,14 @@ EOF
   fi
 fi
 
+malloc=system
 if test "$tcmalloc" = "yes" && test "$jemalloc" = "yes" ; then
     echo "ERROR: tcmalloc && jemalloc can't be used at the same time"
     exit 1
-fi
-
-# Even if malloc_trim() is available, these non-libc memory allocators
-# do not support it.
-if test "$tcmalloc" = "yes" || test "$jemalloc" = "yes" ; then
-    if test "$malloc_trim" = "yes" ; then
-        echo "Disabling malloc_trim with non-libc memory allocator"
-    fi
-    malloc_trim="no"
-fi
-
-#######################################
-# malloc_trim
-
-if test "$malloc_trim" != "no" ; then
-    cat > $TMPC << EOF
-#include <malloc.h>
-int main(void) { malloc_trim(0); return 0; }
-EOF
-    if compile_prog "" "" ; then
-        malloc_trim="yes"
-    else
-        malloc_trim="no"
-    fi
-fi
-
-##########################################
-# tcmalloc probe
-
-if test "$tcmalloc" = "yes" ; then
-  cat > $TMPC << EOF
-#include <stdlib.h>
-int main(void) {
-    void *tmp = malloc(1);
-    if (tmp != NULL) {
-        return 0;
-    }
-    return 1;
-}
-EOF
-
-  if compile_prog "" "-ltcmalloc" ; then
-    LIBS="-ltcmalloc $LIBS"
-  else
-    feature_not_found "tcmalloc" "install gperftools devel"
-  fi
-fi
-
-##########################################
-# jemalloc probe
-
-if test "$jemalloc" = "yes" ; then
-  cat > $TMPC << EOF
-#include <stdlib.h>
-int main(void) {
-    void *tmp = malloc(1);
-    if (tmp != NULL) {
-        return 0;
-    }
-    return 1;
-}
-EOF
-
-  if compile_prog "" "-ljemalloc" ; then
-    LIBS="-ljemalloc $LIBS"
-  else
-    feature_not_found "jemalloc" "install jemalloc devel"
-  fi
+elif test "$tcmalloc" = "yes" ; then
+    malloc=tcmalloc
+elif test "$jemalloc" = "yes" ; then
+    malloc=jemalloc
 fi
 
 ##########################################
@@ -7023,10 +6960,6 @@ if test "$gbm" = "yes" ; then
 fi
 
 
-if test "$malloc_trim" = "yes" ; then
-  echo "CONFIG_MALLOC_TRIM=y" >> $config_host_mak
-fi
-
 if test "$avx2_opt" = "yes" ; then
   echo "CONFIG_AVX2_OPT=y" >> $config_host_mak
 fi
@@ -8003,6 +7936,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
+	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
 	-Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
diff --git a/meson.build b/meson.build
index bba766b4bc..d3b1e5c34c 100644
--- a/meson.build
+++ b/meson.build
@@ -439,6 +439,26 @@ keyutils = dependency('libkeyutils', required: false,
 
 has_gettid = cc.has_function('gettid')
 
+# Malloc tests
+
+malloc = []
+if get_option('malloc') == 'system'
+  has_malloc_trim = \
+    not get_option('malloc_trim').disabled() and \
+    cc.compiles('''#include <malloc.h>
+                   int main(void) { malloc_trim(0); return 0; }''')
+else
+  has_malloc_trim = false
+  malloc = cc.find_library(get_option('malloc'), required: true)
+endif
+if not has_malloc_trim and get_option('malloc_trim').enabled()
+  if get_option('malloc') == 'system'
+    error('malloc_trim not available on this platform.')
+  else
+    error('malloc_trim not available with non-libc memory allocator')
+  endif
+endif
+
 # Create config-host.h
 
 config_host_data.set('CONFIG_SDL', sdl.found())
@@ -450,6 +470,7 @@ config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
 config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('CONFIG_GETTID', has_gettid)
+config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
@@ -818,7 +839,7 @@ util_ss.add_all(trace_ss)
 util_ss = util_ss.apply(config_all, strict: false)
 libqemuutil = static_library('qemuutil',
                              sources: util_ss.sources() + stub_ss.sources() + genh,
-                             dependencies: [util_ss.dependencies(), m, glib, socket])
+                             dependencies: [util_ss.dependencies(), m, glib, socket, malloc])
 qemuutil = declare_dependency(link_with: libqemuutil,
                               sources: genh + version_res)
 
@@ -1442,7 +1463,7 @@ summary_info += {'Install blobs':     config_host.has_key('INSTALL_BLOBS')}
 #  summary_info += {'TCG debug enabled': config_host.has_key('CONFIG_DEBUG_TCG')}
 #  summary_info += {'TCG interpreter':   config_host.has_key('CONFIG_TCG_INTERPRETER')}
 #endif
-summary_info += {'malloc trim support': config_host.has_key('CONFIG_MALLOC_TRIM')}
+summary_info += {'malloc trim support': has_malloc_trim}
 summary_info += {'RDMA support':      config_host.has_key('CONFIG_RDMA')}
 summary_info += {'PVRDMA support':    config_host.has_key('CONFIG_PVRDMA')}
 summary_info += {'fdt support':       config_host.has_key('CONFIG_FDT')}
@@ -1504,8 +1525,7 @@ summary_info += {'lzfse support':     config_host.has_key('CONFIG_LZFSE')}
 summary_info += {'zstd support':      config_host.has_key('CONFIG_ZSTD')}
 summary_info += {'NUMA host support': config_host.has_key('CONFIG_NUMA')}
 summary_info += {'libxml2':           config_host.has_key('CONFIG_LIBXML2')}
-summary_info += {'tcmalloc support':  config_host.has_key('CONFIG_TCMALLOC')}
-summary_info += {'jemalloc support':  config_host.has_key('CONFIG_JEMALLOC')}
+summary_info += {'memory allocator':  get_option('malloc')}
 summary_info += {'avx2 optimization': config_host.has_key('CONFIG_AVX2_OPT')}
 summary_info += {'avx512f optimization': config_host.has_key('CONFIG_AVX512F_OPT')}
 summary_info += {'replication support': config_host.has_key('CONFIG_REPLICATION')}
diff --git a/meson_options.txt b/meson_options.txt
index 543cf70043..894e006799 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -6,6 +6,11 @@ option('docdir', type : 'string', value : 'doc',
 option('gettext', type : 'boolean', value : true,
        description: 'Localization of the GTK+ user interface')
 
+option('malloc_trim', type : 'feature', value : 'auto',
+       description: 'enable libc malloc_trim() for memory optimization')
+option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
+       value: 'system', description: 'choose memory allocator to use')
+
 option('sdl', type : 'feature', value : 'auto',
        description: 'SDL user interface')
 option('sdl_image', type : 'feature', value : 'auto',
-- 
2.26.2


