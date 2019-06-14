Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1385CC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8F0208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 06:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8F0208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48780 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbfp4-0007eG-3Y
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 02:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55971)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao.peng@linux.alibaba.com>) id 1hbfoa-0007FS-L9
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao.peng@linux.alibaba.com>) id 1hbfoZ-00038k-Ex
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:35:56 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:52556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao.peng@linux.alibaba.com>)
 id 1hbfoZ-00034L-5t
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 02:35:55 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R941e4; CH=green; DM=||false|;
 FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01422; MF=tao.peng@linux.alibaba.com; NM=1;
 PH=DS; RN=7; SR=0; TI=SMTPD_---0TU87-DM_1560494124; 
Received: from localhost(mailfrom:tao.peng@linux.alibaba.com
 fp:SMTPD_---0TU87-DM_1560494124) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 14 Jun 2019 14:35:48 +0800
From: Peng Tao <tao.peng@linux.alibaba.com>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 14:35:13 +0800
Message-Id: <1560494113-1141-1-git-send-email-tao.peng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 47.88.44.36
Subject: [Qemu-devel] [PATCH] migration: allow private destination ram with
 x-ignore-shared
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
Cc: Peng Tao <tao.peng@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Xu Wang <xu@hyper.sh>,
 Jiangshan Lai <laijs@hyper.sh>, kata-dev@lists.katacontainers.io
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By removing the share ram check, qemu is able to migrate
to private destination ram when x-ignore-shared capability
is on. Then we can create multiple destination VMs based
on the same source VM.

This changes the x-ignore-shared migration capability to
work similar to Lai's original bypass-shared-memory
work(https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg00003.html)
which enables kata containers (https://katacontainers.io)
to implement the VM templating feature.

An example usage in kata containers(https://katacontainers.io):
1. Start the source VM:
   qemu-system-x86 -m 2G \
     -object memory-backend-file,id=mem0,size=2G,share=on,mem-path=/tmpfs/template-memory \
     -numa node,memdev=mem0
2. Stop the template VM, set migration x-ignore-shared capability,
   migrate "exec:cat>/tmpfs/state", quit it
3. Start target VM:
   qemu-system-x86 -m 2G \
     -object memory-backend-file,id=mem0,size=2G,share=off,mem-path=/tmpfs/template-memory \
     -numa node,memdev=mem0 \
     -incoming defer
4. connect to target VM qmp, set migration x-ignore-shared capability,
migrate_incoming "exec:cat /tmpfs/state"
5. create more target VMs repeating 3 and 4

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: Jiangshan Lai <laijs@hyper.sh>
Cc: Xu Wang <xu@hyper.sh>
Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
---
 migration/ram.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 1ca9ba7..cdb82a3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3373,7 +3373,6 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         }
         if (migrate_ignore_shared()) {
             qemu_put_be64(f, block->mr->addr);
-            qemu_put_byte(f, ramblock_is_ignored(block) ? 1 : 0);
         }
     }
 
@@ -4340,12 +4339,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                     }
                     if (migrate_ignore_shared()) {
                         hwaddr addr = qemu_get_be64(f);
-                        bool ignored = qemu_get_byte(f);
-                        if (ignored != ramblock_is_ignored(block)) {
-                            error_report("RAM block %s should %s be migrated",
-                                         id, ignored ? "" : "not");
-                            ret = -EINVAL;
-                        }
                         if (ramblock_is_ignored(block) &&
                             block->mr->addr != addr) {
                             error_report("Mismatched GPAs for block %s "
-- 
1.8.3.1


