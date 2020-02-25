Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414A3C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C94D21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbn1WtO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C94D21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6a4L-00028v-73
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j6a1T-0005HT-SI
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j6a1S-0001Oh-W6
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:13:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44259
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j6a1S-0001OO-SM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582636394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Om7Vz7vdo7nYIDuWvYk3cCQ4XjegESe8Yo/pfjvOWp8=;
 b=fbn1WtO31+CI07EADPUj+mpIki0+XMDe22VRQOrJM5vcRHZX15ME2paHphFzfJEN2pLlBO
 K1eNB5LV1m9kUbvSJ83UNIIYZtoGTiBTbzsTOxmLhDDu6o4Vg070qhzNfEbbnOe6KzztqG
 kY+7sU2cUYdaU+f8XVx9Z+rXwtpRxyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-BHdD0QR3MBua-zEkk8ONVA-1; Tue, 25 Feb 2020 08:13:13 -0500
X-MC-Unique: BHdD0QR3MBua-zEkk8ONVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 214218017CC
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 13:13:12 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-204-125.brq.redhat.com [10.40.204.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A90AB1BC6D;
 Tue, 25 Feb 2020 13:13:10 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] Acceptance test: EXEC migration
Date: Tue, 25 Feb 2020 15:13:00 +0200
Message-Id: <20200225131302.4792-3-ovoshcha@redhat.com>
In-Reply-To: <20200225131302.4792-1-ovoshcha@redhat.com>
References: <20200225131302.4792-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Improves EXEC migration to run whole test stage

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index e4c39b85a1..8209dcf71d 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -75,3 +75,5 @@ class Migration(Test):
         """
         free_port =3D self._get_free_port()
         dest_uri =3D 'exec:nc -l localhost %u' % free_port
+        src_uri =3D 'exec:nc localhost %u' % free_port
+        self.do_migrate(dest_uri, src_uri)
--=20
2.21.1


