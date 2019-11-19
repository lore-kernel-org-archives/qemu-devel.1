Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8387C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8642E222EF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=data61.csiro.au header.i=@data61.csiro.au header.b="MxFsyFVy";
	dkim=pass (1024-bit key) header.d=CSIROAU.onmicrosoft.com header.i=@CSIROAU.onmicrosoft.com header.b="C/A6Op5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8642E222EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=data61.csiro.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWyVl-0006JW-LT
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 03:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=219428521=Siwei.Zhuang@data61.csiro.au>)
 id 1iWwtV-0005qi-RC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 01:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=219428521=Siwei.Zhuang@data61.csiro.au>)
 id 1iWwtU-0001Ar-EV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 01:21:45 -0500
Received: from vic-mtaout3.csiro.au ([2405:b000:b00:220::64:39]:44599)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71)
 (envelope-from <prvs=219428521=Siwei.Zhuang@data61.csiro.au>)
 id 1iWwtO-0000rA-SW; Tue, 19 Nov 2019 01:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=data61.csiro.au; i=@data61.csiro.au; q=dns/txt;
 s=dkim; t=1574144498; x=1605680498;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=MxYQRbNZuwvYwHfl6iXKquPnrHd59lTzDvBfrltaAqw=;
 b=MxFsyFVyyWo1StBIvesMw8ohCjJTQ81ArcpvAqJjvLP8w/+J6eY5QrHL
 bHvxCkBhl+Cg9a5ZC1wdJ/ql4uGyqEd2DdxNgXQMHq/T5YrIHkskI/36D
 NB8kX3pbwLeF9neJpWo3C2Q712ZxFYr1PQ7RCMmMFwEIJFpx5lephvYII U=;
IronPort-SDR: 60AlCoJV2V9C3Fv0y4zChKpp1L73jzpY074bB7qY644COmu38x0tRQF4hyzIxCIPCoJGinrspR
 JgHx9IwqD6DA==
X-SBRS: 5.1
IronPort-PHdr: =?us-ascii?q?9a23=3Ad0ovARPAcX6X3znjxeIl6mtXPHoupqn0MwgJ65?=
 =?us-ascii?q?Eul7NJdOG58o//OFDEuqw/l0fHCIPc7f8My/HbtaztQyQh2d6AqzhDFf4ETB?=
 =?us-ascii?q?oZkYMTlg0kDtSCDBjALeHnbmoIHNlLUlBN83inOBYMXs3lZkfV5HSvvnYf?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+HHBAB5iNNdlwCwBSSwhIATAJKcgDN?=
 =?us-ascii?q?lHAEBAQEBBwEBEQEEBAEBgX6BS1BeE3gENQqHZgOKdE6DD5MGhT2BEAMYPAk?=
 =?us-ascii?q?BAQENASMKAgEBAoQ+giYkOBMCAwsBAQUBAQEBAQUEAgIQAQEBAQEeBoVnAQu?=
 =?us-ascii?q?DRzkyAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINVCt?=
 =?us-ascii?q?AFhUZAQE3AREBgQAnBA4FIoMAAYJGAy0BAQICCqU2AoE4iF8BAYFzM4J+AQE?=
 =?us-ascii?q?FgTQBg1IYghcDBgkBgSyHPIRZgheBETOCKgdshC6GBY9ahwSXTwcBAoIqhxq?=
 =?us-ascii?q?OKQwbmhABLY4biDiRUAIEAgQFAg4BAQWBaSGBWh1Pg0ASPhEUkRoMDgmDUIR?=
 =?us-ascii?q?ZhXp0AYEnjB8BgQ4BAQ?=
