Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB10BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:59:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B8C217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FxPbV3PP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87B8C217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuzc-0001i3-LL
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusw-0004sC-Kq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusv-0007va-2P
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusu-0007WW-S2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:44 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095231euoutp01fd9594ef41a946a3fd43f596d66a3293~wKkZnG6SR3058130581euoutp01-
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095231euoutp01fd9594ef41a946a3fd43f596d66a3293~wKkZnG6SR3058130581euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809951;
 bh=oTg2jFY4w+QtsoZIr5cs9blt/JLIIZ6dyCWP0BEZoso=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=FxPbV3PPzRNMexsmCUgEdTU0W0T0jS0lUUGXEXdkVf4FtLDZ790tBNU2xLUhRXb5l
 NYyPCc/v7kujruhSn16p0OEb8ck+FbMFfyNEAXi1ojFjVJjmI2YuB5d/TJQoydYeB9
 Z0JuUQVU8LQf/MsxVF55/M94ttnItYUajQ6Fcd9k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204095230eucas1p256714c09b5e6bf590dd5435c493e63f1~wKkZZCqfl0717507175eucas1p2R;
 Tue,  4 Feb 2020 09:52:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id B1.FB.60679.EDE393E5; Tue,  4
 Feb 2020 09:52:30 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095230eucas1p23f3105c4cab4aaec77a3dd42b8158c10~wKkZFLsRD2189621896eucas1p2R;
 Tue,  4 Feb 2020 09:52:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095230eusmtrp24474c35a52db18d5485a14c8ea393505~wKkZEk9_50487104871eusmtrp20;
 Tue,  4 Feb 2020 09:52:30 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-49-5e393edeb14a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id BC.CC.08375.EDE393E5; Tue,  4
 Feb 2020 09:52:30 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095230eusmtip25f37bc7f5dffbe320f3c36da82e6075d~wKkY9UfKK2738327383eusmtip2W;
 Tue,  4 Feb 2020 09:52:30 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:30 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:29 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 23/26] pci: allocate pci id for nvme
Date: Tue, 4 Feb 2020 10:52:05 +0100
Message-ID: <20200204095208.269131-24-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djP87r37CzjDJrvG1ps7m9ntNh/8Bur
 xaRD1xgtllxMtZh3S9li1rt2NovjvTtYHNg9zu04z+6xaVUnm8eda3vYPJ5c28zk8X7fVbYA
 1igum5TUnMyy1CJ9uwSujLV77zMWNAlWnHrt1sD4lbeLkYNDQsBEYt5r9S5GTg4hgRWMEttP
 OHQxcgHZXxglFrXcZoRwPjNKnDl2hxWkCqTh/rZ3UInljBKzZl5khav6veodG4RzmlFi+e+D
 LBCDdzJK7HrLBmKzCWhKbP/zHywuIiAt0X51Elg3s8BvRom5jRPBioQFzCUOPV0LVsQioCLx
 eM5WRhCbV8BaYkfTF0aIO+QlZjeeBqvnBIrvX3WCCaJGUOLkzCdgvcxANc1bZzND2BISB1+8
 YAZZJiGwjV1ix+brUINcJM7+2M4MYQtLvDq+hR3ClpH4v3M+E0RDN6NE34evUN0zGCWmL/vO
 Bgk/a4m+MzkQDY4Sk64+Y4QI80nceCsIsZhPYtK26cwQYV6JjjYhiGo1oF+2Mk5gVJ6F5OxZ
 SM6eheTsBYzMqxjFU0uLc9NTi43yUsv1ihNzi0vz0vWS83M3MQKTzel/x7/sYNz1J+kQowAH
 oxIP78mzFnFCrIllxZW5hxglOJiVRHjP61vGCfGmJFZWpRblxxeV5qQWH2KU5mBREuc1XvQy
 VkggPbEkNTs1tSC1CCbLxMEp1cDILKYwL75Wi3dj80fGw0ujuledNAuyndsf93JJWl2rhMVV
 xi3NL55s6H7xbtfy/7OylbctuVOw+c/D/l2Reo+dqhULJ3S9u9mUZXFf5nfaax9D1s1qLYIc
 K3/ZnLBrt8zham6tXfS7kesGm986Nu+3hikZwnsOOV1X9raMyy+93XX07sLbN9crsRRnJBpq
 MRcVJwIAl9dY8DIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsVy+t/xe7r37CzjDCYfl7bY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GWv3
 3mcsaBKsOPXarYHxK28XIyeHhICJxP1t7xhBbCGBpYwS01epQsRlJD5d+cgOYQtL/LnWxdbF
 yAVU85FR4u+fj0wQzmlGidmHJ7FCODsZJb4sPsgM0sImoCmx/c9/FhBbREBaov0qSBEnB7PA
 b0aJP32BILawgLnEoadrwWpYBFQkHs/ZCnYGr4C1xI6mL4wQq+UlZjeeZgOxOYHi+1edANrM
 AbTMSqL1KDdEuaDEyZlPWCDGy0s0b53NDGFLSBx88YJ5AqPwLCRls5CUzUJStoCReRWjSGpp
 cW56brGhXnFibnFpXrpecn7uJkZgxG079nPzDsZLG4MPMQpwMCrx8F6ws4gTYk0sK67MPcQo
 wcGsJMJ7Xt8yTog3JbGyKrUoP76oNCe1+BCjKdBvE5mlRJPzgckgryTe0NTQ3MLS0NzY3NjM
 Qkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDYzurBF80R3S7/YuMPYbHCxZcfMet6xZm1cDF
 7bJNQv2apuM1PVMeB3n7Qrfd/1u216rkqXFJFKZYVfzfIm347GDVrXcHlm8JKZ/Ir2kmbLKk
 +BKD3ea03ZLMzGKTprqs3TL1SsutV7HXD5WUuLXxvn1jEXD1/5lcQ9n4+VO/yun+3nm7cG6u
 EktxRqKhFnNRcSIAVnfhSc4CAAA=
