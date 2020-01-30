Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE2BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D75292083E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2NKrCcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75292083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHX1-0002nq-Ub
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:39:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixHQr-0000WJ-7B
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixHQp-00074w-4B
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:33:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57485
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixHQo-00073y-W3
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580419978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMMIrVJy0uwR8Uuxe8xOKWdDD+Tu4OY0UK1A96PYN3Q=;
 b=i2NKrCczm+lt7g5OJAyd8ErJT6FNqKW8li13efLdW6UIrtABaZZpc8LYUFKddyuAjZQpJ1
 fDoivzbT3Pmf1Rj0PNIxL/IzCshOqbZPfA/oBkCBrGf1WkXb0POPAeFcc3gmCvVgMBXWrT
 aU10QncsTrHO63tkjzInQ1x3ig46k80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-sefOwBRhMV-vBy981I0THg-1; Thu, 30 Jan 2020 16:32:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B33C800D41;
 Thu, 30 Jan 2020 21:32:55 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C131087B2C;
 Thu, 30 Jan 2020 21:32:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/18] qemu-nbd: adds option for aio engines
Date: Thu, 30 Jan 2020 21:31:12 +0000
Message-Id: <20200130213114.325157-17-stefanha@redhat.com>
In-Reply-To: <20200130213114.325157-1-stefanha@redhat.com>
References: <20200130213114.325157-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sefOwBRhMV-vBy981I0THg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Acked-by: Eric Blake <eblake@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20200120141858.587874-14-stefanha@redhat.com
Message-Id: <20200120141858.587874-14-stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/interop/qemu-nbd.rst |  4 ++--
 qemu-nbd.c                | 12 ++++--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/docs/interop/qemu-nbd.rst b/docs/interop/qemu-nbd.rst
index 873bb9e17d..df7b6b9d0d 100644
--- a/docs/interop/qemu-nbd.rst
+++ b/docs/interop/qemu-nbd.rst
@@ -108,8 +108,8 @@ driver options if ``--image-opts`` is specified.
=20
 .. option:: --aio=3DAIO
=20
-  Set the asynchronous I/O mode between ``threads`` (the default)
-  and ``native`` (Linux only).
+  Set the asynchronous I/O mode between ``threads`` (the default),
+  ``native`` (Linux only), and ``io_uring`` (Linux 5.1+).
=20
 .. option:: --discard=3DDISCARD
=20
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 108a51f7eb..db29a0d0ed 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -135,7 +135,7 @@ static void usage(const char *name)
 "                            '[ID_OR_NAME]'\n"
 "  -n, --nocache             disable host cache\n"
 "      --cache=3DMODE          set cache mode (none, writeback, ...)\n"
-"      --aio=3DMODE            set AIO mode (native or threads)\n"
+"      --aio=3DMODE            set AIO mode (native, io_uring or threads)\=
n"
 "      --discard=3DMODE        set discard mode (ignore, unmap)\n"
 "      --detect-zeroes=3DMODE  set detect-zeroes mode (off, on, unmap)\n"
 "      --image-opts          treat FILE as a full set of image options\n"
@@ -726,13 +726,9 @@ int main(int argc, char **argv)
                 exit(EXIT_FAILURE);
             }
             seen_aio =3D true;
-            if (!strcmp(optarg, "native")) {
-                flags |=3D BDRV_O_NATIVE_AIO;
-            } else if (!strcmp(optarg, "threads")) {
-                /* this is the default */
-            } else {
-               error_report("invalid aio mode `%s'", optarg);
-               exit(EXIT_FAILURE);
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio mode '%s'", optarg);
+                exit(EXIT_FAILURE);
             }
             break;
         case QEMU_NBD_OPT_DISCARD:
--=20
2.24.1


