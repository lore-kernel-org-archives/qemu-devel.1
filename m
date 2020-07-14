Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1738C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 01:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D47221924
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 01:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enmqlDiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D47221924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv9nA-0002zE-L6
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 21:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jv9mF-0002RC-DF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 21:30:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jv9mC-0006H8-OY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 21:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594690231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeZEj7pOZK0XfAZlpMDAfiD29OlCH+1kh5lioCC71k8=;
 b=enmqlDiKC/gAV4pA3IEfrZvfuP1p8pcVvoOh+aMHFy/dmB6yiNpQdRba1zk5X9ox0J5H87
 sXMDPEDUW6sug+KZaMggoe17kjBpppIhuccX5euKWdGYk3XS7x6PEERLOVAC25U5gWOZRx
 VhO501YUBBfPA60PJ9Zh0W/Cur24EPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-fmXGX7miNqaVei91z-Ivlg-1; Mon, 13 Jul 2020 21:30:29 -0400
X-MC-Unique: fmXGX7miNqaVei91z-Ivlg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7CE78015F3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 01:30:28 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-141.rdu2.redhat.com [10.10.113.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E30EF1A912;
 Tue, 14 Jul 2020 01:30:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] python: add check-python target
Date: Mon, 13 Jul 2020 21:30:26 -0400
Message-Id: <20200714013026.9019-2-jsnow@redhat.com>
In-Reply-To: <20200714013026.9019-1-jsnow@redhat.com>
References: <20200714013026.9019-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:30:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, John Snow <jsnow@redhat.com>, berrange@redhat.com,
 ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move pylintrc and flake8 up to the root of the python folder where
they're the most useful. Add a requirements.cqa.txt file to house
the requirements necessary to build a venv sufficient for running
code quality analysis on the python folder. Add a makefile that
will build the venv and run the tests.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 Makefile                    |  1 +
 python/{qemu => }/.flake8   |  0
 python/Makefile.include     | 33 +++++++++++++++++++++++++++++++++
 python/{qemu => }/pylintrc  |  1 +
 python/requirements.cqa.txt |  3 +++
 5 files changed, 38 insertions(+)
 rename python/{qemu => }/.flake8 (100%)
 create mode 100644 python/Makefile.include
 rename python/{qemu => }/pylintrc (99%)
 create mode 100644 python/requirements.cqa.txt

diff --git a/Makefile b/Makefile
index b1b8a5a6d0..41808be392 100644
--- a/Makefile
+++ b/Makefile
@@ -478,6 +478,7 @@ dummy := $(call unnest-vars,, \
                 trace-obj-y)
 
 include $(SRC_PATH)/tests/Makefile.include
+include $(SRC_PATH)/python/Makefile.include
 
 all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules $(vhost-user-json-y)
 
diff --git a/python/qemu/.flake8 b/python/.flake8
similarity index 100%
rename from python/qemu/.flake8
rename to python/.flake8
diff --git a/python/Makefile.include b/python/Makefile.include
new file mode 100644
index 0000000000..917808e2f1
--- /dev/null
+++ b/python/Makefile.include
@@ -0,0 +1,33 @@
+# -*- Mode: makefile -*-
+
+PYLIB_VENV_DIR=$(BUILD_DIR)/venv/cqa
+PYLIB_VENV_REQ=$(SRC_PATH)/python/requirements.cqa.txt
+
+$(PYLIB_VENV_DIR): $(PYLIB_VENV_REQ)
+	$(call quiet-command, \
+	    $(PYTHON) -m venv $@, \
+	    VENV, $@)
+	$(call quiet-command, \
+	    $(PYLIB_VENV_DIR)/bin/python3 -m pip -q install -r $(PYLIB_VENV_REQ), \
+	    PIP, $(PYLIB_VENV_REQ))
+	$(call quiet-command, touch $@)
+
+pylib-venv: $(PYLIB_VENV_DIR)
+
+check-python: pylib-venv
+	$(call quiet-command, cd $(SRC_PATH)/python && \
+	    $(PYLIB_VENV_DIR)/bin/python3 -m flake8 qemu, \
+	    FLAKE8, \
+	    $(SRC_PATH)/python/qemu \
+	)
+	$(call quiet-command, cd $(SRC_PATH)/python && \
+	    $(PYLIB_VENV_DIR)/bin/python3 -m pylint qemu, \
+	    PYLINT, \
+	    $(SRC_PATH)/python/qemu \
+	)
+	$(call quiet-command, cd $(SRC_PATH)/python && \
+	    $(PYLIB_VENV_DIR)/bin/python3 -m mypy \
+	        --strict --no-error-summary qemu, \
+	    MYPY, \
+	    "--strict $(SRC_PATH)/python/qemu" \
+	)
diff --git a/python/qemu/pylintrc b/python/pylintrc
similarity index 99%
rename from python/qemu/pylintrc
rename to python/pylintrc
index 5d6ae7367d..65b4545a6b 100644
--- a/python/qemu/pylintrc
+++ b/python/pylintrc
@@ -16,6 +16,7 @@ disable=too-many-arguments,
         too-many-public-methods,
 
 [REPORTS]
+score=no
 
 [REFACTORING]
 
diff --git a/python/requirements.cqa.txt b/python/requirements.cqa.txt
new file mode 100644
index 0000000000..dbf45984bc
--- /dev/null
+++ b/python/requirements.cqa.txt
@@ -0,0 +1,3 @@
+pylint==2.5.3
+mypy==0.782
+flake8==3.8.3
-- 
2.21.3


