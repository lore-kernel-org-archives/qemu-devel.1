Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02BDC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C9C2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="djVRby0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C9C2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvMc5-0001PF-RY
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 11:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jvMbW-0000xc-Qf
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 11:12:22 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:43776)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1jvMbQ-00009T-3u
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 11:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=jBpZ8VNk9K7vcuvwnQ
 VFDcHvBEEGcPq+v0dDDXvYq00=; b=djVRby0+PpN81rUqxE1116NQQRL5v++M2f
 DbmwXoSUp6biL4hE9UfjtRuv0wakGBna7OVDsCM/HDxDtlkfyRee03Ie9PqSNtqm
 13jwBibdraNfVdaUoqZ8PiASCMDHMK7+x7SIfFYbmrzmImnLAItIWvdzWDCqAFtW
 1o3WL3uOQ=
Received: from localhost.localdomain (unknown [183.159.72.144])
 by smtp1 (Coremail) with SMTP id GdxpCgBn_po8yw1fATzIBQ--.7224S4;
 Tue, 14 Jul 2020 23:11:57 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
Subject: [PATCH] hmp: fix memory leak in qom_composition_compare()
Date: Tue, 14 Jul 2020 08:11:52 -0700
Message-Id: <20200714151152.54760-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgBn_po8yw1fATzIBQ--.7224S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWfWF1fAw1DKw4DGFWktFb_yoW8Zr1UpF
 nxXryIy34xt3y3ZFWkZ3WkuF1UXwsayay3Xasavw1jyrnIva47Wrn2kF15ZF1DW3yrZr9I
 934Utr1DWayUAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UbeOXUUUUU=
X-Originating-IP: [183.159.72.144]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiTx1hbVsGVIUD0AAAsB
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 11:12:01
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While 'make chekc', I got following error:

root@ubuntu:~/qemu# ./tests/qtest/device-introspect-test
/x86_64/device/introspect/list: OK
/x86_64/device/introspect/list-fields: OK
/x86_64/device/introspect/none:
=================================================================
==53741==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 212 byte(s) in 20 object(s) allocated from:
    #0 0x7f3b6319cb40 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xdeb40)
    #1 0x7f3b62805ab8 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x51ab8)

SUMMARY: AddressSanitizer: 212 byte(s) leaked in 20 allocation(s).
tests/qtest/libqtest.c:166: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
Aborted (core dumped)

This is because the 'info qom-tree' path has a memory leak and qemu
exit 1. The leak is in 'qom_composition_compare'. This patch fixes this.

Fixes: e8c9e65816f("qom: Make "info qom-tree" show children sorted")
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 qom/qom-hmp-cmds.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 9ed8bb1c9f..3547d5ba4e 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -96,8 +96,10 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent);
 
 static int qom_composition_compare(const void *a, const void *b, void *ignore)
 {
-    return g_strcmp0(a ? object_get_canonical_path_component(a) : NULL,
-                     b ? object_get_canonical_path_component(b) : NULL);
+    g_autofree char *t1 = a ? object_get_canonical_path_component(a) : NULL;
+    g_autofree char *t2 = b ? object_get_canonical_path_component(b) : NULL;
+
+    return g_strcmp0(t1, t2);
 }
 
 static int insert_qom_composition_child(Object *obj, void *opaque)
-- 
2.17.1


