Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F65C4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C578B23A62
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xn5zcvPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C578B23A62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKUEe-0008VB-U7
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU27-0000aq-2Q
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU22-0001eQ-Eo
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqtEZWQxZSHY7rT/HZvuRkl1HSoTAI8T3ZT+fIlVs1Y=;
 b=Xn5zcvPf4yH/1nbxNkuTIHp9Y3L0c9xFI6fsiIUw/T1ZYcz1w+4uLSh2YCSRuq1oAFuWxC
 rEbs4BWKKTbUQJcx7P5AN2IBk6/grVxBw0cq5PSGn++gc1C4LjHuFoWfu1+27ASClNV/M7
 hnPjkBvWLoV7BPE0QNI6n8NLCA37uas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-m1R--18VMEOT6DC8rwoJLw-1; Mon, 21 Sep 2020 18:11:26 -0400
X-MC-Unique: m1R--18VMEOT6DC8rwoJLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7B64185FD93
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 22:11:25 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A599073684;
 Mon, 21 Sep 2020 22:11:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/24] cpu/core: Register core-id and nr-threads as class
 properties
Date: Mon, 21 Sep 2020 18:10:38 -0400
Message-Id: <20200921221045.699690-18-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-1-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: qemu-devel@nongnu.org
---
 hw/cpu/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 3a659291eae..92d3b2fbad6 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -69,10 +69,6 @@ static void cpu_core_instance_init(Object *obj)
     MachineState *ms = MACHINE(qdev_get_machine());
     CPUCore *core = CPU_CORE(obj);
 
-    object_property_add(obj, "core-id", "int", core_prop_get_core_id,
-                        core_prop_set_core_id, NULL, NULL);
-    object_property_add(obj, "nr-threads", "int", core_prop_get_nr_threads,
-                        core_prop_set_nr_threads, NULL, NULL);
     core->nr_threads = ms->smp.threads;
 }
 
@@ -81,6 +77,10 @@ static void cpu_core_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
+    object_class_property_add(oc, "core-id", "int", core_prop_get_core_id,
+                              core_prop_set_core_id, NULL, NULL);
+    object_class_property_add(oc, "nr-threads", "int", core_prop_get_nr_threads,
+                              core_prop_set_nr_threads, NULL, NULL);
 }
 
 static const TypeInfo cpu_core_type_info = {
-- 
2.26.2