X-CMS-MailID: 20200204095230eucas1p23f3105c4cab4aaec77a3dd42b8158c10
X-Msg-Generator: CA
X-RootMTR: 20200204095230eucas1p23f3105c4cab4aaec77a3dd42b8158c10
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095230eucas1p23f3105c4cab4aaec77a3dd42b8158c10
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095230eucas1p23f3105c4cab4aaec77a3dd42b8158c10@eucas1p2.samsung.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The emulated nvme device (hw/block/nvme.c) is currently using an
internal Intel device id.

Prepare to change that by allocating a device id under the 1b36 (Red
Hat, Inc.) vendor id.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 MAINTAINERS            |  1 +
 docs/specs/nvme.txt    | 10 ++++++++++
 docs/specs/pci-ids.txt |  1 +
 include/hw/pci/pci.h   |  1 +
 4 files changed, 13 insertions(+)
 create mode 100644 docs/specs/nvme.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f0bc72f2189..14a018e9c0ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1645,6 +1645,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: hw/block/nvme*
 F: tests/qtest/nvme-test.c
+F: docs/specs/nvme.txt
=20
 megasas
 M: Hannes Reinecke <hare@suse.com>
diff --git a/docs/specs/nvme.txt b/docs/specs/nvme.txt
new file mode 100644
index 000000000000..6ec7ddbc7ee0
--- /dev/null
+++ b/docs/specs/nvme.txt
@@ -0,0 +1,10 @@
+NVM Express Controller
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The nvme device (-device nvme) emulates an NVM Express Controller.
+
+
+Reference Specifications
+------------------------
+
+  https://nvmexpress.org/resources/specifications/
diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
index 4d53e5c7d9d5..abbdbca6be38 100644
--- a/docs/specs/pci-ids.txt
+++ b/docs/specs/pci-ids.txt
@@ -63,6 +63,7 @@ PCI devices (other than virtio):
 1b36:000b  PCIe Expander Bridge (-device pxb-pcie)
 1b36:000d  PCI xhci usb host adapter
 1b36:000f  mdpy (mdev sample device), linux/samples/vfio-mdev/mdpy.c
+1b36:0010  PCIe NVMe device (-device nvme)
=20
 All these devices are documented in docs/specs.
=20
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index b5013b834b20..9a20c309d0f2 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -103,6 +103,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
 #define PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE 0x000e
 #define PCI_DEVICE_ID_REDHAT_MDPY        0x000f
+#define PCI_DEVICE_ID_REDHAT_NVME        0x0010
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
=20
 #define FMT_PCIBUS                      PRIx64
--=20
2.25.0


