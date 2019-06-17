Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342F1C31E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04904208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZAyB0HTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04904208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51028 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwZq-00032M-7h
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58947)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBW-0005em-Ni
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwBR-000249-Vn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwBR-0001tY-Kr
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:16:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI8u8Y066180;
 Mon, 17 Jun 2019 18:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=NigSNlV5R/RXaRrwwYi+FqS0o/n/JBNM0AEzbryJCMU=;
 b=ZAyB0HTRlvRv1wwlshHm4Dajzs1jkWEhTGViIFk//4sxCm3fbAktO8UyXOf22QlAZAWO
 5Y+lp70wG2rzkVXBtQ/nX+9z0niD+EFqI/19j1TStNUWkGDL5Tcp82dMmbMD4fw9atOo
 01mqfcwVaLGRkGDFo3IGb1kseNz9cEXKAUxqTHCHmdsofES7HhFC/vVViWaFFqXc5x5F
 0IUSmAi5ex8HZ21LgBECtEoUiYGQW/iv9R8eTB+XH74IQacsmK+MlKxOfUUejCV7vY3K
 gtboBsjwIKzSQBtUjUKJ5JCwlAnLjvMUGW1XAHVr5SXAwWUmjcOz8qlZrLMwsEbHTVBu sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2t4rmp00mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF5CL050176;
 Mon, 17 Jun 2019 18:16:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2t5h5t9fps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:16:21 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5HIGK2I014940;
 Mon, 17 Jun 2019 18:16:20 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:16:19 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:16:17 -0700
Message-Id: <20190617181617.30002-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 x5HI8u8Y066180
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC PATCH v2 19/35] multi-process: store info about
 the remote process
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, ross.lagerwall@citrix.com,
 liran.alon@oracle.com, stefanha@redhat.com, kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Store info about the remote process in a hash table, so that
it could be used later for QMP/HMP commands.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 Changes in v2:
 - moved the =E2=80=9Cremote_devs=E2=80=9D object from =E2=80=9Cpcms=E2=80=
=9D (PCMachineState)
 to =E2=80=9Cms=E2=80=9D (MachineState).
---
 hw/core/machine.c     | 12 ++++++++++++
 hw/proxy/qemu-proxy.c |  7 +++++++
 include/hw/boards.h   |  4 ++++
 3 files changed, 23 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 743fef2898..0e6e6c0829 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -821,6 +821,14 @@ static void machine_class_base_init(ObjectClass *oc,=
 void *data)
     }
 }
=20
+#ifdef CONFIG_MPQEMU
+static void rem_list_destroy_key(gpointer data)
+{
+    void *key =3D data;
+    g_free(key);
+}
+#endif
+
 static void machine_initfn(Object *obj)
 {
     MachineState *ms =3D MACHINE(obj);
@@ -854,6 +862,10 @@ static void machine_initfn(Object *obj)
                                         NULL);
     }
=20
+#ifdef CONFIG_MPQEMU
+    ms->remote_devs =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+                                            rem_list_destroy_key, NULL);
+#endif
=20
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify =3D machine_init_notify;
diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 6e65600c45..c691a05dac 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -50,6 +50,7 @@
 #include "qemu/event_notifier.h"
 #include "sysemu/kvm.h"
 #include "util/event_notifier-posix.c"
+#include "hw/boards.h"
=20
 /*
  * TODO: kvm_vm_ioctl is only available for per-target objects (NEED_CPU=
_H).
@@ -299,6 +300,12 @@ static void pci_proxy_dev_realize(PCIDevice *device,=
 Error **errp)
     PCIProxyDev *dev =3D PCI_PROXY_DEV(device);
     PCIProxyDevClass *k =3D PCI_PROXY_DEV_GET_CLASS(dev);
     Error *local_err =3D NULL;
+    MachineState *ms =3D MACHINE(current_machine);
+    DeviceState *d =3D DEVICE(dev);
+
+
+    (void)g_hash_table_insert(ms->remote_devs, (gpointer)g_strdup(d->id)=
,
+                              (gpointer)dev);
=20
     if (k->realize) {
         k->realize(dev, &local_err);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index e231860666..bdc519aba9 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -3,6 +3,8 @@
 #ifndef HW_BOARDS_H
 #define HW_BOARDS_H
=20
+#include <gmodule.h>
+
 #include "sysemu/blockdev.h"
 #include "sysemu/accel.h"
 #include "hw/qdev.h"
@@ -274,6 +276,8 @@ struct MachineState {
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
     struct NVDIMMState *nvdimms_state;
+
+    GHashTable *remote_devs;
 };
=20
 #define DEFINE_MACHINE(namestr, machine_initfn) \
--=20
2.17.1


