Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E292C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29150217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 09:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M6mGAdi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29150217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyuyq-00008o-AY
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 04:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.jensen@samsung.com>) id 1iyusw-0004sM-L6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.jensen@samsung.com>) id 1iyusv-0007vi-5r
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <k.jensen@samsung.com>)
 id 1iyusu-0007Wl-Sx
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 04:52:45 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204095231euoutp0101ecc97e8d8489b6942dd90e99f2bb90~wKkaTU5d73058130581euoutp01C
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 09:52:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204095231euoutp0101ecc97e8d8489b6942dd90e99f2bb90~wKkaTU5d73058130581euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580809951;
 bh=rvrSEQseKfeNqqw5XDKS3yK2e1y5M30V2O/ktHSEgKI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References:From;
 b=M6mGAdi6V5lc97s62VIdYNNI7ayeBjmVG84IqGtLHW5yesDLA+504HBNHPeP/AqlT
 5i9idWNT/ihoEGSsEg9vRF/YTP/5mODb57Wid8zKZyxjPIaKgdGruz5/h2A0kIeURj
 Bc6Yj5xieE0YYJUOoMWN6sddCIzlenhunf3UbgAI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204095231eucas1p20a2b156844cd09db5928aa654af13a0e~wKkaCUvsf2198521985eucas1p2G;
 Tue,  4 Feb 2020 09:52:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id A2.FB.60679.FDE393E5; Tue,  4
 Feb 2020 09:52:31 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204095231eucas1p21019b1d857fcda9d67950e7d01de6b6a~wKkZuqSQd2198521985eucas1p2F;
 Tue,  4 Feb 2020 09:52:31 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200204095231eusmtrp2f6b5bebc7a15752c75a4f9e5c72aaa2a~wKkZuFlUv0485704857eusmtrp2-;
 Tue,  4 Feb 2020 09:52:31 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-4c-5e393edf5d9b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 5D.CC.08375.FDE393E5; Tue,  4
 Feb 2020 09:52:31 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200204095231eusmtip18b084b1ea7853cf954ec43084d1859a0~wKkZm82Km3064230642eusmtip13;
 Tue,  4 Feb 2020 09:52:31 +0000 (GMT)
Received: from CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) by
 CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
 Server (TLS) id 15.0.1320.4; Tue, 4 Feb 2020 09:52:30 +0000
Received: from apples.local (106.110.32.41) by CAMSVWEXC01.scsc.local
 (106.1.227.71) with Microsoft SMTP Server id 15.0.1320.4 via Frontend
 Transport; Tue, 4 Feb 2020 09:52:30 +0000
From: Klaus Jensen <k.jensen@samsung.com>
To: <qemu-block@nongnu.org>
Subject: [PATCH v5 24/26] nvme: change controller pci id
Date: Tue, 4 Feb 2020 10:52:06 +0100
Message-ID: <20200204095208.269131-25-k.jensen@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200204095208.269131-1-k.jensen@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm29nOzlaTs6n4pUU5RchKu9IRTRP8MfoR9S+EzJN+qLSL7ajN
 QJoJ3krThVM3VhaRlz/lnDozGy502tKl4EiTFJtkkhdQu0rmdlb473mfy/c+vHwEJnnECyVy
 lHlIraTlUlzI7Rr8OXpkJjEu7eiv1j1Ux70yQNn6v/Eond0NqCdjiHowFUEZlstwylFl5Z7l
 y0atLr7M3FaBy6bdL3GZx93Bka28msAv8FKFCZlInlOA1LGJ6cLsZ0MWTm57qGZsXKgFDcGV
 gCAgeRJaRs5VAiEhIVsANEx2YOywDuC0Vucf1gDc8vRyKoHAl9DPL/mFZgBbZp/z/7umxks4
 7OAE8HXdoF/pAfBNYznmzePkQdi9ucX14iAyDJZN6HheE0b+BtBUXIt7hUCSgubaTr4Xc8lI
 OP+5yceLyHhotHXjbJH90Fjs9GHBNm9rG+KwHjEcbvT4FmDbnpJOI8ZiCPsXFnzFIdnFh83r
 Vf6HUuC7qUE/DoSLDgufxXvhVs9DDhu4A2D16oY/3QBg/dPvOHvBeFj9Vs4GkmHt0CqfpQPg
 +yUxuzgA6rrqMZYWwfJSCeuOgtbbnaAGRBh21DbsqG3YUbsJYG0gBOUziizEHFeiGzEMrWDy
 lVkxGSqFGWx/HOcfx7oVvNi8agckAaS7RcMjVJqERxcwhQo7gAQmDRK5YuPSJKJMuvAmUquu
 qPPliLGDMIIrDRGdePzlsoTMovPQNYRykfqfyiEEoVqwryJ7URw1fsaud6QURM79wExJhRkK
 tam3JkAjQNfDU4OT10pnJl1R8yKX5iutSjqv1y4vpyir5nataD60RA4cCtPPJguRW7F4WvWx
 P72I0RwwJ4rD8y6agse6nR6UsHHf3kQ0m0/1PZ43tlvslwb6WuuiDxcZPrXa7t5SSLlMNn0s
 GlMz9F8JSwF2NAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7r37SzjDI5N5bTY3N/OaLH/4DdW
 i0mHrjFaLLmYajHvlrLFrHftbBbHe3ewOLB7nNtxnt1j06pONo871/aweTy5tpnJ4/2+q2wB
 rFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GetP
 bGEq2ChVcfESVwPjDNEuRk4OCQETiWlP3zJ3MXJxCAksZZSYe/AwI0RCRuLTlY/sELawxJ9r
 XWwQRR8ZJe4c+sIC4ZxmlNh06jEjhLOTUaJx02+wFjYBTYntf/6zgNgiAtIS7VcnsYLYzAK/
 GSX+9AWC2MICFhKbJm4Fq2cRUJF4+nwBG4jNK2AtMXv/djaI1fISsxtPg9mcQPH9q04wdTFy
 AC2zkmg9yg1RLihxcuYTFojx8hLNW2czQ9gSEgdfvGCewCg8C0nZLCRls5CULWBkXsUoklpa
 nJueW2yoV5yYW1yal66XnJ+7iREYc9uO/dy8g/HSxuBDjAIcjEo8vBfsLOKEWBPLiitzDzFK
 cDArifCe17eME+JNSaysSi3Kjy8qzUktPsRoCvTbRGYp0eR8YDrIK4k3NDU0t7A0NDc2Nzaz
 UBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXA2FbKKXe6IuSSSLe30Y8u/U+/S2Q3L7MSLir/
 rj6d0fCscFTDsR+af883Gcakv732Tabwmvd9EfH4fS8yvv5LLwlJKvALVNCtubJuwnexy19z
 jB7f+pJ+9kqxsKfPJdEdry1k5U+xL6x0eOLwePcHZqs1ETXnMz2KNU7+/yRxT/Omg8jHoMNq
 SizFGYmGWsxFxYkA1uu1Xs8CAAA=
