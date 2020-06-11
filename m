Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D184AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5F8206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zx1i/gNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5F8206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPsb-0001xO-82
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPmH-00078k-3C
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:10:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30626
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPmF-0002QE-7e
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591891801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lg93mmx8nphNH1y4bYZrwT9M+1WJW6lG0NFyoN2HHMc=;
 b=Zx1i/gNCgV7CDz7T/wT1W8BCSrVCR+Y6+a0pW3lw1VS8wffWYGEs8C3/Ha316M4hHRNgqQ
 NOY7Cp0HRUGM9+xFIwTBEfcyfeVa+R2/HRnTX30lZBbPyUBFoRmOkTZud2ea12oTJYN/n4
 kJwjU1YxqqlyhutBLqEAoHGM3He6Nts=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-9d_PgyNDPrWAaJLjzlMDKA-1; Thu, 11 Jun 2020 12:03:32 -0400
X-MC-Unique: 9d_PgyNDPrWAaJLjzlMDKA-1
Received: by mail-wm1-f69.google.com with SMTP id u15so1225473wmm.5
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lg93mmx8nphNH1y4bYZrwT9M+1WJW6lG0NFyoN2HHMc=;
 b=uWvdA1SkLIBRu3oEKHUVAob11diVoUGDEqs+poSGvqLS5jCeAzwPw5BCwwTnUvgqBs
 9nYJvA6a4nl/XCdb9PwQBVDo8HE72UtRrSfrpeYbA36FbWD/qC93xxH3xY4xi2sURngT
 hPSJ3geF7DZ9vphT5eEP/Zo1QAfMxVxxcSG2YuG/puUJP6HWs8XACGa2DoC+MdYz2+BG
 jGXQFjm01Yy8jAKgbRlfarR6Cqc9g5y1kAv+b1Qma6ccFYXSeX7RTyRack5/MYKCW7lu
 tXAlNoLj2hemXOWIflohB4XCoOiuc+8IAYni6HcQY7y4zHKZKRQT+1PcAWiYTb5cuVnX
 fJIg==
X-Gm-Message-State: AOAM533Q+SCx/FyBaHHG3T8yKheRAOby6sk/b8LwQwN7JDq/YVrMGaoS
 rsBjCxJOYehYSW5rWJ6OGCELFOI78B4GxOPVMjxETC12X9GoUrlvsa+QCgWMeSiw9dcuVt25/Pk
 xizGEAajVkohmIJM=
X-Received: by 2002:adf:9286:: with SMTP id 6mr10379909wrn.361.1591891411094; 
 Thu, 11 Jun 2020 09:03:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqTesS7xm4yBhAQQ99I3Nma0bf65xYGUYytQg5xoJP5xIXklWHETgjuJ+4V87pgYtOfbZgxw==
X-Received: by 2002:adf:9286:: with SMTP id 6mr10379891wrn.361.1591891410935; 
 Thu, 11 Jun 2020 09:03:30 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a15sm5749589wra.86.2020.06.11.09.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:03:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/11] hw/tpm: Do not include 'qemu/osdep.h' in header
Date: Thu, 11 Jun 2020 18:02:59 +0200
Message-Id: <20200611160306.2751-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200611160306.2751-1-philmd@redhat.com>
References: <20200611160306.2751-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
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
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From CODING_STYLE.rst:

  Do not include "qemu/osdep.h" from header files since the .c
  file will have already included it.

Remove "qemu/osdep.h" from "tpm_tis.h".

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/tpm_tis.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 5554989395..f6b5872ba6 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -24,7 +24,6 @@
 #ifndef TPM_TPM_TIS_H
 #define TPM_TPM_TIS_H
 
-#include "qemu/osdep.h"
 #include "sysemu/tpm_backend.h"
 #include "tpm_ppi.h"
 
-- 
2.21.3


