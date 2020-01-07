Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3E9C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0542B2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NT9SblVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0542B2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ios4r-0004KJ-IC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 11:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iorkx-0007if-AA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iorkv-0005Km-7u
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iorku-0005KT-9q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 11:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578414655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cp6Js316PIXYZH4FnO2Nl29XN8Dewk3Zb8G0nu+p7nE=;
 b=NT9SblVzOWJwZKdV79L6qBx+jfZC/Ah+pB8n3dSN/jhg7w5D9hociW3Cs5s1NCVWfvlZCO
 HRtZtao/KA8wSbLZo8j9Vbm64cuXRPEpm3T3NbZoGyW//SUn+76fqkDpwgTZ58EV1ucOmV
 0VwAW2s225Jn2OXF8on4YMGRF+aG36c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-dF8HsW8WMnyTv3wtiIegcg-1; Tue, 07 Jan 2020 11:30:54 -0500
Received: by mail-qk1-f200.google.com with SMTP id f22so139490qka.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 08:30:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5G41uwHBTYAB+Ul1VVsmoX3H1jPszYS18zVu3nGvXFk=;
 b=anNZ5/xzM5QgweBDZ/VXevyo9fSQnKlPG0Wfbl0rj38jDK6clYUoXOwOLaCVA19Xfp
 KonMjR1KSVaMmTHTPp1iXCYa5Q1A3b1A+wWY/o3YfpTpOl14erJlBkNJ/PEwkbIeEWjB
 JhfgnwDR4cqcZtZpSl2QPsvLciEsErx7jlxCv1iQh/BbD4Row/5dhNQ3NCp2YIlcgSL5
 JJPnZzaNvC82W/SmMCfsXKOD1uu5CdjWAfdER9VXApvcOoZXaHP3tpY14XkcvmA1EKyK
 VXhYZJDZjF9MZKVWuWxemQLGRAJAoeGmULQAlBStPMNE3Vlbv1HllglIvTLOyOJFo5zU
 8JLQ==
X-Gm-Message-State: APjAAAWdUJvjneX9iUSjKW5pLzh4r1sM8oedS3DBMOtzawcafJyhRsSm
 a/2359t0WqJopjIoHEC73ws1eaNg+bDgtMDLMiFXH4qM4F7vrxeMIlbuKBG6IZ4LGjrJde/3Oyp
 k+fV3u2aR5YzKyp8=
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr119955qkc.77.1578414653244; 
 Tue, 07 Jan 2020 08:30:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqwah7GUkx7y9fb2JGk7cA7ddC8Rl6cHrgBiVnDWK1wfCV8hu0P2HH1OD86pR6COxkElG27dyg==
X-Received: by 2002:a05:620a:718:: with SMTP id 24mr119912qkc.77.1578414652783; 
 Tue, 07 Jan 2020 08:30:52 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id i2sm88397qte.87.2020.01.07.08.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 08:30:52 -0800 (PST)
Date: Tue, 7 Jan 2020 11:30:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 17/32] tests/numa: Add case for QMP build HMAT
Message-ID: <20200107162850.411448-18-mst@redhat.com>
References: <20200107162850.411448-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107162850.411448-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: dF8HsW8WMnyTv3wtiIegcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Tao Xu <tao3.xu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

Check configuring HMAT usecase

Acked-by: Markus Armbruster <armbru@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20191213011929.2520-8-tao3.xu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/numa-test.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/tests/numa-test.c b/tests/numa-test.c
index 8de8581231..17dd807d2a 100644
--- a/tests/numa-test.c
+++ b/tests/numa-test.c
@@ -327,6 +327,216 @@ static void pc_dynamic_cpu_cfg(const void *data)
     qtest_quit(qs);
 }
