Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1DBC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97F742084D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSMGNJuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F742084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX76i-0007l1-Me
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iX6zX-0005Qm-RW
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iX6zV-0004HR-QN
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35635
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iX6zV-0004GH-Lz
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574183316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYkSNofzHAaU5LvfAtRe3RcpQczT+zn51XU0EugCp9E=;
 b=bSMGNJuAjRh15i3JBeYfboX0lxFJhtcibkkkO5/K+fcKvjGtcYAhTCgI6+nHrYkKK+KAjy
 RdTjsF/VE6tjzRwu9bzg60mpHSruZ04fzXcvp9lc4SRpxj6DmTZFxKjwOXWaOu6jL1NHqo
 nwaFlvRv67MBPZWIf/Wa3jijqxqzeZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Hqwbe_-nPxSb-bcxoOt8SA-1; Tue, 19 Nov 2019 12:08:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D895802CD6;
 Tue, 19 Nov 2019 17:08:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52BA55E27A;
 Tue, 19 Nov 2019 17:08:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/6] iotests: Skip test 079 if it is not possible to create
 large files
Date: Tue, 19 Nov 2019 18:08:17 +0100
Message-Id: <20191119170822.45649-3-thuth@redhat.com>
In-Reply-To: <20191119170822.45649-1-thuth@redhat.com>
References: <20191119170822.45649-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Hqwbe_-nPxSb-bcxoOt8SA-1
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test 079 fails in the arm64, s390x and ppc64le LXD containers, which
apparently do not allow large files to be created. Test 079 tries to
create a 4G sparse file, so check first whether we can really create
such files before executing the test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/079 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 81f0c21f53..e9b81419b7 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -39,6 +39,12 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file nfs
=20
+# Some containers (e.g. non-x86 on Travis) do not allow large files
+if ! truncate --size=3D4G "$TEST_IMG"; then
+    _notrun "file system on $TEST_DIR does not support large enough files"
+fi
+rm "$TEST_IMG"
+
 echo "=3D=3D=3D Check option preallocation and cluster_size =3D=3D=3D"
 echo
 cluster_sizes=3D"16384 32768 65536 131072 262144 524288 1048576 2097152 41=
94304"
--=20
2.23.0


