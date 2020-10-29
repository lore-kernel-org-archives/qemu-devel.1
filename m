Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C632FC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32DCD207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9tPcrXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DCD207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY8Bs-000185-53
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kY88f-0005qM-GP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kY88c-0008JF-Om
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603978725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aaI62MqpCVlWiqfeRGUdxe9LfKHQujWNQ0NbrrtWK8=;
 b=F9tPcrXx4hhnLs6FUv7kOnbkaJNObqv2DySXXI7BIty4C+RfwAWf+hdmk4/7PU0/VGjXL6
 7pkXiWCVtw27OgEF9PwrCUDpB2zuNDyycThGwC35SRWmXQqNPbAOCW5D3sUHr68mHK2Pco
 h/654ozV06ZxXiymCMLXqCv+K+cJXxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-_6pBecWGO52W8yGO31eumg-1; Thu, 29 Oct 2020 09:38:44 -0400
X-MC-Unique: _6pBecWGO52W8yGO31eumg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 418826D584;
 Thu, 29 Oct 2020 13:38:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D8795D9EF;
 Thu, 29 Oct 2020 13:38:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B2CC21132922; Thu, 29 Oct 2020 14:38:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] char-socket: Fix qemu_chr_socket_address() for abstract
 sockets
Date: Thu, 29 Oct 2020 14:38:31 +0100
Message-Id: <20201029133833.3450220-10-armbru@redhat.com>
In-Reply-To: <20201029133833.3450220-1-armbru@redhat.com>
References: <20201029133833.3450220-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 776b97d360 "qemu-sockets: add abstract UNIX domain socket
support" neglected to update qemu_chr_socket_address().  It shows
shows neither @abstract nor @tight.  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char-socket.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 1ee5a8c295..dc1cf86ecf 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -443,10 +443,18 @@ static char *qemu_chr_socket_address(SocketChardev *s, const char *prefix)
                                s->is_listen ? ",server" : "");
         break;
     case SOCKET_ADDRESS_TYPE_UNIX:
-        return g_strdup_printf("%sunix:%s%s", prefix,
+    {
+        UnixSocketAddress *sa = &s->addr->u.q_unix;
+
+        return g_strdup_printf("%sunix:%s%s%s%s", prefix,
                                s->addr->u.q_unix.path,
+                               sa->has_abstract && sa->abstract
+                               ? ",abstract" : "",
+                               sa->has_tight && sa->tight
+                               ? ",tight" : "",
                                s->is_listen ? ",server" : "");
         break;
+    }
     case SOCKET_ADDRESS_TYPE_FD:
         return g_strdup_printf("%sfd:%s%s", prefix, s->addr->u.fd.str,
                                s->is_listen ? ",server" : "");
-- 
2.26.2


