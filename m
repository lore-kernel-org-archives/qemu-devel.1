Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34D2C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F84D2070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVNpRWDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F84D2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlPW-0001tV-Nd
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwlKp-0002IM-PT
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwlKo-0006cH-OC
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwlKa-0006Z2-Os
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580296584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWLZ/9Drl1Ndf6wNDAF0nVVo0eWBKeNc0DHpOneHn/Q=;
 b=HVNpRWDFcw4opNYO9UmlpmHK7xOCfnDZqkZxrcM0QGHlIczheou8ewO8Xonco9dV9yDDT2
 iCf8+lOF7Epch4JZrdXAsdWpzBdmzpqD/DE+hMJk0d7hbHworZtfMfoA5DRWZohu4EQwhc
 TDLGBQ2/8xAGJLXMQHrPFbRneRWZbo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-OAlGJ1PrMs6I6hA2CLNJjw-1; Wed, 29 Jan 2020 06:16:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4DC518C43C0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 11:16:21 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53C5A89D2E;
 Wed, 29 Jan 2020 11:16:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/18] multifd: Use qemu_target_page_size()
Date: Wed, 29 Jan 2020 12:15:30 +0100
Message-Id: <20200129111536.9497-13-quintela@redhat.com>
In-Reply-To: <20200129111536.9497-1-quintela@redhat.com>
References: <20200129111536.9497-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: OAlGJ1PrMs6I6hA2CLNJjw-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will make it cpu independent.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 152e9cf46d..8f04b5ab3a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -882,14 +882,14 @@ static int multifd_recv_unfill_packet(MultiFDRecvPara=
ms *p, Error **errp)
     for (i =3D 0; i < p->pages->used; i++) {
         uint64_t offset =3D be64_to_cpu(packet->offset[i]);
=20
-        if (offset > (block->used_length - TARGET_PAGE_SIZE)) {
+        if (offset > (block->used_length - qemu_target_page_size())) {
             error_setg(errp, "multifd: offset too long %" PRIu64
                        " (max " RAM_ADDR_FMT ")",
                        offset, block->max_length);
             return -1;
         }
         p->pages->iov[i].iov_base =3D block->host + offset;
-        p->pages->iov[i].iov_len =3D TARGET_PAGE_SIZE;
+        p->pages->iov[i].iov_len =3D qemu_target_page_size();
     }
=20
     return 0;
@@ -964,7 +964,8 @@ static int multifd_send_pages(QEMUFile *f)
     p->packet_num =3D multifd_send_state->packet_num++;
     multifd_send_state->pages =3D p->pages;
     p->pages =3D pages;
-    transferred =3D ((uint64_t) pages->used) * TARGET_PAGE_SIZE + p->packe=
t_len;
+    transferred =3D ((uint64_t) pages->used) * qemu_target_page_size()
+                + p->packet_len;
     qemu_file_update_transfer(f, transferred);
     ram_counters.multifd_bytes +=3D transferred;
     ram_counters.transferred +=3D transferred;;
@@ -985,7 +986,7 @@ static int multifd_queue_page(QEMUFile *f, RAMBlock *bl=
ock, ram_addr_t offset)
     if (pages->block =3D=3D block) {
         pages->offset[pages->used] =3D offset;
         pages->iov[pages->used].iov_base =3D block->host + offset;
-        pages->iov[pages->used].iov_len =3D TARGET_PAGE_SIZE;
+        pages->iov[pages->used].iov_len =3D qemu_target_page_size();
         pages->used++;
=20
         if (pages->used < pages->allocated) {
--=20
2.24.1


