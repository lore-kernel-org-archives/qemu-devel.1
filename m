Received: from eggs.gnu.org ([2001:4830:134:3::10]:35921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgVpv-0006oX-83
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgVps-0003lS-1S
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:15:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39752
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cgVpr-0003lA-Rc
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:15:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MC9rBs003502
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 07:15:55 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28s6y119h8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 07:15:54 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 22 Feb 2017 12:15:53 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Wed, 22 Feb 2017 13:15:27 +0100
In-Reply-To: <20170222121527.7009-1-cornelia.huck@de.ibm.com>
References: <20170222121527.7009-1-cornelia.huck@de.ibm.com>
Message-Id: <20170222121527.7009-9-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 8/8] s390x/3270: Mark non-migratable and enable
 the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Jing Liu <liujbjl@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Jing Liu <liujbjl@linux.vnet.ibm.com>

Mark 3270 as non-migratable for the experimental stage. Enable
the 3270 device so that we can use x3270 client to operate the guest.

Run qemu with the arguments:
    -chardev socket,id=char3270_0,host=0.0.0.0,port=23,nowait,server,tn3270 \
    -device x-terminal3270,chardev=char3270_0,devno=fe.0.000a,id=terminal3270_0 \

There are some restrictions for the first stage: We don't support SSL
connections, multiple client connections and client resizing. Only
tested with the x3270 client.

Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Signed-off-by: Yang Chen <bjcyang@linux.vnet.ibm.com>
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 default-configs/s390x-softmmu.mak | 1 +
 hw/char/Makefile.objs             | 1 +
 hw/char/terminal3270.c            | 6 ++++++
 3 files changed, 8 insertions(+)

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 36e15de336..9615a48f80 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -2,6 +2,7 @@ CONFIG_PCI=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO=y
 CONFIG_SCLPCONSOLE=y
+CONFIG_TERMINAL3270=y
 CONFIG_S390_FLIC=y
 CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
 CONFIG_WDT_DIAG288=y
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 6ea76feb12..a346820bd3 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -29,3 +29,4 @@ common-obj-$(CONFIG_MILKYMIST) += milkymist-uart.o
 common-obj-$(CONFIG_SCLPCONSOLE) += sclpconsole.o sclpconsole-lm.o
 
 obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o
+obj-$(CONFIG_TERMINAL3270) += terminal3270.o
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 58bcc4be15..b2dda01baa 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -260,12 +260,18 @@ static Property terminal_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const VMStateDescription terminal3270_vmstate = {
+    .name = TYPE_TERMINAL_3270,
+    .unmigratable = 1,
+};
+
 static void terminal_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     EmulatedCcw3270Class *ck = EMULATED_CCW_3270_CLASS(klass);
 
     dc->props = terminal_properties;
+    dc->vmsd = &terminal3270_vmstate;
     ck->init = terminal_init;
     ck->read_payload_3270 = read_payload_3270;
     ck->write_payload_3270 = write_payload_3270;
-- 
2.11.0
