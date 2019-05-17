Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2CAC04E87
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2A120868
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 08:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2A120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYVf-0000YB-HX
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 04:46:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTF-0007S5-AF
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klaus@birkelund.eu>) id 1hRYTD-00062A-2i
	for qemu-devel@nongnu.org; Fri, 17 May 2019 04:44:04 -0400
Received: from charlie.dont.surf ([128.199.63.193]:40192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klaus@birkelund.eu>)
	id 1hRYT9-0005yA-NM; Fri, 17 May 2019 04:43:59 -0400
Received: from apples.localdomain (ip-5-186-120-196.cgn.fibianet.dk
	[5.186.120.196])
	by charlie.dont.surf (Postfix) with ESMTPSA id 87F25C06E4;
	Fri, 17 May 2019 08:43:56 +0000 (UTC)
From: Klaus Birkelund Jensen <klaus@birkelund.eu>
To: qemu-block@nongnu.org
Date: Fri, 17 May 2019 10:42:31 +0200
Message-Id: <20190517084234.26923-6-klaus@birkelund.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517084234.26923-1-klaus@birkelund.eu>
References: <20190517084234.26923-1-klaus@birkelund.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: [Qemu-devel] [PATCH 5/8] nvme: add support for metadata
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
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The new `ms` parameter may be used to indicate the number of metadata
bytes provided per LBA.

Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
---
 hw/block/nvme.c | 31 +++++++++++++++++++++++++++++--
 hw/block/nvme.h | 11 ++++++++++-
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index c514f93f3867..675967a596d1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -33,6 +33,8 @@
  *   num_ns=3D<int>          : Namespaces to make out of the backing sto=
rage,
  *                           Default:1
  *   num_queues=3D<int>      : Number of possible IO Queues, Default:64
+ *   ms=3D<int>              : Number of metadata bytes provided per LBA=
,
+ *                           Default:0
  *   cmb_size_mb=3D<int>     : Size of CMB in MBs, Default:0
  *
  * Parameters will be verified against conflicting capabilities and attr=
ibutes
@@ -386,6 +388,8 @@ static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *cm=
d, NvmeRequest *req)
=20
     uint32_t unit_len =3D nvme_ns_lbads_bytes(ns);
     uint32_t len =3D req->nlb * unit_len;
+    uint32_t meta_unit_len =3D nvme_ns_ms(ns);
+    uint32_t meta_len =3D req->nlb * meta_unit_len;
     uint64_t prp1 =3D le64_to_cpu(cmd->prp1);
     uint64_t prp2 =3D le64_to_cpu(cmd->prp2);
=20
@@ -399,6 +403,19 @@ static uint16_t nvme_blk_map(NvmeCtrl *n, NvmeCmd *c=
md, NvmeRequest *req)
         return err;
     }
=20
+    qsg.nsg =3D 0;
+    qsg.size =3D 0;
+
+    if (cmd->mptr && n->params.ms) {
+        qemu_sglist_add(&qsg, le64_to_cpu(cmd->mptr), meta_len);
+
+        err =3D nvme_blk_setup(n, ns, &qsg, ns->blk_offset_md, meta_unit=
_len,
+            req);
+        if (err) {
+            return err;
+        }
+    }
+
     qemu_sglist_destroy(&qsg);
=20
     return NVME_SUCCESS;
@@ -1902,6 +1919,11 @@ static int nvme_check_constraints(NvmeCtrl *n, Err=
or **errp)
         return 1;
     }
=20
+    if (params->ms && !is_power_of_2(params->ms)) {
+        error_setg(errp, "nvme: invalid metadata configuration");
+        return 1;
+    }
+
     return 0;
 }
=20
@@ -2066,17 +2088,20 @@ static void nvme_init_ctrl(NvmeCtrl *n)
=20
 static uint64_t nvme_ns_calc_blks(NvmeCtrl *n, NvmeNamespace *ns)
 {
-    return n->ns_size / nvme_ns_lbads_bytes(ns);
+    return n->ns_size / (nvme_ns_lbads_bytes(ns) + nvme_ns_ms(ns));
 }
=20
 static void nvme_ns_init_identify(NvmeCtrl *n, NvmeIdNs *id_ns)
 {
+    NvmeParams *params =3D &n->params;
+
     id_ns->nlbaf =3D 0;
     id_ns->flbas =3D 0;
-    id_ns->mc =3D 0;
+    id_ns->mc =3D params->ms ? 0x2 : 0;
     id_ns->dpc =3D 0;
     id_ns->dps =3D 0;
     id_ns->lbaf[0].lbads =3D BDRV_SECTOR_BITS;
+    id_ns->lbaf[0].ms =3D params->ms;
 }
=20
 static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **e=
rrp)
@@ -2086,6 +2111,8 @@ static int nvme_init_namespace(NvmeCtrl *n, NvmeNam=
espace *ns, Error **errp)
     nvme_ns_init_identify(n, id_ns);
=20
     ns->ns_blks =3D nvme_ns_calc_blks(n, ns);
+    ns->blk_offset_md =3D ns->blk_offset + nvme_ns_lbads_bytes(ns) * ns-=
>ns_blks;
+
     id_ns->nuse =3D id_ns->ncap =3D id_ns->nsze =3D cpu_to_le64(ns->ns_b=
lks);
=20
     return 0;
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 711ca249eac5..81ee0c5173d5 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -8,13 +8,15 @@
     DEFINE_PROP_UINT32("cmb_size_mb", _state, _props.cmb_size_mb, 0), \
     DEFINE_PROP_UINT32("num_queues", _state, _props.num_queues, 64), \
     DEFINE_PROP_UINT32("num_ns", _state, _props.num_ns, 1), \
-    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7)
+    DEFINE_PROP_UINT8("mdts", _state, _props.mdts, 7), \
+    DEFINE_PROP_UINT8("ms", _state, _props.ms, 0)
=20
 typedef struct NvmeParams {
     char     *serial;
     uint32_t num_queues;
     uint32_t num_ns;
     uint8_t  mdts;
+    uint8_t  ms;
     uint32_t cmb_size_mb;
 } NvmeParams;
=20
@@ -91,6 +93,7 @@ typedef struct NvmeNamespace {
     uint32_t        id;
     uint64_t        ns_blks;
     uint64_t        blk_offset;
+    uint64_t        blk_offset_md;
 } NvmeNamespace;
=20
 #define TYPE_NVME "nvme"
@@ -154,4 +157,10 @@ static inline size_t nvme_ns_lbads_bytes(NvmeNamespa=
ce *ns)
     return 1 << nvme_ns_lbads(ns);
 }
=20
+static inline uint16_t nvme_ns_ms(NvmeNamespace *ns)
+{
+    NvmeIdNs *id =3D &ns->id_ns;
+    return le16_to_cpu(id->lbaf[NVME_ID_NS_FLBAS_INDEX(id->flbas)].ms);
+}
+
 #endif /* HW_NVME_H */
--=20
2.21.0


