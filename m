Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6593C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BEF2465A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYzbLCIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BEF2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLki-00047A-2D
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irLi0-0001ay-Ve
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:54:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irLhw-0001Xh-Ak
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:54:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40249
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irLhw-0001XP-7a
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:54:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579006447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BrX1W4PqQfRCqbcGSErGINbVpX+XYhnN1Q3v/xMRPg4=;
 b=bYzbLCIyXH1UC3yJVRF5KE6qHwPjvXZiYpwmZt/rxTGpkjXGHLXpYwwrTGJo0uVYRMqjj9
 v59VIKxi+LOPe2u4joQC+y5j/2DVj6WUCUBvkpjULo5qvE0IDiGmO5yeEFSESE5gav/OOv
 Lgr7VcLU0w26c8Ffm3Qz0hjv1neuYlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-hHF51gW1OHyAWdDl-MgE8Q-1; Tue, 14 Jan 2020 07:54:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95DB5189CD13;
 Tue, 14 Jan 2020 12:54:04 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE94E5D9E5;
 Tue, 14 Jan 2020 12:53:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/30] migration-test: ppc64: fix FORTH test program
Date: Tue, 14 Jan 2020 13:52:30 +0100
Message-Id: <20200114125254.4515-7-quintela@redhat.com>
In-Reply-To: <20200114125254.4515-1-quintela@redhat.com>
References: <20200114125254.4515-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: hHF51gW1OHyAWdDl-MgE8Q-1
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 wei@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

Commit e51e711b1bef has moved the initialization of start_address and
end_address after the definition of the command line argument,
where the nvramrc is initialized, and thus the loop is between 0 and 0
rather than 1 MiB and 100 MiB.

It doesn't affect the result of the test if all the tests are run in
sequence because the two first tests don't run the loop, so the
values are correctly initialized when we actually need them.

But it hangs when we ask to run only one test, for instance:

    QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 \
    tests/migration-test -m=3Dquick -p /ppc64/migration/validate_uuid_error

Fixes: e51e711b1bef ("tests/migration: Add migration-test header file")
Cc: wei@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/qtest/migration-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b0580dd541..26e2e77289 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -517,14 +517,14 @@ static int test_migrate_start(QTestState **from, QTes=
tState **to,
     } else if (strcmp(arch, "ppc64") =3D=3D 0) {
         machine_opts =3D "vsmt=3D8";
         memory_size =3D "256M";
+        start_address =3D PPC_TEST_MEM_START;
+        end_address =3D PPC_TEST_MEM_END;
         arch_source =3D g_strdup_printf("-nodefaults "
                                       "-prom-env 'use-nvramrc?=3Dtrue' -pr=
om-env "
                                       "'nvramrc=3Dhex .\" _\" begin %x %x =
"
                                       "do i c@ 1 + i c! 1000 +loop .\" B\"=
 0 "
                                       "until'", end_address, start_address=
);
         arch_target =3D g_strdup("");
-        start_address =3D PPC_TEST_MEM_START;
-        end_address =3D PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") =3D=3D 0) {
         init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
         machine_opts =3D "virt,gic-version=3Dmax";
--=20
2.24.1


