Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280FFC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D628F227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHvi9t3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D628F227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvAm-0000xs-Li
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihurh-0000Eq-HS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihurf-0001vM-NQ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36087
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihurf-0001sB-Bw
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2IFmOVEohUjR3HLNvRqKGi19CA29/Dw84gjDW537l4=;
 b=cHvi9t3WUhIZMMio0X3KjPFvfVAau0Vijm+amZBeMgnaD+4qMOsw0pCllXGDpDH6uR0KoB
 6fAp5fjIvwK0w0ebDAdWZwV56B0TRKiiK6QEhaOz/s/M4nRIT5VX3omCwA6acExOMu97O2
 Ux44zu0xBGS5/ctn7FcO9pGiQw5FeXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-VkA9dLnjPOChJ9wLk0P6xg-1; Thu, 19 Dec 2019 07:25:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02F82477
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:08 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D7E060C18;
 Thu, 19 Dec 2019 12:25:06 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 116/132] meson: sphinx-build
Date: Thu, 19 Dec 2019 13:23:36 +0100
Message-Id: <1576758232-12439-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: VkA9dLnjPOChJ9wLk0P6xg-1
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
 Makefile         | 56 +-----------------------------------------
 docs/meson.build | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 meson.build      |  2 ++
 3 files changed, 78 insertions(+), 55 deletions(-)
 create mode 100644 docs/meson.build

diff --git a/Makefile b/Makefile
index f2152ce..d60a0c9 100644
--- a/Makefile
+++ b/Makefile
@@ -224,22 +224,6 @@ dist: qemu-$(VERSION).tar.bz2
 qemu-%.tar.bz2:
 =09$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.b=
