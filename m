Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDD4C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C2862063A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Q27S+pQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2862063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5S7-0005LR-67
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jw5KY-0007Xd-6e
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:57:50 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:40934)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jw5KS-0002rr-Ks
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=QKU8i7UR2CmH/QcPhR
 NvnooOKXMXtOgn7mW/2BfeVrU=; b=Q27S+pQ8YUkksHrodmIunNsKDZFl2lnffv
 udsLVff+wcxumST2gOhUnXbMZP2TluTNnWL8c2FduoSb0NJDFIDpr7VAoIfRjxYq
 9Gdtftl7+Jj4GnYr1/Mtxt55N+g8/U9XJNejlotOpPgzSQ9NIcCFalttL0P4DcbW
 OE/nV3tmM=
Received: from localhost.localdomain (unknown [183.159.72.144])
 by smtp5 (Coremail) with SMTP id HdxpCgBX9pDBahBf0HrsCA--.14107S4;
 Thu, 16 Jul 2020 22:57:07 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: armbru@redhat.com,
	mdroth@linux.vnet.ibm.com
Subject: [PATCH] qapi: fix memory leak in visit_type_UserDefOneList
Date: Thu, 16 Jul 2020 07:57:02 -0700
Message-Id: <20200716145702.41845-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgBX9pDBahBf0HrsCA--.14107S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw13CrW5XryUCFy3Ar4fKrg_yoW8AFyDp3
 WDA3s2y3yxJFZ5Gr4DGF18WFy7t39rJr18Ww4ruw1UAF15GrZaywsrKw4qyF4DC34rAFW5
 Xw4ktry5ZrWxAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2385UUUUU=
X-Originating-IP: [183.159.72.144]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFANjbVaD6lTqyAAAsQ
Received-SPF: pass client-ip=123.126.97.5; envelope-from=liq3ea@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 10:57:31
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

While executing 'tests/test-qobject-input-visitor'. I got
following error:

/visitor/input/fail/alternate: OK
/visitor/input/fail/union-list: OK

=================================================================
==4353==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7f192d0c5d28 in __interceptor_calloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xded28)
    #1 0x7f192cd21b10 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x51b10)
    #2 0x556725f6bbee in visit_next_list qapi/qapi-visit-core.c:86
    #3 0x556725f49e15 in visit_type_UserDefOneList tests/test-qapi-visit.c:474
    #4 0x556725f4489b in test_visitor_in_fail_struct_in_list tests/test-qobject-input-visitor.c:1086
    #5 0x7f192cd42f29  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72f29)

SUMMARY: AddressSanitizer: 16 byte(s) leaked in 1 allocation(s).

This is because we don't free the last element of the linkedlist
if 'visit_type_UserDefOne' fails. This patch fixes this.

Fixes: cdd2b228b97("qapi: Smooth visitor error checking in generated
code")

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 scripts/qapi/visit.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 3fb2f30510..cdabc5fa28 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -249,6 +249,7 @@ bool visit_type_%(c_name)s(Visitor *v, const char *name, %(c_name)s **obj, Error
     if (!*obj) {
         /* incomplete */
         assert(visit_is_dealloc(v));
+        ok = true;
         goto out_obj;
     }
     if (!visit_type_%(c_name)s_members(v, *obj, errp)) {
-- 
2.17.1


