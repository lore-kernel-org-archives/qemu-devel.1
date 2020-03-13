Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365E2C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A151206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hW4LA7Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A151206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jChef-0003x3-89
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 06:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jChaf-0008NB-Ds
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jChae-0005zn-Ao
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25839
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jChae-0005zM-6i
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584095451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoS97/vnReQKjmCvIt3PaY5H5AiaLEfodgcBzzWrux4=;
 b=hW4LA7CzmXcfrXPXnLn7CtuhsYLsrBTWoMiFytM5w9oweT6zePdg0axzqeArUiGeFipM2D
 PYgpzqmg5ew6TxSakg1MfQXqoKGPTivo+j3aPu3vvU533FxhTGLJurtsHIshF5laQPJwPF
 i3JA9HIaV/IfceqXghR4z3cmWAiHt2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-PuSvyBMWMTuTXDdMLxq3dw-1; Fri, 13 Mar 2020 06:30:49 -0400
X-MC-Unique: PuSvyBMWMTuTXDdMLxq3dw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1E061922960;
 Fri, 13 Mar 2020 10:30:48 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-92.ams2.redhat.com
 [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE4608B773;
 Fri, 13 Mar 2020 10:30:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com,
 zhukeqian1@huawei.com, quintela@redhat.com
Subject: [PULL 4/5] ram/colo: only record bitmap of dirty pages in COLO stage
Date: Fri, 13 Mar 2020 10:30:38 +0000
Message-Id: <20200313103039.150133-5-dgilbert@redhat.com>
In-Reply-To: <20200313103039.150133-1-dgilbert@redhat.com>
References: <20200313103039.150133-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

It is only need to record bitmap of dirty pages while goes
into COLO stage.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Message-Id: <20200224065414.36524-6-zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 31f4a9dc09..c12cfdbe26 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2742,7 +2742,7 @@ static inline void *host_from_ram_block_offset(RAMBlo=
ck *block,
 }
=20
 static inline void *colo_cache_from_block_offset(RAMBlock *block,
-                                                 ram_addr_t offset)
+                             ram_addr_t offset, bool record_bitmap)
 {
     if (!offset_in_ramblock(block, offset)) {
         return NULL;
@@ -2758,7 +2758,8 @@ static inline void *colo_cache_from_block_offset(RAMB=
lock *block,
     * It help us to decide which pages in ram cache should be flushed
     * into VM's RAM later.
     */
-    if (!test_and_set_bit(offset >> TARGET_PAGE_BITS, block->bmap)) {
+    if (record_bitmap &&
+        !test_and_set_bit(offset >> TARGET_PAGE_BITS, block->bmap)) {
         ram_state->migration_dirty_pages++;
     }
     return block->colo_cache + offset;
@@ -3416,13 +3417,13 @@ static int ram_load_precopy(QEMUFile *f)
             if (migration_incoming_colo_enabled()) {
                 if (migration_incoming_in_colo_state()) {
                     /* In COLO stage, put all pages into cache temporarily=
 */
-                    host =3D colo_cache_from_block_offset(block, addr);
+                    host =3D colo_cache_from_block_offset(block, addr, tru=
e);
                 } else {
                    /*
                     * In migration stage but before COLO stage,
                     * Put all pages into both cache and SVM's memory.
                     */
-                    host_bak =3D colo_cache_from_block_offset(block, addr)=
;
+                    host_bak =3D colo_cache_from_block_offset(block, addr,=
 false);
                 }
             }
             if (!host) {
--=20
2.24.1


