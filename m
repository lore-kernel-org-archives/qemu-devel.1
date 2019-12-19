Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB143C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D0B222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbjaZdCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D0B222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv4G-0000Lo-IT
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:38:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurZ-0008Se-4Z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurX-0001Bi-9b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:04 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurX-00019x-2r
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNyIVA4SPkztD/cV2RluZ5XY7kMDeBqg3trG/yvw3YM=;
 b=hbjaZdCdSeebenAUWPdt7Bd+ExsIuoGk4d0CKw9qmdOZEkadQpESv9cyhVy81T/3Et7jC3
 6Oa45ArYQ7A+A2DjqaBWQHp6lKhfdLoREPByJd4h5gSFkrwGOXKxQhwEAsudxbOB8Xk1vs
 NOtXr5jBzlLXyGU7uNlf4hvqIcHPP0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-X5YTZIzSPUKy6FREHGfAMQ-1; Thu, 19 Dec 2019 07:24:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38A2510054E3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:24:55 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0503860C81;
 Thu, 19 Dec 2019 12:24:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 110/132] meson: cpu-emu
Date: Thu, 19 Dec 2019 13:23:30 +0100
Message-Id: <1576758232-12439-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: X5YTZIzSPUKy6FREHGfAMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target         | 12 ------------
 configure               |  6 ++++++
 meson.build             | 28 ++++++++++++++++++++++++++++
 scripts/feature_to_c.sh | 24 ++++++++----------------
 4 files changed, 42 insertions(+), 28 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 0eca5f8..7b5b254 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -108,15 +108,6 @@ obj-y +=3D $(LIBQEMU)
 obj-y +=3D trace/
=20
 #########################################################
-# cpu emulator library
-obj-y +=3D exec.o
-obj-$(CONFIG_TCG) +=3D tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-=
gvec.o
-obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o tcg/optimize.o
-obj-$(CONFIG_TCG_INTERPRETER) +=3D tcg/tci.o
-obj-$(CONFIG_TCG_INTERPRETER) +=3D disas/tci.o
-obj-$(CONFIG_TCG) +=3D fpu/softfloat.o
-obj-y +=3D disas.o
-obj-$(call notempty,$(TARGET_XML_FILES)) +=3D gdbstub-xml.o
 LIBS :=3D $(libs_cpu) $(LIBS)
=20
 #########################################################
@@ -199,9 +190,6 @@ ifdef CONFIG_DARWIN
 =09$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
 endif
=20
-gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
-=09$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_t=
o_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
-
 clean: clean-target
 =09rm -f *.a *~ $(PROGS)
 =09rm -f $(shell find . -name '*.[od]')
diff --git a/configure b/configure
index c53df48..ad36082 100755
--- a/configure
+++ b/configure
@@ -5034,9 +5034,13 @@ case "$capstone" in
       LIBCAPSTONE=3Dlibcapstone.a
     fi
     libs_cpu=3D"-L$PWD/capstone -lcapstone $libs_cpu"
+    capstone_libs=3D"-L$PWD/capstone -lcapstone"
+    capstone_cflags=3D"-I${source_path}/capstone/include"
     ;;
=20
   system)
+    capstone_libs=3D"$($pkg_config --libs capstone)"
+    capstone_cflags=3D"$($pkg_config --cflags capstone)"
     QEMU_CFLAGS=3D"$QEMU_CFLAGS $($pkg_config --cflags capstone)"
     libs_cpu=3D"$($pkg_config --libs capstone) $libs_cpu"
     ;;
@@ -7230,6 +7234,8 @@ if test "$ivshmem" =3D "yes" ; then
 fi
 if test "$capstone" !=3D "no" ; then
   echo "CONFIG_CAPSTONE=3Dy" >> $config_host_mak
+  echo "CAPSTONE_CFLAGS=3D$capstone_cflags" >> $config_host_mak
+  echo "CAPSTONE_LIBS=3D$capstone_libs" >> $config_host_mak
 fi
 if test "$debug_mutex" =3D "yes" ; then
   echo "CONFIG_DEBUG_MUTEX=3Dy" >> $config_host_mak