X-CMS-MailID: 20200204095231eucas1p21019b1d857fcda9d67950e7d01de6b6a
X-Msg-Generator: CA
X-RootMTR: 20200204095231eucas1p21019b1d857fcda9d67950e7d01de6b6a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204095231eucas1p21019b1d857fcda9d67950e7d01de6b6a
References: <20200204095208.269131-1-k.jensen@samsung.com>
 <CGME20200204095231eucas1p21019b1d857fcda9d67950e7d01de6b6a@eucas1p2.samsung.com>
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

There are two reasons for changing this:

  1. The nvme device currently uses an internal Intel device id.

  2. Since commits "nvme: fix write zeroes offset and count" and "nvme:
     support multiple namespaces" the controller device no longer has
     the quirks that the Linux kernel think it has.

     As the quirks are applied based on pci vendor and device id, change
     them to get rid of the quirks.

To keep backward compatibility, add a new 'x-use-intel-id' parameter to
the nvme device to force use of the Intel vendor and device id. This is
off by default but add a compat property to set this for machines 4.2
and older.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c   | 13 +++++++++----
 hw/block/nvme.h   |  4 +++-
 hw/core/machine.c |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 3a377bc56734..bdef53a590b0 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2467,8 +2467,15 @@ static void nvme_init_pci(NvmeCtrl *n, PCIDevice *=
pci_dev)
=20
     pci_conf[PCI_INTERRUPT_PIN] =3D 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
-    pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
-    pci_config_set_device_id(pci_conf, 0x5845);
+
+    if (n->params.use_intel_id) {
+        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_INTEL);
+        pci_config_set_device_id(pci_conf, 0x5846);
+    } else {
+        pci_config_set_vendor_id(pci_conf, PCI_VENDOR_ID_REDHAT);
+        pci_config_set_device_id(pci_conf, PCI_DEVICE_ID_REDHAT_NVME);
+    }
+
     pci_config_set_class(pci_conf, PCI_CLASS_STORAGE_EXPRESS);
     pcie_endpoint_cap_init(pci_dev, 0x80);
=20
@@ -2638,8 +2645,6 @@ static void nvme_class_init(ObjectClass *oc, void *=
data)
     pc->realize =3D nvme_realize;
     pc->exit =3D nvme_exit;
     pc->class_id =3D PCI_CLASS_STORAGE_EXPRESS;
-    pc->vendor_id =3D PCI_VENDOR_ID_INTEL;
-    pc->device_id =3D 0x5845;
     pc->revision =3D 2;
=20
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index c3cef0f024da..6b584f53ed64 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -12,7 +12,8 @@
     DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
     DEFINE_PROP_UINT8("aerl", _state, _props.aerl, 3), \
     DEFINE_PROP_UINT32("aer_max_queued", _state, _props.aer_max_queued, =
64), \
-    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7)
+    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7), \
+    DEFINE_PROP_BOOL("x-use-intel-id", _state, _props.use_intel_id, fals=
e)
=20
 typedef struct NvmeParams {
     char     *serial;
@@ -21,6 +22,7 @@ typedef struct NvmeParams {
     uint8_t  aerl;
     uint32_t aer_max_queued;
     uint8_t  mdts;
+    bool     use_intel_id;
 } NvmeParams;
=20
 typedef struct NvmeAsyncEvent {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 3e288bfceb7f..984412d98c9d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -34,6 +34,7 @@ GlobalProperty hw_compat_4_2[] =3D {
     { "vhost-blk-device", "seg_max_adjust", "off"},
     { "usb-host", "suppress-remote-wake", "off" },
     { "usb-redir", "suppress-remote-wake", "off" },
+    { "nvme", "x-use-intel-id", "on"},
 };
 const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
=20
--=20
2.25.0


