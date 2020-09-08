Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD0BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 918F320732
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQfXkwxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 918F320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbI0-0005MC-M5
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFbH3-0004Q5-IG
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:54:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57027
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFbH2-00044t-16
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599562491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=pEMBhEfXlixiPge74DtxM/QOy/cZbksaQ/TgWRgnUGo=;
 b=FQfXkwxKw7LoJLdpx9yLbMhQEC0Sb4qSnbvXXNfd0uy2YODCNlQtlg97NYM+HfBltDXqkh
 LlmDV0NDwuUM8sm4AtkSvdCxPFJEoEA9q+0CT40Ynzv/UPCBpnnvm733KD41bstFxW6bbO
 pC2tYPjOdgvns7iceOaKBdJXLJwNXcU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Vb_shAecNnCU3PwouJfFNw-1; Tue, 08 Sep 2020 06:54:49 -0400
X-MC-Unique: Vb_shAecNnCU3PwouJfFNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80419801FDC
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 10:54:48 +0000 (UTC)
Received: from thuth.com (ovpn-112-131.ams2.redhat.com [10.36.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B4245D9EF;
 Tue,  8 Sep 2020 10:54:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] tests/socket-helpers: Only fail socket protocol check if it
 is really necessary
Date: Tue,  8 Sep 2020 12:54:35 +0200
Message-Id: <20200908105435.218715-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tests/test-char test is currently always failing on my system since
socket_can_bind_connect("::1", PF_INET6) fails with EINVAL and thus
socket_check_protocol_support() is returning -1 for an error. But IPv4
is working fine. The logic in socket_check_protocol_support() seems to
be wrong here, if either IPv6 or IPv4 is working, we should not return
an error here. Thus rework the function to only return errors if both
checks failed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/socket-helpers.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/tests/socket-helpers.c b/tests/socket-helpers.c
index 19a51e887e..62a0e0f2d9 100644
--- a/tests/socket-helpers.c
+++ b/tests/socket-helpers.c
@@ -136,22 +136,17 @@ static int socket_can_bind_connect(const char *hostname, int family)
 
 int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6)
 {
-    *has_ipv4 = *has_ipv6 = false;
+    int errv4, errv6;
 
-    if (socket_can_bind_connect("127.0.0.1", PF_INET) < 0) {
-        if (errno != EADDRNOTAVAIL) {
-            return -1;
-        }
-    } else {
-        *has_ipv4 = true;
-    }
+    errv4 = socket_can_bind_connect("127.0.0.1", PF_INET);
+    *has_ipv4 = (errv4 == 0);
 
-    if (socket_can_bind_connect("::1", PF_INET6) < 0) {
-        if (errno != EADDRNOTAVAIL) {
-            return -1;
-        }
-    } else {
-        *has_ipv6 = true;
+    errv6 = socket_can_bind_connect("::1", PF_INET6);
+    *has_ipv6 = (errv6 == 0);
+
+    if (!*has_ipv4 && !*has_ipv6 &&
+        (errv4 != EADDRNOTAVAIL || errv6 != EADDRNOTAVAIL)) {
+        return -1;
     }
 
     return 0;
-- 
2.18.2


