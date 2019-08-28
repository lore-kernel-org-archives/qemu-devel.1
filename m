Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACA1C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E591217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 20:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E591217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i34RI-0004bk-Az
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i33Xx-0004qP-B9
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i33Xw-0002SR-8l
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:23:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32345)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i33Xw-0002RU-3L
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 15:23:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4B8193061423;
 Wed, 28 Aug 2019 19:23:55 +0000 (UTC)
Received: from localhost (ovpn-116-60.gru2.redhat.com [10.97.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4EC160BEC;
 Wed, 28 Aug 2019 19:23:54 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Date: Wed, 28 Aug 2019 16:23:40 -0300
Message-Id: <20190828192340.14025-3-ehabkost@redhat.com>
In-Reply-To: <20190828192340.14025-1-ehabkost@redhat.com>
References: <20190828192340.14025-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 28 Aug 2019 19:23:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 2/2] configure: more resilient Python version
 capture
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
Cc: Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

The current approach to capture the Python version is fragile, as it
was demonstrated by a very specific build of Python 3 on Fedora 29
that, under non-interactive shells would print multiline version
information.

The (badly) stripped version output would be sent to config-host.mak,
producing bad syntax and rendering the makefiles unusable.  Now, the
Python versions is printed by configure, but only a simple (and better
controlled variable) indicating whether the build system is using
Python 2 is kept on config-host.mak.

Signed-off-by: Cleber Rosa <crosa@redhat.com>

Message-Id: <20190826155832.17427-1-crosa@redhat.com>
Reviewed-by: Tony Nguyen <tony.nguyen@bt.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure              | 5 +++--
 tests/Makefile.include | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index e44e454c43..95134c0180 100755
--- a/configure
+++ b/configure
@@ -1864,7 +1864,7 @@ if ! $python -c 'import sys; sys.exit(sys.version_i=
nfo < (2,7))'; then
 fi
=20
 # Preserve python version since some functionality is dependent on it
-python_version=3D$($python -V 2>&1 | sed -e 's/Python\ //')
+python_version=3D$($python -c 'import sys; print("%d.%d.%d" % (sys.versi=
on_info[0], sys.version_info[1], sys.version_info[2]))' 2>/dev/null)
=20
 # Suppress writing compiled files
 python=3D"$python -B"
@@ -6511,6 +6511,7 @@ if ! $python -c 'import sys; sys.exit(sys.version_i=
nfo < (3,0))'; then
   echo
   echo "warning: Python 2 support is deprecated" >&2
   echo "warning: Python 3 will be required for building future versions =
of QEMU" >&2
+  python2=3D"y"
 fi
=20
 config_host_mak=3D"config-host.mak"
@@ -7333,7 +7334,7 @@ echo "INSTALL_DATA=3D$install -c -m 0644" >> $confi=
g_host_mak
 echo "INSTALL_PROG=3D$install -c -m 0755" >> $config_host_mak
 echo "INSTALL_LIB=3D$install -c -m 0644" >> $config_host_mak
 echo "PYTHON=3D$python" >> $config_host_mak
-echo "PYTHON_VERSION=3D$python_version" >> $config_host_mak
+echo "PYTHON2=3D$python2" >> $config_host_mak
 echo "CC=3D$cc" >> $config_host_mak
 if $iasl -h > /dev/null 2>&1; then
   echo "IASL=3D$iasl" >> $config_host_mak
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 49684fd4f4..f5ac09549c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1135,7 +1135,7 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
 AVOCADO_SHOW=3Dapp
 AVOCADO_TAGS=3D$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARG=
ET_DIRS)))
=20
-ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
+ifneq ($(PYTHON2),y)
 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
 	$(call quiet-command, \
             $(PYTHON) -m venv --system-site-packages $@, \
--=20
2.21.0


