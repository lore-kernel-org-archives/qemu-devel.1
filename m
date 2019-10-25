Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B182CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2370E20578
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 16:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWen1DHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2370E20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO2Zu-000138-VC
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 12:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iO27I-0004Hr-8S
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iO27F-0003oM-Sv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:07:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28097
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iO27F-0003nj-OR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 12:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572019625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8/E8Ixm69JNDiocHrRbDC2w2nRid/JAzc8pC/QbMe4=;
 b=BWen1DHSKwqvPc3/5fGggytbzE283qGWZahpjy3huChINPMxJXsMZT59G6Ckl882ZHmwCp
 u5bRPaTrqGLz5ArsDeSWLcfUbrAbvTiNM8xc0ZE+gbQT5xt4VhJVOFzhSNpy191QGJOx0D
 EiOl3e+aTYL8FmGZvr8Bkn1vzTVAX9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-4cjSk5cnOF2wgtcHYMLz8w-1; Fri, 25 Oct 2019 12:07:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B37DD1005509;
 Fri, 25 Oct 2019 16:07:01 +0000 (UTC)
Received: from localhost (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5385E5D70E;
 Fri, 25 Oct 2019 16:06:53 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/15] qemu-img: adds option to use aio engine for
 benchmarking
Date: Fri, 25 Oct 2019 18:04:41 +0200
Message-Id: <20191025160444.31632-13-stefanha@redhat.com>
In-Reply-To: <20191025160444.31632-1-stefanha@redhat.com>
References: <20191025160444.31632-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 4cjSk5cnOF2wgtcHYMLz8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, oleksandr@redhat.com, qemu-block@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v10:
 * Add missing space to qemu-img command-line documentation
---
 qemu-img.c       | 11 ++++++++++-
 qemu-img-cmds.hx |  4 ++--
 qemu-img.texi    |  5 ++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 8b03ef8171..3e696a4d8e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4210,7 +4210,8 @@ static int img_bench(int argc, char **argv)
             {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c =3D getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:wU", long_options=
, NULL);
+        c =3D getopt_long(argc, argv, ":hc:d:f:ni:o:qs:S:t:wU", long_optio=
ns,
+                        NULL);
         if (c =3D=3D -1) {
             break;
         }
@@ -4253,6 +4254,14 @@ static int img_bench(int argc, char **argv)
         case 'n':
             flags |=3D BDRV_O_NATIVE_AIO;
             break;
+        case 'i':
+            ret =3D bdrv_parse_aio(optarg, &flags);
+            if (ret < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                ret =3D -1;
+                goto out;
+            }
+            break;
         case 'o':
         {
             offset =3D cvtnum(optarg);
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1c93e6d185..77b5a8dda8 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -20,9 +20,9 @@ STEXI
 ETEXI
=20
 DEF("bench", img_bench,
-    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_interv=
al] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s buffer_siz=
e] [-S step_size] [-t cache] [-w] [-U] filename")
+    "bench [-c count] [-d depth] [-f fmt] [--flush-interval=3Dflush_interv=
al] [-n] [--no-drain] [-o offset] [--pattern=3Dpattern] [-q] [-s buffer_siz=
e] [-S step_size] [-t cache] [-i aio] [-w] [-U] filename")
 STEXI
-@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-inte=
rval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=
=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var=
{cache}] [-w] [-U] @var{filename}
+@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-inte=
rval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=
=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var=
{cache}] [-i @var{aio}] [-w] [-U] @var{filename}
 ETEXI
=20
 DEF("check", img_check,
diff --git a/qemu-img.texi b/qemu-img.texi
index b5156d6316..20136fcb94 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -206,7 +206,7 @@ Command description:
 Amends the image format specific @var{options} for the image file
 @var{filename}. Not all file formats support this operation.
=20
-@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-inte=
rval=3D@var{flush_interval}] [-n] [--no-drain] [-o @var{offset}] [--pattern=
=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_size}] [-t @var=
{cache}] [-w] [-U] @var{filename}
+@item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}] [--flush-inte=
rval=3D@var{flush_interval}] [-n] [-i @var{aio}] [--no-drain] [-o @var{offs=
et}] [--pattern=3D@var{pattern}] [-q] [-s @var{buffer_size}] [-S @var{step_=
size}] [-t @var{cache}] [-w] [-U] @var{filename}
=20
 Run a simple sequential I/O benchmark on the specified image. If @code{-w}=
 is
 specified, a write test is performed, otherwise a read test is performed.
@@ -227,6 +227,9 @@ If @code{-n} is specified, the native AIO backend is us=
ed if possible. On
 Linux, this option only works if @code{-t none} or @code{-t directsync} is
 specified as well.
=20
+If @code{-i} is specified, aio option can be used to specify different AIO
+backends: @var{threads}, @var{native} or @var{io_uring}.
+
 For write tests, by default a buffer filled with zeros is written. This ca=
n be
 overridden with a pattern byte specified by @var{pattern}.
=20
--=20
2.21.0


