Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01B4C2D0D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8046F227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOd5nQFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8046F227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzZp-0008ML-Az
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzXk-000677-De
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzXj-0005bz-44
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzXi-0005Z7-SO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LzbbgxIoL1hfzmiAQvdOupOmZIWsJahvvA0A3jOjjeU=;
 b=BOd5nQFpswhbuIzoeqd37MBFFLT+SVPX1mvg4qvJpXQ9jdnTVSnkbx+6LaowEPCT0og2f+
 bE/JrjPeAI2ehC36gc89n8jDARGCVA7aJaWLfcE4y+Ila3Cbwd5lq2qQPV3B61m+0m9MSe
 fcVjK5VC65/knYen/jU9J9PqHCTheKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-hgS6ckNhPIigxS9syKAojA-1; Thu, 19 Dec 2019 12:24:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C045107ACC4;
 Thu, 19 Dec 2019 17:24:51 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92F315C7DD;
 Thu, 19 Dec 2019 17:24:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/30] iotests: Skip test 079 if it is not possible to create
 large files
Date: Thu, 19 Dec 2019 18:24:14 +0100
Message-Id: <20191219172441.7289-4-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: hgS6ckNhPIigxS9syKAojA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Test 079 fails in the arm64, s390x and ppc64le LXD containers on Travis
(which we will hopefully enable in our CI soon). These containers
apparently do not allow large files to be created. Test 079 tries to
create a 4G sparse file, which is apparently already too big for these
containers, so check first whether we can really create such files before
executing the test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.20.1


