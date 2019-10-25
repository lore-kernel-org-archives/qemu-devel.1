Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEAACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:35:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7718E20578
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgXyIXPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7718E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwwS-00071m-HM
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNwRC-0002DN-5v
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNwQz-0006J8-Sy
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48472
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNwQz-0006Bv-NA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:03:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571997748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PE1JdYLcfkPlEa4T0j9k7C93O795//rjI/j503JnUjE=;
 b=fgXyIXPFCm/LhYEtqdGK467LbSdv8O9k3BYezdYD3zkU4jDTNNiunxwjEdbvAMpXZfXHMc
 dOYktY+thefwUH6AisnLQPAKEv7rnJ1eILR0wiV/YzXruTy6etFFDqTnjzepAUF0Ud4i1j
 FQ9hlAsfZysP1+Ii7MZBS7oYI0ErebU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-sA4AcyYlPQ61-uBbvhJUmg-1; Fri, 25 Oct 2019 06:02:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E95C80183D
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 10:02:25 +0000 (UTC)
Received: from localhost (unknown [10.36.118.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 751FE600D1;
 Fri, 25 Oct 2019 10:02:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 2/3] qgraph: add an "after" test callback function
Date: Fri, 25 Oct 2019 12:01:51 +0200
Message-Id: <20191025100152.6638-3-stefanha@redhat.com>
In-Reply-To: <20191025100152.6638-1-stefanha@redhat.com>
References: <20191025100152.6638-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: sA4AcyYlPQ61-uBbvhJUmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a callback that runs after a test completes.  This will be used for
cleanup.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/qgraph.h          | 2 ++
 tests/libqos/qgraph_internal.h | 1 +
 tests/libqos/qgraph.c          | 1 +
 tests/qos-test.c               | 6 ++++++
 4 files changed, 10 insertions(+)

diff --git a/tests/libqos/qgraph.h b/tests/libqos/qgraph.h
index 3a25dda4b2..5e73a00e4a 100644
--- a/tests/libqos/qgraph.h
+++ b/tests/libqos/qgraph.h
@@ -47,6 +47,7 @@ typedef void (*QOSStartFunct) (QOSGraphObject *object);
=20
 /* Test options functions */
 typedef void *(*QOSBeforeTest) (GString *cmd_line, void *arg);
+typedef void (*QOSAfterTest) (void *arg);
=20
 /**
  * SECTION: qgraph.h
@@ -341,6 +342,7 @@ struct QOSGraphTestOptions {
                                  * additional parameters to the command li=
ne
                                  * and modify the argument to the test fun=
ction.
                                  */
+    QOSAfterTest after;         /* executed after the test */
     bool subprocess;            /* run the test in a subprocess */
 };
=20
diff --git a/tests/libqos/qgraph_internal.h b/tests/libqos/qgraph_internal.=
h
index f4734c8681..5e1131f06c 100644
--- a/tests/libqos/qgraph_internal.h
+++ b/tests/libqos/qgraph_internal.h
@@ -68,6 +68,7 @@ struct QOSGraphNode {
             QOSTestFunc function;
             void *arg;
             QOSBeforeTest before;
+            QOSAfterTest after;
             bool subprocess;
         } test;
     } u;
diff --git a/tests/libqos/qgraph.c b/tests/libqos/qgraph.c
index 7a7ae2a19e..f3e792a509 100644
--- a/tests/libqos/qgraph.c
+++ b/tests/libqos/qgraph.c
@@ -603,6 +603,7 @@ void qos_add_test(const char *name, const char *interfa=
ce,
     assert(!opts->edge.size_arg);
=20
     node->u.test.before =3D opts->before;
+    node->u.test.after =3D opts->after;
     node->u.test.subprocess =3D opts->subprocess;
     node->available =3D true;
     add_edge(interface, test_name, QEDGE_CONSUMED_BY, &opts->edge);
diff --git a/tests/qos-test.c b/tests/qos-test.c
index fd70d73ea5..fa77f661c6 100644
--- a/tests/qos-test.c
+++ b/tests/qos-test.c
@@ -273,6 +273,7 @@ void *qos_allocate_objects(QTestState *qts, QGuestAlloc=
ator **p_alloc)
  * 3) call all nodes constructor and get_driver/get_device depending on ed=
ge,
  *    start the hardware (*_device_enable functions)
  * 4) start test
+ * 5) @after test function as defined in the given QOSGraphTestOptions
  */
 static void run_one_test(const void *arg)
 {
@@ -296,6 +297,11 @@ static void run_one_test(const void *arg)
=20
     obj =3D qos_allocate_objects(global_qtest, &alloc);
     test_node->u.test.function(obj, test_arg, alloc);
+
+    /* After test */
+    if (test_node->u.test.after) {
+        test_node->u.test.after(test_arg);
+    }
 }
=20
 static void subprocess_run_one_test(const void *arg)
--=20
2.21.0


