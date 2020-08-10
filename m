Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848FCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 12:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3AA20678
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 12:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3AA20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k572k-0003WD-Hr
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 08:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1k5723-0002qq-Oy; Mon, 10 Aug 2020 08:36:03 -0400
Received: from relay.sw.ru ([185.231.240.75]:58140 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1k5720-0002NM-SU; Mon, 10 Aug 2020 08:36:03 -0400
Received: from [192.168.15.81] (helo=iris.lishka.ru)
 by relay3.sw.ru with esmtp (Exim 4.93)
 (envelope-from <den@openvz.org>)
 id 1k571m-0002Gz-Qk; Mon, 10 Aug 2020 15:35:46 +0300
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for 5.2 1/1] qemu-io: add -V flag for read sub-command
Date: Mon, 10 Aug 2020 15:35:55 +0300
Message-Id: <20200810123555.30481-1-den@openvz.org>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=185.231.240.75; envelope-from=den@openvz.org;
 helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 08:35:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The problem this patch is trying to address is libguestfs behavior on the
appliance startup. It starts supporting to use root=UUID definition in
the kernel command line of its root filesystem using
    file --  /usr/lib64/guestfs/appliance/root
This works fine with RAW image, but we are using QCOW2 as a storage to
save a bit of file space and in this case we get
    QEMU QCOW Image (v3), 1610612736 bytes
instead of UUID of the root filesystem.

The solution is very simple - we should dump first 256k of the image file
like the follows
    qemu-io -c "read -V 0 256k" appliance | file -
which will provide correct result for all possible types of the appliance
storage.

Unfortunately, additional option for qemu-io is the only and the simplest
solution as '-v' creates very specific output, which requires to be
parsed. 'qemu-img dd of=/dev/stdout' does not work and the fix would be
much more intrusive.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Richard W.M. Jones <rjones@redhat.com>
---
P.S. Patch to libguestfs will follow.

 qemu-io-cmds.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index baeae86d8c..7aae9726cd 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -718,7 +718,7 @@ static const cmdinfo_t read_cmd = {
     .cfunc      = read_f,
     .argmin     = 2,
     .argmax     = -1,
-    .args       = "[-abCqv] [-P pattern [-s off] [-l len]] off len",
+    .args       = "[-abCqvV] [-P pattern [-s off] [-l len]] off len",
     .oneline    = "reads a number of bytes at a specified offset",
     .help       = read_help,
 };
@@ -728,6 +728,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
     struct timespec t1, t2;
     bool Cflag = false, qflag = false, vflag = false;
     bool Pflag = false, sflag = false, lflag = false, bflag = false;
+    bool vrawflag = true;
     int c, cnt, ret;
     char *buf;
     int64_t offset;
@@ -737,7 +738,7 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
     int pattern = 0;
     int64_t pattern_offset = 0, pattern_count = 0;
 
-    while ((c = getopt(argc, argv, "bCl:pP:qs:v")) != -1) {
+    while ((c = getopt(argc, argv, "bCl:pP:qs:vV")) != -1) {
         switch (c) {
         case 'b':
             bflag = true;
@@ -777,6 +778,9 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
         case 'v':
             vflag = true;
             break;
+        case 'V':
+            vrawflag = true;
+            break;
         default:
             qemuio_command_usage(&read_cmd);
             return -EINVAL;
@@ -869,10 +873,15 @@ static int read_f(BlockBackend *blk, int argc, char **argv)
     if (vflag) {
         dump_buffer(buf, offset, count);
     }
+    if (vrawflag) {
+        write(STDOUT_FILENO, buf, count);
+    }
 
     /* Finally, report back -- -C gives a parsable format */
-    t2 = tsub(t2, t1);
-    print_report("read", &t2, offset, count, total, cnt, Cflag);
+    if (!vrawflag) {
+        t2 = tsub(t2, t1);
+        print_report("read", &t2, offset, count, total, cnt, Cflag);
+    }
 
 out:
     qemu_io_free(buf);
-- 
2.17.1


