Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DA3C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 507AC206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLmeD/hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507AC206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcNO-0002UD-8m
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc7M-0007cH-Q2
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52501
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc7L-0007BT-42
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K14BES+WMFIbn9g8gN8psPne12nk195ussOGSNV/KSs=;
 b=BLmeD/hhazn0h1daFvgH7NrBVdTpq/6zYgxpYFPgY2n+wT9KDVVzXMfkU0CRg5eM3E+1D7
 8FP3EaCA3iFfkXWKjw/AdA6vAEcDiID42FxEeGJ5JUTydzkFTQUEIhdfFbSjSpUA3bxE56
 m/pcEmfDfqHH1m+uAI7+WM6ma3qR1Ho=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-6rNV01IwNXmtjoii3MQVgQ-1; Mon, 04 May 2020 10:30:14 -0400
X-MC-Unique: 6rNV01IwNXmtjoii3MQVgQ-1
Received: by mail-wr1-f69.google.com with SMTP id 30so365194wrp.22
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SvK/mML0hz5y1ob99KnJXcmnCwrQAmI3Al2Kedz9fuQ=;
 b=RcLBIEabmJ1qDjSGmMSqFFeTRAk/an2Sjz/h5jvPM9bL8q1qsdvARV7XF/yRRjJLON
 AwdqJ2Rktl5JJdxolp93Fx9Sbl69YMhveuljNRdNm4ETrxHnn4w+zJc3XcvhqZNaTeoA
 9kWFdAxLfh3V0TcU749Vu54g4vzhOKgBMMVgiHMIGQHMfEhQBqxn8L/wMzWi0VRg47aU
 ggKTeklZo9kH/5daLFBcVoqPJBoWdx7tHMPkYp/BQhpSxa6OQgkMxcXlCh6NXxpisFoM
 hNVbHbz2TW0E7EoSStnCEYgJnOHTX8Svwp4005nds78zoEFe8JEfJTDZwZuafEk9FLTl
 pxgw==
X-Gm-Message-State: AGi0PuaX+gIJT2wmR65hB3N5JEx+QkQ/6/uwxYiWQOzUyRYHqV6fHDHR
 V8PtCI9LDKKTm+qePZWTe+95m+w6QgDuxXKKbOxbwYKLHmH2ZGtutfR6pETeUsp95JaXGhrUmTF
 tUzW8C9+OrdI9NKE=
X-Received: by 2002:a1c:1b0b:: with SMTP id b11mr15741597wmb.182.1588602613290; 
 Mon, 04 May 2020 07:30:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypL5/gC6OcLO6h+1lQ7Gh9SSFJ70lKElmnKKcHPTPeKmjofiV0X6uJ/caoKIyA2OF6b8tFrvRg==
X-Received: by 2002:a1c:1b0b:: with SMTP id b11mr15741564wmb.182.1588602613044; 
 Mon, 04 May 2020 07:30:13 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 x16sm12527456wrn.76.2020.05.04.07.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:30:12 -0700 (PDT)
Date: Mon, 4 May 2020 10:30:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/29] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200504142814.157589-25-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Liran Alon <liran.alon@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, Elad Gabay <elad.gabay@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

Microsoft introduced this ACPI table to avoid Windows guests performing
various workarounds for device erratas. As the virtual device emulated
by VMM may not have the errata.

Currently, WAET allows hypervisor to inform guest about two
specific behaviors: One for RTC and the other for ACPI PM timer.

Support for WAET have been introduced since Windows Vista. This ACPI
table is also exposed by other common hypervisors by default, including:
VMware, GCP and AWS.

This patch adds WAET ACPI Table to QEMU.

We set "ACPI PM timer good" bit in "Emualted Device Flags" field to
indicate that the ACPI PM timer has been enhanced to not require
multiple reads to obtain a reliable value.
This results in improving the performance of Windows guests that use
ACPI PM timer by avoiding unnecessary VMExits caused by these multiple
reads.

Co-developed-by: Elad Gabay <elad.gabay@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Message-Id: <20200313145009.144820-3-liran.alon@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7d880bec4a..2e15f6848e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2512,6 +2512,34 @@ build_dmar_q35(GArray *table_data, BIOSLinker *linke=
r)
     build_header(linker, table_data, (void *)(table_data->data + dmar_star=
t),
                  "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
 }
+
+/*
+ * Windows ACPI Emulated Devices Table
+ * (Version 1.0 - April 6, 2009)
+ * Spec: http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A=
97E-CE7CE0D98DC2/WAET.docx
+ *
+ * Helpful to speedup Windows guests and ignored by others.
+ */
+static void
+build_waet(GArray *table_data, BIOSLinker *linker)
+{
+    int waet_start =3D table_data->len;
+
+    /* WAET header */
+    acpi_data_push(table_data, sizeof(AcpiTableHeader));
+    /*
+     * Set "ACPI PM timer good" flag.
+     *
+     * Tells Windows guests that our ACPI PM timer is reliable in the
+     * sense that guest can read it only once to obtain a reliable value.
+     * Which avoids costly VMExits caused by guest re-reading it unnecessa=
rily.
+     */
+    build_append_int_noprefix(table_data, 1 << 1 /* ACPI PM timer good */,=
 4);
+
+    build_header(linker, table_data, (void *)(table_data->data + waet_star=
t),
+                 "WAET", table_data->len - waet_start, 1, NULL, NULL);
+}
+
 /*
  *   IVRS table as specified in AMD IOMMU Specification v2.62, Section 5.2
  *   accessible here http://support.amd.com/TechDocs/48882_IOMMU.pdf
@@ -2859,6 +2887,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState=
 *machine)
                           machine->nvdimms_state, machine->ram_slots);
     }
=20
+    acpi_add_table(table_offsets, tables_blob);
+    build_waet(tables_blob, tables->linker);
+
     /* Add tables supplied by user (if any) */
     for (u =3D acpi_table_first(); u; u =3D acpi_table_next(u)) {
         unsigned len =3D acpi_table_len(u);
--=20
MST


