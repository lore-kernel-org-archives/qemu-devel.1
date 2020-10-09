Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC00C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBB42076E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnnmQ+P3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBB42076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQwby-0004Ay-I0
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQwYJ-00080i-Dr
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQwYG-0007IN-U4
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602265892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ktxWJqF//PoRxsFFkuG3Fy1XSt3Nh1HaEMcL3f4tOE=;
 b=NnnmQ+P3YcGg/Z2Khh/VAHVeCHviEPXhvIkMR3HJcEm54SYBmtBziFECL0PhUlWRytsVA5
 OXIlniztTQn1nQNAQSpoqi5P1kQSGiXXllYiAsaKTegS9OTPscI5HdvlrlsWh2OBZyb43Q
 0WX4h2Ov+1bWWK5brk34No3YYkxo9Fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-ENvizNPTNeyvsH0xHMLDFA-1; Fri, 09 Oct 2020 13:51:30 -0400
X-MC-Unique: ENvizNPTNeyvsH0xHMLDFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7254B80B714
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 17:51:29 +0000 (UTC)
Received: from scv.redhat.com (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A857D7664F;
 Fri,  9 Oct 2020 17:51:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] python/qemu/qmp.py: re-raise OSError when encountered
Date: Fri,  9 Oct 2020 13:51:22 -0400
Message-Id: <20201009175123.249009-3-jsnow@redhat.com>
In-Reply-To: <20201009175123.249009-1-jsnow@redhat.com>
References: <20201009175123.249009-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nested if conditions don't change when the exception block fires; we
need to explicitly re-raise the error if we didn't intend to capture and
suppress it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp.py | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index d911999da1f..4969e5741cb 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -165,14 +165,15 @@ def __get_events(self, wait: Union[bool, float] = False) -> None:
         """
 
         # Check for new events regardless and pull them into the cache:
-        self.__sock.setblocking(False)
         try:
+            self.__sock.setblocking(False)
             self.__json_read()
         except OSError as err:
-            if err.errno == errno.EAGAIN:
-                # No data available
-                pass
-        self.__sock.setblocking(True)
+            # EAGAIN: No data available; not critical
+            if err.errno != errno.EAGAIN:
+                raise
+        finally:
+            self.__sock.setblocking(True)
 
         # Wait for new events, if needed.
         # if wait is 0.0, this means "no wait" and is also implicitly false.
-- 
2.26.2


