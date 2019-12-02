Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF6C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D80520718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHqXc9Zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D80520718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibiqO-0005Q0-HQ
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ibilJ-0008PQ-6K
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ibilG-0008Ij-SB
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:17:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ibil5-00089J-Kl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06bvpxKQ3N/x7DAPDOf5iIrQAdu/5VBGhG8lLFNcv2g=;
 b=KHqXc9ZqPV9Flr6bKHs0YekXFerluHiz+xczKmPb45fGlfkO7VLaMlGPRz6NZqai/BAh7a
 zBm3DUWeO204PNWuqSjk8vbGozoM8LlWsruQQlIIs4gvCPPZspFnpTRb83DpAH7+PXIw3N
 JGkbSfSx9te5W3FgUdHA7lqAA2SUegE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-k-X7UMKUOLeRt1Qemsk5iw-1; Mon, 02 Dec 2019 05:16:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AD208024C0;
 Mon,  2 Dec 2019 10:16:45 +0000 (UTC)
Received: from thuth.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2423C67649;
 Mon,  2 Dec 2019 10:16:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Subject: [PATCH 3/3] iotests: Skip test 079 if it is not possible to create
 large files
Date: Mon,  2 Dec 2019 11:16:31 +0100
Message-Id: <20191202101631.10003-4-thuth@redhat.com>
In-Reply-To: <20191202101631.10003-1-thuth@redhat.com>
References: <20191202101631.10003-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: k-X7UMKUOLeRt1Qemsk5iw-1
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test 079 fails in the arm64, s390x and ppc64le LXD containers on Travis
(which we will hopefully enable in our CI soon). These containers
apparently do not allow large files to be created. Test 079 tries to
create a 4G sparse file, which is apparently already too big for these
containers, so check first whether we can really create such files before
executing the test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/079 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 81f0c21f53..78536d3bbf 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -39,6 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file nfs
=20
+# Some containers (e.g. non-x86 on Travis) do not allow large files
+_require_large_file 4G
+
 echo "=3D=3D=3D Check option preallocation and cluster_size =3D=3D=3D"
 echo
 cluster_sizes=3D"16384 32768 65536 131072 262144 524288 1048576 2097152 41=
94304"
--=20
2.18.1


