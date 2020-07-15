Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8686EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:13:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5B220658
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W9V8Xng3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5B220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvj5q-0007U0-I8
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 11:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jvj5B-00071Y-Ql
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:12:30 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:41992)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1jvj55-0007zt-Bw
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=Jt3NNPR5zOSZ30FiRv
 6kYMnF5H9aP3X0ia43q6OL6jk=; b=W9V8Xng3LTlM+yCiXHl6iWLVce+YzfWyz4
 1/EpM7UpRTPDNftg7uLLWNUeQ9sZ+xr1Kb/YZ0962pvk8BSBLccsmF9z0rk0rz8z
 rIqI8x3zIw8OHqnpJfNW0Jx7eYnM6cwu+NkTdeuGrNnG8HWTx8+7OI3lZrQNAd1p
 B21TUF6jU=
Received: from localhost.localdomain (unknown [183.159.72.144])
 by smtp1 (Coremail) with SMTP id GdxpCgC3xXG_HA9fikzLAA--.5882S4;
 Wed, 15 Jul 2020 23:12:00 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: armbru@redhat.com,
	mdroth@linux.vnet.ibm.com,
	pbonzini@redhat.com
Subject: [PATCH] qapi: record the last element in order to avoid memory leak
Date: Wed, 15 Jul 2020 08:11:53 -0700
Message-Id: <20200715151153.15054-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgC3xXG_HA9fikzLAA--.5882S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFyDGFyDAFyrtFWxtw48Xrb_yoW5CF47pF
 Z3Jr97KrZ5JFWfGr1DGr18Kr13tw4xJryUu3yrWw10yF15urWktF4kK3yjv3W8CrW8AF45
 XFWktrZxuFWxAaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ub18PUUUUU=
X-Originating-IP: [183.159.72.144]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFAFibVaD6kJswgAAsJ
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 11:12:07
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

This is because in 'visit_type_UserDefOneList' function when
'visit_type_UserDefOne' failed and we go to out_obj. And have
no chance to process the last element. The path is:
visit_type_UserDefOneList
    ->visit_type_UserDefOne(error occured)
        ->qapi_free_UserDefOneList
            -->visit_type_UserDefOneList(again)

In the last 'visit_type_UserDefOneList' we will free the elements
allocated in the first 'visit_type_UserDefOneList'. However we delete
the element in 'qapi_dealloc_next_list'. If then 'visit_type_UserDefOne'
return false we will skip the element that still in the 'obj' linked
list. This is why the ASAN complains this memory leak.
This patch store the recent processing elements in 'QapiDeallocVisitor'.
In 'qapi_dealloc_end_list' if it is not NULL, we free it.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 qapi/qapi-dealloc-visitor.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
index ef283f2966..6335cadd9c 100644
--- a/qapi/qapi-dealloc-visitor.c
+++ b/qapi/qapi-dealloc-visitor.c
@@ -20,8 +20,14 @@
 struct QapiDeallocVisitor
 {
     Visitor visitor;
+    void *last;
 };
 
+static QapiDeallocVisitor *to_qdv(Visitor *v)
+{
+    return container_of(v, QapiDeallocVisitor, visitor);
+}
+
 static bool qapi_dealloc_start_struct(Visitor *v, const char *name, void **obj,
                                       size_t unused, Error **errp)
 {
@@ -46,19 +52,25 @@ static bool qapi_dealloc_start_list(Visitor *v, const char *name,
                                     GenericList **list, size_t size,
                                     Error **errp)
 {
+    QapiDeallocVisitor *qdv = to_qdv(v);
+    qdv->last = *list;
     return true;
 }
 
 static GenericList *qapi_dealloc_next_list(Visitor *v, GenericList *tail,
                                            size_t size)
 {
+    QapiDeallocVisitor *qdv = to_qdv(v);
     GenericList *next = tail->next;
+    qdv->last = next;
     g_free(tail);
     return next;
 }
 
 static void qapi_dealloc_end_list(Visitor *v, void **obj)
 {
+    QapiDeallocVisitor *qdv = to_qdv(v);
+    g_free(qdv->last);
 }
 
 static bool qapi_dealloc_type_str(Visitor *v, const char *name, char **obj,
-- 
2.17.1


