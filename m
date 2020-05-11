Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B719C54E90
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD492075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ijb6W6Hb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD492075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBR8-0000GM-HR
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYBPv-0007H6-JR
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:36:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jYBPu-00013M-I0
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589214992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NRwE6/Qo8qRVVp1RfvsYsQfE87zn+GckiKfS3Igwt/E=;
 b=Ijb6W6Hb7347reG0+T5LMzi39bqkt2pZY4/++4TtwXcHMWs+LpIWwkP3aUfSz/Uumyd6G3
 prkx/8GKnvCM3S3S9r7os49EeNcpmfuS76idcs9uFy0UIMBeNNqtk7Fkyrr13eF5hdH0dN
 e9YO+YnAVSDsQpsXVqnkOhmMYJKevuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-88oxXcLgNG-gycbPdHH93Q-1; Mon, 11 May 2020 12:36:26 -0400
X-MC-Unique: 88oxXcLgNG-gycbPdHH93Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A59668C2CAE;
 Mon, 11 May 2020 16:35:42 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-142.ams2.redhat.com
 [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 813DD5C1B5;
 Mon, 11 May 2020 16:35:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] iotests: Run pylint and mypy in a testcase
Date: Mon, 11 May 2020 18:35:29 +0200
Message-Id: <20200511163529.349329-3-kwolf@redhat.com>
In-Reply-To: <20200511163529.349329-1-kwolf@redhat.com>
References: <20200511163529.349329-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 03:10:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We made sure that iotests.py passes pylint. It would be a shame if we
allowed new patches in that break this again, so let's just add a
meta-test case that runs pylint on it.

While we don't pass mypy --strict yet, we can already run it with a few
options that would be part of --strict to make sure that we won't
regress on these aspects at least until we can enable the full thing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/297     | 44 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/297.out |  3 +++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 48 insertions(+)
 create mode 100755 tests/qemu-iotests/297
 create mode 100644 tests/qemu-iotests/297.out

diff --git a/tests/qemu-iotests/297 b/tests/qemu-iotests/297
new file mode 100755
index 0000000000..5c5420712b
--- /dev/null
+++ b/tests/qemu-iotests/297
@@ -0,0 +1,44 @@
+#!/usr/bin/env bash
+#
+# Copyright (C) 2020 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+seq=$(basename $0)
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+# get standard environment
+. ./common.rc
+
+if ! type -p "pylint-3" > /dev/null; then
+    _notrun "pylint-3 not found"
+fi
+if ! type -p "mypy" > /dev/null; then
+    _notrun "mypy not found"
+fi
+
+pylint-3 --score=n iotests.py
+
+MYPYPATH=../../python/ mypy --warn-unused-configs --disallow-subclassing-any \
+    --disallow-any-generics --disallow-incomplete-defs \
+    --disallow-untyped-decorators --no-implicit-optional \
+    --warn-redundant-casts --warn-unused-ignores \
+    --no-implicit-reexport iotests.py
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/297.out b/tests/qemu-iotests/297.out
new file mode 100644
index 0000000000..6acc843649
--- /dev/null
+++ b/tests/qemu-iotests/297.out
@@ -0,0 +1,3 @@
+QA output created by 297
+Success: no issues found in 1 source file
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index fe649c5b73..c514975880 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -299,3 +299,4 @@
 289 rw quick
 290 rw auto quick
 292 rw auto quick
+297 meta
-- 
2.25.3


