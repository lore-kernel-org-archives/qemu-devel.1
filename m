Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30AFC28EBD
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 18:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9E3206C3
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 18:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9E3206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37420 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha2hN-0005oy-RZ
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 14:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49258)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ha2fb-0004Rl-Vu
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 14:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1ha2fa-000649-LL
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 14:35:55 -0400
Received: from relay.sw.ru ([185.231.240.75]:47598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1ha2fa-00062t-DV; Sun, 09 Jun 2019 14:35:54 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.91)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1ha2fY-00087U-3W; Sun, 09 Jun 2019 21:35:52 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Sun,  9 Jun 2019 21:35:48 +0300
Message-Id: <1560105348-459129-8-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560105348-459129-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1560105348-459129-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 7/7] iotests: amend QEMU NBD process
 synchronization
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 rkagan@virtuozzo.com, andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Processes are dying harder under the Valgring. It results in counting
the dying process as a newborn one. Make it sure that old NBD job get
finished before starting a new one.

Suggested-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/common.nbd | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nbd
index 25fc9ff..e3dcc60 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -22,6 +22,7 @@
 nbd_unix_socket="${TEST_DIR}/qemu-nbd.sock"
 nbd_tcp_addr="127.0.0.1"
 nbd_pid_file="${TEST_DIR}/qemu-nbd.pid"
+nbd_job_pid=""
 
 nbd_server_stop()
 {
@@ -33,6 +34,9 @@ nbd_server_stop()
             kill "$NBD_PID"
         fi
     fi
+    if [ -n "$nbd_job_pid" ] && kill -s 0 "$nbd_job_pid" 2>/dev/null; then
+        wait "$nbd_job_pid"
+    fi
     rm -f "$nbd_unix_socket"
 }
 
@@ -61,6 +65,7 @@ nbd_server_start_unix_socket()
 {
     nbd_server_stop
     $QEMU_NBD -v -t -k "$nbd_unix_socket" "$@" &
+    nbd_job_pid=$!
     nbd_server_wait_for_unix_socket $!
 }
 
@@ -105,5 +110,6 @@ nbd_server_start_tcp_socket()
 {
     nbd_server_stop
     $QEMU_NBD -v -t -b $nbd_tcp_addr -p $nbd_tcp_port "$@" &
+    nbd_job_pid=$!
     nbd_server_wait_for_tcp_socket $!
 }
-- 
1.8.3.1


