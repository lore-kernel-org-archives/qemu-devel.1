Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F5CC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2832238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2832238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZNg-0003x7-Ut
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50136)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMY-0007ua-PM
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMX-00005l-LZ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:34 -0400
Received: from mail.ispras.ru ([83.149.199.45]:56994)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <pavel.dovgaluk@gmail.com>) id 1hqZMX-00005T-Dk
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:44:33 -0400
Received: from [127.0.1.1] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 8F95954006A;
 Thu, 25 Jul 2019 11:44:32 +0300 (MSK)
From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Jul 2019 11:44:32 +0300
Message-ID: <156404427238.18669.12378772823692338069.stgit@pasha-Precision-3630-Tower>
In-Reply-To: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
References: <156404424989.18669.12696116045723475173.stgit@pasha-Precision-3630-Tower>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: [Qemu-devel] [for-4.2 PATCH v2 4/8] replay: fix replay shutdown
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

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch fixes shutdown of the replay process, which is terminated with
the assert when shutdown event is read from the log.
replay_finish_event reads new data_kind and therefore the value of data_kind
should be preserved to be valid at qemu_system_shutdown_request call.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 replay/replay.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/replay/replay.c b/replay/replay.c
index 8b172b2d1b..8d77a4ca4c 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -45,14 +45,14 @@ bool replay_next_event_is(int event)
     }
 
     while (true) {
-        if (event == replay_state.data_kind) {
+        unsigned int data_kind = replay_state.data_kind;
+        if (event == data_kind) {
             res = true;
         }
-        switch (replay_state.data_kind) {
+        switch (data_kind) {
         case EVENT_SHUTDOWN ... EVENT_SHUTDOWN_LAST:
             replay_finish_event();
-            qemu_system_shutdown_request(replay_state.data_kind -
-                                         EVENT_SHUTDOWN);
+            qemu_system_shutdown_request(data_kind - EVENT_SHUTDOWN);
             break;
         default:
             /* clock, time_t, checkpoint and other events */


