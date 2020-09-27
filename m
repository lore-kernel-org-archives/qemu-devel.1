Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D689C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC2623718
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 12:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="oxcvDeqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC2623718
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMVcD-0000qK-VX
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 08:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1fb057f08700e9264634c90b960f2c93f36cfb44@lizzy.crudebyte.com>)
 id 1kMVbI-000883-Ce
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:16:20 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:36287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1fb057f08700e9264634c90b960f2c93f36cfb44@lizzy.crudebyte.com>)
 id 1kMVbG-0006SG-N4
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 08:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=vzTZmwRo6gxL8ZvAfTv4lGN1iSk8y/hJoFzIf3N9sQc=; b=oxcvD
 eqNfbpl1ZGjoSkbxF0W3Y0/nVsMUNrRKobGxBdW3m7/tWFVQ80Cm8+30GH0CGmJ0ErZpYyiZbYmqp
 pl8UATKl7AadaAtmz6Z0AsRRnAUA9tKtFKg8cNUI82GJC3EugcskDh4sdChaQql9TQnXz4YZoc1CC
 URGNseDQdCvXqFi3H+r1Id07yXCDSIoVvlI7jh4adsfGAfRzWOvSn89JEl8volG1j7sp6gfHXViXq
 WDEtrdm6IFGCsXlEkW6rP5mOV7ay5Nvao0xboZL4EEKjowqSArk8Wk9eSDg7kQ5q0EgVadYu5RvAH
 HTy8wOEQXChrFw2UL8AjuHj3NC2Ow==;
Message-Id: <1fb057f08700e9264634c90b960f2c93f36cfb44.1601203436.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601203436.git.qemu_oss@crudebyte.com>
References: <cover.1601203436.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 27 Sep 2020 12:38:28 +0200
Subject: [PATCH 01/12] tests/qtest/qgraph: add qemu_name to QOSGraphNode
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=1fb057f08700e9264634c90b960f2c93f36cfb44@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 07:42:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new member variable 'qemu_name' to struct QOSGraphNode.

This new member may be optionally set in case a different
name for the node (which must always be unique) vs. its
actually associated QEMU (QMP) device name is required.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/qgraph.c          | 1 +
 tests/qtest/libqos/qgraph_internal.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qtest/libqos/qgraph.c b/tests/qtest/libqos/qgraph.c
index fc49cfa879..e42f3eaafa 100644
--- a/tests/qtest/libqos/qgraph.c
+++ b/tests/qtest/libqos/qgraph.c
@@ -153,6 +153,7 @@ static QOSGraphNode *create_node(const char *name, QOSNodeType type)
 static void destroy_node(void *val)
 {
     QOSGraphNode *node = val;
+    g_free(node->qemu_name);
     g_free(node->command_line);
     g_free(node);
 }
diff --git a/tests/qtest/libqos/qgraph_internal.h b/tests/qtest/libqos/qgraph_internal.h
index 968fa69450..974985dce9 100644
--- a/tests/qtest/libqos/qgraph_internal.h
+++ b/tests/qtest/libqos/qgraph_internal.h
@@ -56,6 +56,7 @@ struct QOSGraphNode {
     bool available;     /* set by QEMU via QMP, used during graph walk */
     bool visited;       /* used during graph walk */
     char *name;         /* used to identify the node */
+    char *qemu_name;    /* optional: see qos_node_create_driver_named() */
     char *command_line; /* used to start QEMU at test execution */
     union {
         struct {
-- 
2.20.1


