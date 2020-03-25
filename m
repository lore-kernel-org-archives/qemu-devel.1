Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802F0C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2CB2077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 13:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bssRH1Hh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2CB2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH5wp-0003Ch-B1
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 09:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jH5tt-0006ix-HW
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jH5ts-0006A6-GD
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51828)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jH5ts-000692-Cf
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 09:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585142212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYdtQHSIl4/fYPARd3TKivQvxgloLHQr+oCAfsFFOfo=;
 b=bssRH1HhxDSLq1Lv6NTKr9rLJmOWcXxLzXATahQoB4SD3qtiC6ukOGPvbxrjhxXlp8cdZX
 bdkZS9m7GgbCmwiokFE9AVEZkKGtYvnQzJTdMUsV7VODduAPbazkqKs7WXK3oCGSlqiXLb
 PadRyZbG1U//Asl7mvhXK/DKkBtzvfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-q6B9-KKKPfGQZRzDEJhO2A-1; Wed, 25 Mar 2020 09:16:47 -0400
X-MC-Unique: q6B9-KKKPfGQZRzDEJhO2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C5571005512;
 Wed, 25 Mar 2020 13:16:46 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 275B25C545;
 Wed, 25 Mar 2020 13:16:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, pannengyuan@huawei.com,
 maozhongyi@cmss.chinamobile.com, vsementsov@virtuozzo.com,
 imammedo@redhat.com, philmd@redhat.com
Subject: [PULL 4/9] hmp/vnc: Fix info vnc list leak
Date: Wed, 25 Mar 2020 13:16:27 +0000
Message-Id: <20200325131632.311034-5-dgilbert@redhat.com>
In-Reply-To: <20200325131632.311034-1-dgilbert@redhat.com>
References: <20200325131632.311034-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

We're iterating the list, and then freeing the iteration pointer rather
than the list head.

Fixes: 0a9667ecdb6d ("hmp: Update info vnc")
Reported-by: Coverity (CID 1421932)
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20200323120822.51266-1-dgilbert@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor/hmp-cmds.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 76725c2ace..04ca342c51 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -527,10 +527,11 @@ static void hmp_info_vnc_servers(Monitor *mon, VncSer=
verInfo2List *server)
=20
 void hmp_info_vnc(Monitor *mon, const QDict *qdict)
 {
-    VncInfo2List *info2l;
+    VncInfo2List *info2l, *info2l_head;
     Error *err =3D NULL;
=20
     info2l =3D qmp_query_vnc_servers(&err);
+    info2l_head =3D info2l;
     if (err) {
         hmp_handle_error(mon, err);
         return;
@@ -559,7 +560,7 @@ void hmp_info_vnc(Monitor *mon, const QDict *qdict)
         info2l =3D info2l->next;
     }
=20
-    qapi_free_VncInfo2List(info2l);
+    qapi_free_VncInfo2List(info2l_head);
=20
 }
 #endif
--=20
2.25.1


