Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBB5C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C77C20848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXRJ7Tg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C77C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTS88-0001gc-T8
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 11:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTS35-0005zH-AR
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 11:53:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51923)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTS32-0004j8-Ul
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 11:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602863620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrKM9bAV/G34kqOgf/xSxB5N0saAIaMYCQ1d0mcCEbs=;
 b=IXRJ7Tg9/pATNE6OuiRKeEQE8icQIwh8Bhqnf8TpBVGwfjYTsoWt+PRE8cu7N1kJcb1CpV
 PVFc3mvF/7yVnrqssLA6sWMcMD+9hF23hVMgEzjR7ZHqu5OAl10h0cjm6htxIUBY2axhPH
 ir3AR5nIThEzp+RxZGiSx1HvnDKQaJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-YVGEN0lZOwWlukp94X_r6w-1; Fri, 16 Oct 2020 11:53:33 -0400
X-MC-Unique: YVGEN0lZOwWlukp94X_r6w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A556084BA67;
 Fri, 16 Oct 2020 15:53:32 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 647C575125;
 Fri, 16 Oct 2020 15:53:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/22] meson: Move the detection logic for sphinx to meson
Date: Fri, 16 Oct 2020 11:53:31 -0400
Message-Id: <20201016155331.1613089-2-pbonzini@redhat.com>
In-Reply-To: <20201016155331.1613089-1-pbonzini@redhat.com>
References: <20201016155331.1613089-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Message-Id: <20201015220626.418-4-luoyonggang@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         | 59 ++++-------------------------------------------
 docs/meson.build  | 46 ++++++++++++++++++++++++++++++++++++
 meson.build       | 30 ++++++++----------------
 meson_options.txt |  4 ++++
 4 files changed, 64 insertions(+), 75 deletions(-)

diff --git a/configure b/configure
index 3edbdd2a24..68f097861d 100755
--- a/configure
+++ b/configure
@@ -297,7 +297,7 @@ brlapi=""
 curl=""
 iconv="auto"
 curses="auto"
-docs=""
+docs="auto"
 fdt="auto"
 netmap="no"
 sdl="auto"
@@ -820,15 +820,6 @@ do
     fi
 done
 
-sphinx_build=
-for binary in sphinx-build-3 sphinx-build
-do
-    if has "$binary"
-    then
-        sphinx_build=$(command -v "$binary")
-        break
-    fi
-done
 
 # Check for ancillary tools used in testing
 genisoimage=
@@ -1228,9 +1219,9 @@ for opt do
   ;;
   --disable-crypto-afalg) crypto_afalg="no"
   ;;
-  --disable-docs) docs="no"
+  --disable-docs) docs="disabled"
   ;;
-  --enable-docs) docs="yes"
+  --enable-docs) docs="enabled"
   ;;
   --disable-vhost-net) vhost_net="no"
   ;;
@@ -4419,45 +4410,6 @@ if check_include linux/btrfs.h ; then
     btrfs=yes
 fi
 
-# If we're making warnings fatal, apply this to Sphinx runs as well
-sphinx_werror=""
-if test "$werror" = "yes"; then
-    sphinx_werror="-W"
-fi
-
-# Check we have a new enough version of sphinx-build
-has_sphinx_build() {
-    # This is a bit awkward but works: create a trivial document and
-    # try to run it with our configuration file (which enforces a
-    # version requirement). This will fail if either
-    # sphinx-build doesn't exist at all or if it is too old.
-    mkdir -p "$TMPDIR1/sphinx"
-    touch "$TMPDIR1/sphinx/index.rst"
-    "$sphinx_build" $sphinx_werror -c "$source_path/docs" \
-                    -b html "$TMPDIR1/sphinx" \
-                    "$TMPDIR1/sphinx/out"  >> config.log 2>&1
-}
-
-# Check if tools are available to build documentation.
-if test "$docs" != "no" ; then
-  if has_sphinx_build; then
-    sphinx_ok=yes
-  else
-    sphinx_ok=no
-  fi
-  if test "$sphinx_ok" = "yes"; then
-    docs=yes
-  else
-    if test "$docs" = "yes" ; then
-      if has $sphinx_build && test "$sphinx_ok" != "yes"; then
-        echo "Warning: $sphinx_build exists but it is either too old or uses too old a Python version" >&2
-      fi
-      feature_not_found "docs" "Install a Python 3 version of python-sphinx"
-    fi
-    docs=no
-  fi
-fi
-
 # Search for bswap_32 function
 byteswap_h=no
 cat > $TMPC << EOF
