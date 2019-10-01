Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF68DC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D14120818
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 00:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D14120818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFSXz-0003js-BR
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 20:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRsD-0001bX-BW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1iFRs9-00024c-FB
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 19:48:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7900
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1iFRs7-0001Qh-3Q; Tue, 01 Oct 2019 19:48:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x91NlP0n122864; Tue, 1 Oct 2019 19:47:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcgk4095m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:32 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x91NlWPS123064;
 Tue, 1 Oct 2019 19:47:32 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vcgk4095f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 19:47:32 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x91NjlOx031629;
 Tue, 1 Oct 2019 23:47:31 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma02wdc.us.ibm.com with ESMTP id 2v9y587fb5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Oct 2019 23:47:31 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x91NlVJu55443880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Oct 2019 23:47:31 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 437AC2805C;
 Tue,  1 Oct 2019 23:47:31 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 284CF28059;
 Tue,  1 Oct 2019 23:47:31 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  1 Oct 2019 23:47:31 +0000 (GMT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 36/97] virtio-pci: fix missing device properties
Date: Tue,  1 Oct 2019 18:45:15 -0500
Message-Id: <20191001234616.7825-37-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
References: <20191001234616.7825-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-01_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010203
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x91NlP0n122864
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Since commit a4ee4c8baa37154 ("virtio: Helper for registering virtio
device types"), virtio-gpu-pci, virtio-vga, and virtio-crypto-pci lost
some properties: "ioeventfd" and "vectors". This may cause various
issues, such as failing migration or invalid properties.

Since those VirtioPCI devices do not have a base name, their class are
initialized with virtio_pci_generic_base_class_init(). However, if the
VirtioPCIDeviceTypeInfo provided a class_init which sets dc->props,
the properties were overwritten by virtio_pci_generic_class_init().

Instead, introduce an intermediary base-type to register the generic
properties.

Fixes: a4ee4c8baa37154f42b4dc6a13fee79268d15238
Cc: qemu-stable@nongnu.org
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190625232333.30752-1-marcandre.lureau@redhat.com>
(cherry picked from commit 683c1d89efd1eeb111c129a9a91f629b94d90d45)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-pci.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index cb44e19b67..497092e83c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1905,13 +1905,6 @@ static void virtio_pci_generic_class_init(ObjectCl=
ass *klass, void *data)
     dc->props =3D virtio_pci_generic_properties;
 }
=20
-/* Used when the generic type and the base type is the same */
-static void virtio_pci_generic_base_class_init(ObjectClass *klass, void =
*data)
-{
-    virtio_pci_base_class_init(klass, data);
-    virtio_pci_generic_class_init(klass, NULL);
-}
-
 static void virtio_pci_transitional_instance_init(Object *obj)
 {
     VirtIOPCIProxy *proxy =3D VIRTIO_PCI(obj);
@@ -1930,14 +1923,13 @@ static void virtio_pci_non_transitional_instance_=
init(Object *obj)
=20
 void virtio_pci_types_register(const VirtioPCIDeviceTypeInfo *t)
 {
+    char *base_name =3D NULL;
     TypeInfo base_type_info =3D {
         .name          =3D t->base_name,
         .parent        =3D t->parent ? t->parent : TYPE_VIRTIO_PCI,
         .instance_size =3D t->instance_size,
         .instance_init =3D t->instance_init,
         .class_size    =3D t->class_size,
-        .class_init    =3D virtio_pci_base_class_init,
-        .class_data    =3D (void *)t,
         .abstract      =3D true,
     };
     TypeInfo generic_type_info =3D {
@@ -1953,13 +1945,20 @@ void virtio_pci_types_register(const VirtioPCIDev=
iceTypeInfo *t)
=20
     if (!base_type_info.name) {
         /* No base type -> register a single generic device type */
-        base_type_info.name =3D t->generic_name;
-        base_type_info.class_init =3D virtio_pci_generic_base_class_init=
;
-        base_type_info.interfaces =3D generic_type_info.interfaces;
-        base_type_info.abstract =3D false;
-        generic_type_info.name =3D NULL;
+        /* use intermediate %s-base-type to add generic device props */
+        base_name =3D g_strdup_printf("%s-base-type", t->generic_name);
+        base_type_info.name =3D base_name;
+        base_type_info.class_init =3D virtio_pci_generic_class_init;
+
+        generic_type_info.parent =3D base_name;
+        generic_type_info.class_init =3D virtio_pci_base_class_init;
+        generic_type_info.class_data =3D (void *)t;
+
         assert(!t->non_transitional_name);
         assert(!t->transitional_name);
+    } else {
+        base_type_info.class_init =3D virtio_pci_base_class_init;
+        base_type_info.class_data =3D (void *)t;
     }
=20
     type_register(&base_type_info);
@@ -1997,6 +1996,7 @@ void virtio_pci_types_register(const VirtioPCIDevic=
eTypeInfo *t)
         };
         type_register(&transitional_type_info);
     }
+    g_free(base_name);
 }
=20
 /* virtio-pci-bus */
--=20
2.17.1


