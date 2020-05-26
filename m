Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD6EC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:55:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6E320663
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 11:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6E320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdYB1-0007rM-8V
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 07:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdY6v-0001To-Gx
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:51:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jdY6u-0004qU-K1
 for qemu-devel@nongnu.org; Tue, 26 May 2020 07:51:09 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04QBXgwa106903; Tue, 26 May 2020 07:50:37 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 316vqfwghw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 07:50:37 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04QBcADx023836;
 Tue, 26 May 2020 11:50:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma04fra.de.ibm.com with ESMTP id 316uf8abhh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 May 2020 11:50:34 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04QBoWT363897802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 May 2020 11:50:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7E9364C050;
 Tue, 26 May 2020 11:50:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43A7E4C040;
 Tue, 26 May 2020 11:50:32 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Tue, 26 May 2020 11:50:32 +0000 (GMT)
Received: from bahia.ibmuc.com (sig-9-145-63-64.uk.ibm.com [9.145.63.64])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 8E0DA22003E;
 Tue, 26 May 2020 13:50:31 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/5] xen/9pfs: yield when there isn't enough room on the ring
Date: Tue, 26 May 2020 13:49:31 +0200
Message-Id: <20200526114931.391049-5-groug@kaod.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526114931.391049-1-groug@kaod.org>
References: <20200526114931.391049-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-26_02:2020-05-26,
 2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1034 priorityscore=1501
 impostorscore=0 cotscore=-2147483648 mlxscore=0 suspectscore=2
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260087
Received-SPF: softfail client-ip=148.163.156.1; envelope-from=groug@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 07:50:51
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_SOFTFAIL=0.665,
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
Cc: Stefano Stabellini <stefano.stabellini@xilinx.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Stabellini <stefano.stabellini@xilinx.com>

Instead of truncating replies, which is problematic, wait until the
client reads more data and frees bytes on the reply ring.

Do that by calling qemu_coroutine_yield(). The corresponding
qemu_coroutine_enter_if_inactive() is called from xen_9pfs_bh upon
receiving the next notification from the client.

We need to be careful to avoid races in case xen_9pfs_bh and the
coroutine are both active at the same time. In xen_9pfs_bh, wait until
either the critical section is over (ring->co =3D=3D NULL) or until the
coroutine becomes inactive (qemu_coroutine_yield() was called) before
continuing. Then, simply wake up the coroutine if it is inactive.

Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20200521192627.15259-2-sstabellini@kernel.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/xen-9p-backend.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index fc197f6c8aaa..3c84c86ab873 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -37,6 +37,7 @@ typedef struct Xen9pfsRing {
=20
     struct iovec *sg;
     QEMUBH *bh;
+    Coroutine *co;
=20
     /* local copies, so that we can read/write PDU data directly from
      * the ring */
@@ -198,16 +199,20 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *=
pdu,
     g_free(ring->sg);
=20
     ring->sg =3D g_new0(struct iovec, 2);
-    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
+    ring->co =3D qemu_coroutine_self();
+    /* make sure other threads see ring->co changes before continuing */
+    smp_wmb();
=20
+again:
+    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
     buf_size =3D iov_size(ring->sg, num);
     if (buf_size  < size) {
-        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
-                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
-                buf_size);
-        xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
-        xen_9pfs_disconnect(&xen_9pfs->xendev);
+        qemu_coroutine_yield();
+        goto again;
     }
+    ring->co =3D NULL;
+    /* make sure other threads see ring->co changes before continuing */
+    smp_wmb();
=20
     *piov =3D ring->sg;
     *pniov =3D num;
@@ -292,6 +297,20 @@ static int xen_9pfs_receive(Xen9pfsRing *ring)
 static void xen_9pfs_bh(void *opaque)
 {
     Xen9pfsRing *ring =3D opaque;
+    bool wait;
+
+again:
+    wait =3D ring->co !=3D NULL && qemu_coroutine_entered(ring->co);
+    /* paired with the smb_wmb barriers in xen_9pfs_init_in_iov_from_pdu=
 */
+    smp_rmb();
+    if (wait) {
+        cpu_relax();
+        goto again;
+    }
+
+    if (ring->co !=3D NULL) {
+        qemu_coroutine_enter_if_inactive(ring->co);
+    }
     xen_9pfs_receive(ring);
 }
=20
--=20
2.21.3


