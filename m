Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64745C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3023F20718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NP0B381s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3023F20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibis1-00076v-DD
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ibil5-0008Im-LT
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ibil3-00088F-EA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:16:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ibil1-00083s-W8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575281802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fj6HDM3KE3pRtu7dxE+8pWnox8YZTgmkPdDHuXVOU1Q=;
 b=NP0B381seOQ/h42sT04uapf9AxIxShKV44K+wvP5s0YCQk92MASLPgSgNtAle9kp35Api1
 OyEyxQ6/xUh18iYMLBODzitk6tiNy43H74feYkYU0PcLm5RoD/4OxU3gM2n0p+WY9rsIDa
 wk7U5oESw53sdqZ+4CTVBPMHGJytEdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-IFbAkq8oNH-cIId9Sn2u8w-1; Mon, 02 Dec 2019 05:16:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBF1219029EE;
 Mon,  2 Dec 2019 10:16:38 +0000 (UTC)
Received: from thuth.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76CA467E56;
 Mon,  2 Dec 2019 10:16:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Subject: [PATCH 2/3] iotests: Skip test 060 if it is not possible to create
 large files
Date: Mon,  2 Dec 2019 11:16:30 +0100
Message-Id: <20191202101631.10003-3-thuth@redhat.com>
In-Reply-To: <20191202101631.10003-1-thuth@redhat.com>
References: <20191202101631.10003-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: IFbAkq8oNH-cIId9Sn2u8w-1
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test 060 fails in the arm64, s390x and ppc64le LXD containers on Travis
(which we will hopefully enable in our CI soon). These containers
apparently do not allow large files to be created. The repair process
in test 060 creates a file of 64 GiB, so test first whether such large
files are possible and skip the test if that's not the case.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/060 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index b91d8321bb..d96f17a484 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -49,6 +49,9 @@ _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
=20
+# The repair process will create a large file - so check for availability =
first
+_require_large_file 64G
+
 rt_offset=3D65536  # 0x10000 (XXX: just an assumption)
 rb_offset=3D131072 # 0x20000 (XXX: just an assumption)
 l1_offset=3D196608 # 0x30000 (XXX: just an assumption)
--=20
2.18.1


