Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B70C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF2A23741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axxWIf89"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF2A23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLU5f-0004s7-9y
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTlB-0003PY-8Y
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTl1-00046t-RK
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600963567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AH8IYQbb3ay9Cjv/MkGhbM86WcU24pssD37+05te6Zg=;
 b=axxWIf89I2Z2dPI+ZoAtfNdjckBFPfHntBJdqVI2Oio+D+KeNcIQi/0wV5R80E+++3/Bw5
 m9tKkDHpXog+/tm/wjGMopGJJ2JU5V6Zy7Ekk31u3QKIYUeUnpcfnuOB1B9ERW7s6iqqEu
 cPyFgb2c5UlI5eAfxb0UBifNrGSG3ok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-ydXYsntHOt-q1VhWHPH5Kw-1; Thu, 24 Sep 2020 12:06:00 -0400
X-MC-Unique: ydXYsntHOt-q1VhWHPH5Kw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C7DB801E53;
 Thu, 24 Sep 2020 16:05:59 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-4.ams2.redhat.com [10.36.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70EF61A4D7;
 Thu, 24 Sep 2020 16:05:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH PROTOTYPE 6/6] vfio: Disable only
 RAM_BLOCK_DISCARD_T_UNCOORDINATED discards
Date: Thu, 24 Sep 2020 18:04:23 +0200
Message-Id: <20200924160423.106747-7-david@redhat.com>
In-Reply-To: <20200924160423.106747-1-david@redhat.com>
References: <20200924160423.106747-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This unlocks virtio-mem with vfio. A virtio-mem device properly notifies
about all accessible/mapped blocks inside a managed memory region -
whenever blocks become accessible and whenever blocks become inaccessible.

Note: The block size of a virtio-mem device has to be set to sane sizes,
depending on the maximum hotplug size - to not run out of vfio mappings.
The default virtio-mem block size is usually in the range of a couple of
MBs. Linux kernels (x86-64) don't support block sizes > 128MB
with an initial memory size of < 64 MB - and above that only in some
cases 2GB. The larger the blocks, the less likely that a lot of
memory can get unplugged again. The smaller the blocks, the slower
memory hot(un)plug will be.

Assume you want to hotplug 256GB - the block size would have to be at
least 8 MB (resulting in 32768 distinct mappings).

It's expected that the block size will be comparatively large when
virtio-mem is used with vfio in the future (e.g., 128MB, 1G, 2G) -
something Linux guests will have to be optimized for.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/vfio/common.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a3aaf70dd8..4d82296967 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1392,8 +1392,12 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
      * new memory, it will not yet set ram_block_discard_set_required() and
      * therefore, neither stops us here or deals with the sudden memory
      * consumption of inflated memory.
+     *
+     * We do support discarding for memory regions where accessible pieces
+     * are coordinated via the SparseRAMNotifier.
      */
-    ret = ram_block_discard_disable(true);
+    ret = ram_block_discard_type_disable(RAM_BLOCK_DISCARD_T_UNCOORDINATED,
+                                         true);
     if (ret) {
         error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
         return ret;
@@ -1564,7 +1568,7 @@ close_fd_exit:
     close(fd);
 
 put_space_exit:
-    ram_block_discard_disable(false);
+    ram_block_discard_type_disable(RAM_BLOCK_DISCARD_T_UNCOORDINATED, false);
     vfio_put_address_space(space);
 
     return ret;
@@ -1686,7 +1690,8 @@ void vfio_put_group(VFIOGroup *group)
     }
 
     if (!group->ram_block_discard_allowed) {
-        ram_block_discard_disable(false);
+        ram_block_discard_type_disable(RAM_BLOCK_DISCARD_T_UNCOORDINATED,
+                                       false);
     }
     vfio_kvm_device_del_group(group);
     vfio_disconnect_container(group);
@@ -1740,7 +1745,8 @@ int vfio_get_device(VFIOGroup *group, const char *name,
 
         if (!group->ram_block_discard_allowed) {
             group->ram_block_discard_allowed = true;
-            ram_block_discard_disable(false);
+            ram_block_discard_type_disable(RAM_BLOCK_DISCARD_T_UNCOORDINATED,
+                                           false);
         }
     }
 
-- 
2.26.2


