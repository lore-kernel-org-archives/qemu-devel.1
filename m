Return-Path: <SRS0=Dm/C=EH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CE2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DEF2417E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2020 16:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WI3jcXB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DEF2417E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZG4g-0000MK-7z
	for qemu-devel@archiver.kernel.org; Sun, 01 Nov 2020 11:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kZG1O-0005vy-MY
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 11:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kZG1I-0004VP-UC
 for qemu-devel@nongnu.org; Sun, 01 Nov 2020 11:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604247351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EH6WTr0vh6FK4FbaNDaCkhjWo83BpJLixfj77h1j/TM=;
 b=WI3jcXB9j7wRBhtBWYF6yO70l77KmQMc71nn1O/am0S+xd/kX6ATRTHb1KRnFGJVRBl+ao
 qdl3oNy0CcyfFMp+Q+y8txyHBEXQG0Pf5EQIJ6yahN4J/X+rC0GM3VwSLDZRvRqEjqn20M
 BZQhmQGIqQyeVZp2LtO/LLBG+sgE6yg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-xXjbEvZTO2a-0EDq9OEBuA-1; Sun, 01 Nov 2020 11:15:48 -0500
X-MC-Unique: xXjbEvZTO2a-0EDq9OEBuA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28D5F8018A1;
 Sun,  1 Nov 2020 16:15:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 228BD5C1BD;
 Sun,  1 Nov 2020 16:15:42 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] iotests: rewrite iotest 240 in python
Date: Sun,  1 Nov 2020 18:15:32 +0200
Message-Id: <20201101161532.259609-3-mlevitsk@redhat.com>
In-Reply-To: <20201101161532.259609-1-mlevitsk@redhat.com>
References: <20201101161532.259609-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/01 11:15:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The recent changes that brought RCU delayed device deletion,
broke few tests and this test breakage went unnoticed.

Fix this test by rewriting it in python
(which allows to wait for DEVICE_DELETED events before continuing).

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/240     | 228 ++++++++++++++++---------------------
 tests/qemu-iotests/240.out |  76 ++++++++-----
 2 files changed, 143 insertions(+), 161 deletions(-)

diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index 8b4337b58d..bfc9b72f36 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -1,5 +1,5 @@
-#!/usr/bin/env bash
-#
+#!/usr/bin/env python3
+
 # Test hot plugging and unplugging with iothreads
 #
 # Copyright (C) 2019 Igalia, S.L.
@@ -17,133 +17,99 @@
 #
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
-#
 
