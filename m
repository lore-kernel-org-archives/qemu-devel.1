Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A601EC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DF2E2077D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIc0S3QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF2E2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKO3-0007Ni-IA
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jGKMZ-0005gc-S2
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jGKMY-00056U-Rx
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:31:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:37969)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jGKMY-000560-0g
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584959477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsUqspxV7iULdvqiU0mwGq7ybsqS4r5KorXBBo44fJY=;
 b=iIc0S3QV7OozjdZ77ujYJ+ZX7VacPzR6dpkYTXMMPw76RAUNHHVqZdgRTBttV1pZTNBS9k
 jgITZXpAhhBAxWUMLnoX0xpDJmnpj/SmHOb4OLYflyAheL5qjYfttRJgpTBVf78bd4vb9u
 9y5u7PLkOS6eqe/67rn4qNJ0/qV9d5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-gsO459kiOUWf65KUMI3g5A-1; Mon, 23 Mar 2020 06:31:16 -0400
X-MC-Unique: gsO459kiOUWf65KUMI3g5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E3668010FF
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:31:11 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-112-254.ams2.redhat.com [10.36.112.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E343C5DC18;
 Mon, 23 Mar 2020 10:30:59 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/3] Acceptance test: provides to use RDMA transport for
 migration test
Date: Mon, 23 Mar 2020 12:30:16 +0200
Message-Id: <20200323103016.17368-4-ovoshcha@redhat.com>
In-Reply-To: <20200323103016.17368-1-ovoshcha@redhat.com>
References: <20200323103016.17368-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
Cc: ehabkost@redhat.com, crosa@redhat.com, wainersm@redhat.com,
 wrampazz@redhat.com, ovoshcha@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds test for RDMA migration check

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index 59144f18fd..c96da1dd4b 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -107,3 +107,15 @@ class Migration(Test):
         """
         free_port =3D self._get_free_port()
         dest_uri =3D 'exec:nc -l localhost %u' % free_port
+
+    @skipUnless(_if_rdma_enable(), 'Unit rdma.service could not be found')
+    @skipUnless(_get_interface_rdma(), 'RDMA service or interface not conf=
igured')
+    def test_migration_with_rdma_localhost(self):
+        iface =3D _get_interface_rdma()
+        ip =3D _get_ip_rdma(iface)
+        if ip:
+            free_port =3D self._get_free_port(address=3Dip)
+        else:
+            self.cancel("Ip address doesn't configured properly on interfa=
ce:%s" % iface)
+        dest_uri =3D 'rdma:%s:%u' % (ip, free_port)
+        self.do_migrate(dest_uri)
--=20
2.21.1