X-IPAS-Result: =?us-ascii?q?A+HHBAB5iNNdlwCwBSSwhIATAJKcgDNlHAEBAQEBBwEBE?=
 =?us-ascii?q?QEEBAEBgX6BS1BeE3gENQqHZgOKdE6DD5MGhT2BEAMYPAkBAQENASMKAgEBA?=
 =?us-ascii?q?oQ+giYkOBMCAwsBAQUBAQEBAQUEAgIQAQEBAQEeBoVnAQuDRzkyAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINVCtAFhUZAQE3AREBg?=
 =?us-ascii?q?QAnBA4FIoMAAYJGAy0BAQICCqU2AoE4iF8BAYFzM4J+AQEFgTQBg1IYghcDB?=
 =?us-ascii?q?gkBgSyHPIRZgheBETOCKgdshC6GBY9ahwSXTwcBAoIqhxqOKQwbmhABLY4bi?=
 =?us-ascii?q?DiRUAIEAgQFAg4BAQWBaSGBWh1Pg0ASPhEUkRoMDgmDUIRZhXp0AYEnjB8Bg?=
 =?us-ascii?q?Q4BAQ?=
Received: from exch3-cdc.nexus.csiro.au ([IPv6:2405:b000:601:13::247:33])
 by vic-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384;
 19 Nov 2019 17:21:18 +1100
Received: from exch2-cdc.nexus.csiro.au (2405:b000:601:13::247:32) by
 exch3-cdc.nexus.csiro.au (2405:b000:601:13::247:33) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Tue, 19 Nov 2019 17:21:17 +1100
Received: from ExEdge1.csiro.au (150.229.7.34) by exch2-cdc.nexus.csiro.au
 (152.83.247.32) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Nov 2019 17:21:17 +1100
