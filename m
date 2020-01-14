Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97CEC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A1D24685
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiDeFvbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A1D24685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irLrN-0004Te-Hc
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irLhK-0000UN-7l
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:53:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irLhI-0001PZ-C6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:53:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46270
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irLhI-0001PP-8z
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579006407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OFbuBsfI2hdknoUqcqxf7Pz5nXpd3viWe9nVgMcqFyk=;
 b=CiDeFvbwH08EVz+xotrW1KGItgj2sXKmAOThYIMAXZgzRgSWu2mctg31H/T48tVprq4mlp
 Y0hEt4hHIWyepd08h/6WzP4s6ViS/EGtv9keh6P8VunOMCQHoOs5PzJ62jJnEtnJjcNFzT
 5eYfc9h3BhnhE0GfcRYn8v0zp22rXRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-rtLsel4uMG6elYtC9xo37g-1; Tue, 14 Jan 2020 07:53:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64B2CDBAB;
 Tue, 14 Jan 2020 12:53:23 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2858C5D9E5;
 Tue, 14 Jan 2020 12:53:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/30] migration-test: Add migration multifd test
Date: Tue, 14 Jan 2020 13:52:27 +0100
Message-Id: <20200114125254.4515-4-quintela@redhat.com>
In-Reply-To: <20200114125254.4515-1-quintela@redhat.com>
References: <20200114125254.4515-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: rtLsel4uMG6elYtC9xo37g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Wei Yang <richardw.yang@linux.intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We set multifd-channels.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Wei Yang <richardw.yang@linux.intel.com>
---
 tests/qtest/migration-test.c | 56 ++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 53afec4395..fb70214f44 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1202,6 +1202,61 @@ static void test_migrate_auto_converge(void)
     test_migrate_end(from, to, true);
 }
=20
+static void test_multifd_tcp(void)
+{
+    MigrateStart *args =3D migrate_start_new();
+    QTestState *from, *to;
+    QDict *rsp;
+    char *uri;
+
+    if (test_migrate_start(&from, &to, "defer", args)) {
+        return;
+    }
+
+    /*
+     * We want to pick a speed slow enough that the test completes
+     * quickly, but that it doesn't complete precopy even on a slow
+     * machine, so also set the downtime.
+     */
+    /* 1 ms should make it not converge*/
+    migrate_set_parameter_int(from, "downtime-limit", 1);
+    /* 1GB/s */
+    migrate_set_parameter_int(from, "max-bandwidth", 1000000000);
+
+    migrate_set_parameter_int(from, "multifd-channels", 16);
+    migrate_set_parameter_int(to, "multifd-channels", 16);
+
+    migrate_set_capability(from, "multifd", "true");
+    migrate_set_capability(to, "multifd", "true");
+
+    /* Start incoming migration from the 1st socket */
+    rsp =3D wait_command(to, "{ 'execute': 'migrate-incoming',"
+                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}")=
;
+    qobject_unref(rsp);
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    uri =3D migrate_get_socket_address(to, "socket-address");
+
+    migrate_qmp(from, uri, "{}");
+
+    wait_for_migration_pass(from);
+
+    /* 300ms it should converge */
+    migrate_set_parameter_int(from, "downtime-limit", 300);
+
+    if (!got_stop) {
+        qtest_qmp_eventwait(from, "STOP");
+    }
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+    test_migrate_end(from, to, true);
+    free(uri);
+}
+
 int main(int argc, char **argv)
 {
     char template[] =3D "/tmp/migration-test-XXXXXX";
@@ -1266,6 +1321,7 @@ int main(int argc, char **argv)
                    test_validate_uuid_dst_not_set);
=20
     qtest_add_func("/migration/auto_converge", test_migrate_auto_converge)=
;
+    qtest_add_func("/migration/multifd/tcp", test_multifd_tcp);
=20
     ret =3D g_test_run();
=20
--=20
2.24.1


