Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A55C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4152072E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BKYF5Gu+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4152072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isBip-0001Pu-WF
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 15:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1isBgp-00074L-Ju
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1isBgo-0006cl-GZ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:24:27 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1isBgo-0006cJ-DM
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579206266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Gj+wL32s3lB/zSvJEimeOw3jv9y4l33FtW0ORfO8Fk=;
 b=BKYF5Gu+CiU09NjP+LmIva4GF7cHP/MBDT0k9t7XTTOEQJVljyYbYGZO/RUQpnmBLQou5H
 eaggaICJRnkn0hC4kjCF0FxfuhnPILNZbSsgISVTwO6yD8XwaXntAOKgb3DTHpxMW/JJqc
 W5iLDrLMYsUC1Kw5TRmVj4ROr4LW0Ag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-BqmyV8SyM1urA18hBYKxpw-1; Thu, 16 Jan 2020 15:24:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D984DB20
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 20:24:23 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13C345C1D8;
 Thu, 16 Jan 2020 20:24:21 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com
Subject: [PATCH v3 2/2] vhost: Only align sections for vhost-user
Date: Thu, 16 Jan 2020 20:24:14 +0000
Message-Id: <20200116202414.157959-3-dgilbert@redhat.com>
In-Reply-To: <20200116202414.157959-1-dgilbert@redhat.com>
References: <20200116202414.157959-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: BqmyV8SyM1urA18hBYKxpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

I added hugepage alignment code in c1ece84e7c9 to deal with
vhost-user + postcopy which needs aligned pages when using userfault.
However, on x86 the lower 2MB of address space tends to be shotgun'd
with small fragments around the 512-640k range - e.g. video RAM, and
with HyperV synic pages tend to sit around there - again splitting
it up.  The alignment code complains with a 'Section rounded to ...'
error and gives up.

Since vhost-user already filters out devices without an fd
(see vhost-user.c vhost_user_mem_section_filter) it shouldn't be
affected by those overlaps.

Turn the alignment off on vhost-kernel so that it doesn't try
and align, and thus won't hit the rounding issues.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 774d87d98e..25fd469179 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -547,26 +547,28 @@ static void vhost_region_add_section(struct vhost_dev=
 *dev,
     uintptr_t mrs_host =3D (uintptr_t)memory_region_get_ram_ptr(section->m=
r) +
                          section->offset_within_region;
     RAMBlock *mrs_rb =3D section->mr->ram_block;
-    size_t mrs_page =3D qemu_ram_pagesize(mrs_rb);
=20
     trace_vhost_region_add_section(section->mr->name, mrs_gpa, mrs_size,
                                    mrs_host);
=20
-    /* Round the section to it's page size */
-    /* First align the start down to a page boundary */
-    uint64_t alignage =3D mrs_host & (mrs_page - 1);
-    if (alignage) {
-        mrs_host -=3D alignage;
-        mrs_size +=3D alignage;
-        mrs_gpa  -=3D alignage;
-    }
-    /* Now align the size up to a page boundary */
-    alignage =3D mrs_size & (mrs_page - 1);
-    if (alignage) {
-        mrs_size +=3D mrs_page - alignage;
-    }
-    trace_vhost_region_add_section_aligned(section->mr->name, mrs_gpa, mrs=
_size,
-                                           mrs_host);
+    if (dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER) {  =
=20
+        /* Round the section to it's page size */
+        /* First align the start down to a page boundary */
+        size_t mrs_page =3D qemu_ram_pagesize(mrs_rb);
+        uint64_t alignage =3D mrs_host & (mrs_page - 1);
+        if (alignage) {
+            mrs_host -=3D alignage;
+            mrs_size +=3D alignage;
+            mrs_gpa  -=3D alignage;
+        }
+        /* Now align the size up to a page boundary */
+        alignage =3D mrs_size & (mrs_page - 1);
+        if (alignage) {
+            mrs_size +=3D mrs_page - alignage;
+        }
+        trace_vhost_region_add_section_aligned(section->mr->name, mrs_gpa,=
 mrs_size,
+                                               mrs_host);
+    }
=20
     if (dev->n_tmp_sections) {
         /* Since we already have at least one section, lets see if
--=20
2.24.1


