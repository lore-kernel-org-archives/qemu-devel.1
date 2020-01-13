Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8ABC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:40:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACD4207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTYxVP3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACD4207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3hI-0003ot-83
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:40:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ir3e7-0006Ws-T7
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ir3e6-000228-On
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:36:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23324
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ir3e6-00021e-LI
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578937018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n87xPZmTfhj/+IICBXdLr162eK27C7KrFSNvGBgnX6s=;
 b=dTYxVP3z85Sof99waEQhjZzfDdohwVX1KQs4N+MnUvPkllLP44gB5FPGJewpi2qLYX/ewt
 6G5otvCj8t2KypLYBb4qG+W3NzEeaO8W+8MT9Eu7Ic71hytk0EVCPeLl2NvDhAsSlNdiQy
 PMJjzTfb24bFpeuMkwdLqIRmQpYfYJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-JcY69k9SNxy8mydbfhAt0A-1; Mon, 13 Jan 2020 12:36:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF932107ACC5
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 17:36:55 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A85745C1B0;
 Mon, 13 Jan 2020 17:36:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 2/3] memory: Allow a MemoryRegion to be marked no_vhost
Date: Mon, 13 Jan 2020 17:36:46 +0000
Message-Id: <20200113173647.84842-3-dgilbert@redhat.com>
In-Reply-To: <20200113173647.84842-1-dgilbert@redhat.com>
References: <20200113173647.84842-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: JcY69k9SNxy8mydbfhAt0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Allow a memory region to be marked as 'no_vhost' and
exclude that region from vhost's list build.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost.c     |  3 ++-
 include/exec/memory.h | 21 +++++++++++++++++++++
 memory.c              | 15 +++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 774d87d98e..462498bfe6 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -402,7 +402,8 @@ static bool vhost_section(struct vhost_dev *dev, Memory=
RegionSection *section)
     bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr) &
                      ~(1 << DIRTY_MEMORY_MIGRATION);
     result =3D memory_region_is_ram(section->mr) &&
-        !memory_region_is_rom(section->mr);
+             !memory_region_is_rom(section->mr) &&
+             !memory_region_get_no_vhost(section->mr);
=20
     /* Vhost doesn't handle any block which is doing dirty-tracking other
      * than migration; this typically fires on VGA areas.
diff --git a/include/exec/memory.h b/include/exec/memory.h
index aef8123d48..f475c06d63 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -394,6 +394,7 @@ struct MemoryRegion {
     bool ram_device;
     bool enabled;
     bool warning_printed; /* For reservations */
+    bool no_vhost;
     uint8_t vga_logging_count;
     MemoryRegion *alias;
     hwaddr alias_offset;
@@ -1625,6 +1626,26 @@ void memory_region_set_readonly(MemoryRegion *mr, bo=
ol readonly);
  */
 void memory_region_set_nonvolatile(MemoryRegion *mr, bool nonvolatile);
=20
+/**
+ * memory_region_set_no_vhost: Make vhost ignore a memory region
+ *
+ * Makes vhost ignore a memory region, useful if it isn't real
+ * DMAble memory and is at inconvenient addresses
+ *
+ * @mr: the region being updated.
+ * @no_vhost: true to ignore
+ */
+void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost);
+
+/**
+ * memory_region_set_no_vhost: Test if memory region is marked no vhost
+ *
+ * Test if the no_vhost flag is set on the memory region
+ *
+ * @mr: the region being tested.
+ */
+bool memory_region_get_no_vhost(const MemoryRegion *mr);
+
 /**
  * memory_region_rom_device_set_romd: enable/disable ROMD mode
  *
diff --git a/memory.c b/memory.c
index d7b9bb6951..9371998e30 100644
--- a/memory.c
+++ b/memory.c
@@ -2136,6 +2136,21 @@ void memory_region_set_nonvolatile(MemoryRegion *mr,=
 bool nonvolatile)
     }
 }
=20
+void memory_region_set_no_vhost(MemoryRegion *mr, bool no_vhost)
+{
+    if (mr->no_vhost !=3D no_vhost) {
+        memory_region_transaction_begin();
+        mr->no_vhost =3D no_vhost;
+        memory_region_update_pending |=3D mr->enabled;
+        memory_region_transaction_commit();
+    }
+}
+
+bool memory_region_get_no_vhost(const MemoryRegion *mr)
+{
+    return mr->no_vhost;
+}
+
 void memory_region_rom_device_set_romd(MemoryRegion *mr, bool romd_mode)
 {
     if (mr->romd_mode !=3D romd_mode) {
--=20
2.24.1


