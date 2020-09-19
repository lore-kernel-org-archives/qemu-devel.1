Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1EBC43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EB2208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9Dfw06K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EB2208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfjJ-0007Qs-IY
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHM-0005Tr-UL
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfH8-0007PI-8d
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ff/sHlpb/v/HqEwa96UtAVZ7ovOEkkfSWz1CFz4RXDU=;
 b=Y9Dfw06KSDd49RUKPf+TRfHxrsUnDEuZoZ/sp5BHLk7g9O3UjQmEMg4rPB6dPQ/cdRlQyK
 AfBE3cRTyvZxKAkmwEcMkMMau4uosAWlZ8PAMLqd+Yq/I6/w2PxRyGCezoKrLJksxxK0+h
 OdAH68qKTIF3hpP6Q37DWTSrBNfVl/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-WUaj7XVjPRO_-vj4rE2axg-1; Sat, 19 Sep 2020 11:59:43 -0400
X-MC-Unique: WUaj7XVjPRO_-vj4rE2axg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 780B81074654
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42B2D10016DA
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/57] meson: move libmpathpersist test
Date: Sat, 19 Sep 2020 11:58:51 -0400
Message-Id: <20200919155916.1046398-33-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:03:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the first compiler/linker test that has been moved to Meson.
Add more section headings to keep things clearer.

This also fixes static linking to libmpathpersist, which has a
dependency on libmultipath but no pkg-config file to describe it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         | 77 +++----------------------------------------
 meson.build       | 83 ++++++++++++++++++++++++++++++++++++++++++-----
 meson_options.txt |  2 ++
 3 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/configure b/configure
index 4a7f577f49..7e8c31cafa 100755
--- a/configure
+++ b/configure
@@ -394,7 +394,7 @@ netmap="no"
 sdl="auto"
 sdl_image="auto"
 virtfs=""
-mpath=""
+mpath="auto"
 vnc="enabled"
 sparse="no"
 vde=""
@@ -1109,9 +1109,9 @@ for opt do
   ;;
   --enable-virtfs) virtfs="yes"
   ;;
-  --disable-mpath) mpath="no"
+  --disable-mpath) mpath="disabled"
   ;;
-  --enable-mpath) mpath="yes"
+  --enable-mpath) mpath="enabled"
   ;;
   --disable-vnc) vnc="disabled"
   ;;
@@ -3847,57 +3847,6 @@ if test "$modules" = yes; then
     fi
 fi
 
-##########################################
-# libmpathpersist probe
-
-if test "$mpath" != "no" ; then
-  # probe for the new API
-  cat > $TMPC <<EOF
-#include <libudev.h>
-#include <mpath_persist.h>
-unsigned mpath_mx_alloc_len = 1024;
-int logsink;
-static struct config *multipath_conf;
-extern struct udev *udev;
-extern struct config *get_multipath_config(void);
-extern void put_multipath_config(struct config *conf);
-struct udev *udev;
-struct config *get_multipath_config(void) { return multipath_conf; }
-void put_multipath_config(struct config *conf) { }
-
-int main(void) {
-    udev = udev_new();
-    multipath_conf = mpath_lib_init();
-    return 0;
-}
-EOF
-  if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
-    mpathpersist=yes
-    mpathpersist_new_api=yes
-  else
-    # probe for the old API
-    cat > $TMPC <<EOF
-#include <libudev.h>
-#include <mpath_persist.h>
-unsigned mpath_mx_alloc_len = 1024;
-int logsink;
-int main(void) {
-    struct udev *udev = udev_new();
-    mpath_lib_init(udev);
-    return 0;
-}
-EOF
-    if compile_prog "" "-ludev -lmultipath -lmpathpersist" ; then
-      mpathpersist=yes
-      mpathpersist_new_api=no
-    else
-      mpathpersist=no
-    fi
-  fi
-else
-  mpathpersist=no
-fi
-
 ##########################################
 # pthread probe
 PTHREADLIBS_LIST="-pthread -lpthread -lpthreadGC2"
@@ -6339,23 +6288,11 @@ if test "$softmmu" = yes ; then
       fi
       virtfs=no
     fi
-    if test "$mpath" != no && test "$mpathpersist" = yes ; then
-      mpath=yes
-    else
-      if test "$mpath" = yes; then
-        error_exit "Multipath requires libmpathpersist devel"
-      fi
-      mpath=no
-    fi
   else
     if test "$virtfs" = yes; then
       error_exit "VirtFS is supported only on Linux"
     fi
     virtfs=no
-    if test "$mpath" = yes; then
-      error_exit "Multipath is supported only on Linux"
-    fi
-    mpath=no
   fi
 fi
 
@@ -6896,12 +6833,6 @@ fi
 if test "$virtfs" = "yes" ; then
   echo "CONFIG_VIRTFS=y" >> $config_host_mak
 fi
-if test "$mpath" = "yes" ; then
-  echo "CONFIG_MPATH=y" >> $config_host_mak
-  if test "$mpathpersist_new_api" = "yes"; then
-    echo "CONFIG_MPATH_NEW_API=y" >> $config_host_mak
-  fi
-fi
 if test "$vhost_scsi" = "yes" ; then
   echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
 fi
@@ -7992,7 +7923,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
-	-Dsdl=$sdl -Dsdl_image=$sdl_image \
+	-Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
         $cross_arg \
diff --git a/meson.build b/meson.build
index 11213b6e8b..4d617d7561 100644
--- a/meson.build
+++ b/meson.build
@@ -86,6 +86,14 @@ if 'SPARSE_CFLAGS' in config_host
                        'compile_commands.json'])
 endif
 
