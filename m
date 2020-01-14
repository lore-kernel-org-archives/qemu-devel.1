Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6519EC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C83C206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBuwZ3ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C83C206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKAB-0000eM-1Y
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1irJwy-0000hj-S0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1irJwu-0007Ep-VU
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:01:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52603
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1irJwu-0007EX-S3
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578999688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdhLobAo/41hJ/YPFITVtn/i3fzLbZiNJz/7duIUh3Q=;
 b=DBuwZ3lni/PFXBpjkfXh0DEMVRjq2/c+a+3YKHq428vks/Bs2FeLKk/zQNbFZW+DYv7mwR
 ms5BPjyDr/d2j29rSDMEiDPnPTqchaOSv++P+22ZPwK0F6Ib7zYmdqFyJp3sUSne8JGcDo
 noNrlaaB+vGLM0MGAOLHtVFK6Wnn9s0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-4eZ4oBMyO9ynMmo_9fcQ1g-1; Tue, 14 Jan 2020 06:01:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D895110054E3;
 Tue, 14 Jan 2020 11:01:20 +0000 (UTC)
Received: from localhost (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45485108419E;
 Tue, 14 Jan 2020 11:01:13 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 13/15] qemu-nbd: adds option for aio engines
Date: Tue, 14 Jan 2020 10:59:19 +0000
Message-Id: <20200114105921.131880-14-stefanha@redhat.com>
In-Reply-To: <20200114105921.131880-1-stefanha@redhat.com>
References: <20200114105921.131880-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 4eZ4oBMyO9ynMmo_9fcQ1g-1
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
Acked-by: Eric Blake <eblake@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-nbd.c    | 12 ++++--------
 qemu-nbd.texi |  4 ++--
 2 files changed, 6 insertions(+), 10 deletions(-)

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
diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 7f55657722..3ee3e4bdee 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -77,8 +77,8 @@ as an read-only device, @var{snapshot_param} format is
 The cache mode to be used with the file.  See the documentation of
 the emulator's @code{-drive cache=3D...} option for allowed values.
 @item --aio=3D@var{aio}
-Set the asynchronous I/O mode between @samp{threads} (the default)
-and @samp{native} (Linux only).
+Set the asynchronous I/O mode between @samp{threads} (the default),
+@samp{native} (Linux only) and @samp{io_uring} (Linux 5.1+).
 @item --discard=3D@var{discard}
 Control whether @dfn{discard} (also known as @dfn{trim} or @dfn{unmap})
 requests are ignored or passed to the filesystem.  @var{discard} is one of
--=20
2.24.1


