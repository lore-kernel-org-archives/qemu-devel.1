Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93017C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610B7206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJM6GPY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610B7206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfX7-0005bq-OX
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 04:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfTG-0005s1-WC
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfTF-00072c-Fd
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591952128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ux4aj329B1BwmC7nDJ/LNHc4D/BIeJqak7rhlE6WHSo=;
 b=XJM6GPY7PGeb21RWpU0FH80kqbNx50CPDAfiK3GQ7vxMCfEUqWo3+s55jpm+yQwUjvIdFi
 XnAKupLPWe1CatDEQpSLaQstqQdOGDEkh7grWbFof+adIp1VyH7uQi/Dn9ZSgSOm4aqbJR
 CvCE5IedmhGO+fidajhgh32rqtcPuuQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Dj3fb3Z9M8GwDrsLrOR37A-1; Fri, 12 Jun 2020 04:55:27 -0400
X-MC-Unique: Dj3fb3Z9M8GwDrsLrOR37A-1
Received: by mail-wr1-f72.google.com with SMTP id z10so3673439wrs.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 01:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ux4aj329B1BwmC7nDJ/LNHc4D/BIeJqak7rhlE6WHSo=;
 b=QnOxOk8o23ALZ12/oHMApn7oa/aXVKfg4pqC+67HR9ONBdUdv70KXkld3kLfjM0ymb
 jJykOm/exmjwaavTNRzP7ibw4qdHdeVPcQ1JpRxiJrg0KNvheeNlwUqaZUGfBMIOa9LH
 V0xpnHF2n7Tfqo8gr0/Ng52m08LNnfvv3zi8NdLrKA3JEsPk3Sj5opHd+gaCQvPKf1co
 jpubEc+5zID1g5fDBOXHQJlEHLy2RO+K3M2M/Ei0IwWFg3zzONunbWE53kM9pSLGv/Er
 psDBUcVGdrYFMCi4EFZUmOHa7Efn9w5YL/r0rVYqOTWpnxlmRkOLQYiRWU89dhku9EO8
 PLQg==
X-Gm-Message-State: AOAM532aswN5DbOmYQtAYvui0dyEuh/p/WzMiunU6m8KrcmpVNEr83xH
 8WhBNL1x0K3usZHfpjp8RUG9yqL81ZTBRnhEgStdblcRGnHDOmINziAT7SpbZUC1c3ba6YEgl5G
 qnNhN6nq0bs59L9s=
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr11816641wmh.164.1591952125589; 
 Fri, 12 Jun 2020 01:55:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzn4AIarmHlyTc0Co/D9RI+jVWPhzNCDsweBrdQ5el+bccYOS/5OVfdrqjwdTAd0n0gryIEqQ==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr11816624wmh.164.1591952125402; 
 Fri, 12 Jun 2020 01:55:25 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id w1sm7799805wmi.13.2020.06.12.01.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 01:55:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/12] hw/tpm: Remove unnecessary 'tpm_int.h' header
 inclusion
Date: Fri, 12 Jun 2020 10:54:39 +0200
Message-Id: <20200612085444.8362-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612085444.8362-1-philmd@redhat.com>
References: <20200612085444.8362-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove unnecessary 'tpm_int.h' header inclusion.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/tpm_crb.c        | 1 -
 hw/tpm/tpm_spapr.c      | 1 -
 hw/tpm/tpm_tis_common.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index cd004e7f8e..664ff70ef9 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -25,7 +25,6 @@
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
 #include "sysemu/reset.h"
-#include "tpm_int.h"
 #include "tpm_util.h"
 #include "tpm_ppi.h"
 #include "trace.h"
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index ce65eb2e45..ab1a86ad6e 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -20,7 +20,6 @@
 #include "migration/vmstate.h"
 
 #include "sysemu/tpm_backend.h"
-#include "tpm_int.h"
 #include "tpm_util.h"
 
 #include "hw/ppc/spapr.h"
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 1af4bce139..94704870f6 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -33,7 +33,6 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
-#include "tpm_int.h"
 #include "tpm_util.h"
 #include "tpm_ppi.h"
 #include "trace.h"
-- 
2.21.3


