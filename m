Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CCAC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F1F20772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT/DSMub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F1F20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2fl-0003c4-Ma
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jH2aW-0005dJ-JJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jH2aV-0005Nv-Il
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26537)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jH2aV-0005NE-Fk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585129478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ki/dYJkrUgjQUjvX/D1fW1XtB/Q/2tr8F0Jw63mLkjE=;
 b=dT/DSMubZyYfUQWZeauztLgJZoeCo5vzxQx/mmsQ0nsYwSgJaHDvW1jTRGBhuw0kOtWPn9
 28FlVOR0YNMCxAGCNf7zYqGroFHmjyKjWFNfl1mkTACI1eNFjJn75xQcj2dVHDAJboAg3Z
 Jy4iVAFPj0X4qTA9Yfd12sd2DpCni3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-CxzhJLv2O0aHBqC72yLAkQ-1; Wed, 25 Mar 2020 05:44:36 -0400
X-MC-Unique: CxzhJLv2O0aHBqC72yLAkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D197800D4E
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 09:44:35 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA51F8D576;
 Wed, 25 Mar 2020 09:44:31 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 2/2] tests: numa: test one backend with prealloc
 enabled
Date: Wed, 25 Mar 2020 05:44:23 -0400
Message-Id: <20200325094423.24293-3-imammedo@redhat.com>
In-Reply-To: <20200325094423.24293-1-imammedo@redhat.com>
References: <20200325094423.24293-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

canbalize one backend in hmat test to make sure that
prealloc=3Dy is tested

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/numa-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/numa-test.c b/tests/qtest/numa-test.c
index 2f9b7f663a..e1ed6d4322 100644
--- a/tests/qtest/numa-test.c
+++ b/tests/qtest/numa-test.c
@@ -455,7 +455,7 @@ static void pc_hmat_off_cfg(const void *data)
     cli =3D make_cli(data, "-nodefaults --preconfig "
                          "-smp 2,sockets=3D2 "
                          "-m 128M,slots=3D2,maxmem=3D1G "
-                         "-object memory-backend-ram,size=3D64M,id=3Dm0 "
+                         "-object memory-backend-ram,size=3D64M,id=3Dm0,pr=
ealloc=3Dy "
                          "-object memory-backend-ram,size=3D64M,id=3Dm1 "
                          "-numa node,nodeid=3D0,memdev=3Dm0");
     qs =3D qtest_init(cli);
--=20
2.18.1


