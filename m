Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15F9C4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A3221835
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A3221835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKesG-0000j5-Q1
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 04:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iKerM-0000HZ-6F
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:40:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iKerL-0000Ug-57
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:40:44 -0400
Received: from mail.ispras.ru ([83.149.199.45]:35992)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1iKerK-0000Sa-Tj
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:40:43 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id AC2EF54006B;
 Wed, 16 Oct 2019 11:40:39 +0300 (MSK)
Subject: [PATCH] qapi: add support for blkreplay driver
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 16 Oct 2019 11:40:39 +0300
Message-ID: <157121523944.19602.3366908428295086643.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 83.149.199.45
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
Cc: kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds support for blkreplay driver to the blockdev options.
Now blkreplay can be used with -blockdev command line option
in the following format:
-blockdev driver=blkreplay,image=file-node-name,node-name=replay-node-name

This option makes possible implementation of the better command
line support for record/replay invocations.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 qapi/block-core.json |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b2f446122c..a371989924 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2893,12 +2893,13 @@
 # @nvme: Since 2.12
 # @copy-on-read: Since 3.0
 # @blklogwrites: Since 3.0
+# @blkreplay: Since 4.2
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevDriver',
-  'data': [ 'blkdebug', 'blklogwrites', 'blkverify', 'bochs', 'cloop',
-            'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
+  'data': [ 'blkdebug', 'blklogwrites', 'blkreplay', 'blkverify', 'bochs',
+            'cloop', 'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
             'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks',
             'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'qcow',
             'qcow2', 'qed', 'quorum', 'raw', 'rbd',
@@ -3511,6 +3512,18 @@
   'data': { 'test': 'BlockdevRef',
             'raw': 'BlockdevRef' } }
 
+##
+# @BlockdevOptionsBlkreplay:
+#
+# Driver specific block device options for blkreplay.
+#
+# @image:     disk image which should be controlled with blkreplay
+#
+# Since: 4.2
+##
+{ 'struct': 'BlockdevOptionsBlkreplay',
+  'data': { 'image': 'BlockdevRef' } }
+
 ##
 # @QuorumReadPattern:
 #
@@ -4038,6 +4051,7 @@
       'blkdebug':   'BlockdevOptionsBlkdebug',
       'blklogwrites':'BlockdevOptionsBlklogwrites',
       'blkverify':  'BlockdevOptionsBlkverify',
+      'blkreplay':  'BlockdevOptionsBlkreplay',
       'bochs':      'BlockdevOptionsGenericFormat',
       'cloop':      'BlockdevOptionsGenericFormat',
       'copy-on-read':'BlockdevOptionsGenericFormat',


