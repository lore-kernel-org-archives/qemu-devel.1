Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3335CC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2EB227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2EB227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqCsP-0003ep-R6
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 04:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33900)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqCs1-0002GC-B2
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqCs0-0001jN-61
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:43:33 -0400
Received: from mail.ispras.ru ([83.149.199.45]:58824)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqCrz-0001j6-Tp
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:43:32 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 16FEC54006A;
 Wed, 24 Jul 2019 11:43:31 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 24 Jul 2019 11:43:30 +0300
Message-ID: <156395781091.510.11391851999381257435.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
References: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [PATCH for-4.2 03/14] replay: disable default snapshot
 for record/replay
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com,
 mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru,
 mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com,
 thomas.dullien@googlemail.com, dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

This patch disables setting '-snapshot' option on by default
in record/replay mode. This is needed for creating vmstates in record
and replay modes.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Acked-by: Kevin Wolf <kwolf@redhat.com>
---
 vl.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index b426b32134..b73fd078a8 100644
--- a/vl.c
+++ b/vl.c
@@ -1202,7 +1202,7 @@ static void configure_blockdev(BlockdevOptionsQueue *bdo_queue,
         qapi_free_BlockdevOptions(bdo->bdo);
         g_free(bdo);
     }
-    if (snapshot || replay_mode != REPLAY_MODE_NONE) {
+    if (snapshot) {
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
                           NULL, NULL);
     }
@@ -3051,7 +3051,13 @@ int main(int argc, char **argv, char **envp)
                 drive_add(IF_PFLASH, -1, optarg, PFLASH_OPTS);
                 break;
             case QEMU_OPTION_snapshot:
-                snapshot = 1;
+                {
+                    Error *blocker = NULL;
+                    snapshot = 1;
+                    error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED,
+                               "-snapshot");
+                    replay_add_blocker(blocker);
+                }
                 break;
             case QEMU_OPTION_numa:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("numa"),


