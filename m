Received: from eggs.gnu.org ([2001:4830:134:3::10]:34928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dXVwI-0003bQ-Mt
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dXVwD-0000aU-OZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:05:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dXVwD-0000aB-GD
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 13:05:33 -0400
Date: Tue, 18 Jul 2017 13:05:29 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2009859132.54994765.1500397529152.JavaMail.zimbra@redhat.com>
In-Reply-To: <150039615900.87.9924963392732528224@5d477a5b5989>
References: <150039615900.87.9924963392732528224@5d477a5b5989>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build-sys: add --disable-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com



----- Original Message -----
> Hi,
> 
> This series failed build test on FreeBSD host. Please find the details below.
> 
...
>   GEN     trace/generated-helpers.c
>   CC      x86_64-softmmu/trace/control-target.o
>   CC      x86_64-softmmu/gdbstub-xml.o
>   CC      x86_64-softmmu/trace/generated-helpers.o
>   LINK    x86_64-softmmu/qemu-system-x86_64
> hw/scsi/vhost-scsi-common.o: In function `vhost_scsi_common_start':
> /var/tmp/patchew-tester-tmp-rj56yzun/src/hw/scsi/vhost-scsi-common.c:41:
> undefined reference to `vhost_dev_enable_notifiers'
> /var/tmp/patchew-tester-tmp-rj56yzun/src/hw/scsi/vhost-scsi-common.c:53:
> undefined reference to `vhost_dev_start'
> /var/tmp/patchew-tester-tmp-rj56yzun/src/hw/scsi/vhost-scsi-common.c:64:
> undefined reference to `vhost_virtqueue_mask'
> /var/tmp/patchew-tester-tmp-rj56yzun/src/hw/scsi/vhost-scsi-common.c:72:
> undefined reference to `vhost_dev_disable_notifiers'
> hw/scsi/vhost-scsi-common.o: In function `vhost_scsi_common_stop':
> /var/tmp/patchew-tester-tmp-rj56yzun/src/hw/scsi/vhost-scsi-common.c:83:
> undefined reference to `vhost_dev_stop'
> /var/tmp/patchew-tester-tmp-rj56yzun/src/hw/scsi/vhost-scsi-common.c:93:
> undefined reference to `vhost_dev_disable_notifiers'
> hw/scsi/vhost-scsi-common.o: In function `vhost_scsi_common_get_features':
> /var/tmp/patchew-tester-tmp-rj56yzun/src/hw/scsi/vhost-scsi-common.c:101:
> undefined reference to `vhost_get_features'
> hw/scsi/vhost-user-scsi.o: In function `vhost_user_scsi_realize':
> /var/tmp/patchew-tester-tmp-rj56yzun/src/hw/scsi/vhost-user-scsi.c:94:
> undefined reference to `vhost_dev_init'
> hw/scsi/vhost-user-scsi.o: In function `vhost_user_scsi_unrealize':
> /var/tmp/patchew-tester-tmp-rj56yzun/src/hw/scsi/vhost-user-scsi.c:117:
> undefined reference to `vhost_dev_cleanup'
> c++: error: linker command failed with exit code 1 (use -v to see invocation)
> gmake[1]: *** [Makefile:197: qemu-system-x86_64] Error 1
> gmake: *** [Makefile:328: subdir-x86_64-softmmu] Error 2

That should help:

diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 708d7b19ad..5fe530e58d 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -43,4 +43,4 @@ CONFIG_VGA=y
 CONFIG_VGA_PCI=y
 CONFIG_IVSHMEM=$(CONFIG_EVENTFD)
 CONFIG_ROCKER=y
-CONFIG_VHOST_USER_SCSI=$(CONFIG_VHOST_USER)
+CONFIG_VHOST_USER_SCSI=$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))
diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index bb870477f8..51191b77df 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,6 +1,6 @@
 CONFIG_PCI=y
 CONFIG_VIRTIO_PCI=y
-CONFIG_VHOST_USER_SCSI=$(CONFIG_VHOST_USER)
+CONFIG_VHOST_USER_SCSI=$(and $(CONFIG_VHOST_USER),$(CONFIG_LINUX))
 CONFIG_VIRTIO=y
 CONFIG_SCLPCONSOLE=y
 CONFIG_TERMINAL3270=y
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8cc836e9f2..8b0d6b69cd 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2135,7 +2135,7 @@ static const TypeInfo vhost_scsi_pci_info = {
 };
 #endif
 
-#ifdef CONFIG_VHOST_USER_SCSI
+#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
 /* vhost-user-scsi-pci */
 static Property vhost_user_scsi_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
@@ -2665,7 +2665,7 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_VHOST_SCSI
     type_register_static(&vhost_scsi_pci_info);
 #endif
-#ifdef CONFIG_VHOST_USER_SCSI
+#if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
     type_register_static(&vhost_user_scsi_pci_info);
 #endif
 #ifdef CONFIG_VHOST_VSOCK
