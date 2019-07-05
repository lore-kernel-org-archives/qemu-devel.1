Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05EBC4649C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B04F216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B04F216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjPti-0004p9-Nl
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57778)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjPps-0001p4-Qr
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjPpp-0000mJ-Qy
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:09:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hjPpi-0008Gl-Gi; Fri, 05 Jul 2019 11:09:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8117A81F18;
 Fri,  5 Jul 2019 15:09:00 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 034C880DB9;
 Fri,  5 Jul 2019 15:08:57 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:08:49 +0200
Message-Id: <20190705150850.4967-2-philmd@redhat.com>
In-Reply-To: <20190705150850.4967-1-philmd@redhat.com>
References: <20190705150850.4967-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 05 Jul 2019 15:09:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/2] hw/ssi/xilinx_spips: Convert
 lqspi_read() to read_with_attrs
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the next commit we will implement the write_with_attrs()
handler. To avoid using different APIs, convert the read()
handler first.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ssi/xilinx_spips.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 8115bb6d46..e80619aece 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1202,27 +1202,27 @@ static void lqspi_load_cache(void *opaque, hwaddr=
 addr)
     }
 }
=20
-static uint64_t
-lqspi_read(void *opaque, hwaddr addr, unsigned int size)
+static MemTxResult lqspi_read(void *opaque, hwaddr addr, uint64_t *value=
,
+                              unsigned size, MemTxAttrs attrs)
 {
-    XilinxQSPIPS *q =3D opaque;
-    uint32_t ret;
+    XilinxQSPIPS *q =3D XILINX_QSPIPS(opaque);
=20
     if (addr >=3D q->lqspi_cached_addr &&
             addr <=3D q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
         uint8_t *retp =3D &q->lqspi_buf[addr - q->lqspi_cached_addr];
-        ret =3D cpu_to_le32(*(uint32_t *)retp);
-        DB_PRINT_L(1, "addr: %08x, data: %08x\n", (unsigned)addr,
-                   (unsigned)ret);
-        return ret;
+        *value =3D cpu_to_le32(*(uint32_t *)retp);
+        DB_PRINT_L(1, "addr: %08" HWADDR_PRIx ", data: %08" PRIx64 "\n",
+                   addr, *value);
     } else {
         lqspi_load_cache(opaque, addr);
-        return lqspi_read(opaque, addr, size);
+        lqspi_read(opaque, addr, value, size, attrs);
     }
+
+    return MEMTX_OK;
 }
=20
 static const MemoryRegionOps lqspi_ops =3D {
-    .read =3D lqspi_read,
+    .read_with_attrs =3D lqspi_read,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
     .valid =3D {
         .min_access_size =3D 1,
--=20
2.20.1


