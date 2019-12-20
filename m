Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4852AC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110FD20866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyl/WUeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110FD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLbE-0005TR-5L
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iiLVU-0005vr-Sm
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iiLVT-0005b6-JO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:52:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iiLVT-0005aR-El
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576860723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZO3A9x6Z5IrKB672Yanf42gW4KGAYB1T2LPZ+UvO970=;
 b=fyl/WUeYoL43GW4j+6CZt88w/mb2+Gop6hnmr8g4XtzmWtZftc5ES7OQm8eV3nUtQ+vtLV
 u+HuYo+0TdKh4Xb73oWb6ofx+lA1vMWFdNexMJHkZnU5axbQJR2L06TOQgUPCTEWMfZxA7
 0uFBfpfoKguilR3K4lo/dyxB/4CT584=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-b66nyt8LPYieU_6GNcOOEw-1; Fri, 20 Dec 2019 11:52:00 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D16C18B9FD3;
 Fri, 20 Dec 2019 16:51:59 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2D906F12E;
 Fri, 20 Dec 2019 16:51:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/2] configure: Require Python >= 3.5
Date: Fri, 20 Dec 2019 13:51:41 -0300
Message-Id: <20191220165141.2207058-3-ehabkost@redhat.com>
In-Reply-To: <20191220165141.2207058-1-ehabkost@redhat.com>
References: <20191220165141.2207058-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: b66nyt8LPYieU_6GNcOOEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Python 3.5 is the oldest Python version available on our
supported build platforms, and Python 2 end of life will be 3
weeks after the planned release date of QEMU 4.2.0.  Drop Python
2 support from configure completely, and require Python 3.5 or
newer.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20191016224237.26180-1-ehabkost@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure              | 18 ++++--------------
 tests/Makefile.include |  5 -----
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index 940bf9e87a..747d3b4120 100755
--- a/configure
+++ b/configure
@@ -903,9 +903,9 @@ fi
 : ${install=3D${INSTALL-install}}
 # We prefer python 3.x. A bare 'python' is traditionally
 # python 2.x, but some distros have it as python 3.x, so
-# we check that before python2
+# we check that too
 python=3D
-for binary in "${PYTHON-python3}" python python2
+for binary in "${PYTHON-python3}" python
 do
     if has "$binary"
     then
@@ -1842,8 +1842,8 @@ fi
=20
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
-  error_exit "Cannot use '$python', Python 2 >=3D 2.7 or Python 3 is requi=
red." \
+if ! $python -c 'import sys; sys.exit(sys.version_info < (3,5))'; then
+  error_exit "Cannot use '$python', Python >=3D 3.5 is required." \
       "Use --python=3D/path/to/python to specify a supported Python."
 fi
=20
@@ -6594,15 +6594,6 @@ if test "$supported_os" =3D "no"; then
     echo "us upstream at qemu-devel@nongnu.org."
 fi
=20
-# Note that if the Python conditional here evaluates True we will exit
-# with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (3,0))'; then
-  echo
-  echo "warning: Python 2 support is deprecated" >&2
-  echo "warning: Python 3 will be required for building future versions of=
 QEMU" >&2
-  python2=3D"y"
-fi
-
 config_host_mak=3D"config-host.mak"
=20
 echo "# Automatically generated by configure - do not modify" >config-all-=
disas.mak
@@ -7447,7 +7438,6 @@ echo "INSTALL_DATA=3D$install -c -m 0644" >> $config_=
host_mak
 echo "INSTALL_PROG=3D$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=3D$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=3D$python" >> $config_host_mak
-echo "PYTHON2=3D$python2" >> $config_host_mak
 echo "CC=3D$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=3D$iasl" >> $config_host_mak
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 31b86674e5..9146e1bdee 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1157,7 +1157,6 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
 AVOCADO_SHOW=3Dapp
 AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARGET=
_DIRS)))
=20
-ifneq ($(PYTHON2),y)
 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
 =09$(call quiet-command, \
             $(PYTHON) -m venv --system-site-packages $@, \
@@ -1166,10 +1165,6 @@ $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
             $(TESTS_VENV_DIR)/bin/python -m pip -q install -r $(TESTS_VENV=
_REQ), \
             PIP, $(TESTS_VENV_REQ))
 =09$(call quiet-command, touch $@)
-else
-$(TESTS_VENV_DIR):
-=09$(error "venv directory for tests requires Python 3")
-endif
=20
 $(TESTS_RESULTS_DIR):
 =09$(call quiet-command, mkdir -p $@, \
--=20
2.23.0


