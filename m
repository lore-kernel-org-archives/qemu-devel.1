Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F5C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3A02168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWA+i/CI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3A02168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cNJ-0002PS-Hs
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j2cKn-0007L4-IO
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j2cKm-0006LN-MN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:52:49 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33828
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j2cKm-0006K7-GQ
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581691967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfWc4TFJXnsdb4zCme7AUO/usJxjYQf6jCWKupLwOOg=;
 b=OWA+i/CI88KmeA/9zpF6ImyFwRjZEsruluz5vkvn9kfgfjpJvhdEfajxrKoOptSuAnXh6A
 JnOj1jcWew8LZWQ+ovQvhEXpGwmqXuJaiAsgNU9K1J7wKhDsJ6FT4mav9Mh4vG8BsiNu/o
 fMvf6OK93PsR1VSf9jxCRAkP8F0QRSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-6vRs2Ph1PkeuSRleBDkLPg-1; Fri, 14 Feb 2020 09:52:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47E3A8010D0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 14:52:44 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-117-55.ams2.redhat.com [10.36.117.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C4AE845A0;
 Fri, 14 Feb 2020 14:52:42 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/4] Acceptance test: add address as param
Date: Fri, 14 Feb 2020 16:52:32 +0200
Message-Id: <20200214145235.4378-2-ovoshcha@redhat.com>
In-Reply-To: <20200214145235.4378-1-ovoshcha@redhat.com>
References: <20200214145235.4378-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 6vRs2Ph1PkeuSRleBDkLPg-1
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
Cc: philmd@redhat.com, wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provides param address in _get_free_port()
because by default it takes free port only on the localhost

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