@@ -6093,9 +6045,6 @@ qemu_version=$(head $source_path/VERSION)
 echo "PKGVERSION=$pkgversion" >>$config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
-if [ "$docs" = "yes" ] ; then
-  echo "BUILD_DOCS=yes" >> $config_host_mak
-fi
 if test "$modules" = "yes"; then
   # $shacmd can generate a hash started with digit, which the compiler doesn't
   # like as an symbol. So prefix it with an underscore
@@ -6784,7 +6733,6 @@ fi
 echo "ROMS=$roms" >> $config_host_mak
 echo "MAKE=$make" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
-echo "SPHINX_BUILD=$sphinx_build" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
@@ -7066,6 +7014,7 @@ NINJA=$ninja $meson setup \
         -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
         -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
         -Diconv=$iconv -Dcurses=$curses -Dlibudev=$libudev\
+        -Ddocs=$docs -Dsphinx_build=$sphinx_build \
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/docs/meson.build b/docs/meson.build
index 0340d489ac..8c222f96bb 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -1,4 +1,50 @@
+if get_option('sphinx_build') == ''
+  sphinx_build = find_program(['sphinx-build-3', 'sphinx-build'],
+                              required: get_option('docs'))
+else
+  sphinx_build = find_program(get_option('sphinx_build'),
+                              required: get_option('docs'))
+endif
+
+# Check if tools are available to build documentation.
+build_docs = false
+if sphinx_build.found()
+  SPHINX_ARGS = [sphinx_build]
+  # If we're making warnings fatal, apply this to Sphinx runs as well
+  if get_option('werror')
+    SPHINX_ARGS += [ '-W' ]
+  endif
+
+  # This is a bit awkward but works: create a trivial document and
+  # try to run it with our configuration file (which enforces a
+  # version requirement). This will fail if sphinx-build is too old.
+  run_command('mkdir', ['-p', tmpdir / 'sphinx'])
+  run_command('touch', [tmpdir / 'sphinx/index.rst'])
+  sphinx_build_test_out = run_command(SPHINX_ARGS + [
+    '-c', meson.current_source_dir(),
+    '-b', 'html', tmpdir / 'sphinx',
+    tmpdir / 'sphinx/out'])
+  build_docs = (sphinx_build_test_out.returncode() == 0)
+
+  if not build_docs
+    warning('@0@ exists but it is either too old or uses too old a Python version'.format(get_option('sphinx_build')))
+    if get_option('docs').enabled()
+      error('Install a Python 3 version of python-sphinx')
+    endif
+  endif
+endif
+
 if build_docs
