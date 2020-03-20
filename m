Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599EEC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C1120777
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 15:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6gvPl3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C1120777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFJO1-000224-BG
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 11:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jFJM0-0008Kn-51
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jFJLz-0003LS-2L
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:14:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27011)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jFJLy-0003LH-Um
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 11:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584717270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e78Faha+fGRRu6Pg3FumfavLuFFT///4ZuzIX6FhHj8=;
 b=A6gvPl3ASMbGEDoPaKQk+vjWhMlvxXycmvxpgcROzjkCc5eRB/73OdNyrLttHdpIdwP6Ax
 4YWYvL3Xitgr4waWKZbQkawhLLDfCA3Dmythj5ayePYdVXmzBjXj7SoWEuIN4CCdHrHCc/
 lBA+XMjoXpiQVYOeZUnwjHwHrsl4wRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-NqiCfprxPICRZ7V4NReK4w-1; Fri, 20 Mar 2020 11:14:28 -0400
X-MC-Unique: NqiCfprxPICRZ7V4NReK4w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93FDA107B797
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 15:13:49 +0000 (UTC)
Received: from kh066.redhat.com (unknown [10.40.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42FCF1001B3F;
 Fri, 20 Mar 2020 15:13:40 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] Acceptance test: provides to use RDMA transport for
 migration test
Date: Fri, 20 Mar 2020 17:12:54 +0200
Message-Id: <20200320151254.16766-4-ovoshcha@redhat.com>
In-Reply-To: <20200320151254.16766-1-ovoshcha@redhat.com>
References: <20200320151254.16766-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: ovoshcha@redhat.com, philmd@redhat.com, ehabkost@redhat.com,
 wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds test for RDMA migration check

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index a783f3915b..c8673114a9 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -105,3 +105,15 @@ class Migration(Test):
         """
         free_port =3D self._get_free_port()
         dest_uri =3D 'exec:nc -l localhost %u' % free_port
+
+    @skipUnless(_if_rdma_enable(None), "Unit rdma.service could not be fou=
nd")
+    @skipUnless(_get_interface_rdma(None), 'RDMA service or interface not =
configured')
+    def test_migration_with_rdma_localhost(self):
+        iface =3D self._get_interface_rdma()
+        ip =3D self._get_ip_rdma(iface)
+        if ip:
+            free_port =3D self._get_free_port(address=3Dip)
+        else:
+            self.cancel("Ip address isn't configured")
+        dest_uri =3D 'rdma:%s:%u' % (ip, free_port)
+        self.do_migrate(dest_uri)
--=20
2.21.1


