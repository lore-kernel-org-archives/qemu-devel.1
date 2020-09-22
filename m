Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F74C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9817820BED
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYTx7AtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9817820BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKr9c-0004VF-NX
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqtE-00056o-OY
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kKqtC-0007lX-Pb
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600814158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J58kk9KonAS7Kge2Gue/KficmECzeBFNtMpPf9StRKk=;
 b=NYTx7AtLUSCtr6VCUWnM0Flo4hmiJtIY7oeXHdtkToJezBjai94dsVHW7+ZRVQiwI5BWbg
 mZIbwoDk4L9RRmksuLVsVz/qf3rN6Lu0qsdEb1YvRMBJIeRCuwQrjxo4Ewrvy00xX8lKnE
 M9ZkwWjqp7VqSkXetAUAUQrfaju3oNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-F9Ea86SHNA-hTURJuKKVDg-1; Tue, 22 Sep 2020 18:35:55 -0400
X-MC-Unique: F9Ea86SHNA-hTURJuKKVDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46FD581CAFB;
 Tue, 22 Sep 2020 22:35:54 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21B9160BF4;
 Tue, 22 Sep 2020 22:35:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 24/26] qapi/parser.py: remove one and two-letter variables
Date: Tue, 22 Sep 2020 18:35:23 -0400
Message-Id: <20200922223525.4085762-25-jsnow@redhat.com>
In-Reply-To: <20200922223525.4085762-1-jsnow@redhat.com>
References: <20200922223525.4085762-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Standard pylint complaint: use more descriptibe variable names. OK,
fine.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index cdb64ffc22..818f8bc580 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -57,8 +57,8 @@ class QAPIParseError(QAPISourceError):
     @classmethod
     def make(cls: Type[T], parser: 'QAPISchemaParser', msg: str) -> T:
         col = 1
-        for ch in parser.src[parser.line_pos:parser.pos]:
-            if ch == '\t':
+        for char in parser.src[parser.line_pos:parser.pos]:
+            if char == '\t':
                 col = (col + 7) % 8 + 1
             else:
                 col += 1
@@ -100,14 +100,16 @@ def __init__(self, fname: str,
         try:
             with open(self._fname, 'r', encoding='utf-8') as fp:
                 self.src = fp.read()
-        except IOError as e:
+        except IOError as err:
             msg = "can't read {kind:s} file '{fname:s}': {errmsg:s}".format(
                 kind='include' if parent else 'schema',
                 fname=self._fname,
-                errmsg=e.strerror
+                errmsg=err.strerror
             )
             context = parent_info if parent_info else self.info
-            raise QAPIParseError(context, msg) from e
+            raise QAPIParseError(context, msg) from err
+
+        # Showtime!
         self._parse()
 
     def _parse(self) -> None:
@@ -245,25 +247,25 @@ def accept(self, skip_comment: bool = True) -> None:
                 string = ''
                 esc = False
                 while True:
-                    ch = self.src[self.cursor]
+                    char = self.src[self.cursor]
                     self.cursor += 1
-                    if ch == '\n':
+                    if char == '\n':
                         raise self._parse_error("missing terminating \"'\"")
                     if esc:
                         # Note: we recognize only \\ because we have
                         # no use for funny characters in strings
-                        if ch != '\\':
-                            raise self._parse_error(f"unknown escape \\{ch}")
+                        if char != '\\':
+                            raise self._parse_error(f"unknown escape \\{char}")
                         esc = False
-                    elif ch == '\\':
+                    elif char == '\\':
                         esc = True
                         continue
-                    elif ch == "'":
+                    elif char == "'":
                         self.val = string
                         return
-                    if ord(ch) < 32 or ord(ch) >= 127:
+                    if ord(char) < 32 or ord(char) >= 127:
                         raise self._parse_error("funny character in string")
-                    string += ch
+                    string += char
             elif self.src.startswith('true', self.pos):
                 self.val = True
                 self.cursor += 3
-- 
2.26.2


