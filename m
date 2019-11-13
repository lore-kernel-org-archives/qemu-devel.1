Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEDCC17449
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 05:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C9C21783
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 05:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5WAbzPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C9C21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUldr-00073V-4h
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 00:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1iUlcW-00065y-1J
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 00:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1iUlcU-0003j8-5T
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 00:55:11 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1iUlcS-0003hJ-PK
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 00:55:08 -0500
Received: by mail-ot1-x343.google.com with SMTP id f10so629079oto.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 21:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=gjX6wbJl906mJf6rmwn8cAPBMK5AuUdUVm9AY9eb7uY=;
 b=r5WAbzPj6cRT8+d+zf+px4z9nZLOhKqD6xRQkLKryDxGR/WQJHAcjlvUiKsyfaAhRA
 JOAOVOkK2NHMYmvbZgqjDYEFclhyl9VDS9z2TntQ+SfIsafI4XYKIVcHT11GRbPb+gv/
 Wap74mGgkJgH+RUv9Pe7UNRNCRworTxdXi6XUkV66yt2lvbeAQM9FGccK2K54RLjcm+h
 /+yxzYpygSOqyl7x/UUHir9m5yjazgiUAzY8HoMY+tmGX/tYOuJgR69nWx76W6YgRSjH
 uyj/l4IX9+YGvw1mDtjnBod8sEQF9lx7T+T9HFjrftmwJke36B7lfk4cs0XA5fcI+X+5
 ewcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=gjX6wbJl906mJf6rmwn8cAPBMK5AuUdUVm9AY9eb7uY=;
 b=mJsqhGnLMPJcYVWgTVQzs2iEXixHQuudZlpyRDWTWkMbbYHqdfdfz2Nb0b2FUU556r
 bb1id8bcJ/WWTa1oJEGeOrnGL9l/n9RDqgOz8/Yw7EfopZMA9E21BTdfw/eZhvST6uQP
 InrlG45e/2Y66s7XXlHurweVnKm9g8j0Tn64JvMJm572qCv7Ch64+ndlAFKomHvlnIaE
 wFVr4x08J9XeeUBzt0ZndOVImLpIlKWjpn4pd2/+H5nzGIwir0v4opNGUPknXgRLhbjF
 G3M8BYOuKkl2+YKtQFLC21qasoy6l/gddyEyiBQlu8AJ7uiSMpzZbgNlQGc2wJlPhq02
 bYGQ==
X-Gm-Message-State: APjAAAVFWQq56WTi+QsJqJSNNfPGNu79BJH3N8Ozhwbq54qqrdKVj/fo
 eMLwcwEETIomg1RbsooMU8Ec9ng1RW4=
X-Google-Smtp-Source: APXvYqxqRKclTUD4FASZONFVGwvrrsLkhYCem5gPkyLVDkNGp3/CMSFRobTzGzhQ/AN02vSfXfXsuQ==
X-Received: by 2002:a9d:5507:: with SMTP id l7mr1160358oth.146.1573624504571; 
 Tue, 12 Nov 2019 21:55:04 -0800 (PST)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id u204sm390433oig.35.2019.11.12.21.55.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Nov 2019 21:55:03 -0800 (PST)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC] virtio-pci: disable vring processing when bus-mastering
 is disabled
Date: Tue, 12 Nov 2019 23:43:01 -0600
Message-Id: <20191113054301.31529-1-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the SLOF firmware for pseries guests will disable/re-enable
a PCI device multiple times via IO/MEM/MASTER bits of PCI_COMMAND
register after the initial probe/feature negotiation, as it tends to
work with a single device at a time at various stages like probing
and running block/network bootloaders without doing a full reset
in-between.

In QEMU, when PCI_COMMAND_MASTER is disabled we disable the
corresponding IOMMU memory region, so DMA accesses (including to vring
fields like idx/flags) will no longer undergo the necessary
translation. Normally we wouldn't expect this to happen since it would
be misbehavior on the driver side to continue driving DMA requests.

