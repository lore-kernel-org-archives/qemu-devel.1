Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DCFC282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07A02084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07A02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36080 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvey-0002b7-V2
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:52:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvG1-00030D-Mb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvG0-0002jL-Nl
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEvG0-0002if-Dd; Fri, 12 Apr 2019 08:26:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4C1A309264B;
	Fri, 12 Apr 2019 12:26:11 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DFB85D9CC;
	Fri, 12 Apr 2019 12:26:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Fri, 12 Apr 2019 14:25:19 +0200
Message-Id: <20190412122523.24111-14-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 12 Apr 2019 12:26:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 13/17] s390-bios: Use
 control unit type to determine boot method
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
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122519.BcVkEUX1mTuXBcpuXyRtPtmXT1JW4UQ0YfNsFvVp_Gw@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

The boot method is different depending on which device type we are
booting from. Let's examine the control unit type to determine if we're
a virtio device. We'll eventually add a case to check for a real dasd dev=
ice
here as well.

Since we have to call enable_subchannel() in main now, might as well
remove that call from virtio.c : run_ccw(). This requires adding some
additional enable_subchannel calls to not break calls to
virtio_is_supported().

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-14-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c    | 16 ++++++++++++++--
 pc-bios/s390-ccw/netmain.c |  1 +
 pc-bios/s390-ccw/virtio.c  |  1 -
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index d3a161c685..57a10138c6 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -76,6 +76,7 @@ static bool find_subch(int dev_no)
         /* Skip net devices since no IPLB is created and therefore no
          * network bootloader has been loaded
          */
+        enable_subchannel(blk_schid);
         if (virtio_is_supported(blk_schid) &&
             virtio_get_device_type() =3D=3D VIRTIO_ID_NET && dev_no < 0)=
 {
             continue;
@@ -198,13 +199,24 @@ static void virtio_setup(void)
=20
 int main(void)
 {
+    uint16_t cutype;
+
     sclp_setup();
     css_setup();
     boot_setup();
     find_boot_device();
+    enable_subchannel(blk_schid);
=20
-    virtio_setup();
-    zipl_load(); /* no return */
+    cutype =3D cu_type(blk_schid);
+    switch (cutype) {
+    case CU_TYPE_VIRTIO:
+        virtio_setup();
+        zipl_load(); /* no return */
+        break;
+    default:
+        print_int("Attempting to boot from unexpected device type", cuty=
pe);
+        panic("");
+    }
=20
     panic("Failed to load OS from hard disk\n");
     return 0; /* make compiler happy */
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 5189c0fc39..f3542cb2cf 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -476,6 +476,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
         if (!schib->pmcw.dnv) {
             continue;
         }
+        enable_subchannel(net_schid);
         if (!virtio_is_supported(net_schid)) {
             continue;
         }
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 35278eaee1..fb40ca9828 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -102,7 +102,6 @@ static int run_ccw(VDev *vdev, int cmd, void *ptr, in=
t len, bool sli)
         ccw.flags |=3D CCW_FLAG_SLI;
     }
=20
-    enable_subchannel(vdev->schid);
     return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW=
_FMT1);
 }
=20
--=20
2.21.0