Received: from AUS01-SY3-obe.outbound.protection.outlook.com (104.47.117.57)
 by ExEdge1.csiro.au (150.229.7.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 19 Nov 2019 17:21:10 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS79rqVt3MK7ZSMiJwPCamS9A/s2bp4oOM1iZ28PItdMMoX4fKVIWeRtQxYMhjbXaHf30++fz4uW0w/jfDP3BzoTwb3uqfjalnh8XeR21pHWO8Y+xMuKmvJJR6B5ASoi76vTTFHU30TSBlavlp9vz/QKPZfAf4rjIJ0SIlD4U+NARqV7SE8TgS2A7NW8Zyh3HTqtaW4u9SfyXjpmks+PWcBht8yQqSu1qouKdyKB8Bs5EPW4zYprkE9AgAO6C7KW8KKxtFHurvk9CnxDHzZkt6LJmtFvJyw4+9z/WjbYBkCAxPu04Tf6wYOYEN40cS2ilPFKXhPRj4gpJJgcxWbpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MoVhPZtMcl5zYFxme57DkWyci5IBadu8vXEVQv9ol8=;
 b=amni+n2mrsrdIwkvKwy7zupXT/SnWOiYoy0smJNIfOk2nq/0n3rhUoAEf2ctmgk7Tk1EDcQhFYXo9S1NQuqcEJF86O/jBdNvxf9f5k7GH3iC1LwhW18d/4usonBHp/I8T2DX6h/dCKHtGJri3qdVpyG4IHeocMETEjZPcsJm7Lm0iDLPveio3yLSnncxp+WKDWuCt1obdUhCmAou544v9iFP/2qhDCtKzh5c0hEyfLYJcBLSgT0/cRj6N3+60o94oxIn2Lw+215sB6UhA3cKhDvmeRLHos6nZScp2VbEuo1JzBnZk6CeIVaU4UUZe7TqRH1qKMJJPmw8ajosV1hKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=data61.csiro.au; dmarc=pass action=none
 header.from=data61.csiro.au; dkim=pass header.d=data61.csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MoVhPZtMcl5zYFxme57DkWyci5IBadu8vXEVQv9ol8=;
 b=C/A6Op5qRK5X/TqgFxHmwc7vZBLX5dxMj9Vela8JyT/bksU7yX9EIXtM2vQiGZupfZ18q2DfcYuA4W3LEHGeL/D/xRZb6xgJjLBHKRb63Bdt9cAEqdR5cnJwZi5VPgF8vulVZGRkz3cN3jQS3BhrD9iVvQn3XS7unOhJl7j8L68=
Received: from ME2PR01MB3633.ausprd01.prod.outlook.com (52.134.223.18) by
 ME2PR01MB5267.ausprd01.prod.outlook.com (10.255.144.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.24; Tue, 19 Nov 2019 06:21:10 +0000
Received: from ME2PR01MB3633.ausprd01.prod.outlook.com
 ([fe80::756a:b2ea:24e6:1507]) by ME2PR01MB3633.ausprd01.prod.outlook.com
 ([fe80::756a:b2ea:24e6:1507%4]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 06:21:09 +0000
From: "Zhuang, Siwei (Data61, Kensington NSW)" <Siwei.Zhuang@data61.csiro.au>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Subject: [PATCH] hw/riscv: Add optional symbol callback ptr to
 riscv_load_kernel()
Thread-Topic: [PATCH] hw/riscv: Add optional symbol callback ptr to
 riscv_load_kernel()
Thread-Index: AQHVnqGI1rpbrtOSXkKByiWtAB7Cwg==
Date: Tue, 19 Nov 2019 06:21:09 +0000
Message-ID: <20191119062005.5787-1-siwei.zhuang@data61.csiro.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.24.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Siwei.Zhuang@data61.csiro.au; 
x-originating-ip: [221.199.209.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35557f26-a20d-424d-eb53-08d76cb8ab49
x-ms-traffictypediagnostic: ME2PR01MB5267:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <ME2PR01MB52675562EF26368D02F22E7ADD4C0@ME2PR01MB5267.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:392;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(189003)(199004)(66556008)(86362001)(14454004)(478600001)(81156014)(6306002)(186003)(5660300002)(305945005)(54906003)(8676002)(6506007)(316002)(81166006)(486006)(966005)(4326008)(26005)(2616005)(102836004)(50226002)(1076003)(2501003)(8936002)(476003)(66066001)(76116006)(91956017)(6512007)(99286004)(66946007)(66476007)(6486002)(5640700003)(6916009)(2351001)(71200400001)(71190400001)(66446008)(64756008)(14444005)(25786009)(6436002)(7736002)(256004)(2906002)(3846002)(6116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:ME2PR01MB5267;
 H:ME2PR01MB3633.ausprd01.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tWvhlff6uG5fQFkhN3F3LlJrKtTX1G4pRGPDm0T5yNPn8lDTyeRHUnoqQ4a2ljeP1Lku50cSM/W8eEgG5ibGnF0JIpCsX9OejHHc7s+xImKGdyhMEwQ2uUCkGqttO5LVFprJdluM9ywjDMhLOGl9n2qyd5jZIeUSaJyccGHR5nlcrly+fYtf8cEWsndABuy8eeBKD1qqoR2IZaQE2lqA4XNWQfrsSWit+Nt4akQ4DPYY6nArk3M4OmnAWnvPj+67N7OkgwLMV0qvD32GSjarJSeFO02Dhfe2uSzcqyEs2c9+WduI/UROM+L7hQwcNhTvZEgYnz1fRA68BNfcAs9u5rAkJoHssorYIUm8SrwE6+n+TWIxE4k7zoDTatQWwe1Tg6KpsPtIsS7+FrNKS84yV2FV8EOX41d8LR9P06ZEMwIl/48UiXQH9DGlSsGiz+KU
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 35557f26-a20d-424d-eb53-08d76cb8ab49
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 06:21:09.9185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nr9f+wuzjgkMLWtV7mcIYAn1MxoQqaQt4fiRVY81FVixM02xJI6ozaFpOWCSXbU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME2PR01MB5267
X-OriginatorOrg: data61.csiro.au
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2405:b000:b00:220::64:39
X-Mailman-Approved-At: Tue, 19 Nov 2019 03:03:06 -0500
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "open list:All patches
 CC here" <qemu-devel@nongnu.org>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Zhuang, Siwei \(Data61, Kensington NSW\)" <Siwei.Zhuang@data61.csiro.au>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds an optional function pointer, "sym_cb", to
riscv_load_kernel() which provides the possibility to access the symbol
table during kernel loading.

The pointer is ignored, if supplied with Image or uImage file.

The Spike board requires the access to locate the HTIF symbols.

Fixes: 0ac24d56c5e7 ("hw/riscv: Split out the boot functions")
Buglink: https://bugs.launchpad.net/qemu/+bug/1835827
Signed-off-by: Siwei Zhuang <siwei.zhuang@data61.csiro.au>
---
 hw/riscv/boot.c         | 7 ++++---
 hw/riscv/sifive_e.c     | 2 +-
 hw/riscv/sifive_u.c     | 3 ++-
 hw/riscv/spike.c        | 6 +++---
 hw/riscv/virt.c         | 3 ++-
 include/hw/riscv/boot.h | 3 ++-
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 7fee98d2f8..027303d2a3 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -114,12 +114,13 @@ target_ulong riscv_load_firmware(const char *firmware=
_filename,
     exit(1);
 }
=20
-target_ulong riscv_load_kernel(const char *kernel_filename)
+target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sy=
m_cb)
 {
     uint64_t kernel_entry, kernel_high;
=20
-    if (load_elf(kernel_filename, NULL, NULL, NULL,
-                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) > 0=
) {
+    if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
+                         &kernel_entry, NULL, &kernel_high, 0,
+                         EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
         return kernel_entry;
     }
=20
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0f9d641a0e..8a6b0348df 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -111,7 +111,7 @@ static void riscv_sifive_e_init(MachineState *machine)
                           memmap[SIFIVE_E_MROM].base, &address_space_memor=
y);
=20
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename, NULL);
     }
 }
=20
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9552abf4dd..0140e95732 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -344,7 +344,8 @@ static void riscv_sifive_u_init(MachineState *machine)
                                  memmap[SIFIVE_U_DRAM].base);
