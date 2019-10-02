Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBAC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:38:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4320B206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4320B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFa9p-00060A-AR
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 04:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w.bumiller@proxmox.com>) id 1iFa8q-0005MH-EF
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 04:37:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <w.bumiller@proxmox.com>) id 1iFa8p-0005u6-5H
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 04:37:48 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:41519)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
 id 1iFa8o-0005tj-Ue; Wed, 02 Oct 2019 04:37:47 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4187C468A7;
 Wed,  2 Oct 2019 10:30:04 +0200 (CEST)
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] monitor/qmp: resume monitor when clearing its queue
Date: Wed,  2 Oct 2019 10:30:03 +0200
Message-Id: <20191002083003.21556-1-w.bumiller@proxmox.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a monitor's queue is filled up in handle_qmp_command()
it gets suspended. It's the dispatcher bh's job currently to
resume the monitor, which it does after processing an event
from the queue. However, it is possible for a
CHR_EVENT_CLOSED event to be processed before before the bh
is scheduled, which will clear the queue without resuming
the monitor, thereby preventing the dispatcher from reaching
the resume() call.
Fix this by resuming the monitor when clearing a queue which
was filled up.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
@Michael, we ran into this with qemu 4.0, so if the logic in this patch
is correct it may make sense to include it in the 4.0.1 roundup.
A backport is at [1] as 4.0 was before the monitor/ dir split.

[1] https://gitlab.com/wbumiller/qemu/commit/9d8bbb5294ed084f282174b0c91e=
1a614e0a0714

 monitor/qmp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 9d9e5d8b27..c1db5bf940 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -70,9 +70,19 @@ static void qmp_request_free(QMPRequest *req)
 /* Caller must hold mon->qmp.qmp_queue_lock */
 static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon)
 {
+    bool need_resume =3D (!qmp_oob_enabled(mon) && mon->qmp_requests->le=
ngth > 0)
+        || mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX;
     while (!g_queue_is_empty(mon->qmp_requests)) {
         qmp_request_free(g_queue_pop_head(mon->qmp_requests));
     }
+    if (need_resume) {
+        /*
+         * Pairs with the monitor_suspend() in handle_qmp_command() in c=
ase the
+         * queue gets cleared from a CH_EVENT_CLOSED event before the di=
spatch
+         * bh got scheduled.
+         */
+        monitor_resume(&mon->common);
+    }
 }
=20
 static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
--=20
2.20.1



