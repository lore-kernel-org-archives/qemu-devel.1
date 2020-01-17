Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF6C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:48:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 748FA24679
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 17:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748FA24679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isVje-0003tO-Vt
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 12:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1isVi3-0002Gn-RQ
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1isVi2-0007i0-Bg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 12:47:03 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:58596 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1isVhw-0007YV-UC; Fri, 17 Jan 2020 12:46:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 927695ACAEEA5F968A62;
 Sat, 18 Jan 2020 01:46:51 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 18 Jan 2020 01:46:44 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH v2 2/7] hw/acpi/nvdimm: Fix for NVDIMM incorrect DSM output
 buffer length
Date: Fri, 17 Jan 2020 17:45:17 +0000
Message-ID: <20200117174522.22044-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
References: <20200117174522.22044-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 linuxarm@huawei.com, xuwei5@hisilicon.com, shannon.zhaosl@gmail.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As per ACPI spec 6.3, Table 19-419 Object Conversion Rules, if
the Buffer Field <= to the size of an Integer (in bits), it will
be treated as an integer. Moreover, the integer size depends on
DSDT tables revision number. If revision number is < 2, integer
size is 32 bits, otherwise it is 64 bits. Current NVDIMM common
DSM aml code (NCAL) uses CreateField() for creating DSM output
buffer. This creates an issue in arm/virt platform where DSDT
revision number is 2 and results in DSM buffer with a wrong
size(8 bytes) gets returned when actual length is < 8 bytes.
This causes guest kernel to report,

"nfit ACPI0012:00: found a zero length table '0' parsing nfit"

In order to fix this, aml code is now modified such that it builds
the DSM output buffer in a byte by byte fashion when length is
smaller than Integer size.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
Please find the previous discussion on this here,
https://patchwork.kernel.org/cover/11174959/

---
 hw/acpi/nvdimm.c                            | 36 +++++++++++++++++++--
 tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9fdad6dc3f..5e7b8318d0 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -964,6 +964,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
     Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem, *elsectx2;
     Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_invalid;
     Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf, *dsm_out_buf_size;
+    Aml *whilectx, *offset;
     uint8_t byte_list[1];
 
     method = aml_method(NVDIMM_COMMON_DSM, 5, AML_SERIALIZED);
@@ -1117,13 +1118,42 @@ static void nvdimm_build_common_dsm(Aml *dev)
     /* RLEN is not included in the payload returned to guest. */
     aml_append(method, aml_subtract(aml_name(NVDIMM_DSM_OUT_BUF_SIZE),
                aml_int(4), dsm_out_buf_size));
+
+    /*
+     * As per ACPI spec 6.3, Table 19-419 Object Conversion Rules, if
+     * the Buffer Field <= to the size of an Integer (in bits), it will
+     * be treated as an integer. Moreover, the integer size depends on
+     * DSDT tables revision number. If revision number is < 2, integer
+     * size is 32 bits, otherwise it is 64 bits.
+     * Because of this CreateField() canot be used if RLEN < Integer Size.
+     * Hence build dsm_out_buf byte by byte.
+     */
+    ifctx = aml_if(aml_lless(dsm_out_buf_size, aml_sizeof(aml_int(0))));
+    offset = aml_local(2);
+    aml_append(ifctx, aml_store(aml_int(0), offset));
+    aml_append(ifctx, aml_name_decl("TBUF", aml_buffer(1, NULL)));
+    aml_append(ifctx, aml_store(aml_buffer(0, NULL), dsm_out_buf));
+
+    whilectx = aml_while(aml_lless(offset, dsm_out_buf_size));
+    /* Copy 1 byte at offset from ODAT to temporary buffer(TBUF). */
+    aml_append(whilectx, aml_store(aml_derefof(aml_index(
+                                   aml_name(NVDIMM_DSM_OUT_BUF), offset)),
+                                   aml_index(aml_name("TBUF"), aml_int(0))));
+    aml_append(whilectx, aml_concatenate(dsm_out_buf, aml_name("TBUF"),
+                                         dsm_out_buf));
+    aml_append(whilectx, aml_increment(offset));
+    aml_append(ifctx, whilectx);
+
+    aml_append(ifctx, aml_return(dsm_out_buf));
+    aml_append(method, ifctx);
+
+    /* If RLEN >= Integer size, just use CreateField() operator */
     aml_append(method, aml_store(aml_shiftleft(dsm_out_buf_size, aml_int(3)),
                                  dsm_out_buf_size));
     aml_append(method, aml_create_field(aml_name(NVDIMM_DSM_OUT_BUF),
                aml_int(0), dsm_out_buf_size, "OBUF"));
-    aml_append(method, aml_concatenate(aml_buffer(0, NULL), aml_name("OBUF"),
-                                       dsm_out_buf));
-    aml_append(method, aml_return(dsm_out_buf));
+    aml_append(method, aml_return(aml_name("OBUF")));
+
     aml_append(dev, method);
 }
 
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..eb8bae1407 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/SSDT.dimmpxm",
+"tests/data/acpi/q35/SSDT.dimmpxm",
-- 
2.17.1



