Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2668C35257
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17E3206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRBknt/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17E3206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOO1U-00065s-GV
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kONv2-0005Dl-Km
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kONv0-0003GP-Rq
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601656106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sGszPAqKPTBf31hOPwIRrLOBCHoRfj3+4mBGakcPv7U=;
 b=RRBknt/DnxeLc/ptfpuTlwgbkBJWKaMKMdOmGuHw3+WTIivkrdKUo0HH2svVNb4NnUYP56
 sSpUDhM3byb2SvTTH5dZaTjWhNxYAZ9Xal3nXTWTSX9216i5I0NwngomTxQUtFHJ5D8GI7
 uoi3vCUNkNfoqkwUbR4pb0KM7FiPyWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-DvbkQUOgOIyOnwTH-Hrfyw-1; Fri, 02 Oct 2020 12:28:24 -0400
X-MC-Unique: DvbkQUOgOIyOnwTH-Hrfyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CE5E80404E;
 Fri,  2 Oct 2020 16:28:23 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA3121002C03;
 Fri,  2 Oct 2020 16:28:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/10] migration: introduce a delete_snapshot wrapper
Date: Fri,  2 Oct 2020 17:27:45 +0100
Message-Id: <20201002162747.3123597-9-berrange@redhat.com>
In-Reply-To: <20201002162747.3123597-1-berrange@redhat.com>
References: <20201002162747.3123597-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
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
index 16fc94efe2..f6f7aa85fd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2961,6 +2961,20 @@ err_drain:
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