=20
     if (machine->kernel_filename) {
-        uint64_t kernel_entry =3D riscv_load_kernel(machine->kernel_filena=
me);
+        uint64_t kernel_entry =3D riscv_load_kernel(machine->kernel_filena=
me,
+                                                  NULL);
=20
         if (machine->initrd_filename) {
             hwaddr start;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 8bbffbcd0f..8823681783 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -184,7 +184,7 @@ static void spike_board_init(MachineState *machine)
                                 mask_rom);
=20
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
     }
=20
     /* reset vector */
@@ -273,7 +273,7 @@ static void spike_v1_10_0_board_init(MachineState *mach=
ine)
                                 mask_rom);
=20
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
     }
=20
     /* reset vector */
@@ -359,7 +359,7 @@ static void spike_v1_09_1_board_init(MachineState *mach=
ine)
                                 mask_rom);
=20
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
     }
=20
     /* reset vector */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 23f340df19..65557c837e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -476,7 +476,8 @@ static void riscv_virt_board_init(MachineState *machine=
)
                                  memmap[VIRT_DRAM].base);
=20
     if (machine->kernel_filename) {
-        uint64_t kernel_entry =3D riscv_load_kernel(machine->kernel_filena=
me);
+        uint64_t kernel_entry =3D riscv_load_kernel(machine->kernel_filena=
me,
+                                                  NULL);
=20
         if (machine->initrd_filename) {
             hwaddr start;
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 66075d0e57..df80051fbc 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -28,7 +28,8 @@ void riscv_find_and_load_firmware(MachineState *machine,
 char *riscv_find_firmware(const char *firmware_filename);
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr);
-target_ulong riscv_load_kernel(const char *kernel_filename);
+target_ulong riscv_load_kernel(const char *kernel_filename,
+                               symbol_fn_t sym_cb);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
=20
--=20
2.24.0

