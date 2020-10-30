Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EFDC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:25:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A73C620739
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BFPC9Ocq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A73C620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYaxr-0005LG-I3
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYau5-0000C2-LS
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYau3-0007h9-VQ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604089299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+iBjVC7xcw6X3t+JOTGvDiD6Rn9cdGic8J7WThIGNg=;
 b=BFPC9OcqBo5Pc3W2aG1IqnBZlmVnfWFZ5n1lHLFv5fHKwNf1Ea9anTl1zkAcq80hsY1+EJ
 kPkUDgDjkuSCIGiBRo6lEPtcvDQ2dfp7Qr3PDWHl5QkokMylM0q4QqJzbBFfQyhXoA5GxT
 gCOwY06Xmiqwggt/5zy07n02rU7JOOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-oEECHw-IPIGvlfqNIfZITA-1; Fri, 30 Oct 2020 16:21:36 -0400
X-MC-Unique: oEECHw-IPIGvlfqNIfZITA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2245A805F12
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 20:21:35 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF8325D9D2;
 Fri, 30 Oct 2020 20:21:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/20] qdev: Stop using error_set_from_qdev_prop_error() for
 netdev property
Date: Fri, 30 Oct 2020 16:21:13 -0400
Message-Id: <20201030202131.796967-3-ehabkost@redhat.com>
In-Reply-To: <20201030202131.796967-1-ehabkost@redhat.com>
References: <20201030202131.796967-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 16:21:37
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just setting a reasonable error string using error_setg() is
simpler and makes error messages clearer.

Before:

  $ qemu-system-x86_64 -device e1000,netdev=n0
  qemu-system-x86_64: -device e1000,netdev=n0: Property 'e1000.netdev' can't find value 'n0'
  $ qemu-system-x86_64 -netdev id=n0,type=user -device e1000,netdev=n0 -device e1000,netdev=n0
  qemu-system-x86_64: -device e1000,netdev=n0: Property 'e1000.netdev' can't take value 'n0', it's in use

After:

  $ ./qemu-system-x86_64 -device e1000,netdev=n0
  qemu-system-x86_64: -device e1000,netdev=n0: Property 'e1000.netdev' can't take value 'n0': netdev not found
  $ ./qemu-system-x86_64 -netdev id=n0,type=user -device e1000,netdev=n0 -device e1000,netdev=n0
  qemu-system-x86_64: -device e1000,netdev=n0: Property 'e1000.netdev' can't take value 'n0': netdev is in use

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/core/qdev-properties-system.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 232ff955fa..60be09efba 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -376,7 +376,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     NICPeers *peers_ptr = object_static_prop_ptr(obj, prop);
     NetClientState **ncs = peers_ptr->ncs;
     NetClientState *peers[MAX_QUEUE_NUM];
-    int queues, err = 0, i = 0;
+    int queues, i = 0;
     char *str;
 
     if (!visit_type_str(v, name, &str, errp)) {
@@ -387,7 +387,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
                                           NET_CLIENT_DRIVER_NIC,
                                           MAX_QUEUE_NUM);
     if (queues == 0) {
-        err = -ENOENT;
+        error_setg(errp, "netdev not found");
         goto out;
     }
 
@@ -399,7 +399,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
 
     for (i = 0; i < queues; i++) {
         if (peers[i]->peer) {
-            err = -EEXIST;
+            error_setg(errp, "netdev is in use");
             goto out;
         }
 
@@ -418,7 +418,6 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     peers_ptr->queues = queues;
 
 out:
-    error_set_from_qdev_prop_error(errp, err, obj, prop, str);
     g_free(str);
 }
 
-- 
2.28.0


