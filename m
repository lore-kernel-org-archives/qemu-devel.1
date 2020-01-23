Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7875EC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C10217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4QqMYge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C10217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWrk-00060H-80
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWds-0006hB-1H
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdq-00006f-Sm
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34075
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdq-00005x-PP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUTzXG5c0P/cfpSyLzCfAtskYDWEcm5+URpIdvpUQzQ=;
 b=Y4QqMYgemMU0WV0KX4L4mfgcDyobmD4TtMOzV/7bx5yNu491fsDn7TS9moFEuRfnJoGKUF
 C7sXaDqXl8G1vbIOcXHl58SRpwfppPqSzJMsCxUXKosJwyxCJGZwiGopBD/qszZtu1/O3o
 6DpLlD5pe2JU0kiJiLQ7vC8iBr0RgP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-2Dm5adrUOZ6qLLKclhud7A-1; Thu, 23 Jan 2020 02:11:00 -0500
Received: by mail-wm1-f69.google.com with SMTP id s25so246616wmj.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=miOqrXp0EkoFa9QINKw9BvmGX6vXumq1+xiaY2GCJjQ=;
 b=bkowB6E1/uScpM1SHCVUV91afcCRM8puy5EtmxSxvmnAaNxCptJ8yRg89beQ58Sw8z
 dqHpmnCYJMBxtwYEc9kaALbQs2GorrcRWKjH4vLCWgtZ4uqeNvbhvN0E+ZnbL/3mdl2a
 35w5dXrMl8ZdLMw0fd143Zdsllvc+gEj0c5MhA4Zk6+5msk5N88isSdkYyYC1NmoBJBd
 XHzveI+nPlHAOzr+PO58C/G/D+zUMls1PA5MpVXU0EqYL/GTs7T4xyfFDoFy6IiubxP7
 3fdmQLPQywHPsmQEEURYoM2sEeCPBpWULTO1H21osCxsdmfSAEq9VBeZ0GjtXVSpclAr
 NoWQ==
X-Gm-Message-State: APjAAAX6Rbs6c8jMOAY/zGY5IBnBTsxGD2WD8Rp/eZXzbx3mi4ZkAnqu
 dl8qDMK4J4pkeh912TBDOpmZ8bDwugst2h/yZ8PezdUvT8/hteijOB9bI1MHVZrpzjDxA6UANh6
 FTOMCDUeDGOhrl74=
X-Received: by 2002:a1c:b603:: with SMTP id g3mr2568056wmf.133.1579763458964; 
 Wed, 22 Jan 2020 23:10:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqzicJq7F0guYantwv0HY45kVW/mwOgBX4YnxA5Zp098qEtSFopNkz+xKlTploPpYuGBdfw87Q==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr2568035wmf.133.1579763458749; 
 Wed, 22 Jan 2020 23:10:58 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 p5sm1781767wrt.79.2020.01.22.23.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:58 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 16/18] vhost: Only align sections for vhost-user
Message-ID: <20200123070913.626488-17-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 2Dm5adrUOZ6qLLKclhud7A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
Message-Id: <20200116202414.157959-3-dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/vhost.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

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
     }
-    /* Now align the size up to a page boundary */
-    alignage =3D mrs_size & (mrs_page - 1);
-    if (alignage) {
-        mrs_size +=3D mrs_page - alignage;
-    }
-    trace_vhost_region_add_section_aligned(section->mr->name, mrs_gpa, mrs=
_size,
-                                           mrs_host);
=20
     if (dev->n_tmp_sections) {
         /* Since we already have at least one section, lets see if
--=20
MST


