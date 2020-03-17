Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C6AC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 610F2205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="euScu9ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 610F2205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Su-0002Qi-IK
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jE969-0001jn-Aj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jE967-0005lL-GF
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:05:21 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:48023 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jE967-0002rW-4k; Tue, 17 Mar 2020 06:05:19 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48hTKy4yzVz9sTD; Tue, 17 Mar 2020 21:04:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1584439478;
 bh=B1jV0fPQqocvsTwTXF9kvnqwBe/46c7fcSvYFuxuhlo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=euScu9axJryurPEQPYiT+tUUw9VrfgPdpAYpM/A6LVkKGFDZcxb29YGOlVeZ16uBH
 iZC7kTJ5UWJrBUa7xP5630ooScJg+S4aofXwIHZ/LZlETzHlcRdRjbDfC27TPQycj+
 4uVsomRwAFKilupiq3nua/WJUCrkww8TdViV/bhE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 25/45] hw/scsi/spapr_vscsi: Introduce req_iu() helper
Date: Tue, 17 Mar 2020 21:04:03 +1100
Message-Id: <20200317100423.622643-26-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317100423.622643-1-david@gibson.dropbear.id.au>
References: <20200317100423.622643-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Introduce the req_iu() helper which returns a pointer to
the viosrp_iu union held in the vscsi_req structure.
This simplifies the next patch.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200305121253.19078-5-philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/scsi/spapr_vscsi.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 3cb5a38181..70547f98ac 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -97,6 +97,11 @@ typedef struct {
     vscsi_req reqs[VSCSI_REQ_LIMIT];
 } VSCSIState;
