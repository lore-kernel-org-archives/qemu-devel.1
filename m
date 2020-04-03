Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CC8C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D77206F5
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 18:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qm0Q8NM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D77206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQft-0003wy-Va
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 14:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39458)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jKQbX-0008Eq-Vt
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jKQbW-0007mR-Sq
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:59:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32823
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jKQbW-0007l1-P2
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585936782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yo+ryPOZyQt+ZcUKPVTQE/2JrpsvvTK1ah97oCYRcz8=;
 b=Qm0Q8NM8PV3b646/8LJeHsLxFK573UIJS5qs5s+4OLy8Vu7Zgd4cMVv982Au00WVQPEIDU
 2KVkcQZ8OFy4nbq43HvV6H+jZV1qQBwEeO3d+zficeNvrdJoO2PlxNLuz+XivU+zpatF1S
 9rIAf43N9/7tQSKxW8uk/C0Gof1hOlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-fS8dUxOIPMm0zaAbAPkWdw-1; Fri, 03 Apr 2020 13:59:40 -0400
X-MC-Unique: fS8dUxOIPMm0zaAbAPkWdw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E1B68017F5;
 Fri,  3 Apr 2020 17:59:39 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E6155C1B0;
 Fri,  3 Apr 2020 17:59:30 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/7] vmdk: Add trivial backing_fmt support
Date: Fri,  3 Apr 2020 12:58:54 -0500
Message-Id: <20200403175859.863248-3-eblake@redhat.com>
In-Reply-To: <20200403175859.863248-1-eblake@redhat.com>
References: <20200403175859.863248-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: kwolf@redhat.com, Fam Zheng <fam@euphon.net>, pkrempa@redhat.com,
 qemu-block@nongnu.org, kchamart@redhat.com, libvir-list@redhat.com,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 mreitz@redhat.com, "open list:Trivial patches" <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vmdk already requires that if backing_file is present, that it be
another vmdk image (see vmdk_co_do_create).  Meanwhile, we want to
move towards always being explicit about the backing format for other
drivers where it matters.  So for convenience, make qemu-img create -F
vmdk work, while rejecting all other explicit formats (note that this
is only for QemuOpts usage; there is no change to the QAPI to allow a
format through -blockdev).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/vmdk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index 218d9c980059..7ecaf0ee9be3 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2613,6 +2613,14 @@ static int coroutine_fn vmdk_co_create_opts(BlockDri=
ver *drv,
     bool zeroed_grain;
     bool compat6;
     VMDKCreateOptsData data;
+    char *backing_fmt =3D NULL;
+
+    backing_fmt =3D qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
+    if (backing_fmt && strcmp(backing_fmt, "vmdk") !=3D 0) {
+        error_setg(errp, "backing_file must be a vmdk image");
+        ret =3D -EINVAL;
+        goto exit;
+    }

     if (filename_decompose(filename, path, prefix, postfix, PATH_MAX, errp=
)) {
         ret =3D -EINVAL;
@@ -2671,6 +2679,7 @@ static int coroutine_fn vmdk_co_create_opts(BlockDriv=
er *drv,
                             vmdk_co_create_opts_cb, &data, errp);

 exit:
+    g_free(backing_fmt);
     g_free(adapter_type);
     g_free(backing_file);
     g_free(hw_version);
@@ -3007,6 +3016,11 @@ static QemuOptsList vmdk_create_opts =3D {
             .type =3D QEMU_OPT_STRING,
             .help =3D "File name of a base image"
         },
+        {
+            .name =3D BLOCK_OPT_BACKING_FMT,
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "Must be 'vmdk' if present",
+        },
         {
             .name =3D BLOCK_OPT_COMPAT6,
             .type =3D QEMU_OPT_BOOL,
--=20
2.26.0.rc2


