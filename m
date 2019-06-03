Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B88C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30BE625E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BE625E7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXiBk-0001Sk-Cj
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 04:19:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hXi6A-000644-Mx
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hXi69-0006iQ-JN
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:13:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hXi69-0006ha-DX
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:13:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B260630821F4
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 08:13:40 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-112-59.ams2.redhat.com
	[10.36.112.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D38B5C8BD;
	Mon,  3 Jun 2019 08:13:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 10:13:35 +0200
Message-Id: <20190603081335.8185-2-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 03 Jun 2019 08:13:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] qgraph: fix qos_node_contains with options
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, if qos_node_contains was passed options, it would still
create an edge without any options.  Instead, in that case
NULL acts as a terminator.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/libqos/qgraph.c | 12 ++++++++----
 tests/libqos/qgraph.h | 15 +++++++++------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/tests/libqos/qgraph.c b/tests/libqos/qgraph.c
index b149caaaa9..7a7ae2a19e 100644
--- a/tests/libqos/qgraph.c
+++ b/tests/libqos/qgraph.c
@@ -632,15 +632,19 @@ void qos_node_create_driver(const char *name, QOSCr=
eateDriverFunc function)
 }
=20
 void qos_node_contains(const char *container, const char *contained,
-                       ...)
+                       QOSGraphEdgeOptions *opts, ...)
 {
     va_list va;
-    va_start(va, contained);
-    QOSGraphEdgeOptions *opts;
=20
+    if (opts =3D=3D NULL) {
+        add_edge(container, contained, QEDGE_CONTAINS, NULL);
+        return;
+    }
+
+    va_start(va, opts);
     do {
-        opts =3D va_arg(va, QOSGraphEdgeOptions *);
         add_edge(container, contained, QEDGE_CONTAINS, opts);
+        opts =3D va_arg(va, QOSGraphEdgeOptions *);
     } while (opts !=3D NULL);
=20
     va_end(va);
diff --git a/tests/libqos/qgraph.h b/tests/libqos/qgraph.h
index e799095b30..3a25dda4b2 100644
--- a/tests/libqos/qgraph.h
+++ b/tests/libqos/qgraph.h
@@ -453,14 +453,16 @@ void qos_node_create_machine_args(const char *name,
 void qos_node_create_driver(const char *name, QOSCreateDriverFunc functi=
on);
=20
 /**
- * qos_node_contains(): creates an edge of type QEDGE_CONTAINS and
- * adds it to the edge list mapped to @container in the
+ * qos_node_contains(): creates one or more edges of type QEDGE_CONTAINS
+ * and adds them to the edge list mapped to @container in the
  * edge hash table.
  *
- * This edge will have @container as source and @contained as destinatio=
n.
+ * The edges will have @container as source and @contained as destinatio=
n.
  *
- * It also has the possibility to add optional NULL-terminated
- * @opts parameters (see %QOSGraphEdgeOptions)
+ * If @opts is NULL, a single edge will be added with no options.
+ * If @opts is non-NULL, the arguments after @contained represent a
+ * NULL-terminated list of %QOSGraphEdgeOptions structs, and an
+ * edge will be added for each of them.
  *
  * This function can be useful when there are multiple devices
  * with the same node name contained in a machine/other node
@@ -480,7 +482,8 @@ void qos_node_create_driver(const char *name, QOSCrea=
teDriverFunc function);
  * For contains, op1.arg and op1.size_arg represent the arg to pass
  * to @contained constructor to properly initialize it.
  */
-void qos_node_contains(const char *container, const char *contained, ...=
);
+void qos_node_contains(const char *container, const char *contained,
+                       QOSGraphEdgeOptions *opts, ...);
=20
 /**
  * qos_node_produces(): creates an edge of type QEDGE_PRODUCES and
--=20
2.21.0


