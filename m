Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CD2C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FF72072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V6mCcei9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FF72072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj6yB-0005bQ-Fo
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wM-0003kn-W0
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wM-0000VG-68
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e/EYPVDSq9o7kGYyx2YtJypw5YHd6D2ZQpFJlgHmrng=;
 b=V6mCcei9T1ahtv5v3BKvvxEh+qMNGHXj3iqJyfiD+7IS3zJ1wSWEeSkfQaFZhrExodQifw
 lXHbRSFxQSZrYScR1k0R7HSNmz8TZeQ7NmFx58n4EOBBcnEAK9CRW7XNleMJ3akXoU4Ee/
 8rbcv4wF8souoOMxuvdEg8DGalRIGXw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-TwcsvPSgMsOmwQnaKJQz7Q-1; Wed, 10 Jun 2020 16:03:11 -0400
X-MC-Unique: TwcsvPSgMsOmwQnaKJQz7Q-1
Received: by mail-wr1-f69.google.com with SMTP id i6so1520728wrr.23
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e/EYPVDSq9o7kGYyx2YtJypw5YHd6D2ZQpFJlgHmrng=;
 b=L5Yx/Tet7SwgqDH4dXlTM8AYLI/ekZ9cBBlTNm2uK0LrzDJ9VepJIbCEg9lljPnRYM
 El14hGs4GMpt2mWpPBnXPkURs94E9vF8QZCjfiYK/i2v2dkpVpxjoOeoyPdsEC9gsgOH
 eFqiRgh7UkEfEVxJVb1Hp2J0UZpj9z2kHMDpK8KDHJFYfc2OpyW5F2tRu5i26XUFeY3q
 4IgUn2i1m0nlT1LI0hlGLzuLBvaGmebxsNy3un6AvLgZr3QMcQP1lZiQBzSOCAe5xeBa
 M4gjzpqrkFLzRq//p3D5Pr76eMbw6Z6wKT2rpVOu+VLNDNQGXeZqKxx/lFq33MsRF2IN
 6K+A==
X-Gm-Message-State: AOAM530u016HndwLAQMw94t0OssPz1vdyu9zUDlCSgYVySvEkmAwD/7A
 w+k3ypbfjZJL1mCWxzZWG9x462nsXVoOwFoRmmWUf8J96Km1f6Rivt7PREq6RUvg9BgxGWF891o
 JrKMIW/LbaWXlVT4=
X-Received: by 2002:adf:f512:: with SMTP id q18mr5947188wro.38.1591819390282; 
 Wed, 10 Jun 2020 13:03:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvNmYO/WldNwwukngXC7JYTHy59oge5U+OTu+aPSbQql/XO4bcyXINRMJH9NRwrBX9Z9/UtA==
X-Received: by 2002:adf:f512:: with SMTP id q18mr5947168wro.38.1591819390138; 
 Wed, 10 Jun 2020 13:03:10 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o10sm1219017wrq.40.2020.06.10.13.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:03:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] hw/tpm: Remove unnecessary 'tpm_int.h' header inclusion
Date: Wed, 10 Jun 2020 22:02:43 +0200
Message-Id: <20200610200247.21378-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610200247.21378-1-philmd@redhat.com>
References: <20200610200247.21378-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:37:38
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