-# creator
-owner=berto@igalia.com
-
-seq=`basename $0`
-echo "QA output created by $seq"
-
-status=1	# failure is the default!
-
-_cleanup()
-{
-    rm -f "$SOCK_DIR/nbd"
-}
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common.rc
-. ./common.filter
-
-_supported_fmt generic
-_supported_proto generic
-
-do_run_qemu()
-{
-    echo Testing: "$@"
-    $QEMU -nographic -qmp stdio -serial none "$@"
-    echo
-}
-
-# Remove QMP events from (pretty-printed) output. Doesn't handle
-# nested dicts correctly, but we don't get any of those in this test.
-_filter_qmp_events()
-{
-    tr '\n' '\t' | sed -e \
-	's/{\s*"timestamp":\s*{[^}]*},\s*"event":[^,}]*\(,\s*"data":\s*{[^}]*}\)\?\s*}\s*//g' \
-	| tr '\t' '\n'
-}
-
-run_qemu()
-{
-    do_run_qemu "$@" 2>&1 | _filter_qmp | _filter_qmp_events
-}
-
-case "$QEMU_DEFAULT_MACHINE" in
-  s390-ccw-virtio)
-      virtio_scsi=virtio-scsi-ccw
-      ;;
-  *)
-      virtio_scsi=virtio-scsi-pci
-      ;;
-esac
-
-echo
-echo === Unplug a SCSI disk and then plug it again ===
-echo
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0"}}
-{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
-{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
-{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
-{ "execute": "device_del", "arguments": {"id": "scsi0"}}
-{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
-{ "execute": "quit"}
-EOF
-
-echo
-echo === Attach two SCSI disks using the same block device and the same iothread ===
-echo
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
-{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0"}}
-{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
-{ "execute": "device_del", "arguments": {"id": "scsi-hd1"}}
-{ "execute": "device_del", "arguments": {"id": "scsi0"}}
-{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
-{ "execute": "quit"}
-EOF
-
-echo
-echo === Attach two SCSI disks using the same block device but different iothreads ===
-echo
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
-{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
-{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread1"}}
-{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi1", "driver": "${virtio_scsi}", "iothread": "iothread1"}}
-{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi0.0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi1.0"}}
-{ "execute": "device_del", "arguments": {"id": "scsi-hd0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi-hd1", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi1.0"}}
-{ "execute": "device_del", "arguments": {"id": "scsi-hd1"}}
-{ "execute": "device_del", "arguments": {"id": "scsi0"}}
-{ "execute": "device_del", "arguments": {"id": "scsi1"}}
-{ "execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
-{ "execute": "quit"}
-EOF
-
-echo
-echo === Attach a SCSI disks using the same block device as a NBD server ===
-echo
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zeroes": true, "node-name": "hd0", "read-only": true}}
-{ "execute": "nbd-server-start", "arguments": {"addr":{"type":"unix","data":{"path":"$SOCK_DIR/nbd"}}}}
-{ "execute": "nbd-server-add", "arguments": {"device":"hd0"}}
-{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virtio_scsi}", "iothread": "iothread0"}}
-{ "execute": "device_add", "arguments": {"id": "scsi-hd0", "driver": "scsi-hd", "drive": "hd0", "bus": "scsi0.0"}}
-{ "execute": "quit"}
-EOF
-
-# success, all done
-echo "*** done"
-rm -f $seq.full
-status=0
+import iotests
+import os
+
+nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
+
+class TestCase(iotests.QMPTestCase):
+    test_driver = "null-co"
+
+    def required_drivers(self):
+        return [self.test_driver]
+
+    @iotests.skip_if_unsupported(required_drivers)
+    def setUp(self):
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+    def test1(self):
+        iotests.log('==Unplug a SCSI disk and then plug it again==')
+        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0')
+        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
+        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
+        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
+        self.vm.qmp_log('device_del', id='scsi-hd0')
+        self.vm.event_wait('DEVICE_DELETED')
+        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
+        self.vm.qmp_log('device_del', id='scsi-hd0')
+        self.vm.event_wait('DEVICE_DELETED')
+        self.vm.qmp_log('device_del', id='scsi0')
+        self.vm.qmp_log('blockdev-del', node_name='hd0')
+
+    def test2(self):
+        iotests.log('==Attach two SCSI disks using the same block device and the same iothread==')
+        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
+        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
+        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
+
+        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
+        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0')
+        self.vm.qmp_log('device_del', id='scsi-hd1')
+        self.vm.event_wait('DEVICE_DELETED')
+        self.vm.qmp_log('device_del', id='scsi-hd0')
+        self.vm.event_wait('DEVICE_DELETED')
+        self.vm.qmp_log('device_del', id='scsi0')
+        self.vm.qmp_log('blockdev-del', node_name='hd0')
+
+    def test3(self):
+        iotests.log('==Attach two SCSI disks using the same block device but different iothreads==')
+
+        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
+
+        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
+        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread1")
+
+        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
+        self.vm.qmp_log('device_add', id='scsi1', driver=iotests.get_virtio_scsi_device(), iothread='iothread1', filters = [iotests.filter_qmp_virtio_scsi])
+
+        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0', bus="scsi0.0")
+        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
+
+        self.vm.qmp_log('device_del', id='scsi-hd0')
+        self.vm.event_wait('DEVICE_DELETED')
+        self.vm.qmp_log('device_add', id='scsi-hd1', driver='scsi-hd', drive='hd0', bus="scsi1.0")
+
+        self.vm.qmp_log('device_del', id='scsi-hd1')
+        self.vm.event_wait('DEVICE_DELETED')
+
+        self.vm.qmp_log('device_del', id='scsi1')
+        self.vm.qmp_log('device_del', id='scsi0')
+
+        self.vm.qmp_log('blockdev-del', node_name='hd0')
+
+    def test4(self):
+        iotests.log('==Attach a SCSI disks using the same block device as a NBD server==')
+
+        self.vm.qmp_log('blockdev-add', driver='null-co', read_zeroes=True, node_name='hd0', read_only=True)
+
+        self.vm.qmp_log('nbd-server-start',
+                        filters=[iotests.filter_qmp_testfiles],
+                        addr={'type':'unix', 'data':{'path':nbd_sock}})
+
+        self.vm.qmp_log('nbd-server-add', device='hd0')
+
+        self.vm.qmp_log('object-add', qom_type='iothread', id="iothread0")
+        self.vm.qmp_log('device_add', id='scsi0', driver=iotests.get_virtio_scsi_device(), iothread='iothread0', filters = [iotests.filter_qmp_virtio_scsi])
+        self.vm.qmp_log('device_add', id='scsi-hd0', driver='scsi-hd', drive='hd0')
+
+
+if __name__ == '__main__':
+    if 'null-co' not in iotests.supported_formats():
+        iotests.notrun('null-co driver support missing')
+    iotests.activate_logging()
+    iotests.main()
diff --git a/tests/qemu-iotests/240.out b/tests/qemu-iotests/240.out
index d00df50297..064c8eaa41 100644
--- a/tests/qemu-iotests/240.out
+++ b/tests/qemu-iotests/240.out
@@ -1,67 +1,83 @@
-QA output created by 240
-
-=== Unplug a SCSI disk and then plug it again ===
-
-Testing:
-QMP_VERSION
-{"return": {}}
+==Unplug a SCSI disk and then plug it again==
+{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-zeroes": true}}
 {"return": {}}
+{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"driver": "virtio-scsi", "id": "scsi0", "iothread": "iothread0"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
+{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
+{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
 {"return": {}}
+{"execute": "device_del", "arguments": {"id": "scsi0"}}
 {"return": {}}
+{"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
 {"return": {}}
+==Attach two SCSI disks using the same block device and the same iothread==
+{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true, "read-zeroes": true}}
 {"return": {}}
-
-=== Attach two SCSI disks using the same block device and the same iothread ===
-
-Testing:
-QMP_VERSION
+{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"driver": "virtio-scsi", "id": "scsi0", "iothread": "iothread0"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
 {"return": {}}
+{"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
 {"return": {}}
+{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
 {"return": {}}
+{"execute": "device_del", "arguments": {"id": "scsi0"}}
 {"return": {}}
+{"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
 {"return": {}}
+==Attach two SCSI disks using the same block device but different iothreads==
+{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true, "read-zeroes": true}}
 {"return": {}}
+{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
 {"return": {}}
+{"execute": "object-add", "arguments": {"id": "iothread1", "qom-type": "iothread"}}
 {"return": {}}
-
-=== Attach two SCSI disks using the same block device but different iothreads ===
-
-Testing:
-QMP_VERSION
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"return": {}}
+{"execute": "device_add", "arguments": {"driver": "virtio-scsi", "id": "scsi0", "iothread": "iothread0"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"driver": "virtio-scsi", "id": "scsi1", "iothread": "iothread1"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"bus": "scsi0.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
 {"error": {"class": "GenericError", "desc": "Cannot change iothread of active block backend"}}
+{"execute": "device_del", "arguments": {"id": "scsi-hd0"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"bus": "scsi1.0", "drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd1"}}
 {"return": {}}
+{"execute": "device_del", "arguments": {"id": "scsi-hd1"}}
 {"return": {}}
+{"execute": "device_del", "arguments": {"id": "scsi1"}}
 {"return": {}}
+{"execute": "device_del", "arguments": {"id": "scsi0"}}
 {"return": {}}
+{"execute": "blockdev-del", "arguments": {"node-name": "hd0"}}
 {"return": {}}
+==Attach a SCSI disks using the same block device as a NBD server==
+{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true, "read-zeroes": true}}
 {"return": {}}
-
-=== Attach a SCSI disks using the same block device as a NBD server ===
-
-Testing:
-QMP_VERSION
-{"return": {}}
-{"return": {}}
+{"execute": "nbd-server-start", "arguments": {"addr": {"data": {"path": "SOCK_DIR/PID-nbd.sock"}, "type": "unix"}}}
 {"return": {}}
+{"execute": "nbd-server-add", "arguments": {"device": "hd0"}}
 {"return": {}}
+{"execute": "object-add", "arguments": {"id": "iothread0", "qom-type": "iothread"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"driver": "virtio-scsi", "id": "scsi0", "iothread": "iothread0"}}
 {"return": {}}
+{"execute": "device_add", "arguments": {"drive": "hd0", "driver": "scsi-hd", "id": "scsi-hd0"}}
 {"return": {}}
-{"return": {}}
-*** done
+....
+----------------------------------------------------------------------
+Ran 4 tests
+
+OK
-- 
2.26.2