z2,%,$@)"
=20
-# Sphinx does not allow building manuals into the same directory as
-# the source files, so if we're doing an in-tree QEMU build we must
-# build the manuals into a subdirectory (and then install them from
-# there for 'make install'). For an out-of-tree build we can just
-# use the docs/ subdirectory in the build tree as normal.
-ifeq ($(realpath $(SRC_PATH)),$(realpath .))
-MANUAL_BUILDDIR :=3D docs/built
-else
-MANUAL_BUILDDIR :=3D docs
-endif
-
-define clean-manual =3D
-rm -rf $(MANUAL_BUILDDIR)/$1/_static
-rm -f $(MANUAL_BUILDDIR)/$1/objects.inv $(MANUAL_BUILDDIR)/$1/searchindex.=
js $(MANUAL_BUILDDIR)/$1/*.html
-endef
-
 distclean: clean
 =09rm -f config-host.mak config-host.h* config-host.ld $(DOCS) qemu-option=
s.texi qemu-img-cmds.texi qemu-monitor.texi qemu-monitor-info.texi
 =09rm -f tests/tcg/config-*.mak
@@ -260,10 +244,6 @@ distclean: clean
 =09rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
 =09rm -f docs/qemu-block-drivers.7
 =09rm -f docs/qemu-cpu-models.7
-=09rm -rf .doctrees
-=09$(call clean-manual,devel)
-=09$(call clean-manual,interop)
-=09$(call clean-manual,specs)
 =09rm -Rf .sdk
 =09if test -f dtc/version_gen.h; then $(MAKE) $(DTC_MAKE_ARGS) clean; fi
=20
@@ -303,21 +283,7 @@ BLOBS=3D
 DESCS=3D
 endif
=20
-# Note that we manually filter-out the non-Sphinx documentation which
-# is currently built into the docs/interop directory in the build tree.
-define install-manual =3D
-for d in $$(cd $(MANUAL_BUILDDIR) && find $1 -type d); do $(INSTALL_DIR) "=
$(DESTDIR)$(qemu_docdir)/$$d"; done
-for f in $$(cd $(MANUAL_BUILDDIR) && find $1 -type f -a '!' '(' -name 'qem=
u-*-qapi.*' -o -name 'qemu-*-ref.*' ')' ); do $(INSTALL_DATA) "$(MANUAL_BUI=
LDDIR)/$$f" "$(DESTDIR)$(qemu_docdir)/$$f"; done
-endef
-
-# Note that we deliberately do not install the "devel" manual: it is
-# for QEMU developers, and not interesting to our users.
-.PHONY: install-sphinxdocs
-install-sphinxdocs: sphinxdocs
-=09$(call install-manual,interop)
-=09$(call install-manual,specs)
-
-install-doc: $(DOCS) install-sphinxdocs
+install-doc: $(DOCS)
 =09$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
 =09$(INSTALL_DATA) qemu-doc.html "$(DESTDIR)$(qemu_docdir)"
 =09$(INSTALL_DATA) qemu-doc.txt "$(DESTDIR)$(qemu_docdir)"
@@ -458,26 +424,6 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
 %.pdf: %.texi docs/version.texi
 =09$(call quiet-command,texi2pdf $(TEXI2PDFFLAGS) $< -o $@,"GEN","$@")
=20
-# Sphinx builds all its documentation at once in one invocation
-# and handles "don't rebuild things unless necessary" itself.
-# The '.doctrees' files are cached information to speed this up.
-.PHONY: sphinxdocs
-sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop=
/index.html $(MANUAL_BUILDDIR)/specs/index.html
-
-# Canned command to build a single manual
-build-manual =3D $(call quiet-command,sphinx-build $(if $(V),,-q) -W -n -b=
 html -D version=3D$(VERSION) -D release=3D"$(FULL_VERSION)" -d .doctrees/$=
1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$=
1")
-# We assume all RST files in the manual's directory are used in it
-manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/=
conf.py $(SRC_PATH)/docs/conf.py
-
-$(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
-=09$(call build-manual,devel)
-
-$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
-=09$(call build-manual,interop)
-
-$(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
-=09$(call build-manual,specs)
-
 docs/interop/qemu-qmp-qapi.texi: qapi/qapi-doc.texi
 =09@cp -p $< $@
=20
diff --git a/docs/meson.build b/docs/meson.build
new file mode 100644
index 0000000..8680aaa
--- /dev/null
+++ b/docs/meson.build
@@ -0,0 +1,75 @@
+sphinx =3D find_program('sphinx-build', required: build_docs)
+
+if sphinx.found()
+  devel_rst =3D [
+    'devel/decodetree.rst',
+    'devel/index.rst',
+    'devel/kconfig.rst',
+    'devel/loads-stores.rst',
+    'devel/memory.rst',
+    'devel/migration.rst',
+    'devel/secure-coding-practices.rst',
+    'devel/stable-process.rst',
+    'devel/tcg.rst',
+    'devel/testing.rst',
+  ]
+  devel =3D custom_target('sphinx-devel',
+                build_by_default: build_docs,
+                input: devel_rst,
+                depend_files: [files('conf.py', 'devel/conf.py')],
+                output: 'devel',
+                command: [sphinx, '-W', '-n', '-b', 'html', '-q',
+                          '-Dversion=3D' + config_host['VERSION'],
+                          '-Drelease=3D' + config_host['PKGVERSION'],
+                          meson.current_source_dir() / 'devel',
+                          '@OUTPUT@',
+                         ])
+
+  interop_rst =3D [
+    'interop/bitmaps.rst',
+    'interop/index.rst',
+    'interop/live-block-operations.rst',
+    'interop/pr-helper.rst',
+    'interop/vhost-user-gpu.rst',
+    'interop/vhost-user.rst',
+  ]
+  interop =3D custom_target('sphinx-interop',
+                build_by_default: build_docs,
+                input: interop_rst,
+                depend_files: [files('conf.py', 'interop/conf.py')],
+                output: 'interop',
+                command: [sphinx, '-W', '-n', '-b', 'html', '-q',
+                          '-Dversion=3D' + config_host['VERSION'],
+                          '-Drelease=3D' + config_host['PKGVERSION'],
+                          meson.current_source_dir() / 'interop',
+                          '@OUTPUT@',
+                         ])
+  if build_docs
+    install_subdir(meson.current_build_dir() / 'interop',
+                   install_dir: config_host['qemu_docdir'],
+                   exclude_directories: '.doctrees')
+  endif
+
+  specs_rst =3D [
+    'specs/index.rst',
+    'specs/ppc-spapr-xive.rst',
+    'specs/ppc-xive.rst',
+  ]
+  specs =3D custom_target('sphinx-specs',
+                input: specs_rst,
+                depend_files: [files('conf.py', 'specs/conf.py')],
+                output: 'specs',
+                command: [sphinx, '-W', '-n', '-b', 'html', '-q',
+                          '-Dversion=3D' + config_host['VERSION'],
+                          '-Drelease=3D' + config_host['PKGVERSION'],
+                          meson.current_source_dir() / 'specs',
+                          '@OUTPUT@',
+                         ])
+  if build_docs
+    install_subdir(meson.current_build_dir() / 'specs',
+                   install_dir: config_host['qemu_docdir'],
+                   exclude_directories: '.doctrees')
+  endif
+
+  sphinxdocs =3D alias_target('sphinxdocs', devel, interop, specs)
+endif
diff --git a/meson.build b/meson.build
index 55ccb79..5b4b472 100644
--- a/meson.build
+++ b/meson.build
@@ -7,6 +7,7 @@ config_host =3D kconfig.load(meson.current_build_dir() / 'c=
onfig-host.mak')
 config_all_disas =3D kconfig.load(meson.current_build_dir() / 'config-all-=
disas.mak')
=20
 enable_modules =3D 'CONFIG_MODULES' in config_host
+build_docs =3D 'BUILD_DOCS' in config_host
=20
 add_project_arguments(config_host['CFLAGS'].split(),
                       language: ['c', 'objc'])
@@ -923,3 +924,4 @@ if have_tools
 endif
=20
 subdir('pc-bios')
+subdir('docs')
--=20
1.8.3.1