However, in the case of pseries, with iommu_platform=on, we trigger the
following sequence when tearing down the virtio-blk dataplane ioeventfd
in response to the guest unsetting PCI_COMMAND_MASTER:

  #2  0x0000555555922651 in virtqueue_map_desc (vdev=vdev@entry=0x555556dbcfb0, p_num_sg=p_num_sg@entry=0x7fffe657e1a8, addr=addr@entry=0x7fffe657e240, iov=iov@entry=0x7fffe6580240, max_num_sg=max_num_sg@entry=1024, is_write=is_write@entry=false, pa=0, sz=0)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:757
  #3  0x0000555555922a89 in virtqueue_pop (vq=vq@entry=0x555556dc8660, sz=sz@entry=184)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:950
  #4  0x00005555558d3eca in virtio_blk_get_request (vq=0x555556dc8660, s=0x555556dbcfb0)
      at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:255
  #5  0x00005555558d3eca in virtio_blk_handle_vq (s=0x555556dbcfb0, vq=0x555556dc8660)
      at /home/mdroth/w/qemu.git/hw/block/virtio-blk.c:776
  #6  0x000055555591dd66 in virtio_queue_notify_aio_vq (vq=vq@entry=0x555556dc8660)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1550
  #7  0x000055555591ecef in virtio_queue_notify_aio_vq (vq=0x555556dc8660)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:1546
  #8  0x000055555591ecef in virtio_queue_host_notifier_aio_poll (opaque=0x555556dc86c8)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio.c:2527
  #9  0x0000555555d02164 in run_poll_handlers_once (ctx=ctx@entry=0x55555688bfc0, timeout=timeout@entry=0x7fffe65844a8)
      at /home/mdroth/w/qemu.git/util/aio-posix.c:520
  #10 0x0000555555d02d1b in try_poll_mode (timeout=0x7fffe65844a8, ctx=0x55555688bfc0)
      at /home/mdroth/w/qemu.git/util/aio-posix.c:607
  #11 0x0000555555d02d1b in aio_poll (ctx=ctx@entry=0x55555688bfc0, blocking=blocking@entry=true)
      at /home/mdroth/w/qemu.git/util/aio-posix.c:639
  #12 0x0000555555d0004d in aio_wait_bh_oneshot (ctx=0x55555688bfc0, cb=cb@entry=0x5555558d5130 <virtio_blk_data_plane_stop_bh>, opaque=opaque@entry=0x555556de86f0)
      at /home/mdroth/w/qemu.git/util/aio-wait.c:71
  #13 0x00005555558d59bf in virtio_blk_data_plane_stop (vdev=<optimized out>)
      at /home/mdroth/w/qemu.git/hw/block/dataplane/virtio-blk.c:288
  #14 0x0000555555b906a1 in virtio_bus_stop_ioeventfd (bus=bus@entry=0x555556dbcf38)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:245
  #15 0x0000555555b90dbb in virtio_bus_stop_ioeventfd (bus=bus@entry=0x555556dbcf38)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio-bus.c:237
  #16 0x0000555555b92a8e in virtio_pci_stop_ioeventfd (proxy=0x555556db4e40)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:292
  #17 0x0000555555b92a8e in virtio_write_config (pci_dev=0x555556db4e40, address=<optimized out>, val=1048832, len=<optimized out>)
      at /home/mdroth/w/qemu.git/hw/virtio/virtio-pci.c:613

