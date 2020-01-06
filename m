Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2BC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04642075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxpUZBtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04642075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTlw-0003jh-EF
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 09:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTbT-00072s-2b
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTbS-0000ir-0P
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42678
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTbR-0000iM-Rt
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s82BuCk3tx2ruVJGHJbAYGdvIqL16IjCtGpYp+Ky8nE=;
 b=XxpUZBtjqHpZxcvielTynLojgThCzV90ZQVibbT/01wfXXXXLgvVSOXNCSGcdo60jSFyHv
 bUO69OV5Dyow4ahQ9jfgLN/t9dP0iESH+P63si0srYeQeutlTnoGuJrsucK3z+K1RhXMuW
 hBCtDB8Hz70rwmDcpj4YTzM46NYVZCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-mOru9p5NMxq8hfoKkDVW5A-1; Mon, 06 Jan 2020 09:43:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8793941BD;
 Mon,  6 Jan 2020 14:43:27 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65B057DB3E;
 Mon,  6 Jan 2020 14:43:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 24/34] iotests: Make 091 work with data_file
Date: Mon,  6 Jan 2020 15:41:56 +0100
Message-Id: <20200106144206.698920-25-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: mOru9p5NMxq8hfoKkDVW5A-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The image end offset as reported by qemu-img check is different when
using an external data file; we do not care about its value here, so we
can just filter it.  Incidentally, common.rc already has _check_test_img
for us which does exactly that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-id: 20191107163708.833192-18-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/091     | 2 +-
 tests/qemu-iotests/091.out | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index f4b44659ae..0874fa84c8 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -101,7 +101,7 @@ echo "Check image pattern"
 ${QEMU_IO} -c "read -P 0x22 0 4M" "${TEST_IMG}" | _filter_testdir | _filte=
r_qemu_io
=20
 echo "Running 'qemu-img check -r all \$TEST_IMG'"
-"${QEMU_IMG}" check -r all "${TEST_IMG}" 2>&1 | _filter_testdir | _filter_=
qemu
+_check_test_img -r all
=20
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/091.out b/tests/qemu-iotests/091.out
index 5017f8c2d9..5ec7b00f13 100644
--- a/tests/qemu-iotests/091.out
+++ b/tests/qemu-iotests/091.out
@@ -23,6 +23,4 @@ read 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Running 'qemu-img check -r all $TEST_IMG'
 No errors were found on the image.
-80/16384 =3D 0.49% allocated, 0.00% fragmented, 0.00% compressed clusters
-Image end offset: 5570560
 *** done
--=20
2.24.1


