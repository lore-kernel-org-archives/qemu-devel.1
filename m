Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0495C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 17:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B328C206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 17:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B328C206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyJ7Y-0006pY-Py
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 13:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47506)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIk2-0003AU-WC
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjx-0003Ul-Eq
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIjx-0003UQ-9x
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96329C057EC6;
 Thu, 15 Aug 2019 16:36:40 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DCD4BA79;
 Thu, 15 Aug 2019 16:36:38 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:58 +0100
Message-Id: <20190815163504.18937-28-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 15 Aug 2019 16:36:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 27/33] migration: update ram_counters for
 multifd sync packet
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ivan Ren <ivanren@tencent.com>

Multifd sync will send MULTIFD_FLAG_SYNC flag info to destination, add
these bytes to ram_counters record.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
Suggested-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <1564464816-21804-4-git-send-email-ivanren@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 1179519345..30f13ffbdd 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1085,6 +1085,8 @@ static void multifd_send_sync_main(RAMState *rs)
         p->flags |=3D MULTIFD_FLAG_SYNC;
         p->pending_job++;
         qemu_file_update_transfer(rs->f, p->packet_len);
+        ram_counters.multifd_bytes +=3D p->packet_len;
+        ram_counters.transferred +=3D p->packet_len;
         qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
--=20
2.21.0