=20
+static union viosrp_iu *req_iu(vscsi_req *req)
+{
+    return &req->iu;
+}
+
 static struct vscsi_req *vscsi_get_req(VSCSIState *s)
 {
     vscsi_req *req;
@@ -121,7 +126,7 @@ static struct vscsi_req *vscsi_find_req(VSCSIState *s=
, uint64_t srp_tag)
=20
     for (i =3D 0; i < VSCSI_REQ_LIMIT; i++) {
         req =3D &s->reqs[i];
-        if (req->iu.srp.cmd.tag =3D=3D srp_tag) {
+        if (req_iu(req)->srp.cmd.tag =3D=3D srp_tag) {
             return req;
         }
     }
@@ -188,7 +193,7 @@ static int vscsi_send_iu(VSCSIState *s, vscsi_req *re=
q,
     req->crq.s.reserved =3D 0x00;
     req->crq.s.timeout =3D cpu_to_be16(0x0000);
     req->crq.s.IU_length =3D cpu_to_be16(length);
-    req->crq.s.IU_data_ptr =3D req->iu.srp.rsp.tag; /* right byte order =
*/
+    req->crq.s.IU_data_ptr =3D req_iu(req)->srp.rsp.tag; /* right byte o=
rder */
=20
     if (rc =3D=3D 0) {
         req->crq.s.status =3D VIOSRP_OK;
@@ -224,7 +229,7 @@ static void vscsi_makeup_sense(VSCSIState *s, vscsi_r=
eq *req,
 static int vscsi_send_rsp(VSCSIState *s, vscsi_req *req,
                           uint8_t status, int32_t res_in, int32_t res_ou=
t)
 {
-    union viosrp_iu *iu =3D &req->iu;
+    union viosrp_iu *iu =3D req_iu(req);
     uint64_t tag =3D iu->srp.rsp.tag;
     int total_len =3D sizeof(iu->srp.rsp);
     uint8_t sol_not =3D iu->srp.cmd.sol_not;
@@ -285,7 +290,7 @@ static int vscsi_fetch_desc(VSCSIState *s, struct vsc=
si_req *req,
                             unsigned n, unsigned buf_offset,
                             struct srp_direct_buf *ret)
 {
-    struct srp_cmd *cmd =3D &req->iu.srp.cmd;
+    struct srp_cmd *cmd =3D &req_iu(req)->srp.cmd;
=20
     switch (req->dma_fmt) {
     case SRP_NO_DATA_DESC: {
@@ -473,7 +478,7 @@ static int data_out_desc_size(struct srp_cmd *cmd)
=20
 static int vscsi_preprocess_desc(vscsi_req *req)
 {
-    struct srp_cmd *cmd =3D &req->iu.srp.cmd;
+    struct srp_cmd *cmd =3D &req_iu(req)->srp.cmd;
=20
     req->cdb_offset =3D cmd->add_cdb_len & ~3;
=20
@@ -655,7 +660,7 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequ=
est *sreq)
=20
 static void vscsi_process_login(VSCSIState *s, vscsi_req *req)
 {
-    union viosrp_iu *iu =3D &req->iu;
+    union viosrp_iu *iu =3D req_iu(req);
     struct srp_login_rsp *rsp =3D &iu->srp.login_rsp;
     uint64_t tag =3D iu->srp.rsp.tag;
=20
@@ -681,7 +686,7 @@ static void vscsi_process_login(VSCSIState *s, vscsi_=
req *req)
=20
 static void vscsi_inquiry_no_target(VSCSIState *s, vscsi_req *req)
 {
-    uint8_t *cdb =3D req->iu.srp.cmd.cdb;
+    uint8_t *cdb =3D req_iu(req)->srp.cmd.cdb;
     uint8_t resp_data[36];
     int rc, len, alen;
=20
@@ -770,7 +775,7 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_re=
q *req)
=20
 static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
 {
-    union srp_iu *srp =3D &req->iu.srp;
+    union srp_iu *srp =3D &req_iu(req)->srp;
     SCSIDevice *sdev;
     int n, lun;
=20
@@ -821,7 +826,7 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *=
req)
=20
 static int vscsi_process_tsk_mgmt(VSCSIState *s, vscsi_req *req)
 {
-    union viosrp_iu *iu =3D &req->iu;
+    union viosrp_iu *iu =3D req_iu(req);
     vscsi_req *tmpreq;
     int i, lun =3D 0, resp =3D SRP_TSK_MGMT_COMPLETE;
     SCSIDevice *d;
@@ -831,7 +836,8 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
     fprintf(stderr, "vscsi_process_tsk_mgmt %02x\n",
             iu->srp.tsk_mgmt.tsk_mgmt_func);
=20
-    d =3D vscsi_device_find(&s->bus, be64_to_cpu(req->iu.srp.tsk_mgmt.lu=
n), &lun);
+    d =3D vscsi_device_find(&s->bus,
+                          be64_to_cpu(req_iu(req)->srp.tsk_mgmt.lun), &l=
un);
     if (!d) {
         resp =3D SRP_TSK_MGMT_FIELDS_INVALID;
     } else {
@@ -842,7 +848,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
                 break;
             }
=20
-            tmpreq =3D vscsi_find_req(s, req->iu.srp.tsk_mgmt.task_tag);
+            tmpreq =3D vscsi_find_req(s, req_iu(req)->srp.tsk_mgmt.task_=
tag);
             if (tmpreq && tmpreq->sreq) {
                 assert(tmpreq->sreq->hba_private);
                 scsi_req_cancel(tmpreq->sreq);
@@ -867,7 +873,8 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
=20
             for (i =3D 0; i < VSCSI_REQ_LIMIT; i++) {
                 tmpreq =3D &s->reqs[i];
-                if (tmpreq->iu.srp.cmd.lun !=3D req->iu.srp.tsk_mgmt.lun=
) {
+                if (req_iu(tmpreq)->srp.cmd.lun
+                        !=3D req_iu(req)->srp.tsk_mgmt.lun) {
                     continue;
                 }
                 if (!tmpreq->active || !tmpreq->sreq) {
@@ -911,7 +918,7 @@ static int vscsi_process_tsk_mgmt(VSCSIState *s, vscs=
i_req *req)
=20
 static int vscsi_handle_srp_req(VSCSIState *s, vscsi_req *req)
 {
-    union srp_iu *srp =3D &req->iu.srp;
+    union srp_iu *srp =3D &req_iu(req)->srp;
     int done =3D 1;
     uint8_t opcode =3D srp->rsp.opcode;
=20
@@ -948,7 +955,7 @@ static int vscsi_send_adapter_info(VSCSIState *s, vsc=
si_req *req)
     struct mad_adapter_info_data info;
     int rc;
=20
-    sinfo =3D &req->iu.mad.adapter_info;
+    sinfo =3D &req_iu(req)->mad.adapter_info;
=20
 #if 0 /* What for ? */
     rc =3D spapr_vio_dma_read(&s->vdev, be64_to_cpu(sinfo->buffer),
@@ -984,7 +991,7 @@ static int vscsi_send_capabilities(VSCSIState *s, vsc=
si_req *req)
     uint64_t buffer;
     int rc;
=20
-    vcap =3D &req->iu.mad.capabilities;
+    vcap =3D &req_iu(req)->mad.capabilities;
     req_len =3D len =3D be16_to_cpu(vcap->common.length);
     buffer =3D be64_to_cpu(vcap->buffer);
     if (len > sizeof(cap)) {
@@ -1029,7 +1036,7 @@ static int vscsi_send_capabilities(VSCSIState *s, v=
scsi_req *req)
=20
 static int vscsi_handle_mad_req(VSCSIState *s, vscsi_req *req)
 {
-    union mad_iu *mad =3D &req->iu.mad;
+    union mad_iu *mad =3D &req_iu(req)->mad;
     bool request_handled =3D false;
     uint64_t retlen =3D 0;
=20
--=20
2.24.1


