Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C745FC2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9410820659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 13:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqSb/uBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9410820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1sD1-00047Z-Ps
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 08:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j1sBu-00028h-QQ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j1sBt-0006Iz-LM
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23999
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j1sBt-0006Ik-I5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 08:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581514593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IdfiNu1J+bxP7LUX8vZlzAcCWyTkp7FW+pV2K8tYPJY=;
 b=AqSb/uBQnkemTEmGUaSE0cReaVWZ0/nGRrEZa7IKLFtVm8hldXqQYHtMzHrL/wYTQ8RxCP
 uPN9hlRQJZfmBeAImZqG5px1BnkmzcGifTbPX8aRjeghn1zEG3dWu50l4waN5xkrt49buL
 nRGhcAvzBw5VV1N0xLkglo78bArMJWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-lqYbFonrNQ2_lv74tooTxg-1; Wed, 12 Feb 2020 08:36:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7180813E5;
 Wed, 12 Feb 2020 13:36:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-92.ams2.redhat.com [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAE5119C69;
 Wed, 12 Feb 2020 13:36:28 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/16] memory: Add memory_region_max_size() and
 memory_region_is_resizable()
Date: Wed, 12 Feb 2020 14:35:52 +0100
Message-Id: <20200212133601.10555-8-david@redhat.com>
In-Reply-To: <20200212133601.10555-1-david@redhat.com>
References: <20200212133601.10555-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: lqYbFonrNQ2_lv74tooTxg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to pass resizable memory regions to devices that can deal
with them (and autoamtically resize them). Allow them to easily
identify if a region can be resized and what the maximum size is.

Add both functions, adding qemu_ram_is_resizable() as a helper.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/exec/memory.h | 17 +++++++++++++++++
 memory.c              | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9f02bb7830..dfedd88f13 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -395,6 +395,7 @@ struct MemoryRegion {
     void *opaque;
     MemoryRegion *container;
     Int128 size;
+    Int128 max_size;
     hwaddr addr;
     void (*destructor)(MemoryRegion *mr);
     uint64_t align;
@@ -1180,6 +1181,13 @@ struct Object *memory_region_owner(MemoryRegion *mr)=
;
  */
 uint64_t memory_region_size(MemoryRegion *mr);
=20
+/**
+ * memory_region_max_size: get a memory region's maximum size.
+ *
+ * @mr: the memory region being queried.
+ */
+uint64_t memory_region_max_size(MemoryRegion *mr);
+
 /**
  * memory_region_is_ram: check whether a memory region is random access
  *
@@ -1471,6 +1479,15 @@ MemoryRegion *memory_region_from_host(void *ptr, ram=
_addr_t *offset);
  */
 void *memory_region_get_ram_ptr(MemoryRegion *mr);
=20
+/**
+ * memory_region_is_resizable: check whether a memory region resizable
+ *
+ * Returns %true if a memory region is resizable.
+ *
+ * @mr: the memory region being queried
+ */
+bool memory_region_is_resizable(MemoryRegion *mr);
+
 /* memory_region_ram_resize: Resize a RAM region.
  *
  * Only legal before guest might have detected the memory size: e.g. on
diff --git a/memory.c b/memory.c
index cb09a8ee59..5c62702618 100644
--- a/memory.c
+++ b/memory.c
@@ -1130,6 +1130,7 @@ static void memory_region_do_init(MemoryRegion *mr,
     if (size =3D=3D UINT64_MAX) {
         mr->size =3D int128_2_64();
     }
+    mr->max_size =3D mr->size;
     mr->name =3D g_strdup(name);
     mr->owner =3D owner;
     mr->ram_block =3D NULL;
@@ -1540,6 +1541,10 @@ void memory_region_init_resizeable_ram(MemoryRegion =
*mr,
 {
     Error *err =3D NULL;
     memory_region_init(mr, owner, name, size);
+    mr->max_size =3D int128_make64(max_size);
+    if (max_size =3D=3D UINT64_MAX) {
+        mr->max_size =3D int128_2_64();
+    }
     mr->ram =3D true;
     mr->terminates =3D true;
     mr->destructor =3D memory_region_destructor_ram;
@@ -1779,6 +1784,14 @@ uint64_t memory_region_size(MemoryRegion *mr)
     return int128_get64(mr->size);
 }
=20
+uint64_t memory_region_max_size(MemoryRegion *mr)
+{
+    if (int128_eq(mr->max_size, int128_2_64())) {
+        return UINT64_MAX;
+    }
+    return int128_get64(mr->max_size);
+}
+
 const char *memory_region_name(const MemoryRegion *mr)
 {
     if (!mr->name) {
@@ -2198,6 +2211,11 @@ ram_addr_t memory_region_get_ram_addr(MemoryRegion *=
mr)
     return mr->ram_block ? mr->ram_block->offset : RAM_ADDR_INVALID;
 }
=20
+bool memory_region_is_resizable(MemoryRegion *mr)
+{
+    return mr->ram_block && qemu_ram_is_resizable(mr->ram_block);
+}
+
 void memory_region_ram_resize(MemoryRegion *mr, ram_addr_t newsize, Error =
**errp)
 {
     assert(mr->ram_block);
--=20
2.24.1