+  SPHINX_ARGS += ['-Dversion=' + meson.project_version(), '-Drelease=' + config_host['PKGVERSION']]
+
+  sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
+                          meson.source_root() / 'docs/sphinx/hxtool.py',
+                          meson.source_root() / 'docs/sphinx/kerneldoc.py',
+                          meson.source_root() / 'docs/sphinx/kernellog.py',
+                          meson.source_root() / 'docs/sphinx/qapidoc.py',
+                          meson.source_root() / 'docs/sphinx/qmp_lexer.py',
+                          qapi_gen_depends ]
+
   configure_file(output: 'index.html',
                  input: files('index.html.in'),
                  configuration: {'VERSION': meson.project_version()},
diff --git a/meson.build b/meson.build
index 15732f4701..05fb59a00b 100644
--- a/meson.build
+++ b/meson.build
@@ -17,7 +17,13 @@ cc = meson.get_compiler('c')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 enable_modules = 'CONFIG_MODULES' in config_host
 enable_static = 'CONFIG_STATIC' in config_host
-build_docs = 'BUILD_DOCS' in config_host
+
+# Temporary directory used for files created while
+# configure runs. Since it is in the build directory
+# we can safely blow away any previous version of it
+# (and we need not jump through hoops to try to delete
+# it when configure exits.)
+tmpdir = meson.current_build_dir() / 'meson-private/temp'
 
 if get_option('qemu_suffix').startswith('/')
   error('qemu_suffix cannot start with a /')
@@ -1266,22 +1272,6 @@ foreach d : hx_headers
 endforeach
 genh += hxdep
 
-SPHINX_ARGS = [config_host['SPHINX_BUILD'],
-               '-Dversion=' + meson.project_version(),
-               '-Drelease=' + config_host['PKGVERSION']]
-
-if get_option('werror')
-  SPHINX_ARGS += [ '-W' ]
-endif
-
-sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
-                        meson.source_root() / 'docs/sphinx/hxtool.py',
-                        meson.source_root() / 'docs/sphinx/kerneldoc.py',
-                        meson.source_root() / 'docs/sphinx/kernellog.py',
-                        meson.source_root() / 'docs/sphinx/qapidoc.py',
-                        meson.source_root() / 'docs/sphinx/qmp_lexer.py',
-                        qapi_gen_depends ]
-
 ###################
 # Collect sources #
 ###################
@@ -1866,8 +1856,8 @@ endif
 subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
-subdir('tests')
 subdir('docs')
+subdir('tests')
 if 'CONFIG_GTK' in config_host
   subdir('po')
 endif
@@ -1949,7 +1939,7 @@ summary_info += {'QEMU_CFLAGS':       config_host['QEMU_CFLAGS']}
 summary_info += {'QEMU_LDFLAGS':      config_host['QEMU_LDFLAGS']}
 summary_info += {'make':              config_host['MAKE']}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
-summary_info += {'sphinx-build':      config_host['SPHINX_BUILD']}
+summary_info += {'sphinx-build':      sphinx_build.found()}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
 # TODO: add back version
 summary_info += {'slirp support':     slirp_opt == 'disabled' ? false : slirp_opt}
@@ -2017,7 +2007,7 @@ if config_host.has_key('CONFIG_XEN_BACKEND')
   summary_info += {'xen ctrl version':  config_host['CONFIG_XEN_CTRL_INTERFACE_VERSION']}
 endif
 summary_info += {'brlapi support':    config_host.has_key('CONFIG_BRLAPI')}
-summary_info += {'Documentation':     config_host.has_key('BUILD_DOCS')}
+summary_info += {'Documentation':     build_docs}
 summary_info += {'PIE':               get_option('b_pie')}
 summary_info += {'vde support':       config_host.has_key('CONFIG_VDE')}
 summary_info += {'netmap support':    config_host.has_key('CONFIG_NETMAP')}
diff --git a/meson_options.txt b/meson_options.txt
index 77b3fabd00..967229b66e 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -2,7 +2,11 @@ option('qemu_suffix', type : 'string', value: 'qemu',
        description: 'Suffix for QEMU data/modules/config directories (can be empty)')
 option('docdir', type : 'string', value : 'doc',
        description: 'Base directory for documentation installation (can be empty)')
+option('sphinx_build', type : 'string', value : '',
+       description: 'Use specified sphinx-build [$sphinx_build] for building document (default to be empty)')
 
+option('docs', type : 'feature', value : 'auto',
+       description: 'Documentations build support')
 option('gettext', type : 'boolean', value : true,
        description: 'Localization of the GTK+ user interface')
 option('sparse', type : 'feature', value : 'auto',
-- 
2.26.2


