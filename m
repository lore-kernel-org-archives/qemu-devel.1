Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EBCCA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259ED2084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 10:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZOOvPPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259ED2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVLz-0006Cs-PN
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 06:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iMVKI-0004CW-45
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iMVKG-0001i2-TE
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:54:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33797
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iMVKG-0001hq-Pl
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6xpS5jn3FPueHeHNbHmw7PW4u/jvYS3g/pddsd2v1A=;
 b=OZOOvPPvfY2MCg64lP9J9u860Au97C4wWvTSpxkQb0uLDdGO27ONCNG/ohHVxcBou3cr+G
 3v58crLSw5o5vN2yK7C98YRtlppzcesG3T9wTwLg+QLnFwDwOJ6BDBz7HZ4AxY0I/i86ow
 0UcIf2zSklPuZDw4+gRGU2PvPG6K60k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-4rzQJ8NGPWuxSxYyjnLsuQ-1; Mon, 21 Oct 2019 06:54:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FC1A100551E;
 Mon, 21 Oct 2019 10:54:07 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 454CD60BE2;
 Mon, 21 Oct 2019 10:54:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH v2 2/6] iotests: Test 041 only works on certain systems
Date: Mon, 21 Oct 2019 12:53:46 +0200
Message-Id: <20191021105350.1710-3-thuth@redhat.com>
In-Reply-To: <20191021105350.1710-1-thuth@redhat.com>
References: <20191021105350.1710-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 4rzQJ8NGPWuxSxYyjnLsuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

041 works fine on Linux, FreeBSD, NetBSD and OpenBSD, but fails on macOS.
Let's mark it as only supported on the systems where we know that it is
working fine.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/041 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8568426311..0326888c98 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1123,4 +1123,5 @@ class TestOrphanedSource(iotests.QMPTestCase):
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'],
-                 supported_protocols=3D['file'])
+                 supported_protocols=3D['file'],
+                 supported_platforms=3D['linux', 'freebsd', 'netbsd', 'ope=
nbsd'])
--=20
2.18.1


