Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21826C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:56:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB0E22208
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcdalWBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB0E22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIW3J-0003CX-Jl
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVud-0006cG-VT
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:47:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIVub-000874-CY
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600256864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfjAeOa0yZJOy8xZ45J/KTVs5I1f+weqXYLxxsUoSS4=;
 b=bcdalWBNC7zxTZNCn7mgzfdUzL1dTy7L46VXK7jRUGCwz4nS7XWNebh9u0I720B7G9+Yhb
 BB94qi+js72prZ61It7lb7EazK9UpQFdwBbHBpWKCYuvylOzLDs+n3ID9RNAhxrI+oHRjn
 IJk3XOIBZLiM6Qat6zf6JvX9j8UGn9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-r3aq1L9MPZOUHTyxIYznhA-1; Wed, 16 Sep 2020 07:47:42 -0400
X-MC-Unique: r3aq1L9MPZOUHTyxIYznhA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28AB2427C7;
 Wed, 16 Sep 2020 11:47:41 +0000 (UTC)
Received: from thuth.com (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18B1D5DA71;
 Wed, 16 Sep 2020 11:47:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/24] tests/socket-helpers: Treat EAI_NONAME as EADDRNOTAVAIL
Date: Wed, 16 Sep 2020 13:47:11 +0200
Message-Id: <20200916114731.102080-5-thuth@redhat.com>
In-Reply-To: <20200916114731.102080-1-thuth@redhat.com>
References: <20200916114731.102080-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
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
Message-Id: <20200908121543.222872-1-thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


