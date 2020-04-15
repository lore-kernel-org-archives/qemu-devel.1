Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942CEC2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D64F206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 06:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D64F206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOb9T-0004rQ-1a
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 02:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOayh-0001tF-Eq
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOayf-0002dx-6N
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 01:52:51 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47306)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOayb-0002RU-HS; Wed, 15 Apr 2020 01:52:45 -0400
Received: from apples.local (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 5BA6FBFD5C;
 Wed, 15 Apr 2020 05:52:24 +0000 (UTC)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-block@nongnu.org
Subject: [PATCH v7 19/48] nvme: support identify namespace descriptor list
Date: Wed, 15 Apr 2020 07:51:11 +0200
Message-Id: <20200415055140.466900-20-its@irrelevant.dk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415055140.466900-1-its@irrelevant.dk>
References: <20200415055140.466900-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Since we are not providing the NGUID or EUI64 fields, we must support
the Namespace UUID. We do not have any way of storing a persistent
unique identifier, so conjure up a UUID that is just the namespace id.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/block/nvme.c       | 39 +++++++++++++++++++++++++++++++++++++++
 hw/block/trace-events |  1 +
 2 files changed, 40 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d4622278450e..f40bc861facc 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -949,6 +949,43 @@ static uint16_t nvme_identify_nslist(NvmeCtrl *n, Nv=
meIdentify *c)
     return ret;
 }
=20
+static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeIdentify *c=
)
+{
+    uint32_t nsid =3D le32_to_cpu(c->nsid);
+    uint64_t prp1 =3D le64_to_cpu(c->prp1);
+    uint64_t prp2 =3D le64_to_cpu(c->prp2);
+
+    uint8_t list[NVME_IDENTIFY_DATA_SIZE];
+
+    struct data {
+        struct {
+            NvmeIdNsDescr hdr;
+            uint8_t v[16];
+        } uuid;
+    };
+
+    struct data *ns_descrs =3D (struct data *)list;
+
+    trace_nvme_dev_identify_ns_descr_list(nsid);
+
+    if (unlikely(nsid =3D=3D 0 || nsid > n->num_namespaces)) {
+        trace_nvme_dev_err_invalid_ns(nsid, n->num_namespaces);
+        return NVME_INVALID_NSID | NVME_DNR;
+    }
+
+    /*
+     * Because the NGUID and EUI64 fields are 0 in the Identify Namespac=
e data
+     * structure, a Namespace UUID (nidt =3D 0x3) must be reported in th=
e
+     * Namespace Identification Descriptor. Add a very basic Namespace U=
UID
+     * here.
+     */
+    ns_descrs->uuid.hdr.nidt =3D NVME_NIDT_UUID;
+    ns_descrs->uuid.hdr.nidl =3D NVME_NIDT_UUID_LEN;
+    stl_be_p(&ns_descrs->uuid.v, nsid);
+
+    return nvme_dma_read_prp(n, list, NVME_IDENTIFY_DATA_SIZE, prp1, prp=
2);
+}
+
 static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
 {
     NvmeIdentify *c =3D (NvmeIdentify *)cmd;
@@ -960,6 +997,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *c=
md)
         return nvme_identify_ctrl(n, c);
     case NVME_ID_CNS_NS_ACTIVE_LIST:
         return nvme_identify_nslist(n, c);
+    case NVME_ID_CNS_NS_DESCR_LIST:
+        return nvme_identify_ns_descr_list(n, c);
     default:
         trace_nvme_dev_err_invalid_identify_cns(le32_to_cpu(c->cns));
         return NVME_INVALID_FIELD | NVME_DNR;
diff --git a/hw/block/trace-events b/hw/block/trace-events
index fb5b26f6f5f6..7ecd47131ac2 100644
--- a/hw/block/trace-events
+++ b/hw/block/trace-events
@@ -45,6 +45,7 @@ nvme_dev_del_cq(uint16_t cqid) "deleted completion queu=
e, cqid=3D%"PRIu16""
 nvme_dev_identify_ctrl(void) "identify controller"
 nvme_dev_identify_ns(uint32_t ns) "nsid %"PRIu32""
 nvme_dev_identify_nslist(uint32_t ns) "nsid %"PRIu32""
+nvme_dev_identify_ns_descr_list(uint32_t ns) "nsid %"PRIu32""
 nvme_dev_getfeat(uint16_t cid, uint32_t fid) "cid %"PRIu16" fid 0x%"PRIx=
32""
 nvme_dev_setfeat(uint16_t cid, uint32_t fid, uint32_t val) "cid %"PRIu16=
" fid 0x%"PRIx32" val 0x%"PRIx32""
 nvme_dev_getfeat_vwcache(const char* result) "get feature volatile write=
 cache, result=3D%s"
--=20
2.26.0


