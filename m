Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3152EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED926206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 16:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSkrg9ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED926206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXpm0-0005Ry-5M
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 11:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iXplK-00050m-DW
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:57:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iXplH-0005H2-BJ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:56:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iXplG-0005GZ-Tr
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 11:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574355413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TUP0vKlSa0sJPGP4BX2wb/m5/0kPgPow4N+ntS3ffZI=;
 b=SSkrg9epfnp4v5s57k90916SygnPLI+jKiwzh61ktnMaD22XNawoYOxMT5K85NscmP7rZN
 dNL448nBw/hmnu7HZUydYyDXxYLMYqcGdDZ4zkOh90hAQeid/t29xYbXWoO/7H1jcQ43NZ
 GnWPDvPWxlZ7a+QaaE5aEUV7oF8cSNU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-4XK_YFzKP2W0XcEqryxGhg-1; Thu, 21 Nov 2019 11:56:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BA71107ACC4
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 16:56:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AEE75195B;
 Thu, 21 Nov 2019 16:56:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	peterx@redhat.com
Subject: [PATCH] kvm: Reallocate dirty_bmap when we change a slot
Date: Thu, 21 Nov 2019 16:56:45 +0000
Message-Id: <20191121165645.33483-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4XK_YFzKP2W0XcEqryxGhg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

kvm_set_phys_mem can be called to reallocate a slot by something the
guest does (e.g. writing to PAM and other chipset registers).
This can happen in the middle of a migration, and if we're unlucky
it can now happen between the split 'sync' and 'clear'; the clear
asserts if there's no bmap to clear.   Recreate the bmap whenever
we change the slot, keeping the clear path happy.

Typically this is triggered by the guest rebooting during a migrate.

Corresponds to:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1772774
https://bugzilla.redhat.com/show_bug.cgi?id=3D1771032

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 accel/kvm/kvm-all.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 140b0bd8f6..dd56f61420 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -515,6 +515,27 @@ static int kvm_get_dirty_pages_log_range(MemoryRegionS=
ection *section,
=20
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
=20
+/* Allocate the dirty bitmap for a slot  */
+static void kvm_memslot_init_dirty_bitmap(KVMSlot *mem)
+{
+    /*
+     * XXX bad kernel interface alert
+     * For dirty bitmap, kernel allocates array of size aligned to
+     * bits-per-long.  But for case when the kernel is 64bits and
+     * the userspace is 32bits, userspace can't align to the same
+     * bits-per-long, since sizeof(long) is different between kernel
+     * and user space.  This way, userspace will provide buffer which
+     * may be 4 bytes less than the kernel will use, resulting in
+     * userspace memory corruption (which is not detectable by valgrind
+     * too, in most cases).
+     * So for now, let's align to 64 instead of HOST_LONG_BITS here, in
+     * a hope that sizeof(long) won't become >8 any time soon.
+     */
+    hwaddr bitmap_size =3D ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
+                                        /*HOST_LONG_BITS*/ 64) / 8;
+    mem->dirty_bmap =3D g_malloc0(bitmap_size);
+}
+
 /**
  * kvm_physical_sync_dirty_bitmap - Sync dirty bitmap from kernel space
  *
@@ -547,23 +568,9 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryLis=
tener *kml,
             goto out;
         }
=20
-        /* XXX bad kernel interface alert
-         * For dirty bitmap, kernel allocates array of size aligned to
-         * bits-per-long.  But for case when the kernel is 64bits and
-         * the userspace is 32bits, userspace can't align to the same
-         * bits-per-long, since sizeof(long) is different between kernel
-         * and user space.  This way, userspace will provide buffer which
-         * may be 4 bytes less than the kernel will use, resulting in
-         * userspace memory corruption (which is not detectable by valgrin=
d
-         * too, in most cases).
-         * So for now, let's align to 64 instead of HOST_LONG_BITS here, i=
n
-         * a hope that sizeof(long) won't become >8 any time soon.
-         */
         if (!mem->dirty_bmap) {
-            hwaddr bitmap_size =3D ALIGN(((mem->memory_size) >> TARGET_PAG=
E_BITS),
-                                        /*HOST_LONG_BITS*/ 64) / 8;
             /* Allocate on the first log_sync, once and for all */
-            mem->dirty_bmap =3D g_malloc0(bitmap_size);
+            kvm_memslot_init_dirty_bitmap(mem);
         }
=20
         d.dirty_bitmap =3D mem->dirty_bmap;
@@ -1064,6 +1071,13 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->ram =3D ram;
         mem->flags =3D kvm_mem_flags(mr);
=20
+        if (mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+            /*
+             * Reallocate the bmap; it means it doesn't disappear in
+             * middle of a migrate.
+             */
+            kvm_memslot_init_dirty_bitmap(mem);
+        }
         err =3D kvm_set_user_memory_region(kml, mem, true);
         if (err) {
             fprintf(stderr, "%s: error registering slot: %s\n", __func__,
--=20
2.23.0


