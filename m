Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71199C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89F92073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTnAhciM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89F92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokDT-0002H0-JN
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojQ5-00067X-Uj
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojQ4-0008FQ-Fg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:53 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54345
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojQ4-0008DN-AV
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtYURyag3DLg8nTLoi8QUVY5fdiTw/VqNJshcmNYPY8=;
 b=HTnAhciMiEbkk8QOz1gbxOPzj8mybzLCwbYp/uNHeGj9gijwbr7Z+fac5NWvU5QgUAIw6F
 pF5O/2S4rzbwf3MfByl+yy9ZiUSoDl6S5Wy64rUvfvrgB5OgQDX8KZ7mttcQqbp9y1URRu
 AExxobqhc4wFqx4/AuP8DWZx5x6ld/s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-TKGg7BPPMreWkE9uNfwW2g-1; Tue, 07 Jan 2020 02:36:47 -0500
Received: by mail-qt1-f200.google.com with SMTP id g21so8469370qtq.18
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:36:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SruOAG0qaxCXWnEXh2DvWIZr1jCGMkEnWfc8/NLsCZo=;
 b=Bo78tR1X1Jh9hlYJ9qXuQq+myWGmWzzPGLwpJhqZQaLeXTlxc9OFkxTtVflEuiBBDx
 Qpr7569ZPKizz8a9p7Lbq9ADEN8BAO6wIqOmpeTpe9G2rdYacMjFdt5zwBzpPgflgto6
 B0MLgnDqpmip4Ds4l5A8orioW9PDcq4YHnPN/QsPFYiizhTVZZGd0eIxzgGV+Oa0P2c8
 Sjm5T9dnz7LWvqKrv0fyWrnXk/CrVMO86aSeFkFvGYjfQiNP7k91dSXe9AFKcpw5Fi1L
 HnvE+vpTDXptWFSC5zbGRpKJRGrcigVKeCJlrbFWbmPiwsR7SSWnwt87CuqsMvG/0WDF
 5coQ==
X-Gm-Message-State: APjAAAW+nfnASFSLsC9MmpCIU5LRTrsvq4Vy9zBOwYLl1u49j3hSiNEk
 oBb0yw4Q7H8edwReK51YTNYE66ESHlYsFRg4fnEXQHitUiNcbYPxZH2VqC4LQ+0Q5mhcrxysILj
 KOvZX8ooqmWEUKDA=
X-Received: by 2002:a37:496:: with SMTP id 144mr86454037qke.338.1578382606903; 
 Mon, 06 Jan 2020 23:36:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/6q1YXJBxffKyRn0E0xYUUbSR9GFpdGWfp0NOjwr7Il1G1JBt07MOIqkAX5v03kva6Oa1bw==
X-Received: by 2002:a37:496:: with SMTP id 144mr86454023qke.338.1578382606628; 
 Mon, 06 Jan 2020 23:36:46 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id m95sm22011247qte.41.2020.01.06.23.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:36:45 -0800 (PST)
Date: Tue, 7 Jan 2020 02:36:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 18/32] tests/bios-tables-test: add test cases for ACPI HMAT
Message-ID: <20200107073451.298261-19-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: TKGg7BPPMreWkE9uNfwW2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jingqi Liu <Jingqi.liu@intel.com>, Tao Xu <tao3.xu@intel.com>,
 Markus Armbruster <armbru@redhat.com>, Daniel Black <daniel@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

ACPI table HMAT has been introduced, QEMU now builds HMAT tables for
Heterogeneous Memory with boot option '-numa node'.

Add test cases on PC and Q35 machines with 2 numa nodes.
Because HMAT is generated when system enable numa, the
following tables need to be added for this test:
    tests/data/acpi/pc/APIC.acpihmat
    tests/data/acpi/pc/SRAT.acpihmat
    tests/data/acpi/pc/HMAT.acpihmat
    tests/data/acpi/pc/DSDT.acpihmat
    tests/data/acpi/q35/APIC.acpihmat
    tests/data/acpi/q35/SRAT.acpihmat
    tests/data/acpi/q35/HMAT.acpihmat
    tests/data/acpi/q35/DSDT.acpihmat

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Daniel Black <daniel@linux.ibm.com>
Reviewed-by: Jingqi Liu <Jingqi.liu@intel.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20191213011929.2520-9-tao3.xu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test-allowed-diff.h |  8 +++++
 tests/bios-tables-test.c              | 44 +++++++++++++++++++++++++++
 tests/data/acpi/pc/APIC.acpihmat      |  0
 tests/data/acpi/pc/DSDT.acpihmat      |  0
 tests/data/acpi/pc/HMAT.acpihmat      |  0
 tests/data/acpi/pc/SRAT.acpihmat      |  0
 tests/data/acpi/q35/APIC.acpihmat     |  0
 tests/data/acpi/q35/DSDT.acpihmat     |  0
 tests/data/acpi/q35/HMAT.acpihmat     |  0
 tests/data/acpi/q35/SRAT.acpihmat     |  0
 10 files changed, 52 insertions(+)
 create mode 100644 tests/data/acpi/pc/APIC.acpihmat
 create mode 100644 tests/data/acpi/pc/DSDT.acpihmat
 create mode 100644 tests/data/acpi/pc/HMAT.acpihmat
 create mode 100644 tests/data/acpi/pc/SRAT.acpihmat
 create mode 100644 tests/data/acpi/q35/APIC.acpihmat
 create mode 100644 tests/data/acpi/q35/DSDT.acpihmat
 create mode 100644 tests/data/acpi/q35/HMAT.acpihmat
 create mode 100644 tests/data/acpi/q35/SRAT.acpihmat

