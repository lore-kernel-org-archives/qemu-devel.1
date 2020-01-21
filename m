Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9181FC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FAF82073A
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 18:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1jVR0gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAF82073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ity3z-0003Ai-G4
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 13:15:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ity0K-0006z0-Ud
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ity0G-0008UE-85
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:11:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ity0G-0008Tz-5I
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 13:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579630311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CIGsrZ4VaZt5pbeKNnw0aEK4DDQHdkCK7XPVS2pt9A0=;
 b=G1jVR0gZYx8ecYosnfCwmqISTkdSQL6FQX/y9PANBV8BHWrsyOXtgeP7s1lweELD1Ll42R
 FpVpM+2CQO2vdWvOMtvHIfV4J7CA0mQ10tZe7DSbHbzm1EnHYtyPcSnXjALARMkfiggKTC
 ede9lSgqThWymdbkbsl/mnUG3zS94kA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-ZJCrabHPMROFIi2GAxx-rw-1; Tue, 21 Jan 2020 13:11:47 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 871D71882CC7;
 Tue, 21 Jan 2020 18:11:46 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEF2460FC1;
 Tue, 21 Jan 2020 18:11:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/4] block: Mark 'block_resize' as coroutine
Date: Tue, 21 Jan 2020 19:11:22 +0100
Message-Id: <20200121181122.15941-5-kwolf@redhat.com>
In-Reply-To: <20200121181122.15941-1-kwolf@redhat.com>
References: <20200121181122.15941-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ZJCrabHPMROFIi2GAxx-rw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, armbru@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block_resize is safe to run in a coroutine, and it does some I/O that
could potentially take quite some time, so use it as an example for the
new 'coroutine': true annotation in the QAPI schema.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ff5e5edaf..1dbb2a9901 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1341,7 +1341,8 @@
 { 'command': 'block_resize',
   'data': { '*device': 'str',
             '*node-name': 'str',
-            'size': 'int' } }
+            'size': 'int' },
+  'coroutine': true }
=20
 ##
 # @NewImageMode:
--=20
2.20.1


