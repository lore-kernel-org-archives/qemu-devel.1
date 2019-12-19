Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EECDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9D32465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6ycmLZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9D32465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzry-0005zu-Ud
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzY5-0006cH-Ch
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzY2-00072s-Gj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51868
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzY2-000718-Ci
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zh/uEnfpcdXuhvmMKgELcN8eOKfIOwzcm1GbF3BqXwI=;
 b=S6ycmLZKmTJV4NkI94GeVqSnwVaL++NvYelZRKj6+XGjljg7z/v6PRQkk7hOrL2D/CJOhH
 bfzQht5XJLGRZCc05Aj7smdVMcE+dJQX8ZuVAFGUluY0OAm9PhOxDSSr4K9F9zzz7LXQ1L
 HoqzdemGgbI3U/qqbIxdlC9wiBDbhVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-KuDg2OjpPCC11fieIAjWaA-1; Thu, 19 Dec 2019 12:25:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4192E107ACC7;
 Thu, 19 Dec 2019 17:25:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4905063B9F;
 Thu, 19 Dec 2019 17:25:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/30] iotests: Add more "_require_drivers" checks to the
 shell-based tests
Date: Thu, 19 Dec 2019 18:24:25 +0100
Message-Id: <20191219172441.7289-15-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: KuDg2OjpPCC11fieIAjWaA-1
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

Test 051 should be skipped if nbd is not available, and 267 should
be skipped if copy-on-read is not enabled.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/051 | 1 +
 tests/qemu-iotests/267 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 53bcdbc911..a13bce2fd0 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -41,6 +41,7 @@ _supported_proto file
 # A compat=3D0.10 image is created in this test which does not support any=
thing
 # other than refcount_bits=3D16
 _unsupported_imgopts 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
+_require_drivers nbd
=20
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index 170e173c0a..b823668e29 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+_require_drivers copy-on-read
=20
 # Internal snapshots are (currently) impossible with refcount_bits=3D1
 _unsupported_imgopts 'refcount_bits=3D1[^0-9]'
--=20
2.20.1


