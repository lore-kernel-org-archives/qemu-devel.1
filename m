Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B110BC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5C52173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5lymNz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5C52173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33975 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42JR-0006JD-H9
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42Dl-0004dZ-7n
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42Dk-0001Dk-26
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44792
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42Dj-0001DZ-VF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582029803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoXOBQPAPA2CnsqwWNkbNSUQjhaIB3ZBKoZqaBZg2Gw=;
 b=D5lymNz+0VlNLD+p8DahjSoEmLfF+/yOudeDPwbOYQ8ND2tH2qJva1uCWSv6aq3QbXTWVs
 MIPbr7wDKKT/lEEmDJuoOqLce6QO5QGZ55l3gx+f3ei0WHFe/O1btOMBxLrwZa683s6H3k
 IwojM1I0xKIFz4uX3QeFE3J8IDDcFWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-0-0zy09YPo6dhaD3xZjfjw-1; Tue, 18 Feb 2020 07:43:16 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C062E13EA;
 Tue, 18 Feb 2020 12:43:15 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 330BA100194E;
 Tue, 18 Feb 2020 12:43:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 09/33] block: Add generic bdrv_inherited_options()
Date: Tue, 18 Feb 2020 13:42:18 +0100
Message-Id: <20200218124242.584644-10-mreitz@redhat.com>
In-Reply-To: <20200218124242.584644-1-mreitz@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 0-0zy09YPo6dhaD3xZjfjw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/block.c b/block.c
index c33f0e9b42..9179b9b604 100644
--- a/block.c
+++ b/block.c
@@ -998,6 +998,90 @@ static void bdrv_temp_snapshot_options(int *child_flag=
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


