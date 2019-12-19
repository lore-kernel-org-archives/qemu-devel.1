Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7D5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FB921655
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPMu/mZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FB921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzdq-0004mu-1Q
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzXs-0006Ja-GW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzXq-00069O-Gz
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56670
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzXq-00066M-4b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DpfEMkeVoxAUi4VCciCaV9lm9Ejo8S0Ej9ZdoEnI1s=;
 b=DPMu/mZN++ImI0YX/FEPBYMwTz6hzSDJ1pz4aD0sBj9nOjcEq9CpGgXSFuh+BgbSvIVdNh
 waEarPFzhGdOLSEd6Af8T4h3oH8So5/MP09+dh7nTBRPkgTPDWd1QrWgWkBe3UyqDyInbX
 uzPIRb/KRxb1VIuqbL8qVUPI1u+HooA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-W1iOC1-aML2lesrhHS6KGA-1; Thu, 19 Dec 2019 12:24:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F650DB60;
 Thu, 19 Dec 2019 17:24:56 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FB2A620C0;
 Thu, 19 Dec 2019 17:24:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/30] block: Error out on image creation with conflicting size
 options
Date: Thu, 19 Dec 2019 18:24:17 +0100
Message-Id: <20191219172441.7289-7-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: W1iOC1-aML2lesrhHS6KGA-1
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If both the create options (qemu-img create -o ...) and the size
parameter were given, the size parameter was silently ignored. Instead,
make specifying two sizes an error.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c                    | 10 ++++++++--
 tests/qemu-iotests/049     |  5 +++++
 tests/qemu-iotests/049.out |  5 +++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 473eb6eeaa..73029fad64 100644
--- a/block.c
+++ b/block.c
@@ -5751,12 +5751,11 @@ void bdrv_img_create(const char *filename, const ch=
ar *fmt,
         return;
     }
=20
+    /* Create parameter list */
     create_opts =3D qemu_opts_append(create_opts, drv->create_opts);
     create_opts =3D qemu_opts_append(create_opts, proto_drv->create_opts);
=20
-    /* Create parameter list with default values */
     opts =3D qemu_opts_create(create_opts, NULL, 0, &error_abort);
-    qemu_opt_set_number(opts, BLOCK_OPT_SIZE, img_size, &error_abort);
=20
     /* Parse -o options */
     if (options) {
@@ -5766,6 +5765,13 @@ void bdrv_img_create(const char *filename, const cha=
r *fmt,
         }
     }
=20
+    if (!qemu_opt_get(opts, BLOCK_OPT_SIZE)) {
+        qemu_opt_set_number(opts, BLOCK_OPT_SIZE, img_size, &error_abort);
+    } else if (img_size !=3D UINT64_C(-1)) {
+        error_setg(errp, "The image size must be specified only once");
+        goto out;
+    }
+
     if (base_filename) {
         qemu_opt_set(opts, BLOCK_OPT_BACKING_FILE, base_filename, &local_e=
rr);
         if (local_err) {
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index c100d30ed0..051a1c79e0 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -78,6 +78,11 @@ for s in $sizes; do
     test_qemu_img create -f $IMGFMT -o size=3D$s "$TEST_IMG"
 done
=20
+echo "=3D=3D 4. Specify size twice (-o and traditional parameter) =3D=3D"
+echo
+
+test_qemu_img create -f $IMGFMT -o size=3D10M "$TEST_IMG" 20M
+
 echo "=3D=3D Check correct interpretation of suffixes for cluster size =3D=
=3D"
 echo
 sizes=3D"1024 1024b 1k 1K 1M "
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 6b505408dd..affa55b341 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -121,6 +121,11 @@ qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a=
 non-negative number below
 Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
 and exabytes, respectively.
=20
+=3D=3D 4. Specify size twice (-o and traditional parameter) =3D=3D
+
+qemu-img create -f qcow2 -o size=3D10M TEST_DIR/t.qcow2 20M
+qemu-img: TEST_DIR/t.qcow2: The image size must be specified only once
+
 =3D=3D Check correct interpretation of suffixes for cluster size =3D=3D
=20
 qemu-img create -f qcow2 -o cluster_size=3D1024 TEST_DIR/t.qcow2 64M
--=20
2.20.1


