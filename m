Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E07C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 266702084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IB4mIe1R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266702084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1kn-00006P-BH
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1hS-0002zT-Ld
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hR-0002VT-Dq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31882
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hR-0002Th-9b
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2l/QtADm9xJSUp/EDvPXwh4NPTqn435JKN5O21Opy8=;
 b=IB4mIe1Rh9iSSvJQO5cagjHDEMlcURx/Qc+B+NyNfAwxdIqG2Zh8f6K3CAd36ySZs/cNb1
 jCpIPNWWCeeX9/uhWIGbAEHW2SLMcSQn3zlacOOFXUU5uBoDaYkKqc7rTdRqUGoQI2HIoS
 qxt1phTppQU+4hlczxVx3z4GQGudevw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-bf9Oc6--PvWXDFgGQShS7A-1; Tue, 04 Feb 2020 12:09:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4155133656B;
 Tue,  4 Feb 2020 17:09:17 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5FECE86C4A;
 Tue,  4 Feb 2020 17:09:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 09/33] block: Add generic bdrv_inherited_options()
Date: Tue,  4 Feb 2020 18:08:24 +0100
Message-Id: <20200204170848.614480-10-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: bf9Oc6--PvWXDFgGQShS7A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After the series this patch belongs to, we want to have a common
BdrvChildClass that encompasses all of child_file, child_format, and
child_backing.  Such a single class needs a single .inherit_options()
implementation, and this patch introduces it.

The next patch will show how the existing implementations can fall back
to it just by passing appropriate BdrvChildRole and parent_is_format
values.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/block.c b/block.c
index 5b85520515..ab14d52a91 100644
--- a/block.c
+++ b/block.c
@@ -976,6 +976,90 @@ static void bdrv_temp_snapshot_options(int *child_flag=
s, QDict *child_options,
     *child_flags &=3D ~BDRV_O_NATIVE_AIO;
 }
=20
+/*
+ * Returns the options and flags that a generic child of a BDS should
+ * get, based on the given options and flags for the parent BDS.
+ */
+static void __attribute__((unused))
+    bdrv_inherited_options(BdrvChildRole role, bool parent_is_format,
+                           int *child_flags, QDict *child_options,
+                           int parent_flags, QDict *parent_options)
+{
+    int flags =3D parent_flags;
+
+    /*
+     * First, decide whether to set, clear, or leave BDRV_O_PROTOCOL.
+     * Generally, the question to answer is: Should this child be
+     * format-probed by default?
+     */
+
+    /*
+     * Pure and non-filtered data children of non-format nodes should
+     * be probed by default (even when the node itself has BDRV_O_PROTOCOL
+     * set).  This only affects a very limited set of drivers (namely
+     * quorum and blkverify when this comment was written).
+     * Force-clear BDRV_O_PROTOCOL then.
+     */
+    if (!parent_is_format &&
+        (role & (BDRV_CHILD_DATA | BDRV_CHILD_METADATA |
+                 BDRV_CHILD_FILTERED)) =3D=3D
+            BDRV_CHILD_DATA)
+    {
+        flags &=3D ~BDRV_O_PROTOCOL;
+    }
+
+    /*
+     * All children of format nodes (except for COW children) and all
+     * metadata children in general should never be format-probed.
+     * Force-set BDRV_O_PROTOCOL then.
+     */
+    if ((parent_is_format && !(role & BDRV_CHILD_COW)) ||
+        (role & BDRV_CHILD_METADATA))
+    {
+        flags |=3D BDRV_O_PROTOCOL;
+    }
+
+    /*
+     * If the cache mode isn't explicitly set, inherit direct and no-flush=
 from
+     * the parent.
+     */
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_DIREC=
T);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_CACHE_NO_FL=
USH);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_FORCE_SHARE=
);
+
+    if (role & BDRV_CHILD_COW) {
+        /* backing files are always opened read-only */
+        qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
+        qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "off=
");
+    } else {
+        /* Inherit the read-only option from the parent if it's not set */
+        qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ON=
LY);
+        qdict_copy_default(child_options, parent_options,
+                           BDRV_OPT_AUTO_READ_ONLY);
+    }
+
+    if (parent_is_format && !(role & BDRV_CHILD_COW)) {
+        /*
+         * Our format drivers take care to send flushes and respect
+         * unmap policy, so we can default to enable both on lower
+         * layers regardless of the corresponding parent options.
+         */
+        qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap");
+    }
+
+    /* Clear flags that only apply to the top layer */
+    flags &=3D ~(BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING | BDRV_O_COPY_ON_READ=
);
+
+    if (role & BDRV_CHILD_METADATA) {
+        flags &=3D ~BDRV_O_NO_IO;
+    }
+    if (role & BDRV_CHILD_COW) {
+        flags &=3D ~BDRV_O_TEMPORARY;
+    }
+
+    *child_flags =3D flags;
+}
+
 /*
  * Returns the options and flags that bs->file should get if a protocol dr=
iver
  * is expected, based on the given options and flags for the parent BDS
--=20
2.24.1


