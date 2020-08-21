Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB21C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63BA204FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDRR6x00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63BA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97rb-0000Yt-7G
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97j1-0007RV-Uf
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97iz-0004Yt-Mr
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OKTiWydU/nqR2BLF9AhL3+Bno7cgn33+guhRB4DEWZc=;
 b=DDRR6x00S3QsrpqYm/qRWHo+8kXWEPQ3i4b2hQmsyqRH0Vxq6l6gnGk1rcfmpD9RZ9A348
 erNB0FLDIf7MHdzH6dfMxJTlEW5JSQWMFetB45TxRSDlJXb3wXHNacOfDLOewQWRAR8uJA
 dKRKAKbW4uaGxkzzpNYBUwiHL1ItqTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-uv-TMDEWNaePRDHmLWbE_w-1; Fri, 21 Aug 2020 10:08:38 -0400
X-MC-Unique: uv-TMDEWNaePRDHmLWbE_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0465364081;
 Fri, 21 Aug 2020 14:08:37 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F49D7AEC9;
 Fri, 21 Aug 2020 14:08:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/14] qcow2.py: Introduce '-j' key to dump in JSON format
Date: Fri, 21 Aug 2020 09:08:20 -0500
Message-Id: <20200821140826.194322-9-eblake@redhat.com>
In-Reply-To: <20200821140826.194322-1-eblake@redhat.com>
References: <20200821140826.194322-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Add the command key to the qcow2.py arguments list to dump QCOW2
metadata in JSON format. Here is the suggested way to do that. The
implementation of the dump in JSON format is in the patch that follows.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <1596742557-320265-9-git-send-email-andrey.shinkevich@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2.py        | 18 ++++++++++++++----
 tests/qemu-iotests/qcow2_format.py |  4 ++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 0910e6ac0705..77ca59cc663d 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -26,16 +26,19 @@ from qcow2_format import (
 )


+is_json = False
+
+
 def cmd_dump_header(fd):
     h = QcowHeader(fd)
-    h.dump()
+    h.dump(is_json)
     print()
-    h.dump_extensions()
+    h.dump_extensions(is_json)


 def cmd_dump_header_exts(fd):
     h = QcowHeader(fd)
-    h.dump_extensions()
+    h.dump_extensions(is_json)


 def cmd_set_header(fd, name, value):
@@ -151,11 +154,14 @@ def main(filename, cmd, args):


 def usage():
-    print("Usage: %s <file> <cmd> [<arg>, ...]" % sys.argv[0])
+    print("Usage: %s <file> <cmd> [<arg>, ...] [<key>, ...]" % sys.argv[0])
     print("")
     print("Supported commands:")
     for name, handler, num_args, desc in cmds:
         print("    %-20s - %s" % (name, desc))
+    print("")
+    print("Supported keys:")
+    print("    %-20s - %s" % ('-j', 'Dump in JSON format'))


 if __name__ == '__main__':
@@ -163,4 +169,8 @@ if __name__ == '__main__':
         usage()
         sys.exit(1)

+    is_json = '-j' in sys.argv
+    if is_json:
+        sys.argv.remove('-j')
+
     main(sys.argv[1], sys.argv[2], sys.argv[3:])
diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
index 574249bc463c..de0adcbf9db0 100644
--- a/tests/qemu-iotests/qcow2_format.py
+++ b/tests/qemu-iotests/qcow2_format.py
@@ -109,7 +109,7 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
         self.__dict__ = dict((field[2], values[i])
                              for i, field in enumerate(self.fields))

-    def dump(self):
+    def dump(self, is_json=False):
         for f in self.fields:
             value = self.__dict__[f[2]]
             if isinstance(f[1], str):
@@ -408,7 +408,7 @@ class QcowHeader(Qcow2Struct):
         buf = buf[0:header_bytes-1]
         fd.write(buf)

-    def dump_extensions(self):
+    def dump_extensions(self, is_json=False):
         for ex in self.extensions:
             print('Header extension:')
             ex.dump()
-- 
2.28.0


