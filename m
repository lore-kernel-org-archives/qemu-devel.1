Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80DEC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B2521707
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zm1wHhnn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B2521707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXS6d-0005ck-Aa
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXRzG-0006uC-K3
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kXRzD-0002YE-Kk
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603816693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Gy/x1T9WM3IAvu32asY2ozSKIxNuG7eGqcWqehKnHI=;
 b=Zm1wHhnnqj3bgvuRS5m5GPnZzCofO7hKqL93k2WuiqPrhqNcSZ4pFvMbmCxmp8MBcjyHGV
 zLwsitZrcb/vh9xgxc/Q6yDBQo5H5QkGcKz8bESAwk+HuR9cogGgkjG+A5WS4GTHvguyeo
 iAzKe1jHKSz3yBYtqL1X+yzmH7nXwtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-tn-r_n6nNqiQRGjwJprKJg-1; Tue, 27 Oct 2020 12:38:11 -0400
X-MC-Unique: tn-r_n6nNqiQRGjwJprKJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9BEF809DDF;
 Tue, 27 Oct 2020 16:38:10 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-16.ams2.redhat.com [10.36.114.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFCCD1001901;
 Tue, 27 Oct 2020 16:38:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/3] iotests.py: Fix type check errors in wait_migration()
Date: Tue, 27 Oct 2020 17:38:04 +0100
Message-Id: <20201027163806.290960-2-kwolf@redhat.com>
In-Reply-To: <20201027163806.290960-1-kwolf@redhat.com>
References: <20201027163806.290960-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 1847a4a8c20 clarified that event_wait() can return None (though
only with timeout=0) and commit f12a282ff47 annotated it as returning
Optional[QMPMessage].

Type checks in wait_migration() fail because of the unexpected optional
return type:

iotests.py:750: error: Value of type variable "Msg" of "log" cannot be "Optional[Dict[str, Any]]"
iotests.py:751: error: Value of type "Optional[Dict[str, Any]]" is not indexable
iotests.py:754: error: Value of type "Optional[Dict[str, Any]]" is not indexable

Fortunately, the non-zero default timeout is used in the event_wait()
call, so we can make mypy happy by just asserting this.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 63d2ace93c..28388a0fbc 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -747,6 +747,10 @@ class VM(qtest.QEMUQtestMachine):
     def wait_migration(self, expect_runstate: Optional[str]) -> bool:
         while True:
             event = self.event_wait('MIGRATION')
+            # We use the default timeout, and with a timeout, event_wait()
+            # never returns None
+            assert event
+
             log(event, filters=[filter_qmp_event])
             if event['data']['status'] in ('completed', 'failed'):
                 break
-- 
2.28.0


