Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F3C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:28:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370C52074D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeS8W/ES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370C52074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcjM-0002LK-Dc
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFcXa-0008Gn-3I
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFcXX-0006Mk-On
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599567359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HLDu887fn+GCLiYEpEIPL/cUfFTSDg8lJgVxiRXalPw=;
 b=YeS8W/ESolqsRXYwGT9ooj65fpxOuL/zBzqpAJnbNCWvv5LHPglohx4TlPdJDvV4a0pPGW
 TLLIM1Fv4vINFJ5kk/LHoR3KnydGpHkLJ2GRQPK5fowk98OHfmXPq7tJF7XJQ/f0HHc/hl
 4QErgwp5aflGPhRbYaBJL/dqcSokHbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-EI9sdtChP8u0-0iVLqEFbg-1; Tue, 08 Sep 2020 08:15:57 -0400
X-MC-Unique: EI9sdtChP8u0-0iVLqEFbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D04BE18C9F53
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 12:15:56 +0000 (UTC)
Received: from thuth.com (ovpn-112-131.ams2.redhat.com [10.36.112.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC6D67A3C8;
 Tue,  8 Sep 2020 12:15:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] tests/socket-helpers: Treat EAI_NONAME as EADDRNOTAVAIL
Date: Tue,  8 Sep 2020 14:15:43 +0200
Message-Id: <20200908121543.222872-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tests/test-char test is currently always failing on my system since
the getaddrinfo() in socket_can_bind_connect() returns EAI_NONAME when
it is called from socket_check_protocol_support() to check for IPv6.
socket_check_protocol_support() then returns -1 and thus the tests are
not run at all - even though IPv4 is working fine.
socket_can_bind_connect() connect should return EADDRNOTAVAIL in this
case instead, so that socket_check_protocol_support() does not fail.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/socket-helpers.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/socket-helpers.c b/tests/socket-helpers.c
index 19a51e887e..f704fd1a69 100644
--- a/tests/socket-helpers.c
+++ b/tests/socket-helpers.c
@@ -59,8 +59,7 @@ static int socket_can_bind_connect(const char *hostname, int family)
     /* lookup */
     rc = getaddrinfo(hostname, NULL, &ai, &res);
     if (rc != 0) {
-        if (rc == EAI_ADDRFAMILY ||
-            rc == EAI_FAMILY) {
+        if (rc == EAI_ADDRFAMILY || rc == EAI_FAMILY || rc == EAI_NONAME) {
             errno = EADDRNOTAVAIL;
         } else {
             errno = EINVAL;
-- 
2.18.2


