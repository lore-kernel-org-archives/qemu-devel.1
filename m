Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042E8C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10CC2171F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 15:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10CC2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpaU6-0005nu-2x
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 11:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52487)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaTv-0005P7-A3
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1hpaTt-00046T-CE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 11:44:07 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.80]:15138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1hpaTZ-0003rl-65; Mon, 22 Jul 2019 11:43:45 -0400
Received: from tpw09926dag18h.domain1.systemhost.net (10.9.212.42) by
 BWP09926085.bt.com (10.36.82.116) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Mon, 22
 Jul 2019 16:43:46 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18h.domain1.systemhost.net (10.9.212.42) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Mon, 22 Jul 2019 16:43:43 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Mon, 22 Jul
 2019 16:43:43 +0100
From: <tony.nguyen@bt.com>
To: <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 05/20] tcg: Move size+sign+endian from
 TCGMemOp to MemOp
Thread-Index: AQHVQKQ9cEFsk0Sv/kSj8smbj0lJlQ==
Date: Mon, 22 Jul 2019 15:43:43 +0000
Message-ID: <1563810222730.76414@bt.com>
References: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
In-Reply-To: <e9c6e5310b1a4863be45d45bf087fc3d@tpw09926dag18e.domain1.systemhost.net>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.37]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.80
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] [PATCH v2 05/20] tcg: Move size+sign+endian from
 TCGMemOp to MemOp
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, mst@redhat.com,
 palmer@sifive.com, mark.cave-ayland@ilande.co.uk, Alistair.Francis@wdc.com,
 arikalo@wavecomp.com, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, rth@twiddle.net, atar4qemu@gmail.com,
 ehabkost@redhat.com, sw@weilnetz.de, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 cohuck@redhat.com, claudio.fontana@huawei.com, alex.williamson@redhat.com,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Preparation for modifying the memory API to take size+sign+endianness
instead of just size.

Accelerator independent MemOp enum is extended by TCGMemOp enum.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 MAINTAINERS          |  1 +
 include/exec/memop.h | 27 +++++++++++++++++++++++++++
 tcg/tcg.h            | 15 +++++----------
 3 files changed, 33 insertions(+), 10 deletions(-)
 create mode 100644 include/exec/memop.h

diff --git a/MAINTAINERS b/MAINTAINERS
index cc9636b..3f148cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1890,6 +1890,7 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
 F: include/exec/ioport.h
 F: ioport.c
+F: include/exec/memop.h
 F: include/exec/memory.h
 F: include/exec/ram_addr.h
 F: memory.c
diff --git a/include/exec/memop.h b/include/exec/memop.h
new file mode 100644
index 0000000..43e99d7
--- /dev/null
+++ b/include/exec/memop.h
@@ -0,0 +1,27 @@
+/*
+ * Constants for memory operations
+ *
+ * Authors:
+ *  Richard Henderson <rth@twiddle.net>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef MEMOP_H
+#define MEMOP_H
+
+typedef enum MemOp {
+    MO_8     =3D 0,
+    MO_16    =3D 1,
+    MO_32    =3D 2,
+    MO_64    =3D 3,
+    MO_SIZE  =3D 3,   /* Mask for the above.  */
+
+    MO_SIGN  =3D 4,   /* Sign-extended, otherwise zero-extended.  */
+
+    MO_BSWAP =3D 8,   /* Host reverse endian.  */
+} MemOp;
+
+#endif
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 63e9897..18b91fe 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -26,6 +26,7 @@
 #define TCG_H

 #include "cpu.h"
+#include "exec/memop.h"
 #include "exec/tb-context.h"
 #include "qemu/bitops.h"
 #include "qemu/queue.h"
@@ -309,17 +310,11 @@ typedef enum TCGType {
 #endif
 } TCGType;

-/* Constants for qemu_ld and qemu_st for the Memory Operation field.  */
+/*
+ * Extend MemOp with constants for qemu_ld and qemu_st for the Memory
+ * Operation field.
+ */
 typedef enum TCGMemOp {
-    MO_8     =3D 0,
-    MO_16    =3D 1,
-    MO_32    =3D 2,
-    MO_64    =3D 3,
-    MO_SIZE  =3D 3,   /* Mask for the above.  */
-
-    MO_SIGN  =3D 4,   /* Sign-extended, otherwise zero-extended.  */
-
-    MO_BSWAP =3D 8,   /* Host reverse endian.  */
 #ifdef HOST_WORDS_BIGENDIAN
     MO_LE    =3D MO_BSWAP,
     MO_BE    =3D 0,
--
1.8.3.1



