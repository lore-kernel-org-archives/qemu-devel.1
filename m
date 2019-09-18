Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A5C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30B520856
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 13:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30B520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAa0P-0006Be-Fy
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 09:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAZth-0008AN-17
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAZte-0002Tt-VA
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 09:21:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iAZtc-0002Rr-2d; Wed, 18 Sep 2019 09:21:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 40F0A10CC203;
 Wed, 18 Sep 2019 13:21:23 +0000 (UTC)
Received: from localhost (unknown [10.36.118.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 269F3600C8;
 Wed, 18 Sep 2019 13:21:17 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 18 Sep 2019 14:21:10 +0100
Message-Id: <20190918132112.10418-2-stefanha@redhat.com>
In-Reply-To: <20190918132112.10418-1-stefanha@redhat.com>
References: <20190918132112.10418-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 18 Sep 2019 13:21:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/3] loader: Trace loaded images
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This adds a trace point which prints every loaded image. This includes
bios/firmware/kernel/initradmdisk/pcirom.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190613050937.124903-1-aik@ozlabs.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile.objs        | 1 +
 hw/core/loader.c     | 3 +++
 hw/core/trace-events | 2 ++
 3 files changed, 6 insertions(+)
 create mode 100644 hw/core/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 6a143dcd57..abcbd89654 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -203,6 +203,7 @@ trace-events-subdirs +=3D target/riscv
 trace-events-subdirs +=3D target/s390x
 trace-events-subdirs +=3D target/sparc
 trace-events-subdirs +=3D util
+trace-events-subdirs +=3D hw/core
=20
 trace-events-files =3D $(SRC_PATH)/trace-events $(trace-events-subdirs:%=
=3D$(SRC_PATH)/%/trace-events)
=20
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 75eb56ddbb..0d60219364 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -45,6 +45,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qapi/error.h"
+#include "trace.h"
 #include "hw/hw.h"
 #include "disas/disas.h"
 #include "migration/vmstate.h"
@@ -1151,6 +1152,8 @@ static void rom_reset(void *unused)
          * CPU definitely fetches its instructions from the just written=
 data.
          */
         cpu_flush_icache_range(rom->addr, rom->datasize);
+
+        trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom-=
>isrom);
     }
 }
=20
diff --git a/hw/core/trace-events b/hw/core/trace-events
new file mode 100644
index 0000000000..fe47a9c8cb
--- /dev/null
+++ b/hw/core/trace-events
@@ -0,0 +1,2 @@
+# loader.c
+loader_write_rom(const char *name, uint64_t gpa, uint64_t size, bool isr=
om) "%s: @0x%"PRIx64" size=3D0x%"PRIx64" ROM=3D%d"
--=20
2.21.0


