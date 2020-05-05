Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD243C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985D9206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyCP1XUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985D9206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxux-0006PE-Ns
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr3-0000N7-PG
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49865
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr2-0003Vn-QB
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXxalZZXQ2q+1+XiKHCDl61UcTAWRsLeGI8ZX/xQFVI=;
 b=LyCP1XUTtqtQP+P5qz8TCL/w3mYiGaWQKDKfpnjdhgc3h55iAGPfB4IOTNZe46SpEFa89s
 G+KxWX4C60ILI6iF8a+Wj7IzhdVdEE/F1GpsOmdqxGDoMSd8CMsrusv9ASv8C76+kejp4E
 ip788UF4hj+BF1K8wLZHOz7r5DWwVto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-Nwr3RYIWMriveId7IHLwzg-1; Tue, 05 May 2020 09:43:19 -0400
X-MC-Unique: Nwr3RYIWMriveId7IHLwzg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BA3E8014C1;
 Tue,  5 May 2020 13:43:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E20A263F95;
 Tue,  5 May 2020 13:43:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E5F1C1753B; Tue,  5 May 2020 15:43:05 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/13] acpi: move acpi_build_facs to acpi-common.c
Date: Tue,  5 May 2020 15:42:56 +0200
Message-Id: <20200505134305.22666-5-kraxel@redhat.com>
In-Reply-To: <20200505134305.22666-1-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-common.h |  1 +
 hw/i386/acpi-build.c  | 11 +----------
 hw/i386/acpi-common.c |  7 +++++++
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
index 9cac18dddf5b..583c320bbe7d 100644
--- a/hw/i386/acpi-common.h
+++ b/hw/i386/acpi-common.h
@@ -11,5 +11,6 @@
 void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
                      X86MachineState *x86ms, AcpiDeviceIf *adev,
                      bool has_pci);
+void acpi_build_facs(GArray *table_data);
=20
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4cce2192eeb0..a69b85a266e7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -316,15 +316,6 @@ static void acpi_align_size(GArray *blob, unsigned ali=
gn)
     g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
 }
=20
-/* FACS */
-static void
-build_facs(GArray *table_data)
-{
-    AcpiFacsDescriptorRev1 *facs =3D acpi_data_push(table_data, sizeof *fa=
cs);
-    memcpy(&facs->signature, "FACS", 4);
-    facs->length =3D cpu_to_le32(sizeof(*facs));
-}
-
 static void build_append_pcihp_notify_entry(Aml *method, int slot)
 {
     Aml *if_ctx;
@@ -2417,7 +2408,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState=
 *machine)
      * requirements.
      */
     facs =3D tables_blob->len;
-    build_facs(tables_blob);
+    acpi_build_facs(tables_blob);
=20
     /* DSDT is pointed to by FADT */
     dsdt =3D tables_blob->len;
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index ab9b00581a15..5187653893a8 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -154,3 +154,10 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *l=
inker,
                  table_data->len - madt_start, 1, NULL, NULL);
 }
=20
+/* FACS */
+void acpi_build_facs(GArray *table_data)
+{
+    AcpiFacsDescriptorRev1 *facs =3D acpi_data_push(table_data, sizeof *fa=
cs);
+    memcpy(&facs->signature, "FACS", 4);
+    facs->length =3D cpu_to_le32(sizeof(*facs));
+}
--=20
2.18.4


