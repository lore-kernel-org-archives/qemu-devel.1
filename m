Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90BCC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927AB2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OusdcLfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927AB2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKP7-0000h5-OJ
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jGKM3-00057B-DE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:30:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jGKM2-0004v8-BF
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:30:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jGKM2-0004uw-74
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584959445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pIAxnqLbBPi8HGVHGPcFX+gvFTpwFK4hEINmy/jM51U=;
 b=OusdcLfJYSl+iQ8mdn0TzOyjFuFIqR0K/S084lkB56dTeq9u0JtwizTdJjo0WxXY0jdQQ8
 geSXqWkn4oCr2Uf74aBOUX9ANz3hRlprW728PJaZTJqBg9XzE2+ahlZv49j9cObcztpxim
 Kt/Upb0MGyUJAUUyF/+3NnKQwnTqFjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-1Znu35v7OWykfv7r6aF_yg-1; Mon, 23 Mar 2020 06:30:44 -0400
X-MC-Unique: 1Znu35v7OWykfv7r6aF_yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88D3D801E78
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:30:43 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-112-254.ams2.redhat.com [10.36.112.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 416C05E240;
 Mon, 23 Mar 2020 10:30:34 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/3] Acceptance test: adds param 'address' in _get_free_port
Date: Mon, 23 Mar 2020 12:30:14 +0200
Message-Id: <20200323103016.17368-2-ovoshcha@redhat.com>
In-Reply-To: <20200323103016.17368-1-ovoshcha@redhat.com>
References: <20200323103016.17368-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: ehabkost@redhat.com, crosa@redhat.com, wainersm@redhat.com,
 wrampazz@redhat.com, ovoshcha@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the migration test function _get_free_port works only for localhost,
but in the case to use migration through an RDMA we need to get a free port
on the configured network RDMA-interface.
This patch is the start for another migration option

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index a8367ca023..e4c39b85a1 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -52,8 +52,8 @@ class Migration(Test):
         source_vm.qmp('migrate', uri=3Dsrc_uri)
         self.assert_migration(source_vm, dest_vm)
=20
-    def _get_free_port(self):
-        port =3D network.find_free_port()
+    def _get_free_port(self, address=3D'localhost'):
+        port =3D network.find_free_port(address=3Daddress)
         if port is None:
             self.cancel('Failed to find a free port')
         return port
--=20
2.21.1


