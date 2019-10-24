Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C49CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D2120684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D2120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYoL-00077g-Cl
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w.bumiller@proxmox.com>) id 1iNYOC-0004SO-8D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:22:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <w.bumiller@proxmox.com>) id 1iNYOA-0000lE-U9
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:22:35 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:3405)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
 id 1iNYOA-0000jC-Mq; Thu, 24 Oct 2019 04:22:34 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id AE566407FB;
 Thu, 24 Oct 2019 10:12:32 +0200 (CEST)
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] monitor/qmp: resume monitor when clearing its queue
Date: Thu, 24 Oct 2019 10:12:31 +0200
Message-Id: <20191024081231.19087-1-w.bumiller@proxmox.com>
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-stable@nongnu.org
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
Any new connections to the qmp socket will be accept()ed and
show the greeting, but will not respond to any messages sent
afterwards (as they will not be read from the
still-suspended socket).
Fix this by resuming the monitor when clearing a queue which
was filled up.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
---
Changes to v1:
  * Update commit message to include the resulting symptoms.
  * Moved the resume code from `monitor_qmp_cleanup_req_queue_locked` to
    `monitor_qmp_cleanup_queues` to avoid an unnecessary resume when
    destroying the monitor (as the `_locked` version is also used by
    `monitor_data_destroy()`.
  * Renamed `monitor_qmp_cleanup_queues` to
    `monitor_qmp_cleanup_queues_and_resume` to reflect the change and be
    verbose about it for potential future users of the function.
    Currently the only user is `monitor_qmp_event()` in the
    `CHR_EVENT_CLOSED` case, which is exactly the problematic case curren=
tly.

Sorry for the deleay :|

 monitor/qmp.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index 9d9e5d8b27..df689aa95e 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -75,10 +75,30 @@ static void monitor_qmp_cleanup_req_queue_locked(Moni=
torQMP *mon)
     }
 }
=20
-static void monitor_qmp_cleanup_queues(MonitorQMP *mon)
+static void monitor_qmp_cleanup_queues_and_resume(MonitorQMP *mon)
 {
     qemu_mutex_lock(&mon->qmp_queue_lock);
+
+    /*
+     * Same condition as in monitor_qmp_bh_dispatcher(), but before remo=
ving an
+     * element from the queue (hence no `- 1`), also, the queue should n=
ot be
+     * empty either, otherwise the monitor hasn't been suspended yet (or=
 was
+     * already resumed).
+     */
+    bool need_resume =3D (!qmp_oob_enabled(mon) && mon->qmp_requests->le=
ngth > 0)
+        || mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX;
+
     monitor_qmp_cleanup_req_queue_locked(mon);
+
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
+
     qemu_mutex_unlock(&mon->qmp_queue_lock);
 }
=20
@@ -332,7 +352,7 @@ static void monitor_qmp_event(void *opaque, int event=
)
          * stdio, it's possible that stdout is still open when stdin
          * is closed.
          */
-        monitor_qmp_cleanup_queues(mon);
+        monitor_qmp_cleanup_queues_and_resume(mon);
         json_message_parser_destroy(&mon->parser);
         json_message_parser_init(&mon->parser, handle_qmp_command,
                                  mon, NULL);
--=20
2.20.1



