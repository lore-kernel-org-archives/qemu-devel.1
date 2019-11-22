Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1385CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:13:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10862071C
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enU9LrE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10862071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYBYJ-0008RR-NH
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:12:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iYBRA-0000Si-OC
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iYBR9-0002v1-9O
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:05:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34450
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iYBR9-0002t4-4A
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574438734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzOCGyGUkB6MqvpabN7+rCH0SE/ivBCj0/o+iivJo0c=;
 b=enU9LrE+9dME1ClHYy3XNRbygYJIERaaFWIRWjl5TMN8StxTBedjkdqiXvcSpMg14fnglH
 95SOVH9BDD7BiHPEh/6qAfKaZM9N6DLzoAdJ4O2xVi42U+79jZ7vsC3ywThvJgg3+F6YBi
 WSFNak4//mTC29enGCfPNSUjCvk05WU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-4jnCmucqPe22hJo8rnc-KQ-1; Fri, 22 Nov 2019 11:05:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 495B7801E74;
 Fri, 22 Nov 2019 16:05:32 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-252.ams2.redhat.com
 [10.36.117.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A0E6E100032E;
 Fri, 22 Nov 2019 16:05:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 6/8] iotests: Fix timeout in run_job()
Date: Fri, 22 Nov 2019 17:05:09 +0100
Message-Id: <20191122160511.8377-7-kwolf@redhat.com>
In-Reply-To: <20191122160511.8377-1-kwolf@redhat.com>
References: <20191122160511.8377-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 4jnCmucqPe22hJo8rnc-KQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

run_job() accepts a wait parameter for a timeout, but it doesn't
actually use it. The only thing that is missing is passing it to
events_wait(), so do that now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index fc78852ae5..0ac3ad4b04 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -609,7 +609,7 @@ class VM(qtest.QEMUQtestMachine):
         ]
         error =3D None
         while True:
-            ev =3D filter_qmp_event(self.events_wait(events))
+            ev =3D filter_qmp_event(self.events_wait(events, timeout=3Dwai=
t))
             if ev['event'] !=3D 'JOB_STATUS_CHANGE':
                 if use_log:
                     log(ev)
--=20
2.20.1


