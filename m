Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B0CC3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D32E24695
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 09:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzWuH9wP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D32E24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7bxw-0007Zs-B7
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 04:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j7btg-0008EY-DS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j7btf-000465-9J
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j7btf-00045p-4P
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 04:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582881926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JpLkG+7WfjcbZhptBHkg3m0G9Pr99Px+/VdiiAqiGT8=;
 b=DzWuH9wPO8SLfP1fbh3hqmAKotpsMI71gf7JRuPfIrgSpF752bn6wsbbN1q1jva4Y9xruL
 6cISU8taR2Jdoy7uxCpgpZfrujJHFOfgGigRqlnV614Tt1bhmUKoMat9UctaD8aBKjVXLl
 3tmZPnaOiZ8NXJ6MZz27/+OhGRVfMhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-oqMWHx7RMdW5oepGzM8Pog-1; Fri, 28 Feb 2020 04:25:24 -0500
X-MC-Unique: oqMWHx7RMdW5oepGzM8Pog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B0541005514;
 Fri, 28 Feb 2020 09:25:23 +0000 (UTC)
Received: from secure.mitica (ovpn-116-211.ams2.redhat.com [10.36.116.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9734F60BE0;
 Fri, 28 Feb 2020 09:25:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/15] test-vmstate: Fix memleaks in test_load_qlist
Date: Fri, 28 Feb 2020 10:24:15 +0100
Message-Id: <20200228092420.103757-11-quintela@redhat.com>
In-Reply-To: <20200228092420.103757-1-quintela@redhat.com>
References: <20200228092420.103757-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Euler Robot <euler.robot@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

There is memleak in test_load_qlist().It's not a big deal,
but test-vmstate will fail if sanitizers is enabled.

In addition, "ret" is written twice with the same value
 in test_gtree_load_iommu().

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/test-vmstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/test-vmstate.c b/tests/test-vmstate.c
index cea363dd69..f7b3868881 100644
--- a/tests/test-vmstate.c
+++ b/tests/test-vmstate.c
@@ -1241,7 +1241,6 @@ static void test_gtree_load_iommu(void)
     TestGTreeIOMMU *orig_iommu =3D create_iommu();
     QEMUFile *fsave, *fload;
     char eof;
-    int ret;
=20
     fsave =3D open_test_file(true);
     qemu_put_buffer(fsave, iommu_dump, sizeof(iommu_dump));
@@ -1250,10 +1249,8 @@ static void test_gtree_load_iommu(void)
=20
     fload =3D open_test_file(false);
     vmstate_load_state(fload, &vmstate_iommu, dest_iommu, 1);
-    ret =3D qemu_file_get_error(fload);
     eof =3D qemu_get_byte(fload);
-    ret =3D qemu_file_get_error(fload);
-    g_assert(!ret);
+    g_assert(!qemu_file_get_error(fload));
     g_assert_cmpint(orig_iommu->id, =3D=3D, dest_iommu->id);
     g_assert_cmpint(eof, =3D=3D, QEMU_VM_EOF);
=20
@@ -1395,6 +1392,7 @@ static void test_load_qlist(void)
     compare_containers(orig_container, dest_container);
     free_container(orig_container);
     free_container(dest_container);
+    qemu_fclose(fload);
 }
=20
 typedef struct TmpTestStruct {
--=20
2.24.1


