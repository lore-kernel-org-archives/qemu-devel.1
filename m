Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E2CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1022A222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGwJZBXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1022A222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7eAK-0005SA-4V
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7e7B-00086M-17
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7e7A-0001Jm-3i
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:32 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32407)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7e7A-0001JQ-0N
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582890451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8ePsKj5YbwzFmCSbDjLbStV8+VqxxSeQRnfTwIVzUU=;
 b=KGwJZBXmT07Gv1bApnAxuTj8nYQOZyo9ZDdSyHoDGuvzGyem5qPxfp0tBh0/LF4MZWlteZ
 e1lBtB4G3+qHRrIa2DmiUQJlC5OxnU2yGj5dE4c3tslDyV6yY3Nr6WFdIEXztsHKwnJOTj
 /AhIDfFSG88GMJdHcsYU3jCVT8wLAwc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-l2_0s5KrOXO9GRj5UtI4MQ-1; Fri, 28 Feb 2020 06:47:30 -0500
X-MC-Unique: l2_0s5KrOXO9GRj5UtI4MQ-1
Received: by mail-wr1-f71.google.com with SMTP id r1so1213738wrc.15
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T5sSCEp9I6m1ocN4OvxPRUQZAmULP2h9DUzM0g+WsgY=;
 b=QfOBjyQBLx04fMyZObzpv6s35E4lLiFqdpNYLsMj53X5btNK97/4Cwh5K0OSRsUgRI
 p5m9gIy2MCFRQDIrsddFqYFI72j5MRJ/ubtPJNAk8ep95r1+J5JHN3itUIOtDUMyFDFh
 WCnJEkDjc+CGnU7HvckYDLL8bDEX0Lk8+8x6vjuB6S24zDJj+nL6nzD8oumVcRkW/BQy
 CQj7lQuoWh+TcgoEp2mmXiEMnw2+swctiJZ5OFnMiwHOx8n1iQKRAAfenWOxBgr57ZYw
 VV+yrs5INMbmP/0TpwXxC7JgSpgmRZiDZkx+ix+KVLtuewBjxyZgEAxvzF0V64hjcMue
 z7Pg==
X-Gm-Message-State: APjAAAW88E450Fr2JgzZ/ohYN+XgC9AqGfcYOSxpVqdW41n33c+nvnNN
 hQKn12Y2rHcfqemBrEEHDk9PFemN9JGtw5ZzMCsGZaCoAwowf/HoSbEDIZgIBnLR1nL4QizOSRe
 hEWywJsFHsB0MdMY=
X-Received: by 2002:a5d:6690:: with SMTP id l16mr4741426wru.251.1582890448646; 
 Fri, 28 Feb 2020 03:47:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHAG/V9Lgl4O+xWBzgNCPVxffpQWXf5zY4ukcAq+l3DPwWUAFh33GHGippgrBm9pBGh5AtmQ==
X-Received: by 2002:a5d:6690:: with SMTP id l16mr4741418wru.251.1582890448489; 
 Fri, 28 Feb 2020 03:47:28 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id f1sm12392933wro.85.2020.02.28.03.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 03:47:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/18] hw/i386/intel_iommu: Remove unused includes
Date: Fri, 28 Feb 2020 12:46:37 +0100
Message-Id: <20200228114649.12818-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228114649.12818-1-philmd@redhat.com>
References: <20200228114649.12818-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

intel_iommu.h does not use any of these includes, remove them.

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/i386/intel_iommu.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 66b931e526..a1c4afcda5 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -22,11 +22,7 @@
 #ifndef INTEL_IOMMU_H
 #define INTEL_IOMMU_H
=20
-#include "sysemu/dma.h"
 #include "hw/i386/x86-iommu.h"
-#include "hw/i386/ioapic.h"
-#include "hw/pci/msi.h"
-#include "hw/sysbus.h"
 #include "qemu/iova-tree.h"
=20
 #define TYPE_INTEL_IOMMU_DEVICE "intel-iommu"
--=20
2.21.1


