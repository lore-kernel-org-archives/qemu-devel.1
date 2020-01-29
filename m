Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1261FC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE61C20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SoYhqVFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE61C20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlQY-0003dx-V7
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwlKl-00027e-Pf
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwlKk-0006aj-Nk
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwlKW-0006Wu-P4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580296580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODGnHSNVJSUkrrQsMhUmiBKE7p98IabU3841tLj6X7c=;
 b=SoYhqVFd/Idg2Ic2BRRX13wYadUIJY2Wtbcw+O/dZIq4tJP7x8TtXb6l5ByLMza9NUleQC
 f7U7ojAs7lNL2qccJWmiBCjWoV2CI+5Q5h03GQnZ/8BbHzkUGnfFvMp9pBtPedOfnYDqcU
 24FgiZVYEL1W9UHt05tc9bznekdrx4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-MCn5TOF6OlqQkBcxtv8L6g-1; Wed, 29 Jan 2020 06:16:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 147998F70C1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 11:16:18 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 869BC8E9E4;
 Wed, 29 Jan 2020 11:16:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/18] multifd: multifd_queue_page only needs the qemufile
Date: Wed, 29 Jan 2020 12:15:28 +0100
Message-Id: <20200129111536.9497-11-quintela@redhat.com>
In-Reply-To: <20200129111536.9497-1-quintela@redhat.com>
References: <20200129111536.9497-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: MCn5TOF6OlqQkBcxtv8L6g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 602e9ca5a0..ad9cc3e7bd 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -974,7 +974,7 @@ static int multifd_send_pages(QEMUFile *f)
     return 1;
 }
=20
-static int multifd_queue_page(RAMState *rs, RAMBlock *block, ram_addr_t of=
fset)
+static int multifd_queue_page(QEMUFile *f, RAMBlock *block, ram_addr_t off=
set)
 {
     MultiFDPages_t *pages =3D multifd_send_state->pages;
=20
@@ -993,12 +993,12 @@ static int multifd_queue_page(RAMState *rs, RAMBlock =
*block, ram_addr_t offset)
         }
     }
=20
-    if (multifd_send_pages(rs->f) < 0) {
+    if (multifd_send_pages(f) < 0) {
         return -1;
     }
=20
     if (pages->block !=3D block) {
-        return  multifd_queue_page(rs, block, offset);
+        return  multifd_queue_page(f, block, offset);
     }
=20
     return 1;
@@ -2136,7 +2136,7 @@ static int ram_save_page(RAMState *rs, PageSearchStat=
us *pss, bool last_stage)
 static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
                                  ram_addr_t offset)
 {
-    if (multifd_queue_page(rs, block, offset) < 0) {
+    if (multifd_queue_page(rs->f, block, offset) < 0) {
         return -1;
     }
     ram_counters.normal++;
--=20
2.24.1


