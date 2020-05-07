Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2738DC47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB31A206B9
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaUFpH9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB31A206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWk0o-0005bG-6Z
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvB-0005Bl-Rv
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37280
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jWjvA-0001pe-4H
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588870971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxAwV5cCOIjxdHhvGM6F2GiyMmKXmAKAS1MNp/T0hNU=;
 b=WaUFpH9aFK6at1xmAXxqBKKSu/zy5yAY5ToRyG8uX7+GCJLF9X3aqciNUYXUCU5f39EGHE
 0OYKzKkDR6ooV1xausvgiKxlQ8S56WiPTm+BJ+EKuZUwzL2dckfyfdUbq75e8CE0C408Dk
 wmG9Jw+2g2fsmCqJ+IuY827a9qEgLXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-a1alW5jWNZOK-ta_KcX6VA-1; Thu, 07 May 2020 13:02:49 -0400
X-MC-Unique: a1alW5jWNZOK-ta_KcX6VA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9E4D1009619;
 Thu,  7 May 2020 17:02:47 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-224.ams2.redhat.com
 [10.36.114.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F32210013BD;
 Thu,  7 May 2020 17:02:45 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, zhukeqian1@huawei.com,
 maozhongyi@cmss.chinamobile.com, marcandre.lureau@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, wei.w.wang@intel.com,
 yi.y.sun@intel.com, quintela@redhat.com
Subject: [PULL 08/12] migration/ram: Consolidate variable reset after
 placement in ram_load_postcopy()
Date: Thu,  7 May 2020 18:02:07 +0100
Message-Id: <20200507170211.238283-9-dgilbert@redhat.com>
In-Reply-To: <20200507170211.238283-1-dgilbert@redhat.com>
References: <20200507170211.238283-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Let's consolidate resetting the variables.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200421085300.7734-10-david@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Fixup for context conflicts with 91ba442
---
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 52fc032b83..08eb382f53 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3147,7 +3147,7 @@ static int ram_load_postcopy(QEMUFile *f)
     /* Temporary page that is later 'placed' */
     void *postcopy_host_page =3D mis->postcopy_tmp_page;
     void *this_host =3D NULL;
-    bool all_zero =3D false;
+    bool all_zero =3D true;
     int target_pages =3D 0;
=20
     while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
@@ -3174,7 +3174,6 @@ static int ram_load_postcopy(QEMUFile *f)
         addr &=3D TARGET_PAGE_MASK;
=20
         trace_ram_load_postcopy_loop((uint64_t)addr, flags);
-        place_needed =3D false;
         if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
                      RAM_SAVE_FLAG_COMPRESS_PAGE)) {
             block =3D ram_block_from_stream(f, flags);
@@ -3199,9 +3198,7 @@ static int ram_load_postcopy(QEMUFile *f)
              */
             page_buffer =3D postcopy_host_page +
                           ((uintptr_t)host & (block->page_size - 1));
-            /* If all TP are zero then we can optimise the place */
             if (target_pages =3D=3D 1) {
-                all_zero =3D true;
                 this_host =3D (void *)QEMU_ALIGN_DOWN((uintptr_t)host,
                                                     block->page_size);
             } else {
@@ -3221,7 +3218,6 @@ static int ram_load_postcopy(QEMUFile *f)
              */
             if (target_pages =3D=3D (block->page_size / TARGET_PAGE_SIZE))=
 {
                 place_needed =3D true;
-                target_pages =3D 0;
             }
             place_source =3D postcopy_host_page;
         }
@@ -3303,6 +3299,10 @@ static int ram_load_postcopy(QEMUFile *f)
                 ret =3D postcopy_place_page(mis, place_dest,
                                           place_source, block);
             }
+            place_needed =3D false;
+            target_pages =3D 0;
+            /* Assume we have a zero page until we detect something differ=
ent */
+            all_zero =3D true;
         }
     }
=20
--=20
2.26.2


