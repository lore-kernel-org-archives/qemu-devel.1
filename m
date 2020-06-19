Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52032C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4A720C09
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRBrm7w8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4A720C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmNAD-0000ld-Am
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 15:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jmN7r-0004OX-9G
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:56:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jmN7p-0007dq-3l
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592596592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAaai+v3ekjzxQNoIAQM8Et+XPRTb/yLFReK68ARHEM=;
 b=KRBrm7w8/F1yABPhleeP0bSzRpPHcus040+bhV2dcFW1mCu7uYfkGioL/i4o5XwOrvLGYN
 Qza/f2OeXR7w2/EUW4cshLgWK1UpmEWk9pdoe1QoFFAdnzb4l+3EQinXwrs84TJqcXQrfp
 /Qd6BTgFiblNK+XywOJi6JoEqbhFaG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-1n61iAabMYKLuHfifAlmAg-1; Fri, 19 Jun 2020 15:56:27 -0400
X-MC-Unique: 1n61iAabMYKLuHfifAlmAg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9AB81800D4A;
 Fri, 19 Jun 2020 19:56:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-4.phx2.redhat.com [10.3.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C0917166C;
 Fri, 19 Jun 2020 19:56:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/6] iotests: move bitmap helpers into their own file
Date: Fri, 19 Jun 2020 14:56:19 -0500
Message-Id: <20200619195621.58740-5-eblake@redhat.com>
In-Reply-To: <20200619195621.58740-1-eblake@redhat.com>
References: <20200619195621.58740-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20200514034922.24834-5-jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/257        | 110 +---------------------------
 tests/qemu-iotests/bitmaps.py | 131 ++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 109 deletions(-)
 create mode 100644 tests/qemu-iotests/bitmaps.py

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 004a433b8be2..2a81f9e30c56 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -24,120 +24,12 @@ import os

 import iotests
 from iotests import log, qemu_img
+from bitmaps import EmulatedBitmap, GROUPS

 SIZE = 64 * 1024 * 1024
 GRANULARITY = 64 * 1024


