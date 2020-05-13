Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A883A2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 21:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS+y/iFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A883A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYzCu-0003Ha-O2
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 17:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8M-0006zz-9f
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33414
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jYz8L-0005cS-9F
 for qemu-devel@nongnu.org; Wed, 13 May 2020 17:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589406104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mADFPjG4NsDPQUvoHbp1gHPK/gjpmZfpYfEuvG6grrA=;
 b=jS+y/iFw0GVQnnhByxnHk2PI/NSTuu8z32l/Y4TpzBxgUfwS6oazJEbEgXMSe2WbGcQdTc
 codHxk59Rbc8l8UYr+FchmRVPpjR2aFNGRbNXnF2toSW33QA3rkYhmC1sn9PaQ1O+R/4Ky
 orCEg+LCHDexZ5H62ExnXPGr/yX2nRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-Dz6Hj7TWM3uAr18L59AzaA-1; Wed, 13 May 2020 17:41:36 -0400
X-MC-Unique: Dz6Hj7TWM3uAr18L59AzaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 954EC84638F;
 Wed, 13 May 2020 21:41:35 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-80.rdu2.redhat.com [10.10.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D312B1C94D;
 Wed, 13 May 2020 21:41:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC WIP 4/6] qed.py: delint
Date: Wed, 13 May 2020 17:41:28 -0400
Message-Id: <20200513214130.15375-5-jsnow@redhat.com>
In-Reply-To: <20200513214130.15375-1-jsnow@redhat.com>
References: <20200513214130.15375-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/Makefile |  2 +-
 tests/qemu-iotests/qed.py   | 46 ++++++++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/tests/qemu-iotests/Makefile b/tests/qemu-iotests/Makefile
index 64db48342f..5a3a1e8092 100644
--- a/tests/qemu-iotests/Makefile
+++ b/tests/qemu-iotests/Makefile
@@ -1,6 +1,6 @@
 PYMODULES = $(wildcard *.py)
 
-KNOWN_GOOD = iotests.py nbd-fault-injector.py
+KNOWN_GOOD = iotests.py nbd-fault-injector.py qed.py
 
 CLEANFILES= *.out.bad *.notrun check.log check.time*
 
diff --git a/tests/qemu-iotests/qed.py b/tests/qemu-iotests/qed.py
index d6bec96069..9e016cc2a2 100755
--- a/tests/qemu-iotests/qed.py
+++ b/tests/qemu-iotests/qed.py
@@ -13,7 +13,6 @@
 import sys
 import struct
 import random
-import optparse
 
 # This can be used as a module
 __all__ = ['QED_F_NEED_CHECK', 'QED']
@@ -47,7 +46,7 @@ def unpack_table_elem(s):
 def pack_table_elem(elem):
     return struct.pack(table_elem_fmt, elem)
 
-class QED(object):
+class QED:
     def __init__(self, f):
         self.f = f
 
@@ -74,19 +73,22 @@ def store_header(self):
     def read_table(self, offset):
         size = self.header['table_size'] * self.header['cluster_size']
         s = self.raw_pread(offset, size)
-        table = [unpack_table_elem(s[i:i + table_elem_size]) for i in xrange(0, size, table_elem_size)]
+        table = [unpack_table_elem(s[i:i + table_elem_size])
+                 for i in range(0, size, table_elem_size)]
         return table
 
     def load_l1_table(self):
         self.l1_table = self.read_table(self.header['l1_table_offset'])
-        self.table_nelems = self.header['table_size'] * self.header['cluster_size'] // table_elem_size
+        self.table_nelems = (self.header['table_size']
+                             * self.header['cluster_size'] // table_elem_size)
 
     def write_table(self, offset, table):
         s = ''.join(pack_table_elem(x) for x in table)
         self.raw_pwrite(offset, s)
 
 def random_table_item(table):
-    vals = [(index, offset) for index, offset in enumerate(table) if offset != 0]
+    vals = [(index, offset) for index, offset
+            in enumerate(table) if offset != 0]
     if not vals:
         err('cannot pick random item because table is empty')
     return random.choice(vals)
@@ -103,7 +105,8 @@ def corrupt_table_duplicate(table):
 def corrupt_table_invalidate(qed, table):
     '''Corrupt a table by introducing an invalid offset'''
     index, _ = random_table_item(table)
-    table[index] = qed.filesize + random.randint(0, 100 * 1024 * 1024 * 1024 * 1024)
+    table[index] = (qed.filesize
+                    + random.randint(0, 100 * 1024 * 1024 * 1024 * 1024))
 
 def cmd_show(qed, *args):
     '''show [header|l1|l2 <offset>]- Show header or l1/l2 tables'''
@@ -144,7 +147,11 @@ def cmd_invalidate(qed, table_level):
     qed.write_table(offset, table)
 
 def cmd_need_check(qed, *args):
-    '''need-check [on|off] - Test, set, or clear the QED_F_NEED_CHECK header bit'''
+    """
+    need-check [on|off]
+
+    Test, set, or clear the QED_F_NEED_CHECK header bit
+    """
     if not args:
         print(bool(qed.header['features'] & QED_F_NEED_CHECK))
         return
@@ -165,7 +172,7 @@ def cmd_zero_cluster(qed, pos, *args):
             err('expected one argument')
         n = int(args[0])
 
-    for i in xrange(n):
+    for _ in range(n):
         l1_index = pos // qed.header['cluster_size'] // len(qed.l1_table)
         if qed.l1_table[l1_index] == 0:
             err('no l2 table allocated')
@@ -179,7 +186,11 @@ def cmd_zero_cluster(qed, pos, *args):
         pos += qed.header['cluster_size']
 
 def cmd_copy_metadata(qed, outfile):
-    '''copy-metadata <outfile> - Copy metadata only (for scrubbing corrupted images)'''
+    """
+    copy-metadata <outfile>
+
+    Copy metadata only (for scrubbing corrupted images)
+    """
     out = open(outfile, 'wb')
 
     # Match file size
@@ -213,23 +224,26 @@ def usage():
     print('Supported commands:')
     for cmd in sorted(x for x in globals() if x.startswith('cmd_')):
         print(globals()[cmd].__doc__)
-    sys.exit(1)
+    return 1
 
 def main():
     if len(sys.argv) < 3:
-        usage()
-    filename, cmd = sys.argv[1:3]
+        return usage()
+    filename = sys.argv[1]
+    cmd = sys.argv[2]
 
     cmd = 'cmd_' + cmd.replace('-', '_')
     if cmd not in globals():
-        usage()
+        return usage()
 
     qed = QED(open(filename, 'r+b'))
     try:
         globals()[cmd](qed, *sys.argv[3:])
-    except TypeError as e:
+    except TypeError:
         sys.stderr.write(globals()[cmd].__doc__ + '\n')
-        sys.exit(1)
+        return 1
+
+    return 0
 
 if __name__ == '__main__':
-    main()
+    sys.exit(main())
-- 
2.21.1


