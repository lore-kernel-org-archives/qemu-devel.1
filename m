Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A84C433EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A1920717
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJ6NsxI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A1920717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy9mK-0000ek-4s
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jy9l6-0007ID-L6
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:05:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42981
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jy9l4-00047G-FF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595405145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BxWByZrpFXEqeZ14ib/Meiot3W5HVU8SuLLgw24KJU=;
 b=QJ6NsxI0XSpRjLI0LrmrbdPUK1xDmNuL73aO2lo2bspBvOm074e2pKrOUTq33nF4uzezSy
 50S2Q+2zW4ymB3F3S2ixO5stZIDp4tQba4v6nvko8FNVVNedw/L2ostZybTF4aINQNv9Wt
 fTgqb/ZvpPSpS+JH/hCY75PTzUHGrQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-5sQspgvUPaWKubelkiEGvQ-1; Wed, 22 Jul 2020 04:05:43 -0400
X-MC-Unique: 5sQspgvUPaWKubelkiEGvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3684185BDD1;
 Wed, 22 Jul 2020 08:05:23 +0000 (UTC)
Received: from localhost (ovpn-113-86.ams2.redhat.com [10.36.113.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47D2C90E68;
 Wed, 22 Jul 2020 08:05:23 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.2 v3 2/3] iotests.py: Add wait_for_runstate()
Date: Wed, 22 Jul 2020 10:05:15 +0200
Message-Id: <20200722080516.126147-3-mreitz@redhat.com>
In-Reply-To: <20200722080516.126147-1-mreitz@redhat.com>
References: <20200722080516.126147-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 3590ed78a0..20645a6e7d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -28,6 +28,7 @@ import signal
 import struct
 import subprocess
 import sys
+import time
 from typing import (Any, Callable, Dict, Iterable,
                     List, Optional, Sequence, Tuple, TypeVar)
 import unittest
@@ -803,6 +804,10 @@ class VM(qtest.QEMUQtestMachine):
                    'Found node %s under %s (but expected %s)' % \
                    (node['name'], path, expected_node)
 
+    def wait_for_runstate(self, runstate: str) -> None:
+        while self.qmp('query-status')['return']['status'] != runstate:
+            time.sleep(0.2)
+
 index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
 
 class QMPTestCase(unittest.TestCase):
-- 
2.26.2


