Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70302C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4465C20575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EV6JOPg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4465C20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ71y-0008A6-6H
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pf-0005o7-2C
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53114
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pe-0001iv-8X
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r78YIUi5EF3+10yAnst7esoBjnzAwGVfqgCglUH45E4=;
 b=EV6JOPg31MTS4xvojjAX6T6vQXDvJq3d+4eB09LvtRIS4Oe37hv/0vAWLiH67txfSfCwgn
 s/brRdiZFNJpiDc1QQloHVVZ9CFQl1goKYb6Wbh1oH3DeRDkbOBlSZV9hB0jr+VoskwFRx
 XkyDJ0KcclrUShF14FdMwN8btj4SrUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-0KkirazrNSCimaZB9Sv-6w-1; Thu, 14 May 2020 01:54:54 -0400
X-MC-Unique: 0KkirazrNSCimaZB9Sv-6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2F76107ACF5;
 Thu, 14 May 2020 05:54:53 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5189B6A977;
 Thu, 14 May 2020 05:54:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 25/32] python//machine.py: Handle None events in event_wait
Date: Thu, 14 May 2020 01:53:56 -0400
Message-Id: <20200514055403.18902-26-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the timeout is 0, we can get None back. Handle this explicitly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/lib/machine.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
index 8548c7c32d..61ee3a0e81 100644
--- a/python/qemu/lib/machine.py
+++ b/python/qemu/lib/machine.py
@@ -32,7 +32,7 @@
 from types import TracebackType
 
 from . import qmp
-from .qmp import SocketAddrT
+from .qmp import SocketAddrT, QMPMessage
 
 LOG = logging.getLogger(__name__)
 
@@ -519,6 +519,8 @@ def _match(event):
                     return True
             return False
 
+        event: Optional[QMPMessage]
+
         # Search cached events
         for event in self._events:
             if _match(event):
@@ -528,6 +530,8 @@ def _match(event):
         # Poll for new events
         while True:
             event = self._qmp.pull_event(wait=timeout)
+            if event is None:
+                break
             if _match(event):
                 return event
             self._events.append(event)
-- 
2.21.1


