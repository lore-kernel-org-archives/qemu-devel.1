Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF342C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4586B218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 15:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbkgTNPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4586B218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihy6H-0002cH-Be
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 10:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihy5Z-00025t-9z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:51:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihy5Y-0007mo-85
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:51:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51517
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihy5Y-0007jg-2J
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 10:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576770703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dXnn+rIOxilmxZsJf7SiCshrmkqx4BM1gh0ESf65bD0=;
 b=PbkgTNPSzlMreNROAuhphkJM3xOtP3U6CIlg0LURZ0Zm83NWnuIlfQdwsCSynZlMueuAUE
 +33c/agAg1z4fKWvM4pgaNbYStoF3KnFi355JuC4tDPEXorujWRJROoyZclcpz/QrJXb2W
 Tnn6Fjhvqy4O5wErngoVThGVSWba1Vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-rCenpN6LMrCl67YFXoqibQ-1; Thu, 19 Dec 2019 10:51:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F2C4184BEFE;
 Thu, 19 Dec 2019 15:51:39 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A72C865F6A;
 Thu, 19 Dec 2019 15:51:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests.py: Wait for postmigrate in wait_migration
Date: Thu, 19 Dec 2019 16:51:37 +0100
Message-Id: <20191219155137.2431986-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: rCenpN6LMrCl67YFXoqibQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Without this patch, I see intermittent failures in the new iotest 280
under high system load.  I have not yet seen such failures with other
iotests that use VM.wait_migration() and query-status afterwards, but
maybe they just occur even more rarely.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 13fd8b5cd2..4da25c88f5 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -674,6 +674,9 @@ class VM(qtest.QEMUQtestMachine):
             log(event, filters=3D[filter_qmp_event])
             if event['data']['status'] =3D=3D 'completed':
                 break
+        # The event may occur in finish-migrate, so wait for postmigrate
+        while self.qmp('query-status')['return']['status'] !=3D 'postmigra=
te':
+            pass
=20
     def node_info(self, node_name):
         nodes =3D self.qmp('query-named-block-nodes')
--=20
2.23.0


