Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1566C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF1320838
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 00:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMMc3oxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF1320838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6OY9-00044R-Nt
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 19:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6OWw-0002Cx-7S
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6OWt-00086N-6a
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36082
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6OWt-00084t-2S
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 19:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582592214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/wCudtQMl0134+X0MXUafJH6n/tbZq25GtZ65dP+LY=;
 b=JMMc3oxIdahjK+MgfXJU7IGqsZkYnhthMiMU4NmRlEfUmY8gQzWuUCvTr6MZ0DF9OdQED8
 gKzXXWdEkEpJcPslU1A4IMeoeYIZ+2rbwyDacL+NvInkwRdSZItC/blqN1aNUrD2h8iRot
 /x5KVj7JcssWQkBBeS7dYOEzSJSJvaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-MieQXN5tOp-L7Ka33cXJeQ-1; Mon, 24 Feb 2020 19:56:47 -0500
X-MC-Unique: MieQXN5tOp-L7Ka33cXJeQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A23D1007268;
 Tue, 25 Feb 2020 00:56:46 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC7911CB;
 Tue, 25 Feb 2020 00:56:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] iotests: move bitmap helpers into their own file
Date: Mon, 24 Feb 2020 19:56:38 -0500
Message-Id: <20200225005641.5478-4-jsnow@redhat.com>
In-Reply-To: <20200225005641.5478-1-jsnow@redhat.com>
References: <20200225005641.5478-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 pkrempa@redhat.com, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/257        | 110 +---------------------------
 tests/qemu-iotests/bitmaps.py | 131 ++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+), 109 deletions(-)
 create mode 100644 tests/qemu-iotests/bitmaps.py

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 004a433b8b..2a81f9e30c 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -24,120 +24,12 @@ import os
=20
 import iotests
 from iotests import log, qemu_img
+from bitmaps import EmulatedBitmap, GROUPS
=20
 SIZE =3D 64 * 1024 * 1024
 GRANULARITY =3D 64 * 1024
=20
=20
-class Pattern:
-    def __init__(self, byte, offset, size=3DGRANULARITY):
-        self.byte =3D byte
-        self.offset =3D offset
-        self.size =3D size
-
-    def bits(self, granularity):
-        lower =3D self.offset // granularity
-        upper =3D (self.offset + self.size - 1) // granularity
-        return set(range(lower, upper + 1))
-
-
-class PatternGroup:
-    """Grouping of Pattern objects. Initialize with an iterable of Pattern=
s."""
-    def __init__(self, patterns):
-        self.patterns =3D patterns
-
-    def bits(self, granularity):
-        """Calculate the unique bits dirtied by this pattern grouping"""
-        res =3D set()
-        for pattern in self.patterns:
-            res |=3D pattern.bits(granularity)
-        return res
-
-
-GROUPS =3D [
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
-    def __init__(self, granularity=3DGRANULARITY):
-        self._bits =3D set()
-        self.granularity =3D granularity
-
-    def dirty_bits(self, bits):
-        self._bits |=3D set(bits)
-
-    def dirty_group(self, n):
-        self.dirty_bits(GROUPS[n].bits(self.granularity))
-
-    def clear(self):
-        self._bits =3D set()
-
-    def clear_bits(self, bits):
-        self._bits -=3D set(bits)
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
-        Print a nice human-readable message checking that a bitmap as repo=
rted
-        by the QMP interface has as many bits set as we expect it to.
-        """
-
-        name =3D qmp_bitmap.get('name', '(anonymous)')
-        log("=3D Checking Bitmap {:s} =3D".format(name))
-
-        want =3D self.count
-        have =3D qmp_bitmap['count'] // qmp_bitmap['granularity']
-
-        log("expecting {:d} dirty sectors; have {:d}. {:s}".format(
-            want, have, "OK!" if want =3D=3D have else "ERROR!"))
-        log('')
-
-
 class Drive:
     """Represents, vaguely, a drive attached to a VM.
     Includes format, graph, and device information."""
diff --git a/tests/qemu-iotests/bitmaps.py b/tests/qemu-iotests/bitmaps.py
new file mode 100644
index 0000000000..522fc25171
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
+# owner=3Djsnow@redhat.com
+
+from iotests import log
+
+GRANULARITY =3D 64 * 1024
+
+
+class Pattern:
+    def __init__(self, byte, offset, size=3DGRANULARITY):
+        self.byte =3D byte
+        self.offset =3D offset
+        self.size =3D size
+
+    def bits(self, granularity):
+        lower =3D self.offset // granularity
+        upper =3D (self.offset + self.size - 1) // granularity
+        return set(range(lower, upper + 1))
+
+
+class PatternGroup:
+    """Grouping of Pattern objects. Initialize with an iterable of Pattern=
s."""
+    def __init__(self, patterns):
+        self.patterns =3D patterns
+
+    def bits(self, granularity):
+        """Calculate the unique bits dirtied by this pattern grouping"""
+        res =3D set()
+        for pattern in self.patterns:
+            res |=3D pattern.bits(granularity)
+        return res
+
+
+GROUPS =3D [
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
+    def __init__(self, granularity=3DGRANULARITY):
+        self._bits =3D set()
+        self.granularity =3D granularity
+
+    def dirty_bits(self, bits):
+        self._bits |=3D set(bits)
+
+    def dirty_group(self, n):
+        self.dirty_bits(GROUPS[n].bits(self.granularity))
+
+    def clear(self):
+        self._bits =3D set()
+
+    def clear_bits(self, bits):
+        self._bits -=3D set(bits)
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
+        Print a nice human-readable message checking that a bitmap as repo=
rted
+        by the QMP interface has as many bits set as we expect it to.
+        """
+
+        name =3D qmp_bitmap.get('name', '(anonymous)')
+        log("=3D Checking Bitmap {:s} =3D".format(name))
+
+        want =3D self.count
+        have =3D qmp_bitmap['count'] // qmp_bitmap['granularity']
+
+        log("expecting {:d} dirty sectors; have {:d}. {:s}".format(
+            want, have, "OK!" if want =3D=3D have else "ERROR!"))
+        log('')
--=20
2.21.1


