Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF42320BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aZCP3jAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF42320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaApM-0003rB-5k
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmU-0007V4-ML
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmS-0004t2-OA
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TD7SW6oID+mQnZFy+V2Ba30n404JJ+wGVVREK/DvNQg=;
 b=aZCP3jAcMXUKp7xzl4wGCRhPY1pmIPd0O7TT2J8FpshJwgy4PQ36lHSUyFr7QATiKWz1nQ
 Dk+Na8/3W31OfT3gh6IVVXff8zH6/UM+Js2eD2IheGSeLD+G9fj5gmf9i57RHngRolXR+m
 v3ng3OJZlx4iTpfTOb0j6ja7GOJDjQc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-rl1JBh8nPFyQIOXc3GuTlQ-1; Tue, 03 Nov 2020 23:52:18 -0500
X-MC-Unique: rl1JBh8nPFyQIOXc3GuTlQ-1
Received: by mail-wm1-f71.google.com with SMTP id 13so745113wmf.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:52:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TD7SW6oID+mQnZFy+V2Ba30n404JJ+wGVVREK/DvNQg=;
 b=brJpTjVJVufENROetFwUeGYHHqEKLvwWFbTcHO8OcQwLXr3rUDT7+VEaRtNgM5cDS9
 IRkg+Zk9fxumpVXr5XopjsC79Gtsj01n9um9rjLN9UeJ0ao9u2Y7sO8wmq4ui51EBiVF
 IzoxBTXrmr283+mCjSW7gm1pRezFlHTsWw9+zBFRQa1e7DyDUZUy65fAaFhNc8Kk3ovT
 wg7Npj5RUplgOPzC3CH93RtVMJxqtpumunQ7axTSFxoNFTef3p4FxJUNX/uMTS07B3hC
 z1iQhDLxZmPrOLRMCDT5HrON4HGG6PWa2FFQoSffW11cQyxahXnJq/1MmnRHb1YFf+6Q
 LHiw==
X-Gm-Message-State: AOAM530rGfSmxOBbnunKH056Etmasi44ixvn5wriiUNrl96A6qv0n542
 ki2qCRcOotPHze+wReVP6QD0repP758eiTnFpnjxGpKINAItogXEZOwghcKNXZTbZPcGyw79S0F
 JjU/Kei35+S7+2ow=
X-Received: by 2002:adf:8296:: with SMTP id 22mr30026186wrc.341.1604465536295; 
 Tue, 03 Nov 2020 20:52:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQtGJvRzuJRVkQQaGdOLzVKaIhBMX8O1pz2/91oQjb81dn1jhGsEP/DXOaEi0JSD38ETqDyw==
X-Received: by 2002:adf:8296:: with SMTP id 22mr30026174wrc.341.1604465536166; 
 Tue, 03 Nov 2020 20:52:16 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id x18sm926510wrg.4.2020.11.03.20.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:52:15 -0800 (PST)
Date: Tue, 3 Nov 2020 23:52:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 34/38] libqtest: add qtest_socket_server()
Message-ID: <20201104044937.226370-35-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

There is a qtest_socket_client() API. Add an equivalent
qtest_socket_server() API that returns a new UNIX domain socket in the
listen state. The code for this was already there but only used
internally in init_socket().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20201027173528.213464-9-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/libqos/libqtest.h |  8 +++++++
 tests/qtest/libqtest.c        | 40 ++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
index 241b5f89fb..699be8c2a2 100644
--- a/tests/qtest/libqos/libqtest.h
+++ b/tests/qtest/libqos/libqtest.h
@@ -132,6 +132,14 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...)
 void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
     GCC_FMT_ATTR(2, 3);
 
+/**
+ * qtest_socket_server:
+ * @socket_path: the UNIX domain socket path
+ *
+ * Create and return a listen socket file descriptor, or abort on failure.
+ */
+int qtest_socket_server(const char *socket_path);
+
 /**
  * qtest_socket_client:
  * @server_socket_path: the socket server's path
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index ab34075f2b..d652ffc90d 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -82,24 +82,8 @@ static void qtest_client_set_rx_handler(QTestState *s, QTestRecvFn recv);
 
 static int init_socket(const char *socket_path)
 {
-    struct sockaddr_un addr;
-    int sock;
-    int ret;
-
-    sock = socket(PF_UNIX, SOCK_STREAM, 0);
-    g_assert_cmpint(sock, !=, -1);
-
-    addr.sun_family = AF_UNIX;
-    snprintf(addr.sun_path, sizeof(addr.sun_path), "%s", socket_path);
+    int sock = qtest_socket_server(socket_path);
     qemu_set_cloexec(sock);
-
-    do {
-        ret = bind(sock, (struct sockaddr *)&addr, sizeof(addr));
-    } while (ret == -1 && errno == EINTR);
-    g_assert_cmpint(ret, !=, -1);
-    ret = listen(sock, 1);
-    g_assert_cmpint(ret, !=, -1);
-
     return sock;
 }
 
@@ -638,6 +622,28 @@ QTestState *qtest_create_state_with_qmp_fd(int fd)
     return qmp_test_state;
 }
 
+int qtest_socket_server(const char *socket_path)
+{
+    struct sockaddr_un addr;
+    int sock;
+    int ret;
+
+    sock = socket(PF_UNIX, SOCK_STREAM, 0);
+    g_assert_cmpint(sock, !=, -1);
+
+    addr.sun_family = AF_UNIX;
+    snprintf(addr.sun_path, sizeof(addr.sun_path), "%s", socket_path);
+
+    do {
+        ret = bind(sock, (struct sockaddr *)&addr, sizeof(addr));
+    } while (ret == -1 && errno == EINTR);
+    g_assert_cmpint(ret, !=, -1);
+    ret = listen(sock, 1);
+    g_assert_cmpint(ret, !=, -1);
+
+    return sock;
+}
+
 int qtest_socket_client(char *server_socket_path)
 {
     struct sockaddr_un serv_addr;
-- 
MST


