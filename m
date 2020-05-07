Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B801C47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5CB207DD
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wb4ubqiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5CB207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWjws-0006WT-SD
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjuz-0004kG-EF
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39964
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjuv-0001bF-0e
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588870956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIpgeCFsLaXlM09x3yJ/YbxMjQwTXw1hTKGqgDwsFxo=;
 b=Wb4ubqiXB0LimWAn2fepJtOw2eIzd33LUsaIenArjPoZ8S3m/dvM4LKcTIiUzI6wKMGAfx
 9ftSEai4PIuC/bthc1PtdfoRAt2FV5M1W+PXMJKwyDhs+i3qhImkjRMomcoj80id6muOxF
 JN3zm6rSPs3sCQcZjtMcMXXS6U4kEMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-1N0o07S9MWmtrxHhqBMrhw-1; Thu, 07 May 2020 13:02:34 -0400
X-MC-Unique: 1N0o07S9MWmtrxHhqBMrhw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2171819057A2;
 Thu,  7 May 2020 17:02:28 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-224.ams2.redhat.com
 [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9FB1001B07;
 Thu,  7 May 2020 17:02:25 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, zhukeqian1@huawei.com,
 maozhongyi@cmss.chinamobile.com, marcandre.lureau@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, wei.w.wang@intel.com,
 yi.y.sun@intel.com, quintela@redhat.com
Subject: [PULL 02/12] migration/migration: improve error reporting for migrate
 parameters
Date: Thu,  7 May 2020 18:02:01 +0100
Message-Id: <20200507170211.238283-3-dgilbert@redhat.com>
In-Reply-To: <20200507170211.238283-1-dgilbert@redhat.com>
References: <20200507170211.238283-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

use QERR_INVALID_PARAMETER_VALUE instead of
"Parameter '%s' expects" for consistency.

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Message-Id: <4ce71da4a5f98ad6ead0806ec71043473dcb4c07.1585641083.git.maozho=
ngyi@cmss.chinamobile.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8f27174ff6..6e079efdcc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1202,16 +1202,19 @@ static bool migrate_params_check(MigrationParameter=
s *params, Error **errp)
     }
=20
     if (params->has_max_bandwidth && (params->max_bandwidth > SIZE_MAX)) {
-        error_setg(errp, "Parameter 'max_bandwidth' expects an integer in =
the"
-                         " range of 0 to %zu bytes/second", SIZE_MAX);
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "max_bandwidth",
+                   "an integer in the range of 0 to "stringify(SIZE_MAX)
+                   " bytes/second");
         return false;
     }
=20
     if (params->has_downtime_limit &&
         (params->downtime_limit > MAX_MIGRATE_DOWNTIME)) {
-        error_setg(errp, "Parameter 'downtime_limit' expects an integer in=
 "
-                         "the range of 0 to %d milliseconds",
-                         MAX_MIGRATE_DOWNTIME);
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "downtime_limit",
+                   "an integer in the range of 0 to "
+                    stringify(MAX_MIGRATE_DOWNTIME)" milliseconds");
         return false;
     }
=20
@@ -2107,9 +2110,10 @@ void qmp_migrate_set_speed(int64_t value, Error **er=
rp)
 void qmp_migrate_set_downtime(double value, Error **errp)
 {
     if (value < 0 || value > MAX_MIGRATE_DOWNTIME_SECONDS) {
-        error_setg(errp, "Parameter 'downtime_limit' expects an integer in=
 "
-                         "the range of 0 to %d seconds",
-                         MAX_MIGRATE_DOWNTIME_SECONDS);
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   "downtime_limit",
+                   "an integer in the range of 0 to "
+                    stringify(MAX_MIGRATE_DOWNTIME_SECONDS)" seconds");
         return;
     }
=20
--=20
2.26.2


