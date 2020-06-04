Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A1CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B70A2067B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 20:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDObFp+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B70A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgwUk-0000Vp-MA
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 16:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgwO0-000437-8s
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:22:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jgwNz-0005VI-E9
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 16:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591302166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ZHtmt1m1ZkVFBw/uJkXhMkYPR+P+eLoSIG2usa9Dcg=;
 b=LDObFp+TdC+WxtGmJTtDdPNZgscFX2p6/uZm5MKy+/ArOUlu83vj8h/mpI1u4tX33BCxpT
 zKc0fXDV6sux75BukR0qcFJuKiufRNqfGxmNu1fjUb8HuZRoEIYI/whzmRa/C0whOhYQnF
 N9hpQhcqb6OciulcGTd1M/3uw5qT9D8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-Hnce5f6-OoqszN2XEaJUIA-1; Thu, 04 Jun 2020 16:22:40 -0400
X-MC-Unique: Hnce5f6-OoqszN2XEaJUIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94C69835B41;
 Thu,  4 Jun 2020 20:22:39 +0000 (UTC)
Received: from probe.redhat.com (ovpn-117-188.rdu2.redhat.com [10.10.117.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAC1C5D9D3;
 Thu,  4 Jun 2020 20:22:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/16] iotests.py: use qemu.qmp type aliases
Date: Thu,  4 Jun 2020 16:22:22 -0400
Message-Id: <20200604202236.25039-3-jsnow@redhat.com>
In-Reply-To: <20200604202236.25039-1-jsnow@redhat.com>
References: <20200604202236.25039-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:58:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

iotests.py should use the type definitions from qmp.py instead of its
own.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index f20d90f9698..7c1773bba37 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -35,13 +35,10 @@
 # pylint: disable=import-error, wrong-import-position
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qtest
+from qemu.qmp import QMPMessage
 
 assert sys.version_info >= (3, 6)
 
-# Type Aliases
-QMPResponse = Dict[str, Any]
-
-
 # Use this logger for logging messages directly from the iotests module
 logger = logging.getLogger('qemu.iotests')
 logger.addHandler(logging.NullHandler())
@@ -554,7 +551,7 @@ def add_incoming(self, addr):
         self._args.append(addr)
         return self
 
-    def hmp(self, command_line: str, use_log: bool = False) -> QMPResponse:
+    def hmp(self, command_line: str, use_log: bool = False) -> QMPMessage:
         cmd = 'human-monitor-command'
         kwargs = {'command-line': command_line}
         if use_log:
@@ -575,7 +572,7 @@ def resume_drive(self, drive: str) -> None:
         self.hmp(f'qemu-io {drive} "remove_break bp_{drive}"')
 
     def hmp_qemu_io(self, drive: str, cmd: str,
-                    use_log: bool = False) -> QMPResponse:
+                    use_log: bool = False) -> QMPMessage:
         """Write to a given drive using an HMP command"""
         return self.hmp(f'qemu-io {drive} "{cmd}"', use_log=use_log)
 
-- 
2.21.3


