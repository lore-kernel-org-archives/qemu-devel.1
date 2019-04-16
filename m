Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B109EC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAEC2077C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 13:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S14w4/N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAEC2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36693 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGO2p-0007JO-Ni
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 09:22:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNgb-00065O-B4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNga-00024K-Ce
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hGNga-00023G-1f
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GCxWxE038905; Tue, 16 Apr 2019 12:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=from : to : cc :
	subject : date : message-id : in-reply-to : references : mime-version :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=+iZ36eJcL1K2wKNm+8unx5+IkEBFjcTbyMt7Zw3EHHM=;
	b=S14w4/N8yZtaSScb2hX6q7ZzHJYODIhDIAjvB6Z+m5Y78qMr5l+NK/KM5dd0sf2+pJ5r
	fxkGhiJtCRtN9b0W/vTeRDhiUAgvFoaElu1nBPjCvi05uz+EAGkPosSEh8Z8Vs3SlcHV
	W1gmvcxpAyrin5Yq81UDnLuLy3xSF1QzvhZoIP1EzVIf3yIEOrPOq2eydi7zGjPBzMtB
	Q80iAPfDLMcLToAX1UrsfN19wubVzKrNO7u39NxhdBdbwvhyWhrW3wV63TJDCrOw8ikX
	iXzyMsqeTl0CCdododEZib695mFLP57E6iYSx0ssgvRgpCT4h5ZJceS74jFisMmMadvE
	8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2rvwk3mk3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2019 12:59:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x3GCw9qu185364; Tue, 16 Apr 2019 12:59:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 2rwe79s8b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2019 12:59:37 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3GCxapL007010;
	Tue, 16 Apr 2019 12:59:36 GMT
Received: from spark.ravello.local (/213.57.127.2)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 16 Apr 2019 05:59:35 -0700
From: Liran Alon <liran.alon@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Apr 2019 15:59:11 +0300
Message-Id: <20190416125912.44001-3-liran.alon@oracle.com>
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
	suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904160088
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2130.oracle.com id
	x3GCxWxE038905
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [PATCH v2 2/3] vhost-scsi: Add VMState descriptor
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
Message-ID: <20190416125911.gX9-CkfbJXFWq0577A7K4y_P8beuzlI_N4BXlFwSAs4@z>

From: Nir Weiner <nir.weiner@oracle.com>

As preparation of enabling migration of vhost-scsi device,
define it=E2=80=99s VMState. Note, we keep the convention of
verifying in the pre_save() method that the vhost backend
must be stopped before attempting to save the device
state. Similar to how it is done for vhost-vsock.

Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Nir Weiner <nir.weiner@oracle.com>
---
 hw/scsi/vhost-scsi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index ca42cff1b907..eb0cf9e1312f 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -139,6 +139,28 @@ static void vhost_dummy_handle_output(VirtIODevice *=
vdev, VirtQueue *vq)
 {
 }
=20
+static int vhost_scsi_pre_save(void *opaque)
+{
+    VHostSCSICommon *vsc =3D opaque;
+
+    /* At this point, backend must be stopped, otherwise
+     * it might keep writing to memory. */
+    assert(!vsc->dev.started);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_virtio_vhost_scsi =3D {
+    .name =3D "virtio-vhost_scsi",
+    .minimum_version_id =3D 1,
+    .version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+    .pre_save =3D vhost_scsi_pre_save,
+};
+
 static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
@@ -256,6 +278,7 @@ static void vhost_scsi_class_init(ObjectClass *klass,=
 void *data)
     FWPathProviderClass *fwc =3D FW_PATH_PROVIDER_CLASS(klass);
=20
     dc->props =3D vhost_scsi_properties;
+    dc->vmsd =3D &vmstate_virtio_vhost_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize =3D vhost_scsi_realize;
     vdc->unrealize =3D vhost_scsi_unrealize;
--=20
2.20.1


