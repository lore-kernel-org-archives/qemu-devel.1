Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D051CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085DF20873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OarLdnCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085DF20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4RV-0004cN-Ik
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3wX-0002Lk-QV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wW-0001jv-Nw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48105
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wW-0001jZ-J4
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riNSMiO+14ulx+UiW3yO9j58OeQiJkagmAlO8zmtw1M=;
 b=OarLdnCIprZ0ivDb3+jlIFNvGmm1TPkVA6W1eUF/K6pHFoF4T5KRNbT6osqCmnZt/OZqUs
 X4gUKtHyp9LTAFi/EA/XgUav8ClkPuI0r3QCiB8YC+80+A7XJ3BvmmsVtUpozUvtRI0/VQ
 WRCV6afc2gevOw9FGkygzVG9XK4fJbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-EKzE7KbiN1OxYlem2PRICw-1; Mon, 28 Oct 2019 08:16:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA39A10052E0;
 Mon, 28 Oct 2019 12:16:11 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ED53600C7;
 Mon, 28 Oct 2019 12:16:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 33/69] iotests/240: Create socket in $SOCK_DIR
Date: Mon, 28 Oct 2019 13:14:25 +0100
Message-Id: <20191028121501.15279-34-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: EKzE7KbiN1OxYlem2PRICw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191017133155.5327-22-mreitz@redhat.com
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/240 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/240 b/tests/qemu-iotests/240
index f73bc07d80..8b4337b58d 100755
--- a/tests/qemu-iotests/240
+++ b/tests/qemu-iotests/240
@@ -29,7 +29,7 @@ status=3D1=09# failure is the default!
=20
 _cleanup()
 {
-    rm -f "$TEST_DIR/nbd"
+    rm -f "$SOCK_DIR/nbd"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
=20
@@ -135,7 +135,7 @@ echo
 run_qemu <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "blockdev-add", "arguments": {"driver": "null-co", "read-zero=
es": true, "node-name": "hd0", "read-only": true}}
-{ "execute": "nbd-server-start", "arguments": {"addr":{"type":"unix","data=
":{"path":"$TEST_DIR/nbd"}}}}
+{ "execute": "nbd-server-start", "arguments": {"addr":{"type":"unix","data=
":{"path":"$SOCK_DIR/nbd"}}}}
 { "execute": "nbd-server-add", "arguments": {"device":"hd0"}}
 { "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "io=
thread0"}}
 { "execute": "device_add", "arguments": {"id": "scsi0", "driver": "${virti=
o_scsi}", "iothread": "iothread0"}}
--=20
2.21.0


