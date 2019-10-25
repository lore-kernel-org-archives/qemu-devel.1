Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C70CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:53:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CC820679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJxmL8Zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CC820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO01U-0006gh-Bx
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNzvW-0006ZB-Jd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNzvV-0000PM-Fd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNzvV-0000Kg-CK
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572011204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wE9v+oMYoLM+ZHCSTLatnwuohBVoL4LrjAghHeGwKg=;
 b=NJxmL8ZuD3Zb2UmJoDoA9dOJ2Rn24P7UKis2ivQOOCQTNUDSa2YXi5tpLtueSO5LL8W9vr
 nKAHM6pfvgU3AuXwR/AQIBeqwHrSYmZljyHZgPjfi/LBI+tkUoD9s7FZe4f2g/J2myu1rS
 JqfEIU4VpDLFyHMdWThSBZdZFjMa9x4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-5JuSQiLBOWy8FVTxNkupmw-1; Fri, 25 Oct 2019 09:46:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB10E1005500;
 Fri, 25 Oct 2019 13:46:23 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B43B65D70E;
 Fri, 25 Oct 2019 13:46:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/7] blockdev: Use error_report() in hmp_commit()
Date: Fri, 25 Oct 2019 15:46:07 +0200
Message-Id: <20191025134611.25920-4-kwolf@redhat.com>
In-Reply-To: <20191025134611.25920-1-kwolf@redhat.com>
References: <20191025134611.25920-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5JuSQiLBOWy8FVTxNkupmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of using monitor_printf() to report errors, hmp_commit() should
use error_report() like other places do.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 blockdev.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 03c7cd7651..ba491e3ef5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1088,11 +1088,11 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
=20
         blk =3D blk_by_name(device);
         if (!blk) {
-            monitor_printf(mon, "Device '%s' not found\n", device);
+            error_report("Device '%s' not found", device);
             return;
         }
         if (!blk_is_available(blk)) {
-            monitor_printf(mon, "Device '%s' has no medium\n", device);
+            error_report("Device '%s' has no medium", device);
             return;
         }
=20
@@ -1105,8 +1105,7 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
         aio_context_release(aio_context);
     }
     if (ret < 0) {
-        monitor_printf(mon, "'commit' error for '%s': %s\n", device,
-                       strerror(-ret));
+        error_report("'commit' error for '%s': %s", device, strerror(-ret)=
);
     }
 }
=20
--=20
2.20.1


