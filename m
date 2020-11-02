Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE247C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21D122277
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJr3/ZSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21D122277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWPh-0004HV-Vh
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOF-0002UY-Oe
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kZWOC-00057K-DA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604310275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXuXJxjnqhtxag+DQM4whHUnRMOzZMsKydCxNqulPqU=;
 b=EJr3/ZSLWvkKCkTeHLsyBonrX02wRBjQbCfXYv5lB8kG/ElezDXH12FBvOLSLlYQMuOC46
 GTEwIV7E315ZV+3hL+v3KIjNj/uBsf1JZ/CGrvod3TG6khC1RWQoOidrZSkOtNhWRAsyra
 REpTWcxDTk8HzYz7ZzX0HSpuTDbxYCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-BMrEG41CMzix5p9Yp3LrWg-1; Mon, 02 Nov 2020 04:44:34 -0500
X-MC-Unique: BMrEG41CMzix5p9Yp3LrWg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 464CD1006C8D;
 Mon,  2 Nov 2020 09:44:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F66C21E91;
 Mon,  2 Nov 2020 09:44:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E8DA01129947; Mon,  2 Nov 2020 10:44:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/11] test-util-sockets: Factor out
 test_socket_unix_abstract_one()
Date: Mon,  2 Nov 2020 10:44:15 +0100
Message-Id: <20201102094422.173975-5-armbru@redhat.com>
In-Reply-To: <20201102094422.173975-1-armbru@redhat.com>
References: <20201102094422.173975-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-util-sockets.c | 48 ++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index a4792253ba..40ff893e64 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -261,6 +261,24 @@ static gpointer unix_client_thread_func(gpointer user_data)
     return NULL;
 }
 
+static void test_socket_unix_abstract_one(SocketAddress *addr)
+{
+    GThread *serv, *cli;
+
+    serv = g_thread_new("abstract_unix_server",
+                        unix_server_thread_func,
+                        addr);
+
+    sleep(1);
+
+    cli = g_thread_new("abstract_unix_client",
+                       unix_client_thread_func,
+                       addr);
+
+    g_thread_join(cli);
+    g_thread_join(serv);
+}
+
 static void test_socket_unix_abstract_good(void)
 {
     SocketAddress addr;
@@ -272,40 +290,14 @@ static void test_socket_unix_abstract_good(void)
     addr.u.q_unix.abstract = true;
 
     /* non tight socklen serv and cli */
-
     addr.u.q_unix.has_tight = false;
     addr.u.q_unix.tight = false;
-
-    GThread *serv = g_thread_new("abstract_unix_server",
-                                 unix_server_thread_func,
-                                 &addr);
-
-    sleep(1);
-
-    GThread *cli = g_thread_new("abstract_unix_client",
-                                unix_client_thread_func,
-                                &addr);
-
-    g_thread_join(cli);
-    g_thread_join(serv);
+    test_socket_unix_abstract_one(&addr);
 
     /* tight socklen serv and cli */
-
     addr.u.q_unix.has_tight = true;
     addr.u.q_unix.tight = true;
-
-    serv = g_thread_new("abstract_unix_server",
-                        unix_server_thread_func,
-                        &addr);
-
-    sleep(1);
-
-    cli = g_thread_new("abstract_unix_client",
-                       unix_client_thread_func,
-                       &addr);
-
-    g_thread_join(cli);
-    g_thread_join(serv);
+    test_socket_unix_abstract_one(&addr);
 
     g_free(addr.u.q_unix.path);
 }
-- 
2.26.2


