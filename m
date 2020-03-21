Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD408C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CC020663
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 19:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRXJS2wv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CC020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFjc7-0001LP-OT
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 15:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFjYj-0005Vb-AJ
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1jFjYi-0005qD-9K
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1jFjYi-0005p4-3b
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 15:13:24 -0400
Received: by mail-wm1-x342.google.com with SMTP id f130so8833632wmf.4
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sspz/br+P8mUAXaacMtETm/32ruEWwdUnsySxlRkdEg=;
 b=gRXJS2wvF9x8E1wNK0xgIqCDDJm/HzlZT3vxrdSap0MObaE5Qd9Pmahl43/xswU7i2
 l1hElMblmPyQXhnqAq0QFUpl+mnlctLKflOc5xoFOGfGcuUcqJQuPySStOy8UJfi7uF1
 nY3A7fzNgpMP2ou1dbaclIobgHl+aKidC2sQhR0qtefkzhknJeAld7bFbUM3FN7AiKpa
 v1eAl8llG9H6ubtKLepFy78rbXrXcIKHlC4kONBHYPdXxdxGNHvrMoN/6UAVvhvOL/EE
 nSvR5kU/rTrflUR3RIIpndxE7uQfrNAU3Ayd8t144XE99sX43tF2VlvdLmqdBF1tmia7
 yJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sspz/br+P8mUAXaacMtETm/32ruEWwdUnsySxlRkdEg=;
 b=rD+9A+Vp/UTnSJlCFuFWShm+yOfdyyCsxHhsRCThNZvWKllTGIeEwBUvTXlF5hh+o1
 SiVdSln27QlTEk1QsSbeOE8bgQ41rNfRbzjj1XATV93BmuwfbUpzDK8vvH77iSRGIZdl
 1aGQ3BSanBhMAJ8ilpvKHyh3kI/iscGemvpMXW0H3Y1qlgNRZsUb76rIWku8K8iXZWI2
 LKFPPXiqGfyg9c1F1Zy3iugKTJgxaJrAVFPJOZXsEwSzkt7danFKtNi5d540Ng0I70mI
 ZthZdvsU2oWmLuya/xmaeN8TAXQJ9erAutAc0YDcEPRArel2n/pthlkqNN3yeVtUZWyq
 H7Vg==
X-Gm-Message-State: ANhLgQ29aj4Bp7p/auqvTJbhs65FTpHdUxBbOT7z6SXz7AmciLF/EngP
 6OP7MnW1qNRcX3Sp468WvPi6O52v
X-Google-Smtp-Source: ADFU+vvj0dx3RdKk1pibdINBNN/Bm2KEsW0U36u6py3iV6j2B/qOWPlgTtGMJEJjX6wNBtwlWZegpw==
X-Received: by 2002:a7b:c305:: with SMTP id k5mr18431419wmj.189.1584818002856; 
 Sat, 21 Mar 2020 12:13:22 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id i1sm15226252wrs.18.2020.03.21.12.13.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 21 Mar 2020 12:13:22 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [Qemu-devel] [PATCH PULL 4/4] hw/rdma: avoid suspicious strncpy() use
Date: Sat, 21 Mar 2020 21:13:11 +0200
Message-Id: <20200321191311.31537-5-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
References: <20200321191311.31537-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: jusual@redhat.com, stefanha@redhat.com, yuval.shaia.ml@gmail.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1) with sanitizers enabled
reports the following error:

  CC      x86_64-softmmu/hw/rdma/vmw/pvrdma_dev_ring.o
In file included from /usr/include/string.h:495,
                 from include/qemu/osdep.h:101,
                 from hw/rdma/vmw/pvrdma_dev_ring.c:16:
In function ‘strncpy’,
    inlined from ‘pvrdma_ring_init’ at hw/rdma/vmw/pvrdma_dev_ring.c:33:5:
/usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound 32 equals destination size [-Werror=stringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use pstrcpy() instead of strncpy().  It is guaranteed to NUL-terminate
strings.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Yuval Shaia <yuval.shaia.ml.gmail.com>
Message-Id: <20200316160702.478964-3-stefanha@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_dev_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
index c2b3dd70a9..c122fe7035 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.c
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "hw/pci/pci.h"
 #include "cpu.h"
 #include "qemu/cutils.h"
-- 
2.17.2


