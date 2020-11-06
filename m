Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2893C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:35:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEEE2065E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 18:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qXt+Wpgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEEE2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb6aB-0006Kc-Iy
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 13:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kb6ZZ-0005jr-9R
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:34:53 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8211)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwankhede@nvidia.com>)
 id 1kb6ZX-00066l-EA
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 13:34:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fa5974d0001>; Fri, 06 Nov 2020 10:34:53 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 18:34:49 +0000
Received: from kwankhede-dev.nvidia.com (172.20.13.39) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Nov 2020 18:34:47 +0000
From: Kirti Wankhede <kwankhede@nvidia.com>
To: <alex.williamson@redhat.com>, <cjia@nvidia.com>
Subject: [PATCH v2 1/1] Fix use after free in vfio_migration_probe
Date: Fri, 6 Nov 2020 23:32:24 +0530
Message-ID: <1604685744-25125-1-git-send-email-kwankhede@nvidia.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1604687693; bh=Grj6BlRKypQ46ciXgHeY+mq2/Q3EhXp1Rt0NDGRROm0=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Type:X-NVConfidentiality:Content-Transfer-Encoding;
 b=qXt+WpgdhRWmxVGRE13j3gTbqYm0R49O32wEwxXLpB4uG/gBNT6OaojaSrRvbKJFa
 k9xuDWvzp9s034/uUEgozhBXfKpyengSLQ2+AfsZ/+Z2K2IRiV3a9HcXRRXJ7MU5vo
 WRTsYR8NT9/mA6ypLig+j2Yp6KJSW1cpJkbJ8F7LLm3six5IL2z1zfAToiKk6UJxEP
 oFjeQocLTp5L+Xqu6kAr14m+zuW15+5kjJNz4PE3nD+a7VxwdS3jOpAMyzwXFywDu4
 gx8wehalJX1mWbR8I0R4q+rYXngWtqJDdY9ZJ2sEGsUIaARIfK9AmK0ZyHf3NZLhRi
 6gx2AehVZ+7AQ==
Received-SPF: pass client-ip=216.228.121.65; envelope-from=kwankhede@nvidia.com;
 helo=hqnvemgate26.nvidia.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 13:34:49
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mcrossley@nvidia.com, Kirti Wankhede <kwankhede@nvidia.com>,
 qemu-devel@nongnu.org, dnigam@nvidia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes Coverity issue:
CID 1436126:  Memory - illegal accesses  (USE_AFTER_FREE)

Fixes: a9e271ec9b36 ("vfio: Add migration region initialization and finaliz=
e
function")

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: David Edmondson <dme@dme.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/vfio/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 3ce285ea395d..55261562d4f3 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -897,8 +897,8 @@ int vfio_migration_probe(VFIODevice *vbasedev, Error **=
errp)
         goto add_blocker;
     }
=20
-    g_free(info);
     trace_vfio_migration_probe(vbasedev->name, info->index);
+    g_free(info);
     return 0;
=20
 add_blocker:
--=20
2.7.0