diff --git a/meson.build b/meson.build
index 31c9591..6f2c838 100644
--- a/meson.build
+++ b/meson.build
@@ -319,6 +319,11 @@ if 'CONFIG_USB_LIBUSB' in config_host
   libusb =3D declare_dependency(compile_args: config_host['LIBUSB_CFLAGS']=
.split(),
                               link_args: config_host['LIBUSB_LIBS'].split(=
))
 endif
+capstone =3D declare_dependency()
+if 'CONFIG_CAPSTONE' in config_host
+  capstone =3D declare_dependency(compile_args: config_host['CAPSTONE_CFLA=
GS'].split(),
+                                link_args: config_host['CAPSTONE_LIBS'].sp=
lit())
+endif
=20
 create_config =3D find_program('scripts/create_config')
 minikconf =3D find_program('scripts/minikconf.py')
@@ -481,6 +486,18 @@ hw_arch =3D {}
 target_arch =3D {}
 target_softmmu_arch =3D {}
=20
+specific_ss.add(files('disas.c', 'exec.c'), capstone)
+specific_ss.add(when: 'CONFIG_TCG', if_true: files(
+  'fpu/softfloat.c',
+  'tcg/optimize.c',
+  'tcg/tcg-common.c',
+  'tcg/tcg-op-gvec.c',
+  'tcg/tcg-op-vec.c',
+  'tcg/tcg-op.c',
+  'tcg/tcg.c',
+))
+specific_ss.add(when: 'CONFIG_TCG_INTERPRETER', if_true: files('disas/tci.=
c', 'tcg/tci.c'))
+
 # TODO: add each directory to the subdirs from its own meson.build, once
 # we have those
 trace_events_subdirs =3D [
@@ -717,6 +734,8 @@ common_all =3D static_library('common',
                             dependencies: common_all.dependencies(),
                             name_suffix: 'fa')
=20
+feature_to_c =3D find_program('scripts/feature_to_c.sh')
+
 foreach target : target_dirs
   config_target =3D target_config[target]
   target_name =3D config_target['TARGET_NAME']
@@ -762,6 +781,15 @@ foreach target : target_dirs
     endif
   endif
=20
+  if 'TARGET_XML_FILES' in config_target
+    gdbstub_xml =3D custom_target(target + '-gdbstub-xml.c',
+                                output: target + '-gdbstub-xml.c',
+                                input: files(config_target['TARGET_XML_FIL=
ES'].split()),
+                                command: [feature_to_c, '@INPUT@'],
+                                capture: true)
+    arch_srcs +=3D gdbstub_xml
+  endif
+
   t =3D target_arch[arch].apply(config_target, strict: false)
   arch_srcs +=3D t.sources()
   arch_deps +=3D t.dependencies()
diff --git a/scripts/feature_to_c.sh b/scripts/feature_to_c.sh
index c8ce9b8..b116989 100644
--- a/scripts/feature_to_c.sh
+++ b/scripts/feature_to_c.sh
@@ -19,16 +19,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, see <http://www.gnu.org/licenses/>.
=20
-output=3D$1
-shift
-
-if test -z "$output" || test -z "$1"; then
-  echo "Usage: $0 OUTPUTFILE INPUTFILE..."
-  exit 1
-fi
-
-if test -e "$output"; then
-  echo "Output file \"$output\" already exists; refusing to overwrite."
+if test -z "$1"; then
+  echo "Usage: $0 INPUTFILE..."
   exit 1
 fi
=20
@@ -60,17 +52,17 @@ for input; do
       printf "'\''\\n'\'', \n"
     } END {
       print "  0 };"
-    }' < $input >> $output
+    }' < $input
 done
=20
-echo >> $output
-echo "const char *const xml_builtin[][2] =3D {" >> $output
+echo
+echo "const char *const xml_builtin[][2] =3D {"
=20
 for input; do
   basename=3D$(echo $input | sed 's,.*/,,')
   arrayname=3Dxml_feature_$(echo $input | sed 's,.*/,,; s/[-.]/_/g')
-  echo "  { \"$basename\", $arrayname }," >> $output
+  echo "  { \"$basename\", $arrayname },"
 done
=20
-echo "  { (char *)0, (char *)0 }" >> $output
-echo "};" >> $output
+echo "  { (char *)0, (char *)0 }"
+echo "};"
--=20
1.8.3.1



