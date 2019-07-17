Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BF8C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD74208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfgGfA+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD74208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkMl-0005Pg-Hb
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKl-0004wN-HE
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKi-00016t-Jv
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:51:02 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkKi-00015c-Bz
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:51:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id v15so22273056wml.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r0APmCoUIG/w2qLEz3oEEruxZ1VMqL8sI7RlOiUMs8k=;
 b=vfgGfA+0cUbAZ8WOL5VGfN7Yn+KIvSpudPq/bQyO0Y1foDZrOpJnmE24fG68US1ShK
 IW9uitMI/Bc0oQW9JltinHJgpNKQh9GRidGwXdZxe0dH8oSDDGpWSoNooEaiDl7tPWNx
 VqsP/BK0n2IvD+ijPxJzx/i1/1lA3VGTpBPkgKtecJp6EJXFu7+BPffnm9Ti2AMZs7CC
 ZGIplavUxCxnPXcznEANH3tJn1n86/CRrSlV6Kbq/DSlt6Bx7od+TNzPhJCQtyCSfV6s
 +1miIL2Zv7IQPv3VU6Emvo9XE81haDkgjok7Av48DrQCMxOaa4VsBFJ5OMY9enYDXXUx
 iyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r0APmCoUIG/w2qLEz3oEEruxZ1VMqL8sI7RlOiUMs8k=;
 b=aup7bAYOi8Rsiy41ZAtmvi0ZhRfxfk0gWXk3yliTD70UKlcSvtkRSqpdICqKGpZARH
 Uquq3bxHXGvyoHjVpKEpX3lGaPByapWtlQ2KE6luHLlKybV1sbMYv9DjfRUYAJGz/g3g
 hY5+tU99pbq40dQYscrpGgjSig2GW+rt0GPKXVy35AWL/7TaL67NiqzUH74hBh5yYvoi
 1UZ1eoCNtNdX4NNmvipzKvroir7CRk2xYptd7V6WNMga1q/VcEHX9GNpuuGFSQ8C38y/
 rveDV+UqalSaZjmP+fQqMR9WZDnzF4/tNrkQdtqBybKQbKNgbdXAD+aoZ+75+JvOsjt4
 jU7w==
X-Gm-Message-State: APjAAAX8w2aG/TqH5vIqwB9K3e7BXen2MyCD72zYZmEi6tISpI2sW6Rx
 8y6QIPUDf6u8rLbnhHdU5IgI6s6GOwA=
X-Google-Smtp-Source: APXvYqy5SooGQiYPcSCkJYQdvhobVUX/EClRJs9hluw60EKV35LcJkOw+OBbdPKCGrTD4YMZyYufHA==
X-Received: by 2002:a1c:f90f:: with SMTP id x15mr35821393wmh.69.1563371459136; 
 Wed, 17 Jul 2019 06:50:59 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 4sm53933619wro.78.2019.07.17.06.50.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:50:55 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C11881FFAA;
 Wed, 17 Jul 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:34 +0100
Message-Id: <20190717134335.15351-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v2 22/23] tests: Run the iotests during "make
 check" again
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

People often forget to run the iotests before submitting patches or pull
requests - this is likely due to the fact that we do not run the tests
during our mandatory "make check" tests yet. Now that we've got a proper
"auto" group of iotests that should be fine to run in every environment,
we can enable the iotests during "make check" again by running the "auto"
tests by default from the check-block.sh script.

Some cases still need to be checked first, though: iotests need bash and
GNU sed (otherwise they fail), and if gprof is enabled, it spoils the
output of some test cases causing them to fail. So if we detect that one
of the required programs is missing or that gprof is enabled, we still
have to skip the iotests to avoid failures.

And finally, since we are using check-block.sh now again, this patch also
removes the qemu-iotests-quick.sh script since we do not need that anymore
(and having two shell wrapper scripts around the block tests seems rather
confusing than helpful).