-class Pattern:
-    def __init__(self, byte, offset, size=GRANULARITY):
-        self.byte = byte
-        self.offset = offset
-        self.size = size
-
-    def bits(self, granularity):
-        lower = self.offset // granularity
-        upper = (self.offset + self.size - 1) // granularity
-        return set(range(lower, upper + 1))
-
-
-class PatternGroup:
-    """Grouping of Pattern objects. Initialize with an iterable of Patterns."""
-    def __init__(self, patterns):
-        self.patterns = patterns
-
-    def bits(self, granularity):
-        """Calculate the unique bits dirtied by this pattern grouping"""
-        res = set()
-        for pattern in self.patterns:
-            res |= pattern.bits(granularity)
-        return res
-
-
-GROUPS = [
-    PatternGroup([
-        # Batch 0: 4 clusters
-        Pattern('0x49', 0x0000000),
-        Pattern('0x6c', 0x0100000),   # 1M
-        Pattern('0x6f', 0x2000000),   # 32M
-        Pattern('0x76', 0x3ff0000)]), # 64M - 64K
-    PatternGroup([
-        # Batch 1: 6 clusters (3 new)
-        Pattern('0x65', 0x0000000),   # Full overwrite
-        Pattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
-        Pattern('0x72', 0x2008000),   # Partial-right (32M+32K)
-        Pattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K)
-    PatternGroup([
-        # Batch 2: 7 clusters (3 new)
-        Pattern('0x74', 0x0010000),   # Adjacent-right
-        Pattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
-        Pattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
-        Pattern('0x67', 0x3fe0000,
-                2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M)
-    PatternGroup([
-        # Batch 3: 8 clusters (5 new)
-        # Carefully chosen such that nothing re-dirties the one cluster
-        # that copies out successfully before failure in Group #1.
-        Pattern('0xaa', 0x0010000,
-                3*GRANULARITY),       # Overwrite and 2x Adjacent-right
-        Pattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
-        Pattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
-        Pattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the right
-]
-
-
-class EmulatedBitmap:
-    def __init__(self, granularity=GRANULARITY):
-        self._bits = set()
-        self.granularity = granularity
-
-    def dirty_bits(self, bits):
-        self._bits |= set(bits)
-
-    def dirty_group(self, n):
-        self.dirty_bits(GROUPS[n].bits(self.granularity))
-
-    def clear(self):
-        self._bits = set()
-
-    def clear_bits(self, bits):
-        self._bits -= set(bits)
-
-    def clear_bit(self, bit):
-        self.clear_bits({bit})
-
-    def clear_group(self, n):
-        self.clear_bits(GROUPS[n].bits(self.granularity))
-
-    @property
-    def first_bit(self):
-        return sorted(self.bits)[0]
-
-    @property
-    def bits(self):
-        return self._bits
-
-    @property
-    def count(self):
-        return len(self.bits)
-
-    def compare(self, qmp_bitmap):
-        """
-        Print a nice human-readable message checking that a bitmap as reported
-        by the QMP interface has as many bits set as we expect it to.
-        """
-
-        name = qmp_bitmap.get('name', '(anonymous)')
-        log("= Checking Bitmap {:s} =".format(name))
-
-        want = self.count
-        have = qmp_bitmap['count'] // qmp_bitmap['granularity']
-
-        log("expecting {:d} dirty sectors; have {:d}. {:s}".format(
-            want, have, "OK!" if want == have else "ERROR!"))
-        log('')
-
-
 class Drive:
     """Represents, vaguely, a drive attached to a VM.
     Includes format, graph, and device information."""
diff --git a/tests/qemu-iotests/bitmaps.py b/tests/qemu-iotests/bitmaps.py
new file mode 100644
index 000000000000..522fc25171d1
--- /dev/null
+++ b/tests/qemu-iotests/bitmaps.py
@@ -0,0 +1,131 @@
+# Bitmap-related helper utilities
+#
+# Copyright (c) 2020 John Snow for Red Hat, Inc.
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
+#
+# owner=jsnow@redhat.com
+
+from iotests import log
+
+GRANULARITY = 64 * 1024
+
+
+class Pattern:
+    def __init__(self, byte, offset, size=GRANULARITY):
+        self.byte = byte
+        self.offset = offset
+        self.size = size
+
+    def bits(self, granularity):
+        lower = self.offset // granularity
+        upper = (self.offset + self.size - 1) // granularity
+        return set(range(lower, upper + 1))
+
+
+class PatternGroup:
+    """Grouping of Pattern objects. Initialize with an iterable of Patterns."""
+    def __init__(self, patterns):
+        self.patterns = patterns
+
+    def bits(self, granularity):
+        """Calculate the unique bits dirtied by this pattern grouping"""
+        res = set()
+        for pattern in self.patterns:
+            res |= pattern.bits(granularity)
+        return res
+
+
+GROUPS = [
+    PatternGroup([
+        # Batch 0: 4 clusters
+        Pattern('0x49', 0x0000000),
+        Pattern('0x6c', 0x0100000),   # 1M
+        Pattern('0x6f', 0x2000000),   # 32M
+        Pattern('0x76', 0x3ff0000)]), # 64M - 64K
+    PatternGroup([
+        # Batch 1: 6 clusters (3 new)
+        Pattern('0x65', 0x0000000),   # Full overwrite
+        Pattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
+        Pattern('0x72', 0x2008000),   # Partial-right (32M+32K)
+        Pattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K)
+    PatternGroup([
+        # Batch 2: 7 clusters (3 new)
+        Pattern('0x74', 0x0010000),   # Adjacent-right
+        Pattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
+        Pattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
+        Pattern('0x67', 0x3fe0000,
+                2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M)
+    PatternGroup([
+        # Batch 3: 8 clusters (5 new)
+        # Carefully chosen such that nothing re-dirties the one cluster
+        # that copies out successfully before failure in Group #1.
+        Pattern('0xaa', 0x0010000,
+                3*GRANULARITY),       # Overwrite and 2x Adjacent-right
+        Pattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
+        Pattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
+        Pattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the right
+]
+
+
+class EmulatedBitmap:
+    def __init__(self, granularity=GRANULARITY):
+        self._bits = set()
+        self.granularity = granularity
+
+    def dirty_bits(self, bits):
+        self._bits |= set(bits)
+
+    def dirty_group(self, n):
+        self.dirty_bits(GROUPS[n].bits(self.granularity))
+
+    def clear(self):
+        self._bits = set()
+
+    def clear_bits(self, bits):
+        self._bits -= set(bits)
+
+    def clear_bit(self, bit):
+        self.clear_bits({bit})
+
+    def clear_group(self, n):
+        self.clear_bits(GROUPS[n].bits(self.granularity))
+
+    @property
+    def first_bit(self):
+        return sorted(self.bits)[0]
+
+    @property
+    def bits(self):
+        return self._bits
+
+    @property
+    def count(self):
+        return len(self.bits)
+
+    def compare(self, qmp_bitmap):
+        """
+        Print a nice human-readable message checking that a bitmap as reported
+        by the QMP interface has as many bits set as we expect it to.
+        """
+
+        name = qmp_bitmap.get('name', '(anonymous)')
+        log("= Checking Bitmap {:s} =".format(name))
+
+        want = self.count
+        have = qmp_bitmap['count'] // qmp_bitmap['granularity']
+
+        log("expecting {:d} dirty sectors; have {:d}. {:s}".format(
+            want, have, "OK!" if want == have else "ERROR!"))
+        log('')
-- 
2.27.0


