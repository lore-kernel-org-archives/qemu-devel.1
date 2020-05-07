Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D498C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED28420735
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqs3NY0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED28420735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkWu-0007Iz-4T
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVj-0004ty-Fc
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24304
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVh-000243-Vp
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdFZ0OjE1DpAAVLNEZIjDa8uv1PWgwWozsvTfYsCYTw=;
 b=fqs3NY0MwEsFXhtfJZVQcYghaYguR6/N/SVruP9SufuA2o/YO+MkzX/1CsEc6+2wcFCChy
 qxO7yCzlK/9GwPq2UopMK7xw3tErMECxM1hzc0XZ5fkwrMmo2MOkGhrkQJ5PpzdAs2kStI
 hLc7G3vtQHU7FNjpcB8jk8JZl6qsOt4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-kddcGn7pNz6SBaZFLnbpHw-1; Thu, 07 May 2020 13:40:35 -0400
X-MC-Unique: kddcGn7pNz6SBaZFLnbpHw-1
Received: by mail-wm1-f71.google.com with SMTP id w189so134751wmg.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DuSlgYQW6m0eg/30d5EZD9dD1Dk0rLysx3QIzLKclSo=;
 b=k/CNdeo/yrfjbUl9ArfQASE6veMhP///cHGEqWYF+TEoJ0Mw1B/uJxree8mMHjdD6E
 LO5hAgqsie81EoEyNFAPUxXFNRWCCyHVzVj3cIsYQchjVbdkQlqIHETKZH34E7sXKPaX
 04pD4EhWX8e/1vB53J68drJv/oL2fg21KhSiAX1sMWF3nFuM6ufvH+55mZPUaPiw7I6v
 rqeAZIic0yJygoYHcl2AoFf6sguYU4QKMSM/XYaMT2F4YRn0QSTN5Ww7d7n0ntxN6TWk
 S1vQy0rxfvRECsSeJsFMo3FNgi0c6zYKlpipl4uX2zQ9sSwH4JhWg2Y30VCyKlxQFcPi
 ihXg==
X-Gm-Message-State: AGi0Pua8IYafI3NjS1YmTozer/m1DdZKLQsJx6ootJlJjX25H+5ujmya
 WTqgjJTiPRYJOLrAsKHC8ivHJZeBmQ0Ru4tahhxCOPn7qd93Pq0RXvxEWG4/CL5stN9Tpohihi0
 jkbjeJBfmQJmvi2k=
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr4412726wmc.53.1588873234572; 
 Thu, 07 May 2020 10:40:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypIUjywJdc7qvMuEX/G7gKNbNfCgRlvC+A643ONE2kdTVge32hF2c0AYqiGKGwl93xhWiL4H5g==
X-Received: by 2002:a1c:7e82:: with SMTP id z124mr4412705wmc.53.1588873234244; 
 Thu, 07 May 2020 10:40:34 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id c190sm9535898wme.10.2020.05.07.10.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:40:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 05/10] exec: Move qemu_minrampagesize/qemu_maxrampagesize to
 'qemu-common.h'
Date: Thu,  7 May 2020 19:39:53 +0200
Message-Id: <20200507173958.25894-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move these generic functions to a more common place, with other
functions related to host page size. Document a little.

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/ram_addr.h    |  3 ---
 include/qemu-common.h      | 10 ++++++++++
 hw/ppc/spapr_caps.c        |  2 +-
 hw/s390x/s390-virtio-ccw.c |  1 +
 hw/vfio/spapr.c            |  2 +-
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 06096e8c6a..195b67d3c8 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -93,9 +93,6 @@ static inline unsigned long int ramblock_recv_bitmap_offs=
et(void *host_addr,
=20
 bool ramblock_is_pmem(RAMBlock *rb);
=20
-long qemu_minrampagesize(void);
-long qemu_maxrampagesize(void);
-
 /**
  * qemu_ram_alloc_from_file,
  * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backin=
g
diff --git a/include/qemu-common.h b/include/qemu-common.h
index d0142f29ac..2821a6ef76 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -80,6 +80,16 @@ bool set_preferred_target_page_bits(int bits);
  */
 void finalize_target_page_bits(void);
=20
+/**
+ * qemu_minrampagesize:
+ * qemu_maxrampagesize:
+ *
+ * If backed via -memdev, return the device page size,
+ * else return the host kernel page size.
+ */
+long qemu_minrampagesize(void);
+long qemu_maxrampagesize(void);
+
 /**
  * Sends a (part of) iovec down a socket, yielding when the socket is full=
, or
  * Receives data into a (part of) iovec from a socket,
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index eb54f94227..33a802a103 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -23,11 +23,11 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "sysemu/hw_accel.h"
-#include "exec/ram_addr.h"
 #include "target/ppc/cpu.h"
 #include "target/ppc/mmu-hash64.h"
 #include "cpu-models.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index f660070d22..c009384505 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -12,6 +12,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/boards.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 2900bd1941..c64db940a7 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -9,13 +9,13 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "cpu.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
=20
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
-#include "exec/ram_addr.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
--=20
2.21.3


