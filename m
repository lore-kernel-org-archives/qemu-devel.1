Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DDFCA9EC1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:37:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8CE214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCCzlX6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8CE214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4Gx-0002Jp-Cb
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vz-0001hA-Lc
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vy-0001QT-Ev
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32957)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vy-0001Q0-BG
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWAJzrkgp4bSHSVktmBeu7aN2rV4fKsTo365vflS3Og=;
 b=iCCzlX6BpieScrxW3YenrVfSN0yL8QdXxrEsFKnWrHimULpnXMWiiOxYK4DV77RlBvvDR8
 8UquuAM4qjabAP4A/uBSw2mo5Ep0ps25v4uk1465ZsHg0ALE02pULsSgIcb3EWxgN5Wi0P
 Fh/IAVQ5gdCnuv5jCeWWBISjd9g8Myc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-Nr43nzHlM0y_PjLDAX0AIA-1; Mon, 28 Oct 2019 08:15:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1935800FF1;
 Mon, 28 Oct 2019 12:15:38 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8808C5C207;
 Mon, 28 Oct 2019 12:15:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 17/69] iotests: Let common.nbd create socket in $SOCK_DIR
Date: Mon, 28 Oct 2019 13:14:09 +0100
Message-Id: <20191028121501.15279-18-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Nr43nzHlM0y_PjLDAX0AIA-1
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

In addition, drop the nbd_unix_socket assignment in 241 because it does
not really do anything.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191017133155.5327-6-mreitz@redhat.com
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/241        | 2 --
 tests/qemu-iotests/common.nbd | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/241 b/tests/qemu-iotests/241
index 58b64ebf41..8dae8d39e4 100755
--- a/tests/qemu-iotests/241
+++ b/tests/qemu-iotests/241
@@ -23,8 +23,6 @@ echo "QA output created by $seq"
=20
 status=3D1 # failure is the default!
=20
-nbd_unix_socket=3D$TEST_DIR/test_qemu_nbd_socket
-
 _cleanup()
 {
     _cleanup_test_img
diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nbd
index 24b01b60aa..a8cae8fe2c 100644
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -19,7 +19,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
-nbd_unix_socket=3D"${TEST_DIR}/qemu-nbd.sock"
+nbd_unix_socket=3D"${SOCK_DIR}/qemu-nbd.sock"
 nbd_tcp_addr=3D"127.0.0.1"
 nbd_pid_file=3D"${TEST_DIR}/qemu-nbd.pid"
 nbd_stderr_fifo=3D"${TEST_DIR}/qemu-nbd.fifo"
--=20
2.21.0


