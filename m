Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2609FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2025206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kx2cn4CB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2025206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPpc-0005SZ-2q
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPgj-00074c-NY
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:04:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59119
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPgg-00011c-JZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591891457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ux4aj329B1BwmC7nDJ/LNHc4D/BIeJqak7rhlE6WHSo=;
 b=Kx2cn4CBjPK1CqpQKI9i6oBCXlwJTf1P2MTW+lh1OaKNcizEpSyyt+JsGHY1XN0nx2Y2P6
 a1uzm/1crup0g6I+rpOLqa3bmPDBP6gfisxonqhrQJhYwGhWRrrBnggW8cTZ2Q3VwyDYpH
 jJOa+VyqMPb9ZwKFIBjA0zu52T9CziA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-yf2d5jhNM6KYnyi0u79FlA-1; Thu, 11 Jun 2020 12:03:47 -0400
X-MC-Unique: yf2d5jhNM6KYnyi0u79FlA-1
Received: by mail-wm1-f71.google.com with SMTP id r1so1493891wmh.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ux4aj329B1BwmC7nDJ/LNHc4D/BIeJqak7rhlE6WHSo=;
 b=km1eZW9AP3IDi8ElYGc9WOh0sTuvzShAKx+tJMDAJrFQh0cbOM1CsE3OaOkPyoI5KL
 PXL8i7JgsHHv2CrwCGsBoR/hWvc2f2PCUgFm8Lo5AgRGLy/VbB/nvzjuokSWL5lvfyT9
 qLEOYPk1C9Wb2R0YAp5UE99FcjvOq4IgspyD1hqSB7qogTskDH0CGWKi6xYuTgrPe75A
 TQq0Y6k/thl7AAJw0SEo61l+1pHJ4YIefVRoIHiG6CLq4F53X8jtOUM8ZaayVKIaZ5Mj
 HO9XWWF6Mu3znyOQxUL6wg84Z2miE500sj6oehZ8ZDYBn2NiFyxkDBYisMYoTA2lzWPd
 6YaQ==
X-Gm-Message-State: AOAM53027qcLROVygYoSR9xWIWtns+KL8ld+/5sBBZotV1KHJkV1ZF7L
 Sx4Mt/n7PcZZMBmWsgtVZFtXbGCdEAvqVIiL+aDtqRIuHHEbhZFzBjbr9CnBZF3bjeiS+S86ekt
 ++X1404dT3b5Mwww=
X-Received: by 2002:a1c:e355:: with SMTP id a82mr8773683wmh.1.1591891425834;
 Thu, 11 Jun 2020 09:03:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwriCdule6rDyHlaOYJfsMRQUFtfkg7m1fkMoEufPkUS5l2qH13Kg73X86hkLtbD/7aT3zCew==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr8773657wmh.1.1591891425631;
 Thu, 11 Jun 2020 09:03:45 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q13sm5612598wrn.84.2020.06.11.09.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:03:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/11] hw/tpm: Remove unnecessary 'tpm_int.h' header
 inclusion
Date: Thu, 11 Jun 2020 18:03:02 +0200
Message-Id: <20200611160306.2751-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200611160306.2751-1-philmd@redhat.com>
References: <20200611160306.2751-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
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


