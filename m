Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A13C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DB92064A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IxTpEU+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DB92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36733 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGO49-0008NC-M9
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:24:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNga-00064O-7E
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNgY-00022c-3s
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hGNgX-00021t-Pf
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GCxTmU055626; Tue, 16 Apr 2019 12:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=/f6Vn0qOWjqIheyoMHr5MtfUPS8Upb1rVgZ3o5Gcs3s=;
	b=IxTpEU+1oXtFTLCfD7pqlb4x7sT+xoRA+0kK62O2EZ84BetkPkosnMK2Gu0w8EKI5QyC
	7w47ffzqdJEDOgSJ7wp/XAqyNXUTk9tXKUNOeq2YtMU4P0NtjaYqiOjii3IGCWOZCQgs
	Cz1IIXVHD8cLkxuzQAFpBwywhaQSA4KsKmdysYV3qzQ9Xb2UAq7/nJi7D0awK6yWJSGg
	qGrpUfj1guRYBF6OL8ICdeMrn1OH9BEiYO9wpZr8/7TpB6O/1uxRkKxxk4+5OPah+ZB5
	UZE/xf7ECOYSa3aiNu3CrB/MX40V6dpB8oH8fDYhnbKrM7uYNCunnQWXZGaGfqpsqZ2/
	9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2rusnetf76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2019 12:59:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GCwAUL185417; Tue, 16 Apr 2019 12:59:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 2rwe79s8ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2019 12:59:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3GCxXGX020497;
	Tue, 16 Apr 2019 12:59:34 GMT
Received: from spark.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 16 Apr 2019 05:59:33 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 15:59:10 +0300
Message-Id: <20190416125912.44001-2-liran.alon@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416125912.44001-1-liran.alon@oracle.com>
References: <20190416125912.44001-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904160088
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9228
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904160088
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
	x3GCxTmU055626
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [PATCH v2 1/3] vhost-scsi: The vhost backend should be
 stopped when the VM is not running
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
Cc: ehabkost@redhat.com, stefanha@gmail.com, mtosatti@redhat.com,
	bijan.mottahedeh@oracle.com, Liran Alon <liran.alon@oracle.com>,
	pbonzini@redhat.com, nir.weiner@oracle.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416125910.Z5pH0C6O37JTmH7yR1XOoNMIS-0XLfojIxGpri654ck@z>

From: Nir Weiner <nir.weiner@oracle.com>

vhost-scsi doesn=E2=80=99t takes into account whether the VM is running o=
r not in
order to decide if it should start/stop vhost backend.
This would lead to vhost backend still being active when VM's RunState
suddenly change to stopped.

An example of when this issue is encountered is when Live-Migration Pre-C=
opy
phase completes. As in this case, VM state will be changed to stopped (wh=
ile
vhost backend is still active), which will result in
virtio_vmstate_change() -> virtio_set_status() -> vhost_scsi_set_status()
executed but vhost_scsi_set_status() will just return without stopping
vhost backend.

To handle this, change code to consider that vhost processing should be
stopped when VM is not running. Similar to how it is done in vhost-vsock
device at vhost_vsock_set_status().

Fixes: 5e9be92d7752 ("vhost-scsi: new device supporting the tcm_vhost Lin=
ux kernel module=E2=80=9D)
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Nir Weiner <nir.weiner@oracle.com>
---
 hw/scsi/vhost-scsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 61e2e57da9d5..ca42cff1b907 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -114,6 +114,10 @@ static void vhost_scsi_set_status(VirtIODevice *vdev=
, uint8_t val)
     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
     bool start =3D (val & VIRTIO_CONFIG_S_DRIVER_OK);
=20
+    if (!vdev->vm_running) {
+        start =3D false;
+    }
+
     if (vsc->dev.started =3D=3D start) {
         return;
     }
--=20
2.20.1


