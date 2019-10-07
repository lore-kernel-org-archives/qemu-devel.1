Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA87C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C07206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C07206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHS4F-0006le-0V
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iHRrE-0002kh-Qt
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iHRrD-0004qq-Av
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iHRrA-0004pv-K3; Mon, 07 Oct 2019 08:11:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9D1C85362;
 Mon,  7 Oct 2019 12:11:15 +0000 (UTC)
Received: from localhost (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE47C6061E;
 Mon,  7 Oct 2019 12:11:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/16] qemu-io: adds option to use aio engine
Date: Mon,  7 Oct 2019 13:09:32 +0100
Message-Id: <20191007120937.5862-12-stefanha@redhat.com>
In-Reply-To: <20191007120937.5862-1-stefanha@redhat.com>
References: <20191007120937.5862-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 07 Oct 2019 12:11:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: oleksandr@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Julia Suvorova <jusual@mail.ru>, Julia Suvorova <jusual@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aarushi Mehta <mehta.aaru20@gmail.com>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-io.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index f64eca6940..0abb4af134 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -130,7 +130,8 @@ static void open_help(void)
 " -C, -- use copy-on-read\n"
 " -n, -- disable host cache, short for -t none\n"
 " -U, -- force shared permissions\n"
-" -k, -- use kernel AIO implementation (on Linux only)\n"
+" -k, -- use kernel AIO implementation (Linux only, prefer use of -i)\n"
+" -i, -- use AIO mode (threads, native or io_uring)\n"
 " -t, -- use the given cache mode for the image\n"
 " -d, -- use the given discard mode for the image\n"
 " -o, -- options to be given to the block driver"
@@ -172,7 +173,7 @@ static int open_f(BlockBackend *blk, int argc, char *=
*argv)
     QDict *opts;
     bool force_share =3D false;
=20
-    while ((c =3D getopt(argc, argv, "snCro:kt:d:U")) !=3D -1) {
+    while ((c =3D getopt(argc, argv, "snCro:ki:t:d:U")) !=3D -1) {
         switch (c) {
         case 's':
             flags |=3D BDRV_O_SNAPSHOT;
@@ -204,6 +205,13 @@ static int open_f(BlockBackend *blk, int argc, char =
**argv)
                 return -EINVAL;
             }
             break;
+        case 'i':
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                qemu_opts_reset(&empty_opts);
+                return -EINVAL;
+            }
+            break;
         case 'o':
             if (imageOpts) {
                 printf("--image-opts and 'open -o' are mutually exclusiv=
e\n");
@@ -291,7 +299,9 @@ static void usage(const char *name)
 "  -n, --nocache        disable host cache, short for -t none\n"
 "  -C, --copy-on-read   enable copy-on-read\n"
 "  -m, --misalign       misalign allocations for O_DIRECT\n"
-"  -k, --native-aio     use kernel AIO implementation (on Linux only)\n"
+"  -k, --native-aio     use kernel AIO implementation\n"
+"                       (Linux only, prefer use of -i)\n"
+"  -i, --aio=3DMODE       use AIO mode (threads, native or io_uring)\n"
 "  -t, --cache=3DMODE     use the given cache mode for the image\n"
 "  -d, --discard=3DMODE   use the given discard mode for the image\n"
 "  -T, --trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\=
n"
@@ -489,7 +499,7 @@ static QemuOptsList file_opts =3D {
 int main(int argc, char **argv)
 {
     int readonly =3D 0;
-    const char *sopt =3D "hVc:d:f:rsnCmkt:T:U";
+    const char *sopt =3D "hVc:d:f:rsnCmki:t:T:U";
     const struct option lopt[] =3D {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -501,6 +511,7 @@ int main(int argc, char **argv)
         { "copy-on-read", no_argument, NULL, 'C' },
         { "misalign", no_argument, NULL, 'm' },
         { "native-aio", no_argument, NULL, 'k' },
+        { "aio", required_argument, NULL, 'i' },
         { "discard", required_argument, NULL, 'd' },
         { "cache", required_argument, NULL, 't' },
         { "trace", required_argument, NULL, 'T' },
@@ -568,6 +579,12 @@ int main(int argc, char **argv)
         case 'k':
             flags |=3D BDRV_O_NATIVE_AIO;
             break;
+        case 'i':
+            if (bdrv_parse_aio(optarg, &flags) < 0) {
+                error_report("Invalid aio option: %s", optarg);
+                exit(1);
+            }
+            break;
         case 't':
             if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0=
) {
                 error_report("Invalid cache option: %s", optarg);
--=20
2.21.0


