Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EE1C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:52:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9644206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fucafzHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9644206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOnA-00080k-0T
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jOObC-00040R-K8
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jOObA-0005J0-K9
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jOObA-0005Iq-Ge
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586882384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjNE7nreJs0a8yikD36QTMRC5rr9fFbe/9NEabbKFKY=;
 b=fucafzHAlUneH0Fs8aDpEDxKpBl0a3RDq4aa6i1TMrGcxg5jUuJrK8vVU0e2q2hF/sAK2G
 hwvhDnrHH0U7uP8n8ch9OHZHeXVUjgqGvi1iRSQUgHHOBhzYhxWKuNfzN27X3hJr4YpzZC
 R5gLhfRqmE1K8K1bd7pW5xqApxitoX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-PMyLxLVDP0io7HMRUENjWg-1; Tue, 14 Apr 2020 12:39:42 -0400
X-MC-Unique: PMyLxLVDP0io7HMRUENjWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C8E91060DF7
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 16:39:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B94FF60BEC;
 Tue, 14 Apr 2020 16:39:39 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] tests: numa: test one backend with prealloc enabled
Date: Tue, 14 Apr 2020 12:39:36 -0400
Message-Id: <20200414163937.29669-3-pbonzini@redhat.com>
In-Reply-To: <20200414163937.29669-1-pbonzini@redhat.com>
References: <20200414163937.29669-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Cannibalize one backend in the HMAT test to make sure that
prealloc=3Dy is tested.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200325094423.24293-3-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.18.2



