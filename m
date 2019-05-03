Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450EDC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD332070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 00:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD332070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60507 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMMKs-00070X-64
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 20:45:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGr-0003a5-Sl
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hMMGq-0006lE-NZ
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hMMGq-0006kt-Db
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:41:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B906C3082E60;
	Fri,  3 May 2019 00:41:47 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 45DF35D9C4;
	Fri,  3 May 2019 00:41:47 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Date: Thu,  2 May 2019 21:41:16 -0300
Message-Id: <20190503004130.8285-6-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
References: <20190503004130.8285-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 03 May 2019 00:41:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/19] tests/acceptance: use "arch:" tag to
 filter target specific tests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190503004116.zZULGwOlnaCCD2R3QBndXQRFIiF1JT-A05ED_Go7qLc@z>

From: Cleber Rosa <crosa@redhat.com>

Currently, some tests contains target architecture information, in the
form of a "x86_64" tag.  But that tag is not respected in the default
execution, that is, "make check-acceptance" doesn't do anything with
it.

That said, even the target architecture handling currently present in
the "avocado_qemu.Test" class is pretty limited.  For instance, by
default, it chooses a target based on the host architecture.

Because the original implementation of the tags feature in Avocado did
not include any time of namespace or "key:val" mechanism, no tag has
relation to another tag.  The new implementation of the tags feature
from version 67.0 onwards, allows "key:val" tags, and because of that,
a test can be classified with a tag in a given key.  For instance, the
new proposed version of the "boot_linux_console.py" test, which
downloads and attempts to run a x86_64 kernel, is now tagged as:

  :avocado: tags=arch:x86_64

This means that it can be filtered (out) when no x86_64 target is
available.  At the same time, tests that don't have a "arch:" tag,
will not be filtered out.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20190312171824.5134-6-crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 tests/Makefile.include                 | 3 +++
 tests/acceptance/boot_linux_console.py | 2 +-
 tests/acceptance/linux_initrd.py       | 2 +-
 tests/acceptance/virtio_version.py     | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 445aa0bb12..7c8b9c84b2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1134,6 +1134,7 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
 # Any number of command separated loggers are accepted.  For more
 # information please refer to "avocado --help".
 AVOCADO_SHOW=app
+AVOCADO_TAGS=$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARGET_DIRS)))
 
 ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
 $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
@@ -1159,6 +1160,8 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 	$(call quiet-command, \
             $(TESTS_VENV_DIR)/bin/python -m avocado \
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
+            --filter-by-tags-include-empty --filter-by-tags-include-empty-key \
+            $(AVOCADO_TAGS) \
             --failfast=on $(SRC_PATH)/tests/acceptance, \
             "AVOCADO", "tests/acceptance")
 
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index beeb1e59e8..fa4594f612 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -18,7 +18,7 @@ class BootLinuxConsole(Test):
     Boots a x86_64 Linux kernel and checks that the console is operational
     and the kernel command line is properly passed from QEMU to the kernel
 
-    :avocado: tags=x86_64
+    :avocado: tags=arch:x86_64
     """
 
     timeout = 60
diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
index fbdb48e43f..23be5a63aa 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -19,7 +19,7 @@ class LinuxInitrd(Test):
     """
     Checks QEMU evaluates correctly the initrd file passed as -initrd option.
 
-    :avocado: tags=x86_64
+    :avocado: tags=arch:x86_64
     """
 
     timeout = 300
diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
index 37fc01ea18..8b97453ff8 100644
--- a/tests/acceptance/virtio_version.py
+++ b/tests/acceptance/virtio_version.py
@@ -61,7 +61,7 @@ class VirtioVersionCheck(Test):
     same device tree created by `disable-modern` and
     `disable-legacy`.
 
-    :avocado: tags=x86_64
+    :avocado: tags=arch:x86_64
     """
 
     # just in case there are failures, show larger diff:
-- 
2.18.0.rc1.1.g3f1ff2140