+###########################################
+# Target-specific checks and dependencies #
+###########################################
+
+if targetos != 'linux' and get_option('mpath').enabled()
+  error('Multipath is supported only on Linux')
+endif
+
 m = cc.find_library('m', required: false)
 util = cc.find_library('util', required: false)
 winmm = []
@@ -117,6 +125,11 @@ elif targetos == 'haiku'
             cc.find_library('network'),
             cc.find_library('bsd')]
 endif
+
+################
+# Dependencies #
+################
+
 # The path to glib.h is added to all compilation commands.  This was
 # grandfathered in from the QEMU Makefiles.
 add_project_arguments(config_host['GLIB_CFLAGS'].split(),
@@ -223,10 +236,6 @@ if 'CONFIG_SPICE' in config_host
                              link_args: config_host['SPICE_LIBS'].split())
 endif
 rt = cc.find_library('rt', required: false)
-libmpathpersist = not_found
-if config_host.has_key('CONFIG_MPATH')
-  libmpathpersist = cc.find_library('mpathpersist')
-endif
 libdl = not_found
 if 'CONFIG_PLUGIN' in config_host
   libdl = cc.find_library('dl', required: true)
@@ -257,9 +266,65 @@ if 'CONFIG_CURL' in config_host
                             link_args: config_host['CURL_LIBS'].split())
 endif
 libudev = not_found
-if target_os == 'linux'
-  libudev = dependency('libudev', static: enable_static)
+if targetos == 'linux'
+  libudev = dependency('libudev',
+                       required: get_option('mpath').enabled(),
+                       static: enable_static)
+endif
+
+mpathpersist = not_found
+mpathpersist_new_api = false
+if targetos == 'linux' and not get_option('mpath').disabled()
+  mpath_test_source_new = '''
+    #include <libudev.h>
+    #include <mpath_persist.h>
+    unsigned mpath_mx_alloc_len = 1024;
+    int logsink;
+    static struct config *multipath_conf;
+    extern struct udev *udev;
+    extern struct config *get_multipath_config(void);
+    extern void put_multipath_config(struct config *conf);
+    struct udev *udev;
+    struct config *get_multipath_config(void) { return multipath_conf; }
+    void put_multipath_config(struct config *conf) { }
+    int main(void) {
+        udev = udev_new();
+        multipath_conf = mpath_lib_init();
+        return 0;
+    }'''
+  mpath_test_source_old = '''
+      #include <libudev.h>
+      #include <mpath_persist.h>
+      unsigned mpath_mx_alloc_len = 1024;
+      int logsink;
+      int main(void) {
+          struct udev *udev = udev_new();
+          mpath_lib_init(udev);
+          return 0;
+      }'''
+  libmultipath = cc.find_library('multipath',
+                                 required: get_option('mpath'),
+                                 static: enable_static)
+  libmpathpersist = cc.find_library('mpathpersist',
+                                    required: get_option('mpath'),
+                                    static: enable_static)
+  if libmultipath.found() and libmpathpersist.found() and libudev.found()
+    mpathlibs = [libmultipath, libmpathpersist, libudev]
+    if cc.links(mpath_test_source_new, dependencies: mpathlibs)
+      mpathpersist = declare_dependency(dependencies: mpathlibs)
+      mpathpersist_new_api = true
+    elif cc.links(mpath_test_source_old, dependencies: mpathlibs)
+      mpathpersist = declare_dependency(dependencies: mpathlibs)
+    else
+      if get_option('mpath').enabled()
+        error('Cannot detect libmpathpersist API')
+      else
+        warning('Cannot detect libmpathpersist API, disabling')
+      endif
+    endif
+  endif
 endif
+
 brlapi = not_found
 if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
@@ -447,6 +512,8 @@ has_gettid = cc.has_function('gettid')
 # Create config-host.h
 
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
+config_host_data.set('CONFIG_MPATH', mpathpersist.found())
+config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
@@ -1196,7 +1263,7 @@ if have_tools
 
     executable('qemu-pr-helper', files('scsi/qemu-pr-helper.c', 'scsi/utils.c'),
                dependencies: [authz, crypto, io, qom, qemuutil,
-                              libcap_ng, libudev, libmpathpersist],
+                              libcap_ng, mpathpersist],
                install: true)
   endif
 
@@ -1418,7 +1485,7 @@ summary_info += {'Audio drivers':     config_host['CONFIG_AUDIO_DRIVERS']}
 summary_info += {'Block whitelist (rw)': config_host['CONFIG_BDRV_RW_WHITELIST']}
 summary_info += {'Block whitelist (ro)': config_host['CONFIG_BDRV_RO_WHITELIST']}
 summary_info += {'VirtFS support':    config_host.has_key('CONFIG_VIRTFS')}
-summary_info += {'Multipath support': config_host.has_key('CONFIG_MPATH')}
+summary_info += {'Multipath support': mpathpersist.found()}
 summary_info += {'VNC support':       vnc.found()}
 if vnc.found()
   summary_info += {'VNC SASL support':  sasl.found()}
diff --git a/meson_options.txt b/meson_options.txt
index 543cf70043..b38a6ae92a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -6,6 +6,8 @@ option('docdir', type : 'string', value : 'doc',
 option('gettext', type : 'boolean', value : true,
        description: 'Localization of the GTK+ user interface')
 
+option('mpath', type : 'feature', value : 'auto',
+       description: 'Multipath persistent reservation passthrough')
 option('sdl', type : 'feature', value : 'auto',
        description: 'SDL user interface')
 option('sdl_image', type : 'feature', value : 'auto',
-- 
2.26.2



