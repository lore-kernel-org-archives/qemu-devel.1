Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ABDC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8280320717
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxAhqH8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8280320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihdA1-0002ty-Nn
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:30:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihd0s-00006c-7U
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihd0q-0002eG-Vl
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27781
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihd0q-0002aF-IY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576689688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mTCF7sW1w6Y2PZ1xCWcrAxTpx1mo+iIlUacORX0SktM=;
 b=TxAhqH8WmIPeKteGNJ+OqPoZ5RaIaHZ2qS87EzIIo8GHUY5dz6wYyEwggWDLwY7Jnl4JpD
 52PQix8axMYQfsAY+KoDUFncmyjZLo9W3xRflO4QhIky70D8qk4zWxKZ07iDtfXNXGcCrF
 gDWIPYU+QIG5ta+GSvIMteqoQbcg1YM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-zzWUmRjBOs6u1GiwVSbcHQ-1; Wed, 18 Dec 2019 12:21:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B308C18543A1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 17:21:25 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-235.ams2.redhat.com [10.36.116.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA6F21000322;
 Wed, 18 Dec 2019 17:21:24 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/14] monitor/hmp: Explicit we ignore a QEMUChrEvent in
 IOEventHandler
Date: Wed, 18 Dec 2019 18:20:07 +0100
Message-Id: <20191218172009.8868-13-philmd@redhat.com>
In-Reply-To: <20191218172009.8868-1-philmd@redhat.com>
References: <20191218172009.8868-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: zzWUmRjBOs6u1GiwVSbcHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Chardev events are listed in the QEMUChrEvent enum. To be
able to use this enum in the IOEventHandler typedef, we need to
explicit an event ignored by this frontend, to silent the
following GCC warning:

    CC      monitor/hmp.o
  monitor/hmp.c: In function =E2=80=98monitor_event=E2=80=99:
  monitor/hmp.c:1330:5: error: enumeration value =E2=80=98CHR_EVENT_BREAK=
=E2=80=99 not handled in switch [-Werror=3Dswitch]
   1330 |     switch (event) {
        |     ^~~~~~
  cc1: all warnings being treated as errors

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Add all missing values

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
---
 monitor/hmp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 8942e28933..706ebe7074 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1371,6 +1371,10 @@ static void monitor_event(void *opaque, int event)
         mon_refcount--;
         monitor_fdsets_cleanup();
         break;
+
+    case CHR_EVENT_BREAK:
+        /* Ignored */
+        break;
     }
 }
=20
--=20
2.21.0


