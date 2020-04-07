Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB44C2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:05:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E90EF2075E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VRKmXjFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90EF2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLqix-0006aJ-2Q
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 12:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1jLqas-0004oX-Tm
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1jLqar-0002Ke-NK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:56:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36091
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1jLqar-0002KH-JW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586275013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pIAxnqLbBPi8HGVHGPcFX+gvFTpwFK4hEINmy/jM51U=;
 b=VRKmXjFUr3McsPaVwmTdvr6faGeDnQEV58SiroDA3WU3KO0KBXei3vxidQo3VkYnhqyBJw
 tLoyq9WuxQ8VJCcroRUtGSV05iz3ME9haD3Sy8DX8nRDgIFClp+6lcSSv30rE2LVveaT3F
 g1sZI9RLB88DhWJdS3YpyoCUG3vkoeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-2UmsZt7YOr2JgfZ8BVY1SA-1; Tue, 07 Apr 2020 11:56:51 -0400
X-MC-Unique: 2UmsZt7YOr2JgfZ8BVY1SA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62EB5800D50
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 15:56:50 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-114-200.ams2.redhat.com [10.36.114.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC6BE5DA7B;
 Tue,  7 Apr 2020 15:56:48 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/3] Acceptance test: adds param 'address' in _get_free_port
Date: Tue,  7 Apr 2020 18:56:40 +0300
Message-Id: <20200407155642.10716-2-ovoshcha@redhat.com>
In-Reply-To: <20200407155642.10716-1-ovoshcha@redhat.com>
References: <20200407155642.10716-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: ovoshcha@redhat.com, philmd@redhat.com, wainersm@redhat.com,
 crosa@redhat.com
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


