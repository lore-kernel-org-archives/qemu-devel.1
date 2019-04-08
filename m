Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C2C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A402087F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 16:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A402087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56049 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDXGn-0006OS-KW
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 12:37:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDXEt-00057u-R5
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDXEs-00060G-Uh
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:35:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hDXEn-0005vX-5x; Mon, 08 Apr 2019 12:35:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CCFC32D7F5;
	Mon,  8 Apr 2019 16:35:10 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-165.ams2.redhat.com
	[10.36.117.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B9BF11001DDA;
	Mon,  8 Apr 2019 16:35:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  8 Apr 2019 18:34:38 +0200
Message-Id: <20190408163439.18818-2-kwolf@redhat.com>
In-Reply-To: <20190408163439.18818-1-kwolf@redhat.com>
References: <20190408163439.18818-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 08 Apr 2019 16:35:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/2] block: Forward 'discard' to temporary
 overlay
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408163438.P6TIbpH58lIC8Xw13hOBUbSOoXXNvWfiz2EjfUxHJjU@z>

When bdrv_temp_snapshot_options() is called for snapshot=3Don, the
'discard' option in the options QDict hasn't been parsed and merged into
the flags yet. So copy the dict entry to make sure that the temporary
overlay enables discard when it was requested for the drive.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 3050854528..16615bc876 100644
--- a/block.c
+++ b/block.c
@@ -950,8 +950,9 @@ static void bdrv_temp_snapshot_options(int *child_fla=
gs, QDict *child_options,
     qdict_set_default_str(child_options, BDRV_OPT_CACHE_DIRECT, "off");
     qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on");
=20
-    /* Copy the read-only option from the parent */
+    /* Copy the read-only and discard options from the parent */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY=
);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_DISCARD);
=20
     /* aio=3Dnative doesn't work for cache.direct=3Doff, so disable it f=
or the
      * temporary snapshot */
--=20
2.20.1