=20
+static void pc_hmat_build_cfg(const void *data)
+{
+    QTestState *qs =3D qtest_initf("%s -nodefaults --preconfig -machine hm=
at=3Don "
+                     "-smp 2,sockets=3D2 "
+                     "-m 128M,slots=3D2,maxmem=3D1G "
+                     "-object memory-backend-ram,size=3D64M,id=3Dm0 "
+                     "-object memory-backend-ram,size=3D64M,id=3Dm1 "
+                     "-numa node,nodeid=3D0,memdev=3Dm0 "
+                     "-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 "
+                     "-numa cpu,node-id=3D0,socket-id=3D0 "
+                     "-numa cpu,node-id=3D0,socket-id=3D1",
+                     data ? (char *)data : "");
+
+    /* Fail: Initiator should be less than the number of nodes */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 2, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")))=
;
+
+    /* Fail: Target should be less than the number of nodes */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 2,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")))=
;
+
+    /* Fail: Initiator should contain cpu */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 1, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")))=
;
+
+    /* Fail: Data-type mismatch */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"write-latency\","
+        " 'bandwidth': 524288000 } }")));
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"read-bandwidth\","
+        " 'latency': 5 } }")));
+
+    /* Fail: Bandwidth should be 1MB (1048576) aligned */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
+        " 'bandwidth': 1048575 } }")));
+
+    /* Configuring HMAT bandwidth and latency details */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-no=
de',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 1 } }")));    /* 1 ns */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 5 } }")));    /* Fail: Duplicate configuration */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-no=
de',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
+        " 'bandwidth': 68717379584 } }")));    /* 65534 MB/s */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-no=
de',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 65534 } }")));    /* 65534 ns */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-no=
de',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
+        " 'bandwidth': 34358689792 } }")));    /* 32767 MB/s */
+
+    /* Fail: node_id should be less than the number of nodes */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 2, 'size': 10240=
,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\=
","
+        " 'line': 8 } }")));
+
+    /* Fail: level should be less than HMAT_LB_LEVELS (4) */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240=
,"
+        " 'level': 4, 'associativity': \"direct\", 'policy': \"write-back\=
","
+        " 'line': 8 } }")));
+
+    /* Fail: associativity option should be 'none', if level is 0 */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240=
,"
+        " 'level': 0, 'associativity': \"direct\", 'policy': \"none\","
+        " 'line': 0 } }")));
+    /* Fail: policy option should be 'none', if level is 0 */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240=
,"
+        " 'level': 0, 'associativity': \"none\", 'policy': \"write-back\",=
"
+        " 'line': 0 } }")));
+    /* Fail: line option should be 0, if level is 0 */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240=
,"
+        " 'level': 0, 'associativity': \"none\", 'policy': \"none\","
+        " 'line': 8 } }")));
+
+    /* Configuring HMAT memory side cache attributes */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-no=
de',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240=
,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\=
","
+        " 'line': 8 } }")));
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240=
,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\=
","
+        " 'line': 8 } }")));    /* Fail: Duplicate configuration */
+    /* Fail: The size of level 2 size should be small than level 1 */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240=
,"
+        " 'level': 2, 'associativity': \"direct\", 'policy': \"write-back\=
","
+        " 'line': 8 } }")));
+    /* Fail: The size of level 0 size should be larger than level 1 */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240=
,"
+        " 'level': 0, 'associativity': \"direct\", 'policy': \"write-back\=
","
+        " 'line': 8 } }")));
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-no=
de',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 1, 'size': 10240=
,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\=
","
+        " 'line': 8 } }")));
+
+    /* let machine initialization to complete and run */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs,
+        "{ 'execute': 'x-exit-preconfig' }")));
+    qtest_qmp_eventwait(qs, "RESUME");
+
+    qtest_quit(qs);
+}
+
+static void pc_hmat_off_cfg(const void *data)
+{
+    QTestState *qs =3D qtest_initf("%s -nodefaults --preconfig "
+                     "-smp 2,sockets=3D2 "
+                     "-m 128M,slots=3D2,maxmem=3D1G "
+                     "-object memory-backend-ram,size=3D64M,id=3Dm0 "
+                     "-object memory-backend-ram,size=3D64M,id=3Dm1 "
+                     "-numa node,nodeid=3D0,memdev=3Dm0",
+                     data ? (char *)data : "");
+
+    /*
+     * Fail: Enable HMAT with -machine hmat=3Don
+     * before using any of hmat specific options
+     */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': \"m1\","
+        " 'initiator': 0 } }")));
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-no=
de',"
+        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': \"m1\" } }=
")));
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 1 } }")));
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240=
,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\=
","
+        " 'line': 8 } }")));
+
+    /* let machine initialization to complete and run */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs,
+        "{ 'execute': 'x-exit-preconfig' }")));
+    qtest_qmp_eventwait(qs, "RESUME");
+
+    qtest_quit(qs);
+}
+
+static void pc_hmat_erange_cfg(const void *data)
+{
+    QTestState *qs =3D qtest_initf("%s -nodefaults --preconfig -machine hm=
at=3Don "
+                     "-smp 2,sockets=3D2 "
+                     "-m 128M,slots=3D2,maxmem=3D1G "
+                     "-object memory-backend-ram,size=3D64M,id=3Dm0 "
+                     "-object memory-backend-ram,size=3D64M,id=3Dm1 "
+                     "-numa node,nodeid=3D0,memdev=3Dm0 "
+                     "-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 "
+                     "-numa cpu,node-id=3D0,socket-id=3D0 "
+                     "-numa cpu,node-id=3D0,socket-id=3D1",
+                     data ? (char *)data : "");
+
+    /* Can't store the compressed latency */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-no=
de',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 1 } }")));    /* 1 ns */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
+        " 'latency': 65535 } }")));    /* 65535 ns */
+
+    /* Test the 0 input (bandwidth not provided) */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-no=
de',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
+        " 'bandwidth': 0 } }")));    /* 0 MB/s */
+    /* Fail: bandwidth should be provided before memory side cache attribu=
tes */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240=
,"
+        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\=
","
+        " 'line': 8 } }")));
+
+    /* Can't store the compressed bandwidth */
+    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-nod=
e',"
+        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
+        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
+        " 'bandwidth': 68718428160 } }")));    /* 65535 MB/s */
+
+    /* let machine initialization to complete and run */
+    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs,
+        "{ 'execute': 'x-exit-preconfig' }")));
+    qtest_qmp_eventwait(qs, "RESUME");
+
+    qtest_quit(qs);
+}
+
 int main(int argc, char **argv)
 {
     const char *args =3D NULL;
@@ -346,6 +556,9 @@ int main(int argc, char **argv)
     if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
         qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
         qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu_c=
fg);
+        qtest_add_data_func("/numa/pc/hmat/build", args, pc_hmat_build_cfg=
);
+        qtest_add_data_func("/numa/pc/hmat/off", args, pc_hmat_off_cfg);
+        qtest_add_data_func("/numa/pc/hmat/erange", args, pc_hmat_erange_c=
fg);
     }
=20
     if (!strcmp(arch, "ppc64")) {
--=20
MST