I.e. the calling code is only scheduling a one-shot BH for
virtio_blk_data_plane_stop_bh, but somehow we end up trying to process
an additional virtqueue entry before we get there. This is likely due
to the following check in virtio_queue_host_notifier_aio_poll:

  static bool virtio_queue_host_notifier_aio_poll(void *opaque)
  {
      EventNotifier *n = opaque;
      VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
      bool progress;

      if (!vq->vring.desc || virtio_queue_empty(vq)) {
          return false;
      }

      progress = virtio_queue_notify_aio_vq(vq);

namely the call to virtio_queue_empty(). In this case, since no new
requests have actually been issued, shadow_avail_idx == last_avail_idx,
so we actually try to access the vring via vring_avail_idx() to get
the latest non-shadowed idx:

  int virtio_queue_empty(VirtQueue *vq)
  {
      bool empty;
      ...

      if (vq->shadow_avail_idx != vq->last_avail_idx) {
          return 0;
      }

      rcu_read_lock();
      empty = vring_avail_idx(vq) == vq->last_avail_idx;
      rcu_read_unlock();
      return empty;

but since the IOMMU region has been disabled we get a bogus value (0
usually), which causes virtio_queue_empty() to falsely report that
there are entries to be processed, which causes errors such as:

  "virtio: zero sized buffers are not allowed"

or

  "virtio-blk missing headers"

and puts the device in an error state.

This patch works around the issue by introducing virtio_set_disabled(),
which piggy-backs off the vdev->broken flag we already use to bypass
checks like virtio_queue_empty(), and sets/unsets it in response to
enabling/disabling bus-mastering.

NOTES:

 - It's possible we could also work around this in SLOF by doing a
   full reset instead of relying on PCI_COMMAND to enable/disable, but
   in any case the QEMU behavior seems wrong.
 - This leaves some other oddities in play, like the fact that
   DRIVER_OK also gets unset in response to bus-mastering being
   disabled, but not restored (however the device seems to continue
   working)
 - Similarly, we disable the host notifier via
   virtio_bus_stop_ioeventfd(), which seems to move the handling out
   of virtio-blk dataplane and back into the main IO thread, and it
   ends up staying there till a reset (but otherwise continues working
   normally)

Cc: David Gibson <david@gibson.dropbear.id.au>,
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/virtio/virtio-pci.c     | 12 ++++++++----
 hw/virtio/virtio.c         |  7 ++++++-
 include/hw/virtio/virtio.h |  1 +
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c6b47a9c73..394d409fb9 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -608,10 +608,14 @@ static void virtio_write_config(PCIDevice *pci_dev, uint32_t address,
         pcie_cap_flr_write_config(pci_dev, address, val, len);
     }
 
-    if (range_covers_byte(address, len, PCI_COMMAND) &&
-        !(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
-        virtio_pci_stop_ioeventfd(proxy);
-        virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_DRIVER_OK);
+    if (range_covers_byte(address, len, PCI_COMMAND)) {
+        if (!(pci_dev->config[PCI_COMMAND] & PCI_COMMAND_MASTER)) {
+            virtio_set_disabled(vdev, true);
+            virtio_pci_stop_ioeventfd(proxy);
+            virtio_set_status(vdev, vdev->status & ~VIRTIO_CONFIG_S_DRIVER_OK);
+        } else {
+            virtio_set_disabled(vdev, false);
+        }
     }
 
     if (proxy->config_cap &&
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 527df03bfd..46580c357d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2575,6 +2575,11 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
     vdev->bus_name = g_strdup(bus_name);
 }
 
+void virtio_set_disabled(VirtIODevice *vdev, bool disable)
+{
+    vdev->broken = disable;
+}
+
 void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
 {
     va_list ap;
@@ -2588,7 +2593,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
         virtio_notify_config(vdev);
     }
 
-    vdev->broken = true;
+    virtio_set_disabled(vdev, true);
 }
 
 static void virtio_memory_listener_commit(MemoryListener *listener)
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 48e8d04ff6..921945b7e8 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -168,6 +168,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
                          uint16_t device_id, size_t config_size);
 void virtio_cleanup(VirtIODevice *vdev);
 
+void virtio_set_disabled(VirtIODevice *vdev, bool disable);
 void virtio_error(VirtIODevice *vdev, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
 /* Set the child bus name. */
-- 
2.17.1