Signed-off-by: Thomas Huth <thuth@redhat.com>
[AJB: -makecheck to check-block.sh, move check-block to start and gate it]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190717111947.30356-4-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include      | 10 +++++----
 tests/check-block.sh        | 44 ++++++++++++++++++++++++++++---------
 tests/qemu-iotests-quick.sh |  8 -------
 3 files changed, 40 insertions(+), 22 deletions(-)
 delete mode 100755 tests/qemu-iotests-quick.sh

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fd7fdb86586..6f02dfcc019 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -142,7 +142,7 @@ check-unit-y += tests/test-uuid$(EXESUF)
 check-unit-y += tests/ptimer-test$(EXESUF)
 check-unit-y += tests/test-qapi-util$(EXESUF)
 
-check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
+check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFTMMU)) += tests/check-block.sh
 
 # All QTests for now are POSIX-only, but the dependencies are
 # really in libqtest, not in the testcases themselves.
@@ -1092,8 +1092,10 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
 
 QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
 
-.PHONY: check-tests/qemu-iotests-quick.sh
-check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
+.PHONY: check-tests/check-block.sh
+check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
+		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
+		$(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
 	$<
 
 .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
@@ -1167,7 +1169,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
 check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
 check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
 check-block: $(patsubst %,check-%, $(check-block-y))
-check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
+check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
 check-clean:
 	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
 	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
diff --git a/tests/check-block.sh b/tests/check-block.sh
index f3d12fd602d..c8b6cec3f68 100755
--- a/tests/check-block.sh
+++ b/tests/check-block.sh
@@ -1,24 +1,48 @@
 #!/bin/sh
 
-FORMAT_LIST="raw qcow2 qed vmdk vpc"
+# Honor the SPEED environment variable, just like we do it for the qtests.
+if [ "$SPEED" = "slow" ]; then
+    format_list="raw qcow2"
+    group=
+elif [ "$SPEED" = "thorough" ]; then
+    format_list="raw qcow2 qed vmdk vpc"
+    group=
+else
+    format_list=qcow2
+    group="-g auto"
+fi
+
 if [ "$#" -ne 0 ]; then
-    FORMAT_LIST="$@"
+    format_list="$@"
+fi
+
+if grep -q "TARGET_GPROF=y" *-softmmu/config-target.mak 2>/dev/null ; then
+    echo "GPROF is enabled ==> Not running the qemu-iotests."
+    exit 0
 fi
 
-export QEMU_PROG="$PWD/x86_64-softmmu/qemu-system-x86_64"
-export QEMU_IMG_PROG="$PWD/qemu-img"
-export QEMU_IO_PROG="$PWD/qemu-io"
+if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
+    echo "No qemu-system binary available ==> Not running the qemu-iotests."
+    exit 0
+fi
+
+if ! command -v bash >/dev/null 2>&1 ; then
+    echo "bash not available ==> Not running the qemu-iotests."
+    exit 0
+fi
 
-if [ ! -x $QEMU_PROG ]; then
-    echo "'make check-block' requires qemu-system-x86_64"
-    exit 1
+if ! (sed --version | grep 'GNU sed') > /dev/null 2>&1 ; then
+    if ! command -v gsed >/dev/null 2>&1; then
+        echo "GNU sed not available ==> Not running the qemu-iotests."
+        exit 0
+    fi
 fi
 
 cd tests/qemu-iotests
 
 ret=0
-for FMT in $FORMAT_LIST ; do
-    ./check -T -nocache -$FMT || ret=1
+for fmt in $format_list ; do
+    ./check -makecheck -$fmt $group || ret=1
 done
 
 exit $ret
diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
deleted file mode 100755
index 0e554bb9724..00000000000
--- a/tests/qemu-iotests-quick.sh
+++ /dev/null
@@ -1,8 +0,0 @@
-#!/bin/sh
-
-cd tests/qemu-iotests
-
-ret=0
-TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g quick || ret=1
-
-exit $ret
-- 
2.20.1


