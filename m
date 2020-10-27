Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826A6C71156
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E75AF222EA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 15:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqqsmH/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75AF222EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQsX-0003j7-PP
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 11:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXQhL-0006DQ-9J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32414)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXQhA-0007gP-0U
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 11:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603811729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aojtNcYM5JZGocHlr42uqtul6nag2xreruX+X6NpCKo=;
 b=XqqsmH/Brw5oJY7K45fpVonCdT6+tUkebWLZDCbAQI3Rwy6l9zoqlMkSFDE99DgQGcLSoe
 bmtjG8iIJw10jEMsLZzBh+MqGaY5Y8WOq0fFG7h6EoiJOxM4t9cL3H/6s0F7nT10ORghCR
 +o+yA5lCatlrXY39SJLiKsaMEjK0zZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-fLL_FNFrOtuRZIyp8XumJQ-1; Tue, 27 Oct 2020 11:15:26 -0400
X-MC-Unique: fLL_FNFrOtuRZIyp8XumJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25B4F8030DB;
 Tue, 27 Oct 2020 15:15:25 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 265AD55762;
 Tue, 27 Oct 2020 15:15:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 5/5] block: End quiescent sections when a BDS is deleted
Date: Tue, 27 Oct 2020 16:15:15 +0100
Message-Id: <20201027151515.213565-6-kwolf@redhat.com>
In-Reply-To: <20201027151515.213565-1-kwolf@redhat.com>
References: <20201027151515.213565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

If a BDS gets deleted during blk_drain_all(), it might miss a
call to bdrv_do_drained_end(). This means missing a call to
aio_enable_external() and the AIO context remains disabled for
ever. This can cause a device to become irresponsive and to
disrupt the guest execution, ie. hang, loop forever or worse.

This scenario is quite easy to encounter with virtio-scsi
on POWER when punching multiple blockdev-create QMP commands
while the guest is booting and it is still running the SLOF
firmware. This happens because SLOF disables/re-enables PCI
devices multiple times via IO/MEM/MASTER bits of PCI_COMMAND
register after the initial probe/feature negotiation, as it
tends to work with a single device at a time at various stages
like probing and running block/network bootloaders without
doing a full reset in-between. This naturally generates many
dataplane stops and starts, and thus many drain sections that
can race with blockdev_create_run(). In the end, SLOF bails
out.

It is somehow reproducible on x86 but it requires to generate
articial dataplane start/stop activity with stop/cont QMP
commands. In this case, seabios ends up looping for ever,
waiting for the virtio-scsi device to send a response to
a command it never received.

Add a helper that pairs all previously called bdrv_do_drained_begin()
with a bdrv_do_drained_end() and call it from bdrv_close().
While at it, update the "/bdrv-drain/graph-change/drain_all"
test in test-bdrv-drain so that it can catch the issue.

BugId: https://bugzilla.redhat.com/show_bug.cgi?id=1874441
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160346526998.272601.9045392804399803158.stgit@bahia.lan>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h   |  6 ++++++
 block.c                 |  9 +++++++++
 block/io.c              | 13 +++++++++++++
 tests/test-bdrv-drain.c |  1 +
 4 files changed, 29 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index c9d7c58765..4bfe3b546b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -781,6 +781,12 @@ void bdrv_drained_end(BlockDriverState *bs);
  */
 void bdrv_drained_end_no_poll(BlockDriverState *bs, int *drained_end_counter);
 
+/**
+ * End all quiescent sections started by bdrv_drain_all_begin(). This is
+ * only needed when deleting a BDS before bdrv_drain_all_end() is called.
+ */
+void bdrv_drain_all_end_quiesce(BlockDriverState *bs);
+
 /**
  * End a quiescent section started by bdrv_subtree_drained_begin().
  */
diff --git a/block.c b/block.c
index 430edf79bb..ee5b28a979 100644
--- a/block.c
+++ b/block.c
@@ -4458,6 +4458,15 @@ static void bdrv_close(BlockDriverState *bs)
     }
     QLIST_INIT(&bs->aio_notifiers);
     bdrv_drained_end(bs);
+
+    /*
+     * If we're still inside some bdrv_drain_all_begin()/end() sections, end
+     * them now since this BDS won't exist anymore when bdrv_drain_all_end()
+     * gets called.
+     */
+    if (bs->quiesce_counter) {
+        bdrv_drain_all_end_quiesce(bs);
+    }
 }
 
 void bdrv_close_all(void)
diff --git a/block/io.c b/block/io.c
index c33cecd58d..9918f2499c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -633,6 +633,19 @@ void bdrv_drain_all_begin(void)
     }
 }
 
+void bdrv_drain_all_end_quiesce(BlockDriverState *bs)
+{
+    int drained_end_counter = 0;
+
+    g_assert(bs->quiesce_counter > 0);
+    g_assert(!bs->refcnt);
+
+    while (bs->quiesce_counter) {
+        bdrv_do_drained_end(bs, false, NULL, true, &drained_end_counter);
+    }
+    BDRV_POLL_WHILE(bs, qatomic_read(&drained_end_counter) > 0);
+}
+
 void bdrv_drain_all_end(void)
 {
     BlockDriverState *bs = NULL;
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 1595bbc92e..8a29e33e00 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -594,6 +594,7 @@ static void test_graph_change_drain_all(void)
 
     g_assert_cmpint(bs_b->quiesce_counter, ==, 0);
     g_assert_cmpint(b_s->drain_count, ==, 0);
+    g_assert_cmpint(qemu_get_aio_context()->external_disable_cnt, ==, 0);
 
     bdrv_unref(bs_b);
     blk_unref(blk_b);
-- 
2.28.0


