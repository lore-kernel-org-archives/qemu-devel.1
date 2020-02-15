Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F8EC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5985C20726
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 11:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TImihfZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5985C20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2vu1-0005LL-Gk
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 06:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j2vpQ-0004Uh-JM
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j2vpP-0006sU-0o
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j2vpO-0006rt-TY
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 06:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581766902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MTi811OZPphFyRl+nqaKLSWPFjQnN/zzcKcbYOqLX90=;
 b=TImihfZIaFOdPNSSXk5EUhMAO2Z/YSvCKkmWb5rd2z+qgJzkna6zXTX9lQENjrZZBecIPU
 qL0HTx527Mtn30JHh1xTToX6ka6ZplFbVYULctJF8Btiwucl6k1rhLWfz4JXyhgGsqZywT
 7ados3v6OHf0ybDSmhLhCDSoVvvA1y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-lUyXGWLLNIK9QwdDok1NUw-1; Sat, 15 Feb 2020 06:41:38 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66E5018B5F69;
 Sat, 15 Feb 2020 11:41:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A336E1001DEF;
 Sat, 15 Feb 2020 11:41:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 20BC911366C3; Sat, 15 Feb 2020 12:41:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/18] configure: Allow user to specify sphinx-build binary
Date: Sat, 15 Feb 2020 12:41:17 +0100
Message-Id: <20200215114133.15097-3-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
References: <20200215114133.15097-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: lUyXGWLLNIK9QwdDok1NUw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Currently we insist on using 'sphinx-build' from the $PATH;
allow the user to specify the binary to use. This will be
more useful as we become pickier about the capabilities
we require (eg needing a Python 3 sphinx-build).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200213175647.17628-2-peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 configure | 10 +++++++++-
 Makefile  |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 16f94cd96b..14172909f0 100755
--- a/configure
+++ b/configure
@@ -584,6 +584,7 @@ query_pkg_config() {
 }
 pkg_config=3Dquery_pkg_config
 sdl2_config=3D"${SDL2_CONFIG-${cross_prefix}sdl2-config}"
+sphinx_build=3Dsphinx-build
=20
 # If the user hasn't specified ARFLAGS, default to 'rv', just as make does=
.
 ARFLAGS=3D"${ARFLAGS-rv}"
@@ -975,6 +976,8 @@ for opt do
   ;;
   --python=3D*) python=3D"$optarg"
   ;;
+  --sphinx-build=3D*) sphinx_build=3D"$optarg"
+  ;;
   --gcov=3D*) gcov_tool=3D"$optarg"
   ;;
   --smbd=3D*) smbd=3D"$optarg"
@@ -1677,6 +1680,7 @@ Advanced options (experts only):
   --make=3DMAKE              use specified make [$make]
   --install=3DINSTALL        use specified install [$install]
   --python=3DPYTHON          use specified python [$python]
+  --sphinx-build=3DSPHINX    use specified sphinx-build [$sphinx_build]
   --smbd=3DSMBD              use specified smbd [$smbd]
   --with-git=3DGIT           use specified git [$git]
   --static                 enable static build [$static]
@@ -4799,7 +4803,7 @@ has_sphinx_build() {
     # sphinx-build doesn't exist at all or if it is too old.
     mkdir -p "$TMPDIR1/sphinx"
     touch "$TMPDIR1/sphinx/index.rst"
-    sphinx-build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDIR=
1/sphinx/out" >/dev/null 2>&1
+    $sphinx_build -c "$source_path/docs" -b html "$TMPDIR1/sphinx" "$TMPDI=
R1/sphinx/out" >/dev/null 2>&1
 }
=20
 # Check if tools are available to build documentation.
@@ -6474,6 +6478,9 @@ echo "QEMU_LDFLAGS      $QEMU_LDFLAGS"
 echo "make              $make"
 echo "install           $install"
 echo "python            $python ($python_version)"
+if test "$docs" !=3D "no"; then
+    echo "sphinx-build      $sphinx_build"
+fi
 echo "slirp support     $slirp $(echo_version $slirp $slirp_version)"
 if test "$slirp" !=3D "no" ; then
     echo "smbd              $smbd"
@@ -7506,6 +7513,7 @@ echo "INSTALL_DATA=3D$install -c -m 0644" >> $config_=
host_mak
 echo "INSTALL_PROG=3D$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=3D$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=3D$python" >> $config_host_mak
+echo "SPHINX_BUILD=3D$sphinx_build" >> $config_host_mak
 echo "CC=3D$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=3D$iasl" >> $config_host_mak
diff --git a/Makefile b/Makefile
index f0e1a2fc1d..430bbad055 100644
--- a/Makefile
+++ b/Makefile
@@ -1030,7 +1030,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html \
 # Note the use of different doctree for each (manual, builder) tuple;
 # this works around Sphinx not handling parallel invocation on
 # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
-build-manual =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" sphinx-b=
uild $(if $(V),,-q) -W -b $2 -D version=3D$(VERSION) -D release=3D"$(FULL_V=
ERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPH=
INX","$(MANUAL_BUILDDIR)/$1")
+build-manual =3D $(call quiet-command,CONFDIR=3D"$(qemu_confdir)" $(SPHINX=
_BUILD) $(if $(V),,-q) -W -b $2 -D version=3D$(VERSION) -D release=3D"$(FUL=
L_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"=
SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps =3D $(wildcard $(SRC_PATH)/docs/$1/*.rst) \
               $(wildcard $(SRC_PATH)/docs/$1/*.rst.inc) \
--=20
2.21.1


