Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0B2C2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA629206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlvwqgp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA629206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtqm-0002zr-9t
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFn-00062c-8T
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFl-0000lJ-P3
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:50 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFl-0000h9-55
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id w15so8066939wru.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nb2hZFwKzalXfmKpcbYjmUeCAEo1SDTH5IqQlmfU414=;
 b=Mlvwqgp4qGA8Fg20kZKCRxrVTnH9nl3keRg5gX5ia4/a25JwygHQuQVfd3R0u9X/Ln
 jFzr/7Qpk8dRaqssdw3yIqAZe1Wd2/e8pij/SyHZN9tsh6F9r+XfXDoEObCJXf0GlzhC
 68M6NEBkwvljigddmM2OrBXaigcwO3A/eYcDy2TwtQttDP+JtYqyWzjlP892pzNGHOpx
 dkOe9qk4bnBNuaoGgng7s0bJIdfFKXMNcFcqv1z2UI5s6KKZREO0bNf9Cwryzx5SBya7
 HZFNE19pk+APZgtq3W28aKAgL0ypJ+uupV6R+OE/AgwcLI7eEpRFFiUDmWSeHo23fg59
 rAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=nb2hZFwKzalXfmKpcbYjmUeCAEo1SDTH5IqQlmfU414=;
 b=HoHIRVuRdGAzTkYwaczKsOt5uTpSu0Aff3i2lT9xQlGna/s/Sm2ZjSZ8eVZB9RCBp2
 +d/T7LKCdoCDZZ4yujXgeZW92aBAcjvvOzgIb0ETbXxUoGMH/8BhdC1/h9ppQOB6bmgc
 gYzXVQ9DqRBaePe9n4VGHK3NDIbLxFaEXwtYkquM3d4Pj9fy/RNHguoF1BGoWErs9Orl
 g7/ajP8H9T2rvHOTaNWwmWmTOT+ImG5bYKmevHdVBX1HwlYpV+V4gKrH3BMdenfLmCPF
 O68g9JP4oJckskZbnSsDko8Y/BaXBAbuZQdr0c4GD9r1OrXYuP6+i+Hus5dreOuWbw3t
 +8BQ==
X-Gm-Message-State: APjAAAUMwMIjE0tAe6+rqXAuOg6Li7yIl5DULrrq/IhhwcfJV2g/QXkY
 SCfRxMSH4XefLmX7MQsaOMRoc0Hs
X-Google-Smtp-Source: APXvYqznP2mGIOd/oI3qbOORu/XNCRRVQ5dz+tEQGyoGG6EashnmbuSxwOjhbszs8HQ+Yial5Iaaew==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr32258278wrn.356.1576513787766; 
 Mon, 16 Dec 2019 08:29:47 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 60/62] qsp: Use WITH_RCU_READ_LOCK_GUARD
Date: Mon, 16 Dec 2019 17:28:44 +0100
Message-Id: <1576513726-53700-61-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The automatic rcu read lock maintenance works quite
nicely in this case where it previously relied on a comment to
delimit the lifetime and now has a block.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qsp.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/util/qsp.c b/util/qsp.c
index 6226541..7d5147f 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -598,7 +598,6 @@ static void qsp_ht_delete(void *p, uint32_t h, void *htp)
 
 static void qsp_mktree(GTree *tree, bool callsite_coalesce)
 {
-    QSPSnapshot *snap;
     struct qht ht, coalesce_ht;
     struct qht *htp;
 
@@ -610,20 +609,19 @@ static void qsp_mktree(GTree *tree, bool callsite_coalesce)
      * We must remain in an RCU read-side critical section until we're done
      * with the snapshot.
      */
-    rcu_read_lock();
-    snap = atomic_rcu_read(&qsp_snapshot);
+    WITH_RCU_READ_LOCK_GUARD() {
+        QSPSnapshot *snap = atomic_rcu_read(&qsp_snapshot);
 
-    /* Aggregate all results from the global hash table into a local one */
-    qht_init(&ht, qsp_entry_no_thread_cmp, QSP_INITIAL_SIZE,
-             QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
-    qht_iter(&qsp_ht, qsp_aggregate, &ht);
+        /* Aggregate all results from the global hash table into a local one */
+        qht_init(&ht, qsp_entry_no_thread_cmp, QSP_INITIAL_SIZE,
+                 QHT_MODE_AUTO_RESIZE | QHT_MODE_RAW_MUTEXES);
+        qht_iter(&qsp_ht, qsp_aggregate, &ht);
 
-    /* compute the difference wrt the snapshot, if any */
-    if (snap) {
-        qsp_diff(&snap->ht, &ht);
+        /* compute the difference wrt the snapshot, if any */
+        if (snap) {
+            qsp_diff(&snap->ht, &ht);
+        }
     }
-    /* done with the snapshot; RCU can reclaim it */
-    rcu_read_unlock();
 
     htp = &ht;
     if (callsite_coalesce) {
-- 
1.8.3.1



