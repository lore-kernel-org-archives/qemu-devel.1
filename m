Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10562C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0937222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsJXeNzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0937222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hLh-0001E9-WB
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j2hGZ-0007ql-9w
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j2hGX-0005fT-7V
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j2hGX-0005dl-3M
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581710924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7fpPkW0Znm7Ual5KsYCLNoIphxRplpjPiS+1ZA2nF0=;
 b=BsJXeNzs0ZF2rFjT1tKYLjDaqvkGmKpOWzUn0fsUaop4IvfyI4xnxln0pb2NSRGyGpQLzf
 rROZ/EKIR5EzxwH1R/sxL6D5fy3m0Rw5sl57iWD79VQkfP9U92OHbtFSnIlPob5qB+K63h
 LdMRSo7pWao9LdBX0f+TtQDVAvm0i3I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-4Zqu-HpXO5iT44iRVtPkjg-1; Fri, 14 Feb 2020 15:08:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BD7B108442A;
 Fri, 14 Feb 2020 20:08:38 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF5DF5C1C3;
 Fri, 14 Feb 2020 20:08:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 6/7] commit: Expose on-error option in QMP
Date: Fri, 14 Feb 2020 21:08:11 +0100
Message-Id: <20200214200812.28180-7-kwolf@redhat.com>
In-Reply-To: <20200214200812.28180-1-kwolf@redhat.com>
References: <20200214200812.28180-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 4Zqu-HpXO5iT44iRVtPkjg-1
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the error handling in the common block job is fixed, we can
expose the on-error option in QMP instead of hard-coding it as 'report'
in qmp_block_commit().

This fulfills the promise that the old comment in that function made,
even if a bit later than expected: "This will be part of the QMP
command, if/when the BlockdevOnError change for blkmirror makes it in".

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 4 ++++
 blockdev.c           | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 395d205fa8..c69aece46e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1659,6 +1659,9 @@
 #
 # @speed:  the maximum speed, in bytes per second
 #
+# @on-error: the action to take on an error. 'ignore' means that the reque=
st
+#            should be retried. (default: report; Since: 5.0)
+#
 # @filter-node-name: the node name that should be assigned to the
 #                    filter driver that the commit job inserts into the gr=
aph
 #                    above @top. If this option is not given, a node name =
is
@@ -1695,6 +1698,7 @@
   'data': { '*job-id': 'str', 'device': 'str', '*base-node': 'str',
             '*base': 'str', '*top-node': 'str', '*top': 'str',
             '*backing-file': 'str', '*speed': 'int',
+            '*on-error': 'BlockdevOnError',
             '*filter-node-name': 'str',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
=20
diff --git a/blockdev.c b/blockdev.c
index c6a727cca9..374189a426 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3471,6 +3471,7 @@ void qmp_block_commit(bool has_job_id, const char *jo=
b_id, const char *device,
                       bool has_top, const char *top,
                       bool has_backing_file, const char *backing_file,
                       bool has_speed, int64_t speed,
+                      bool has_on_error, BlockdevOnError on_error,
                       bool has_filter_node_name, const char *filter_node_n=
ame,
                       bool has_auto_finalize, bool auto_finalize,
                       bool has_auto_dismiss, bool auto_dismiss,
@@ -3481,15 +3482,14 @@ void qmp_block_commit(bool has_job_id, const char *=
job_id, const char *device,
     BlockDriverState *base_bs, *top_bs;
     AioContext *aio_context;
     Error *local_err =3D NULL;
-    /* This will be part of the QMP command, if/when the
-     * BlockdevOnError change for blkmirror makes it in
-     */
-    BlockdevOnError on_error =3D BLOCKDEV_ON_ERROR_REPORT;
     int job_flags =3D JOB_DEFAULT;
=20
     if (!has_speed) {
         speed =3D 0;
     }
+    if (!has_on_error) {
+        on_error =3D BLOCKDEV_ON_ERROR_REPORT;
+    }
     if (!has_filter_node_name) {
         filter_node_name =3D NULL;
     }
--=20
2.20.1


