Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09293C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA6920679
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 17:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="fVGRuF8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA6920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOOn4-0006wn-Ba
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 13:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5e3a48aa672d7fcfdc48dead3d031cdf457e413c@lizzy.crudebyte.com>)
 id 1kOOhR-0000n7-Ax
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:18:29 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:44445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5e3a48aa672d7fcfdc48dead3d031cdf457e413c@lizzy.crudebyte.com>)
 id 1kOOhP-0001A4-NP
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 13:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=Cyyld5a/6X2z/GHtUILwJZBN75BuasEc9WQ7betFIyk=; b=fVGRu
 F8mLg6wk66MEjg1YtbyuklNbwWyB1DjxeRBpOVxLidrnKFqari8u8sklAW+AGmWXLebA2b9R6Jsqy
 RjZ58goeQAtgGl3gijGwa8YPUcWkhB7w8IZ10gPht3Gqsk609nuqQErFVpuXufCj/R1iZW04DiPGG
 hRzwTljNs7qRRLa60zCAGHXwa+yZL5hPtWbhq0gAzqv+qfyyiypLRzw4GPxu7ldPB5XkL/kKQKbBB
 KBNoUPBNFHlkAGmTVKHSfVvjE6Vp8fDBdEcItCf/a3SDFkp1Dh070dI0luJoCXiuJl9NehxV+vmJh
 RkpJ43iivk7tHE3CVe1rpNPQcLoyQ==;
Message-Id: <5e3a48aa672d7fcfdc48dead3d031cdf457e413c.1601655308.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1601655308.git.qemu_oss@crudebyte.com>
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 2 Oct 2020 18:15:05 +0200
Subject: [PATCH v3 04/11] tests/qtest/qos-test: dump qos graph if verbose
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>, berrange@redhat.com
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=5e3a48aa672d7fcfdc48dead3d031cdf457e413c@lizzy.crudebyte.com;
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

If qtests were run in verbose mode (i.e. if --verbose CL argument was
provided) then dump the generated qos graph (all nodes and edges,
along with their current individual availability status) to stdout.

See API doc comment on function qos_dump_graph() for details.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/qos-test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 8fdf87b183..d98ef78613 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -322,6 +322,9 @@ int main(int argc, char **argv)
     qos_set_machines_devices_available();
 
     qos_graph_foreach_test_path(walk_path);
+    if (g_test_verbose()) {
+        qos_dump_graph();
+    }
     g_test_run();
     qtest_end();
     qos_graph_destroy();
-- 
2.20.1


