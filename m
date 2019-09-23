Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9F6C432C1
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C5A21A4C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 23:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C5A21A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCXvi-0004al-7j
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 19:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iCXuz-00045d-US
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iCXuy-0001VZ-SK
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 19:38:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iCXuv-0001UY-3F; Mon, 23 Sep 2019 19:38:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 21293300CB25;
 Mon, 23 Sep 2019 23:38:52 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9382B6012D;
 Mon, 23 Sep 2019 23:38:50 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-pr-helper: fix crash in mpath_reconstruct_sense
Date: Tue, 24 Sep 2019 02:38:48 +0300
Message-Id: <20190923233848.29445-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 23 Sep 2019 23:38:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'r' variable was accidently shadowed, and because of this
we were always passing 0 to mpath_generic_sense, instead of original
return value, which triggers an abort()

This is an attempt to fix the
https://bugzilla.redhat.com/show_bug.cgi?id=1720047
although there might be other places in the code
that trigger qemu-pr-helper crash, and this fix might
not be the root cause.

The crash was reproduced by creating an iscsi target on a test machine,
and passing it twice to the guest like that:

-blockdev node-name=idisk0,driver=iscsi,transport=...,target=...
-device scsi-block,drive=idisk0,bus=scsi0.0,bootindex=-1,scsi-id=1,lun=0,share-rw=on
-device scsi-block,drive=idisk0,bus=scsi0.0,bootindex=-1,scsi-id=1,lun=1,share-rw=on

Then in the guest, both /dev/sda and /dev/sdb were aggregated by multipath to /dev/mpatha,
which was passed to a nested guest like that

-object pr-manager-helper,id=qemu_pr_helper,path=/root/work/vm/testvm/.run/pr_helper.socket
-blockdev node-name=test,driver=host_device,filename=/dev/mapper/mpatha,pr-manager=qemu_pr_helper
-device scsi-block,drive=test,bus=scsi0.0,bootindex=-1,scsi-id=0,lun=0

The nested guest run:

sg_persist --no-inquiry  -v --out --register --param-sark 0x1234 /dev/sda

Strictly speaking this is wrong configuration since qemu is where
the multipath was split, and thus the iscsi target was not aware of
multipath, and thus when libmpathpersist code rightfully tried to register
the PR key on all paths, it failed to do so.

However qemu-pr-helper should not crash in this case.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 scsi/qemu-pr-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index a8a74d1dba..debb18f4aa 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -323,10 +323,10 @@ static int mpath_reconstruct_sense(int fd, int r, uint8_t *sense)
              */
             uint8_t cdb[6] = { TEST_UNIT_READY };
             int sz = 0;
-            int r = do_sgio(fd, cdb, sense, NULL, &sz, SG_DXFER_NONE);
+            int ret = do_sgio(fd, cdb, sense, NULL, &sz, SG_DXFER_NONE);
 
-            if (r != GOOD) {
-                return r;
+            if (ret != GOOD) {
+                return ret;
             }
             scsi_build_sense(sense, mpath_generic_sense(r));
             return CHECK_CONDITION;
-- 
2.17.2


