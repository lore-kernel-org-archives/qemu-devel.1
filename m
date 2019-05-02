Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D376C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E713B20675
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E713B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52853 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDOg-0006SG-58
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:13:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4F-00058b-E3
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMD4E-0002od-E3
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMD4E-0002oJ-8Y
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:52:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 746D7883B8;
	Thu,  2 May 2019 14:52:09 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
	(dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0304971C80;
	Thu,  2 May 2019 14:52:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 16:51:53 +0200
Message-Id: <1556808723-226478-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 02 May 2019 14:52:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 05/15] tests: acpi: fetch X_DSDT if pointer
 to DSDT is 0
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, linuxarm@huawei.com,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>, xuwei5@huawei.com,
	xuwei5@hisilicon.com,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502145153.4TyGZGJRUwFYS_semFEGiDlKKJ0LR-SlLN6kL8dK6co@z>

that way it would be possible to test a DSDT pointed by
64bit X_DSDT field in FADT.

PS:
it will allow to enable testing arm/virt board, which sets
only newer X_DSDT field.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v4:
 * dropping Reviewed-bys due to acpi_fetch_table() change
   introduced by earlier patch:
   "tests: acpi: make acpi_fetch_table() take size of fetched table point=
er"
v2:
  add 'val =3D le32_to_cpu(val)' even if it doesn't necessary
  it works as reminder that value copied from table is in
  little-endian format (Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>)
---
 tests/bios-tables-test.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index a164d27..d165a1b 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -140,6 +140,9 @@ static void test_acpi_fadt_table(test_data *data)
     AcpiSdtTable table =3D g_array_index(data->tables, typeof(table), 0)=
;
     uint8_t *fadt_aml =3D table.aml;
     uint32_t fadt_len =3D table.aml_len;
+    uint32_t val;
+    int dsdt_offset =3D 40 /* DSDT */;
+    int dsdt_entry_size =3D 4;
=20
     g_assert(compare_signature(&table, "FACP"));
=20
@@ -148,8 +151,14 @@ static void test_acpi_fadt_table(test_data *data)
                      fadt_aml + 36 /* FIRMWARE_CTRL */, 4, "FACS", false=
);
     g_array_append_val(data->tables, table);
=20
+    memcpy(&val, fadt_aml + dsdt_offset, 4);
+    val =3D le32_to_cpu(val);
+    if (!val) {
+        dsdt_offset =3D 140 /* X_DSDT */;
+        dsdt_entry_size =3D 8;
+    }
     acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
-                     fadt_aml + 40 /* DSDT */, 4, "DSDT", true);
+                     fadt_aml + dsdt_offset, dsdt_entry_size, "DSDT", tr=
ue);
     g_array_append_val(data->tables, table);
=20
     memset(fadt_aml + 36, 0, 4); /* sanitize FIRMWARE_CTRL ptr */
--=20
2.7.4


