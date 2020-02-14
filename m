Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D23C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195DC2168B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 14:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="euXkfM4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195DC2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2cMR-0001Uz-AP
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 09:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j2cKn-0007L3-Ha
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j2cKm-0006LT-MX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:52:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49247
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j2cKm-0006KL-HF
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 09:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581691967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Om7Vz7vdo7nYIDuWvYk3cCQ4XjegESe8Yo/pfjvOWp8=;
 b=euXkfM4aRASYXPDWQTa+hbeRV346zwR81QLW4HZheGSrHCkKJZGGY8ujxggH7jHQHq0XP8
 Q+tR5835MbPJn/6JXHtfzycMPXlRQ2WpJaGoF1JBFHiyrH77jf+GCzkGgCew0ubI9JUM62
 RotZqydBckFsuPX0dZf644UI00MN80I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-QGFfMYUoMxWedmB4-LIxrQ-1; Fri, 14 Feb 2020 09:52:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C224A13E5
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 14:52:45 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-117-55.ams2.redhat.com [10.36.117.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E113790D1;
 Fri, 14 Feb 2020 14:52:44 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/4] Acceptance test: EXEC migration
Date: Fri, 14 Feb 2020 16:52:33 +0200
Message-Id: <20200214145235.4378-3-ovoshcha@redhat.com>
In-Reply-To: <20200214145235.4378-1-ovoshcha@redhat.com>
References: <20200214145235.4378-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QGFfMYUoMxWedmB4-LIxrQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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


