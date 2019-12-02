Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F810C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D51B215E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwEU5MEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D51B215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibigs-0003Mj-SZ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ibifS-0001iJ-JJ
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ibifR-0004wa-Ho
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:10:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53606
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ibifR-0004wK-EP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2Z3+As+UUjZZvK4a3KeXRi6hSKm32Oq0U6w7Ks/Y0U=;
 b=TwEU5MEZ0m7GH3po1qWkqL4c2xf37vZQ8O+JPJ/31ELaUj2lR+KU2WZCMEA8gQwNdounKV
 PD8gxLSiM3RflB6Up73jCiWpcHHwB0c6Ind2vjLlqmZRwlRWedOhOEmg2aup79q4qUDrBP
 l+839AkgcDwOmZFeIXzoVhsAmuWQcS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-AMy0sVu2NX6K8nzevX3hXw-1; Mon, 02 Dec 2019 05:10:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AC3C18B5FA3;
 Mon,  2 Dec 2019 10:10:54 +0000 (UTC)
Received: from thuth.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7D8C19C68;
 Mon,  2 Dec 2019 10:10:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Subject: [PATCH v4 3/6] iotests: Test 183 does not work on macOS and OpenBSD
Date: Mon,  2 Dec 2019 11:10:36 +0100
Message-Id: <20191202101039.8981-4-thuth@redhat.com>
In-Reply-To: <20191202101039.8981-1-thuth@redhat.com>
References: <20191202101039.8981-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: AMy0sVu2NX6K8nzevX3hXw-1
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the long term, we might want to add test 183 to the "auto" group
(but it still fails occasionally, so we cannot do that yet). However,
when running 183 in Cirrus-CI on macOS, or with our vm-build-openbsd
target, it currently always fails with an "Timeout waiting for return
on handle 0" error.

Let's mark it as supported only on systems where the test is working
fine (i.e. Linux, FreeBSD and NetBSD).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/183 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index bced83fae0..0bbae13647 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.qemu
=20
+_supported_os Linux FreeBSD NetBSD
 _supported_fmt qcow2 raw qed quorum
 _supported_proto file
=20
--=20
2.18.1


