Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E175C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74FA21BE5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbXEYw3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74FA21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYF5-00080C-Kn
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kUYA1-0001uA-ST
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kUYA0-0006Fn-5D
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603125443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xyKHqoXsMaWLGNeEEfI9VERvN/PBwd2ItxKq+ji5ns=;
 b=YbXEYw3aYoJhOzTaCEFxHCtG8C7pnV21XS23ELzTXrQ3gGFmRjJ+mulNn2uQFMHlAfErvi
 4k8bYFiTBNH6lTSoyTkB/YZD3DYbtclPp6/cVMTxseHmd2C5kl+3hBvhxU60xOozG0k8+K
 GNmpgMDRYcJ7OE2l+zT1Gla731wQOe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-wWUo6pk8PfKxtTc5V1ySFg-1; Mon, 19 Oct 2020 12:37:21 -0400
X-MC-Unique: wWUo6pk8PfKxtTc5V1ySFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B2D38049C2;
 Mon, 19 Oct 2020 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5F565B4AD;
 Mon, 19 Oct 2020 16:37:17 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] libqtest: fix memory leak in the qtest_qmp_event_ref
Date: Mon, 19 Oct 2020 19:37:01 +0300
Message-Id: <20201019163702.471239-4-mlevitsk@redhat.com>
In-Reply-To: <20201019163702.471239-1-mlevitsk@redhat.com>
References: <20201019163702.471239-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The g_list_remove_link doesn't free the link element,
opposed to what I thought.
Switch to g_list_delete_link that does free it.

Also refactor the code a bit.
Thanks for Max Reitz for helping me with this.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qtest/libqtest.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index bd96cb6fdd..9ae052d566 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -795,15 +795,12 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
 
 QDict *qtest_qmp_event_ref(QTestState *s, const char *event)
 {
-    GList *next = NULL;
-    QDict *response;
-
-    for (GList *it = s->pending_events; it != NULL; it = next) {
+    while (s->pending_events) {
 
-        next = it->next;
-        response = (QDict *)it->data;
+        GList *first = s->pending_events;
+        QDict *response = (QDict *)first->data;
 
-        s->pending_events = g_list_remove_link(s->pending_events, it);
+        s->pending_events = g_list_delete_link(s->pending_events, first);
 
         if (!strcmp(qdict_get_str(response, "event"), event)) {
             return response;
-- 
2.26.2


