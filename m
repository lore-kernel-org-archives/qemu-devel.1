Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B7FC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A8C25316
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 16:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhEtKMQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A8C25316
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYMr-0002Wf-Ij
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 12:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQYBu-0006xB-Gp
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:50:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQYBr-0002fk-Q0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602172246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WxKv55fPq1bR04tSsO5j1f8G8Qman/L17fIf4CdFLc=;
 b=IhEtKMQHVIt1YquV4Z/2sFQmRP9yuih+tcfjYj6Y2Xyv0foi7i5xt7ojH9OImJjRQijBrq
 z+Cr6oJF3PJlTMqr5qc/G+1X0FAOlyosjhenQaKvMD1czrM6cWe3D2AVk1kxG0w7+kVGs1
 9wXKXlS79Qr4+MfqY7E2wDf4KITyu6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-acPDkEBcM3uAYmnRYqxwIg-1; Thu, 08 Oct 2020 11:50:44 -0400
X-MC-Unique: acPDkEBcM3uAYmnRYqxwIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66B849CC01;
 Thu,  8 Oct 2020 15:50:43 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 280465C1BD;
 Thu,  8 Oct 2020 15:50:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/10] migration: introduce a delete_snapshot wrapper
Date: Thu,  8 Oct 2020 16:49:59 +0100
Message-Id: <20201008155001.3357288-9-berrange@redhat.com>
In-Reply-To: <20201008155001.3357288-1-berrange@redhat.com>
References: <20201008155001.3357288-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make snapshot deletion consistent with the snapshot save
and load commands by using a wrapper around the blockdev
layer. The main difference is that we get upfront validation
of the passed in device list (if any).

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/migration/snapshot.h |  4 +++-
 migration/savevm.c           | 14 ++++++++++++++
 monitor/hmp-cmds.c           |  2 +-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index b2c72e0a1b..f46f28745d 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -25,5 +25,7 @@ int load_snapshot(const char *name,
                   const char *vmstate,
                   bool has_devices, strList *devices,
                   Error **errp);
-
+int delete_snapshot(const char *name,
+                    bool has_devices, strList *devices,
+                    Error **errp);
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 9cf18c87ed..bfbf84b9f2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2966,6 +2966,20 @@ err_drain:
     return -1;
 }
 
+int delete_snapshot(const char *name, bool has_devices,
+                    strList *devices, Error **errp)
+{
+    if (!bdrv_all_can_snapshot(has_devices, devices, errp)) {
+        return -1;
+    }
+
+    if (bdrv_all_delete_snapshot(name, has_devices, devices, errp) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
 void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
 {
     qemu_ram_set_idstr(mr->ram_block,
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 96f7060e00..2f65fada29 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1143,7 +1143,7 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     const char *name = qdict_get_str(qdict, "name");
 
-    bdrv_all_delete_snapshot(name, false, NULL, &err);
+    delete_snapshot(name, false, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
-- 
2.26.2