diff --git a/tests/bios-tables-test-allowed-diff.h b/tests/bios-tables-test=
-allowed-diff.h
index dfb8523c8b..3c9e0c979b 100644
--- a/tests/bios-tables-test-allowed-diff.h
+++ b/tests/bios-tables-test-allowed-diff.h
@@ -1 +1,9 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/APIC.acpihmat",
+"tests/data/acpi/pc/SRAT.acpihmat",
+"tests/data/acpi/pc/HMAT.acpihmat",
+"tests/data/acpi/pc/DSDT.acpihmat",
+"tests/data/acpi/q35/APIC.acpihmat",
+"tests/data/acpi/q35/SRAT.acpihmat",
+"tests/data/acpi/q35/HMAT.acpihmat",
+"tests/data/acpi/q35/DSDT.acpihmat",
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index bc0ad594a1..f1ac2d7e96 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -947,6 +947,48 @@ static void test_acpi_virt_tcg_numamem(void)
=20
 }
=20
+static void test_acpi_tcg_acpi_hmat(const char *machine)
+{
+    test_data data;
+
+    memset(&data, 0, sizeof(data));
+    data.machine =3D machine;
+    data.variant =3D ".acpihmat";
+    test_acpi_one(" -machine hmat=3Don"
+                  " -smp 2,sockets=3D2"
+                  " -m 128M,slots=3D2,maxmem=3D1G"
+                  " -object memory-backend-ram,size=3D64M,id=3Dm0"
+                  " -object memory-backend-ram,size=3D64M,id=3Dm1"
+                  " -numa node,nodeid=3D0,memdev=3Dm0"
+                  " -numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0"
+                  " -numa cpu,node-id=3D0,socket-id=3D0"
+                  " -numa cpu,node-id=3D0,socket-id=3D1"
+                  " -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmem=
ory,"
+                  "data-type=3Daccess-latency,latency=3D1"
+                  " -numa hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmem=
ory,"
+                  "data-type=3Daccess-bandwidth,bandwidth=3D65534M"
+                  " -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmem=
ory,"
+                  "data-type=3Daccess-latency,latency=3D65534"
+                  " -numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmem=
ory,"
+                  "data-type=3Daccess-bandwidth,bandwidth=3D32767M"
+                  " -numa hmat-cache,node-id=3D0,size=3D10K,level=3D1,"
+                  "associativity=3Ddirect,policy=3Dwrite-back,line=3D8"
+                  " -numa hmat-cache,node-id=3D1,size=3D10K,level=3D1,"
+                  "associativity=3Ddirect,policy=3Dwrite-back,line=3D8",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_q35_tcg_acpi_hmat(void)
+{
+    test_acpi_tcg_acpi_hmat(MACHINE_Q35);
+}
+
+static void test_acpi_piix4_tcg_acpi_hmat(void)
+{
+    test_acpi_tcg_acpi_hmat(MACHINE_PC);
+}
+
 static void test_acpi_virt_tcg(void)
 {
     test_data data =3D {
@@ -991,6 +1033,8 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/q35/numamem", test_acpi_q35_tcg_numamem);
         qtest_add_func("acpi/piix4/dimmpxm", test_acpi_piix4_tcg_dimm_pxm)=
;
         qtest_add_func("acpi/q35/dimmpxm", test_acpi_q35_tcg_dimm_pxm);
+        qtest_add_func("acpi/piix4/acpihmat", test_acpi_piix4_tcg_acpi_hma=
t);
+        qtest_add_func("acpi/q35/acpihmat", test_acpi_q35_tcg_acpi_hmat);
     } else if (strcmp(arch, "aarch64") =3D=3D 0) {
         qtest_add_func("acpi/virt", test_acpi_virt_tcg);
         qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
diff --git a/tests/data/acpi/pc/APIC.acpihmat b/tests/data/acpi/pc/APIC.acp=
ihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acp=
ihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/pc/HMAT.acpihmat b/tests/data/acpi/pc/HMAT.acp=
ihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/pc/SRAT.acpihmat b/tests/data/acpi/pc/SRAT.acp=
ihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/APIC.acpihmat b/tests/data/acpi/q35/APIC.a=
cpihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.a=
cpihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/HMAT.acpihmat b/tests/data/acpi/q35/HMAT.a=
cpihmat
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/data/acpi/q35/SRAT.acpihmat b/tests/data/acpi/q35/SRAT.a=
cpihmat
new file mode 100644
index 0000000000..e69de29bb2
--=20
MST


