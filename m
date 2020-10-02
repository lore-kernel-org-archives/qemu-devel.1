Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096F6C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F659206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="JDU+w+1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F659206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKdA-0005DU-Qv
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <040e30f37e4bf31b14331d97f2c8c2bad430fd4c@lizzy.crudebyte.com>)
 id 1kOKaS-0002oT-JT
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:55:00 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:55963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <040e30f37e4bf31b14331d97f2c8c2bad430fd4c@lizzy.crudebyte.com>)
 id 1kOKaR-00009U-3v
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=GZyTCxmYrj69i/SVm0Mbovz8XYMGA8mLuCNmRo809OE=; b=JDU+w
 +1Vsy/goVVqEQqJcdTROhZUKR1WJnl9hoWDqhd0S3wte8hed8T/QJaRMPX+F5vVkp/4hLgxV8phK7
 wDu92ACuzyoKSyolS7ab5yWQ0TJO3FoNUwM9ADh1abZ+N+onhytV0MCn+VoH4JQvZ3RPfBMPxKFQK
 sJ64mK77n0HiGRyvAlj+OmbPUqbVP42TGMzQhaF4NumG3gjd/cM71I9FgIqDQP6Qo55bhonHrS6XR
 KgY0QIOQ5iFVio/Y/Q0m9GUThHbX6SBRhx/PYWXLGq9lHOu4HFa0fpe9WwGi3d7Cv2tkhULgTYh3I
 EFNlbBw5O77Df3bHP7DHj+VrDfolQ==;
Message-Id: <040e30f37e4bf31b14331d97f2c8c2bad430fd4c.1601639563.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601639563.git.qemu_oss@crudebyte.com>
References: <cover.1601639563.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 2 Oct 2020 13:51:54 +0200
Subject: [PATCH v2 01/11] libqos/qgraph: add qemu_name to QOSGraphNode
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=040e30f37e4bf31b14331d97f2c8c2bad430fd4c@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 08:18:24
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
name for the node (which must always be a unique name) vs.
its actually associated QEMU (QMP) device name is required.

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


