Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EFDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B13822225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 16:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+EdWXqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13822225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQv9i-000250-NZ
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 12:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuqQ-0003y2-0p
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQuqH-0001AP-SO
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 12:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602259317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDUmdghtMAyCegm7L5TJffotsreIuyhWtE7FUPEkJ/8=;
 b=R+EdWXqAse/4wqcYq1bEroqg6xedj23i5wcrTW3/ojaqW0sHVMBO1VOrz4ve/fEV6gmBiQ
 LjMFpf2Ucz4lV7VX0B6i32xLqi4CRuK8lJZkOeecOgfUv+3fXH7RNkeIW93As1OdovU1ua
 953EOZwXuwWUpxmxJFtvB2ixapu0Bno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-NaKwDGiLN2S7OzmPNkWy_A-1; Fri, 09 Oct 2020 12:01:52 -0400
X-MC-Unique: NaKwDGiLN2S7OzmPNkWy_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0493801F95;
 Fri,  9 Oct 2020 16:01:51 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9669E38A;
 Fri,  9 Oct 2020 16:01:48 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/12] netfilter: Reorder functions
Date: Fri,  9 Oct 2020 12:01:18 -0400
Message-Id: <20201009160122.1662082-9-ehabkost@redhat.com>
In-Reply-To: <20201009160122.1662082-1-ehabkost@redhat.com>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
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
Cc: Kevin Wolf <kwolf@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trivial code reordering in some filter backends, to make the next
changes easier to review.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org
---
 net/filter-buffer.c | 20 ++++++++++----------
 net/filter-mirror.c | 36 ++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index d8392be53c..95e384865f 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -144,16 +144,6 @@ static void filter_buffer_status_changed(NetFilterState *nf, Error **errp)
     }
 }
 
-static void filter_buffer_class_init(ObjectClass *oc, void *data)
-{
-    NetFilterClass *nfc = NETFILTER_CLASS(oc);
-
-    nfc->setup = filter_buffer_setup;
-    nfc->cleanup = filter_buffer_cleanup;
-    nfc->receive_iov = filter_buffer_receive_iov;
-    nfc->status_changed = filter_buffer_status_changed;
-}
-
 static void filter_buffer_get_interval(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
@@ -182,6 +172,16 @@ static void filter_buffer_set_interval(Object *obj, Visitor *v,
     s->interval = value;
 }
 
+static void filter_buffer_class_init(ObjectClass *oc, void *data)
+{
+    NetFilterClass *nfc = NETFILTER_CLASS(oc);
+
+    nfc->setup = filter_buffer_setup;
+    nfc->cleanup = filter_buffer_cleanup;
+    nfc->receive_iov = filter_buffer_receive_iov;
+    nfc->status_changed = filter_buffer_status_changed;
+}
+
 static void filter_buffer_init(Object *obj)
 {
     object_property_add(obj, "interval", "uint32",
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index 088d4dcace..26b783011a 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -284,24 +284,6 @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
     }
 }
 
-static void filter_mirror_class_init(ObjectClass *oc, void *data)
-{
-    NetFilterClass *nfc = NETFILTER_CLASS(oc);
-
-    nfc->setup = filter_mirror_setup;
-    nfc->cleanup = filter_mirror_cleanup;
-    nfc->receive_iov = filter_mirror_receive_iov;
-}
-
-static void filter_redirector_class_init(ObjectClass *oc, void *data)
-{
-    NetFilterClass *nfc = NETFILTER_CLASS(oc);
-
-    nfc->setup = filter_redirector_setup;
-    nfc->cleanup = filter_redirector_cleanup;
-    nfc->receive_iov = filter_redirector_receive_iov;
-}
-
 static char *filter_redirector_get_indev(Object *obj, Error **errp)
 {
     MirrorState *s = FILTER_REDIRECTOR(obj);
@@ -388,6 +370,24 @@ static void filter_redirector_set_vnet_hdr(Object *obj,
     s->vnet_hdr = value;
 }
 
+static void filter_mirror_class_init(ObjectClass *oc, void *data)
+{
+    NetFilterClass *nfc = NETFILTER_CLASS(oc);
+
+    nfc->setup = filter_mirror_setup;
+    nfc->cleanup = filter_mirror_cleanup;
+    nfc->receive_iov = filter_mirror_receive_iov;
+}
+
+static void filter_redirector_class_init(ObjectClass *oc, void *data)
+{
+    NetFilterClass *nfc = NETFILTER_CLASS(oc);
+
+    nfc->setup = filter_redirector_setup;
+    nfc->cleanup = filter_redirector_cleanup;
+    nfc->receive_iov = filter_redirector_receive_iov;
+}
+
 static void filter_mirror_init(Object *obj)
 {
     MirrorState *s = FILTER_MIRROR(obj);
-- 
2.26.2


