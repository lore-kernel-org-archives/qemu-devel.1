Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B8C73C63
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30FC32064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FC32064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl1Ed-0006l7-VR
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 21:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48966)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hl13l-0000Ju-LG
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hl13j-0004Mr-6s
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hl13b-0004El-7v; Tue, 09 Jul 2019 21:06:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 621BB8535C;
 Wed, 10 Jul 2019 01:06:01 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 998991001B1B;
 Wed, 10 Jul 2019 01:06:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 21:05:50 -0400
Message-Id: <20190710010556.32365-3-jsnow@redhat.com>
In-Reply-To: <20190710010556.32365-1-jsnow@redhat.com>
References: <20190710010556.32365-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 10 Jul 2019 01:06:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/8] iotests/257: add EmulatedBitmap class
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Represent a bitmap with an object that we can mark and clear bits in.
This makes it easier to manage partial writes when we don't write a
full group's worth of patterns before an error.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/257 | 125 +++++++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 49 deletions(-)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index f576a35a5c..2ff4aa8695 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -85,6 +85,60 @@ GROUPS =3D [
         Pattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the right
 ]
=20
+
+class EmulatedBitmap:
+    def __init__(self, granularity=3DGRANULARITY):
+        self._bits =3D set()
+        self.groups =3D set()
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
+        self._bits =3D self._bits - set(bits)
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
+        Print a nice human-readable message checking that a bitmap as re=
ported
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
+
+
 class Drive:
     """Represents, vaguely, a drive attached to a VM.
     Includes format, graph, and device information."""
@@ -195,27 +249,6 @@ def perform_writes(drive, n):
     log('')
     return bitmaps
=20
-def calculate_bits(groups=3DNone):
-    """Calculate how many bits we expect to see dirtied."""
-    if groups:
-        bits =3D set.union(*(GROUPS[group].bits(GRANULARITY) for group i=
n groups))
-        return len(bits)
-    return 0
-
-def bitmap_comparison(bitmap, groups=3DNone, want=3D0):
-    """
-    Print a nice human-readable message checking that this bitmap has as
-    many bits set as we expect it to.
-    """
-    log("=3D Checking Bitmap {:s} =3D".format(bitmap.get('name', '(anony=
mous)')))
-
-    if groups:
-        want =3D calculate_bits(groups)
-    have =3D bitmap['count'] // bitmap['granularity']
-
-    log("expecting {:d} dirty sectors; have {:d}. {:s}".format(
-        want, have, "OK!" if want =3D=3D have else "ERROR!"))
-    log('')
=20
 def compare_images(image, reference, baseimg=3DNone, expected_match=3DTr=
ue):
     """
@@ -321,12 +354,13 @@ def test_bitmap_sync(bsync_mode, failure=3DNone):
         vm.qmp_log("block-dirty-bitmap-add", node=3Ddrive0.name,
                    name=3D"bitmap0", granularity=3DGRANULARITY)
         log('')
+        ebitmap =3D EmulatedBitmap()
=20
         # 1 - Writes and Reference Backup
         bitmaps =3D perform_writes(drive0, 1)
-        dirty_groups =3D {1}
+        ebitmap.dirty_group(1)
         bitmap =3D get_bitmap(bitmaps, drive0.device, 'bitmap0')
-        bitmap_comparison(bitmap, groups=3Ddirty_groups)
+        ebitmap.compare(bitmap)
         reference_backup(drive0, 1, fbackup1)
=20
         # 1 - Bitmap Backup (Optional induced failure)
@@ -342,54 +376,47 @@ def test_bitmap_sync(bsync_mode, failure=3DNone):
             log('')
             bitmaps =3D perform_writes(drive0, 2)
             # Named bitmap (static, should be unchanged)
-            bitmap_comparison(get_bitmap(bitmaps, drive0.device, 'bitmap=
0'),
-                              groups=3Ddirty_groups)
+            ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'=
))
             # Anonymous bitmap (dynamic, shows new writes)
-            bitmap_comparison(get_bitmap(bitmaps, drive0.device, '',
-                                         recording=3DTrue), groups=3D{2}=
)
-            dirty_groups.add(2)
+            anonymous =3D EmulatedBitmap()
+            anonymous.dirty_group(2)
+            anonymous.compare(get_bitmap(bitmaps, drive0.device, '',
+                                         recording=3DTrue))
+
+            # Simulate the order in which this will happen:
+            # group 1 gets cleared first, then group two gets written.
+            if ((bsync_mode =3D=3D 'on-success' and not failure) or
+                (bsync_mode =3D=3D 'always')):
+                ebitmap.clear_group(1)
+            ebitmap.dirty_group(2)
=20
         vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
                    pre_finalize=3D_callback,
                    cancel=3D(failure =3D=3D 'simulated'))
         bitmaps =3D query_bitmaps(vm)
-        bitmap =3D get_bitmap(bitmaps, drive0.device, 'bitmap0')
         log(bitmaps, indent=3D2)
         log('')
=20
-        if ((bsync_mode =3D=3D 'on-success' and not failure) or
-                (bsync_mode =3D=3D 'always' and failure !=3D 'intermedia=
te')):
-            dirty_groups.remove(1)
-
         if bsync_mode =3D=3D 'always' and failure =3D=3D 'intermediate':
             # We manage to copy one sector (one bit) before the error.
-            bitmap_comparison(bitmap,
-                              want=3Dcalculate_bits(groups=3Ddirty_group=
s) - 1)
-        else:
-            bitmap_comparison(bitmap, groups=3Ddirty_groups)
+            ebitmap.clear_bit(ebitmap.first_bit)
+        ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'))
=20
         # 2 - Writes and Reference Backup
         bitmaps =3D perform_writes(drive0, 3)
-        dirty_groups.add(3)
-        bitmap =3D get_bitmap(bitmaps, drive0.device, 'bitmap0')
-        if bsync_mode =3D=3D 'always' and failure =3D=3D 'intermediate':
-            # We're one bit short, still.
-            bitmap_comparison(bitmap,
-                              want=3Dcalculate_bits(groups=3Ddirty_group=
s) - 1)
-        else:
-            bitmap_comparison(bitmap, groups=3Ddirty_groups)
+        ebitmap.dirty_group(3)
+        ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'))
         reference_backup(drive0, 2, fbackup2)
=20
         # 2 - Bitmap Backup (In failure modes, this is a recovery.)
         job =3D bitmap_backup(drive0, 2, bsync2, "bitmap0", bsync_mode)
         vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse)
         bitmaps =3D query_bitmaps(vm)
-        bitmap =3D get_bitmap(bitmaps, drive0.device, 'bitmap0')
         log(bitmaps, indent=3D2)
         log('')
-        bitmap_comparison(bitmap, groups=3D{}
-                          if bsync_mode !=3D 'never'
-                          else dirty_groups)
+        if bsync_mode !=3D 'never':
+            ebitmap.clear()
+        ebitmap.compare(get_bitmap(bitmaps, drive0.device, 'bitmap0'))
=20
         log('--- Cleanup ---\n')
         vm.qmp_log("block-dirty-bitmap-remove",
--=20
2.21.0


