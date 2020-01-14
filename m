Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D55C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1BD206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTLg0mJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1BD206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irK4O-0000zU-00
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1irJwp-0000cx-GS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:01:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1irJwl-0007Bh-5D
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:01:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35030
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1irJwk-0007BG-SC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578999678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcF76SiLWpgtvCUROTLlRH+nHSE6t2UFIHOWl610TG4=;
 b=jTLg0mJ8CMBrvhUdpD5ntp3v/rLc8NL+otzK+ISP8jUBxol7ydoo9sjhnocfSQEfRAexj0
 6HEQtVLftBlDbD9HanMJPEUtbMFM6Jk3wNuiDXJwVWpwSCXKW0kQntVmazMc44tp6haTRi
 +3zvlr/5pXYsZ6aaQfAhNpi6LO6nADQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-Kb55M265PQSnWNBDba-odA-1; Tue, 14 Jan 2020 06:01:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE8961007277;
 Tue, 14 Jan 2020 11:01:11 +0000 (UTC)
Received: from localhost (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D44C27C456;
 Tue, 14 Jan 2020 11:01:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/15] qemu-img: adds option to use aio engine for
 benchmarking
Date: Tue, 14 Jan 2020 10:59:18 +0000
Message-Id: <20200114105921.131880-13-stefanha@redhat.com>
In-Reply-To: <20200114105921.131880-1-stefanha@redhat.com>
References: <20200114105921.131880-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Kb55M265PQSnWNBDba-odA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, oleksandr@redhat.com,
 Julia Suvorova <jusual@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v10:
 * Add missing space to qemu-img command-line documentation
---
 qemu-img-cmds.hx |  4 ++--
 qemu-img.c       | 11 ++++++++++-
 qemu-img.texi    |  5 ++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

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
diff --git a/qemu-img.c b/qemu-img.c
index 6233b8ca56..2b4562b9d9 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4187,7 +4187,8 @@ static int img_bench(int argc, char **argv)
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
@@ -4230,6 +4231,14 @@ static int img_bench(int argc, char **argv)
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
2.24.1


