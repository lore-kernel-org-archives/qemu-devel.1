Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC7C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B23B206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M06L2GAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B23B206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAF5-0004NY-FU
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:32:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAAn-0007SJ-6g
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAAl-000278-9Q
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49609
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUAAk-00025T-Qa
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588256897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KxQX3xylq5gjdmvUawu4jPp33ysfok6lyiGIzU7m13w=;
 b=M06L2GAfspoOFWGq6f0crB7dfJasuViKjW186DTk4ZRr2scp8WqNWRwknaolKUU9zVtokC
 5IG/WlUBpd0/C8wBS7tfos0hDu2Ag0kojiOio1XACCGGtkJX4sXPXFylim0GLdJ00hF+7Y
 xgCQJvJyLz9W8reRg9T+oaDZGw9SU0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-UDaQ3BHJNtW5JTTidsRaHg-1; Thu, 30 Apr 2020 10:28:15 -0400
X-MC-Unique: UDaQ3BHJNtW5JTTidsRaHg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3C7A1054F92;
 Thu, 30 Apr 2020 14:28:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5023860C87;
 Thu, 30 Apr 2020 14:28:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/4] iotests/283: Use consistent size for source and target
Date: Thu, 30 Apr 2020 16:27:52 +0200
Message-Id: <20200430142755.315494-2-kwolf@redhat.com>
In-Reply-To: <20200430142755.315494-1-kwolf@redhat.com>
References: <20200430142755.315494-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test case forgot to specify the null-co size for the target node.
When adding a check to backup that both sizes match, this would fail
because of the size mismatch and not the behaviour that the test really
wanted to test.

Fixes: a541fcc27c98b96da187c7d4573f3270f3ddd283
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/283     | 6 +++++-
 tests/qemu-iotests/283.out | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
index 55b7cff953..44de76effe 100644
--- a/tests/qemu-iotests/283
+++ b/tests/qemu-iotests/283
@@ -72,7 +72,11 @@ to check that crash is fixed :)
 vm =3D iotests.VM()
 vm.launch()
=20
-vm.qmp_log('blockdev-add', **{'node-name': 'target', 'driver': 'null-co'})
+vm.qmp_log('blockdev-add', **{
+    'node-name': 'target',
+    'driver': 'null-co',
+    'size': size,
+})
=20
 vm.qmp_log('blockdev-add', **{
     'node-name': 'source',
diff --git a/tests/qemu-iotests/283.out b/tests/qemu-iotests/283.out
index daaf5828c1..d8cff22cc1 100644
--- a/tests/qemu-iotests/283.out
+++ b/tests/qemu-iotests/283.out
@@ -1,4 +1,4 @@
-{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name"=
: "target"}}
+{"execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name"=
: "target", "size": 1048576}}
 {"return": {}}
 {"execute": "blockdev-add", "arguments": {"driver": "blkdebug", "image": {=
"driver": "null-co", "node-name": "base", "size": 1048576}, "node-name": "s=
ource"}}
 {"return": {}}
--=20
2.25.3


