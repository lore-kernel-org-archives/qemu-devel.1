Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF02C33CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 06:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2455214D8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 06:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2455214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqt6f-0007xS-OS
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 01:21:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1iqt5q-0007XJ-HF
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 01:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1iqt5p-0005bE-3z
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 01:20:54 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2676 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1iqt5o-0005VS-PT
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 01:20:53 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 7F032E3B261F83C05358;
 Mon, 13 Jan 2020 14:20:44 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Mon, 13 Jan 2020 14:20:34 +0800
From: <pannengyuan@huawei.com>
To: <pbonzini@redhat.com>, <fam@euphon.net>
Subject: [PATCH] scsi-disk: define props in scsi_block_disk to avoid memleaks
Date: Mon, 13 Jan 2020 14:20:30 +0800
Message-ID: <20200113062030.56020-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Euler Robot <euler.robot@huawei.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

scsi_block_realize() use scsi_realize() to init some props, but
these props is not defined in scsi_block_disk_properties, so they will
not be freed.

This patch defines these prop in scsi_block_disk_properties and aslo
calls scsi_unrealize to avoid memleaks, the leak stack as
follow(it's easy to reproduce by attaching/detaching scsi-block-disks):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3Dqemu-system-x86_64=3D=3D32195=3D=3DERROR: LeakSanitizer: detected m=
emory leaks

Direct leak of 57 byte(s) in 3 object(s) allocated from:
  #0 0x7f19f8bed768 (/lib64/libasan.so.5+0xef768)  ??:?
  #1 0x7f19f64d9445 (/lib64/libglib-2.0.so.0+0x52445)  ??:?
  #2 0x7f19f64f2d92 (/lib64/libglib-2.0.so.0+0x6bd92)  ??:?
  #3 0x55975366e596 (qemu-system-x86_64+0x35c0596)  /mnt/sdb/qemu/hw/scsi=
/scsi-disk.c:2399
  #4 0x559753671201 (emu-system-x86_64+0x35c3201)  /mnt/sdb/qemu/hw/scsi/=
scsi-disk.c:2681
  #5 0x559753687e3e (qemu-system-x86_64+0x35d9e3e)  /mnt/sdb/qemu/hw/scsi=
/scsi-bus.c:58
  #6 0x55975368ac44 (qemu-system-x86_64+0x35dcc44)  /mnt/sdb/qemu/hw/scsi=
/scsi-bus.c:216
  #7 0x5597532a7840 (qemu-system-x86_64+0x31f9840)  /mnt/sdb/qemu/hw/core=
/qdev.c:876

Direct leak of 15 byte(s) in 3 object(s) allocated from:
  #0 0x7f19f8bed768 (/lib64/libasan.so.5+0xef768)  ??:?
  #1 0x7f19f64d9445 (/lib64/libglib-2.0.so.0+0x52445)  ??:?
  #2 0x7f19f64f2d92 (/lib64/libglib-2.0.so.0+0x6bd92)  ??:?
  #3 0x55975366e06f (qemu-system-x86_64+0x35c006f)  /mnt/sdb/qemu/hw/scsi=
/scsi-disk.c:2388
  #4 0x559753671201 (qemu-system-x86_64+0x35c3201)  /mnt/sdb/qemu/hw/scsi=
/scsi-disk.c:2681
  #5 0x559753687e3e (qemu-system-x86_64+0x35d9e3e)  /mnt/sdb/qemu/hw/scsi=
/scsi-bus.c:58
  #6 0x55975368ac44 (qemu-system-x86_64+0x35dcc44)  /mnt/sdb/qemu/hw/scsi=
/scsi-bus.c:216

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 hw/scsi/scsi-disk.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e44c61eeb4..caec99ae20 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2981,7 +2981,6 @@ static const TypeInfo scsi_disk_base_info =3D {
 };
=20
 #define DEFINE_SCSI_DISK_PROPERTIES()                                   =
\
-    DEFINE_PROP_DRIVE_IOTHREAD("drive", SCSIDiskState, qdev.conf.blk),  =
\
     DEFINE_BLOCK_PROPERTIES_BASE(SCSIDiskState, qdev.conf),             =
\
     DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),            =
\
     DEFINE_PROP_STRING("ver", SCSIDiskState, version),                  =
\
@@ -2993,6 +2992,7 @@ static const TypeInfo scsi_disk_base_info =3D {
=20
 static Property scsi_hd_properties[] =3D {
     DEFINE_SCSI_DISK_PROPERTIES(),
+    DEFINE_PROP_DRIVE_IOTHREAD("drive", SCSIDiskState, qdev.conf.blk),
     DEFINE_PROP_BIT("removable", SCSIDiskState, features,
                     SCSI_DISK_F_REMOVABLE, false),
     DEFINE_PROP_BIT("dpofua", SCSIDiskState, features,
@@ -3048,6 +3048,7 @@ static const TypeInfo scsi_hd_info =3D {
=20
 static Property scsi_cd_properties[] =3D {
     DEFINE_SCSI_DISK_PROPERTIES(),
+    DEFINE_PROP_DRIVE_IOTHREAD("drive", SCSIDiskState, qdev.conf.blk),
     DEFINE_PROP_UINT64("wwn", SCSIDiskState, qdev.wwn, 0),
     DEFINE_PROP_UINT64("port_wwn", SCSIDiskState, qdev.port_wwn, 0),
     DEFINE_PROP_UINT16("port_index", SCSIDiskState, port_index, 0),
@@ -3079,9 +3080,8 @@ static const TypeInfo scsi_cd_info =3D {
=20
 #ifdef __linux__
 static Property scsi_block_properties[] =3D {
-    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
+    DEFINE_SCSI_DISK_PROPERTIES(),
     DEFINE_PROP_DRIVE("drive", SCSIDiskState, qdev.conf.blk),
-    DEFINE_PROP_BOOL("share-rw", SCSIDiskState, qdev.conf.share_rw, fals=
e),
     DEFINE_PROP_UINT16("rotation_rate", SCSIDiskState, rotation_rate, 0)=
,
     DEFINE_PROP_UINT64("max_unmap_size", SCSIDiskState, max_unmap_size,
                        DEFAULT_MAX_UNMAP_SIZE),
@@ -3099,6 +3099,7 @@ static void scsi_block_class_initfn(ObjectClass *kl=
ass, void *data)
     SCSIDiskClass *sdc =3D SCSI_DISK_BASE_CLASS(klass);
=20
     sc->realize      =3D scsi_block_realize;
+    sc->unrealize    =3D scsi_unrealize;
     sc->alloc_req    =3D scsi_block_new_request;
     sc->parse_cdb    =3D scsi_block_parse_cdb;
     sdc->dma_readv   =3D scsi_block_dma_readv;
@@ -3119,6 +3120,7 @@ static const TypeInfo scsi_block_info =3D {
=20
 static Property scsi_disk_properties[] =3D {
     DEFINE_SCSI_DISK_PROPERTIES(),
+    DEFINE_PROP_DRIVE_IOTHREAD("drive", SCSIDiskState, qdev.conf.blk),
     DEFINE_PROP_BIT("removable", SCSIDiskState, features,
                     SCSI_DISK_F_REMOVABLE, false),
     DEFINE_PROP_BIT("dpofua", SCSIDiskState, features,
--=20
2.21.0.windows.1



