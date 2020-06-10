Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA48206F7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImB/Pl7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA48206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj73N-0004UX-Hf
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wK-0003iY-9J
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35978
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jj6wJ-0000Tl-CU
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591819390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8vcbVygnzll77AIdF+TXScFaEG2IAKPO5yj5yE5bD4=;
 b=ImB/Pl7lagZjCVqO9FJXsdM245YhCFXwVZ3+R634bL15Vt661aioSX8QRffWREdKDSpGbN
 pJBmtBqgwxxCmXcJN3lHpKrSqYR565c9fFymhwMetF60cP6/4lDrhoS32RiumcYxe/bC8t
 KNzpSlf/lLXjbz76f43ReoU9NtF2w0s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-lnYVG0xGPFqTeGBT61zU_g-1; Wed, 10 Jun 2020 16:03:07 -0400
X-MC-Unique: lnYVG0xGPFqTeGBT61zU_g-1
Received: by mail-wr1-f72.google.com with SMTP id n6so1539669wrv.6
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L8vcbVygnzll77AIdF+TXScFaEG2IAKPO5yj5yE5bD4=;
 b=gXMSEkRByMzMyLj8E4j+wJq/hC1Y645kvTa+4GwzL8HFohJ7ReUcOAYKjwbAfO11Iu
 5BzGX3vZtglMCwm7hZYIe+26axSnfXEIGYRQ3KCMouBFFpswLp/nqnKTJzERqfm6zrpk
 EvKPJS+Kk+lumEGrU/5Gli6+RQb06GCQIBq2ZosQ+Fe7a1+mm8KD69dFU772so6daec4
 a+sG3FzDzkPT5q7EE2FczLksIJ13n/R30ZmX+D6ABrnbV1wuNC77KOJKetxUoqPY9UH/
 UEs9H8P02Agqxnvi5X0NUaXDz+05MEJUy/NHpUWH/XlO4sB9XzJIL8ky0B5CIVdvseZp
 DcFQ==
X-Gm-Message-State: AOAM530G+cVM7UOldkhofwOWUJr5g76UxEGU+pfK5NPOCT+IlmUFWxmX
 PQcO3zIGTnNbSHtp/lKumeCSGFfFhX8BPPj/pBdBKQjh+b7UjgvN7WAeb3ICzPacDX2P0gQ7JoT
 w+BpsCNu92JcxTUE=
X-Received: by 2002:a7b:c764:: with SMTP id x4mr4577367wmk.94.1591819385602;
 Wed, 10 Jun 2020 13:03:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb3l657YWc7tCE3RybZH3rQEL7JuWNOJgyiZ21SJfzDedPCZSViDPU6gnw7BV6RoIVDSYSIw==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr4577354wmk.94.1591819385399;
 Wed, 10 Jun 2020 13:03:05 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l17sm1230253wrq.17.2020.06.10.13.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:03:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] hw/tpm: Move 'hw/acpi/tpm.h' inclusion from header to
 sources
Date: Wed, 10 Jun 2020 22:02:42 +0200
Message-Id: <20200610200247.21378-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200610200247.21378-1-philmd@redhat.com>
References: <20200610200247.21378-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 15:37:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Nothing in "tpm_ppi.h" require declarations from "hw/acpi/tpm.h".
Reduce dependencies and include it only in the files requiring it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/tpm_ppi.h        | 1 -
 hw/tpm/tpm_tis_isa.c    | 1 +
 hw/tpm/tpm_tis_sysbus.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
index d33ef27de6..6f773c25a0 100644
--- a/hw/tpm/tpm_ppi.h
+++ b/hw/tpm/tpm_ppi.h
@@ -12,7 +12,6 @@
 #ifndef TPM_TPM_PPI_H
 #define TPM_TPM_PPI_H
 
-#include "hw/acpi/tpm.h"
 #include "exec/address-spaces.h"
 
 typedef struct TPMPPI {
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 30ba37079d..42f909ff1e 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -26,6 +26,7 @@
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "hw/acpi/tpm.h"
 #include "tpm_util.h"
 #include "tpm_tis.h"
 
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index eced1fc843..edca1dae0d 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "hw/acpi/tpm.h"
 #include "tpm_util.h"
 #include "hw/sysbus.h"
 #include "tpm_tis.h"
-- 
2.21.3


