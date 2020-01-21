Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C67C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C642621569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLX4bf94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C642621569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itu0W-0004xv-UN
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsgt-0002mU-HU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsgp-0004Wq-FA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23074
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsgp-0004Wg-Au
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ozsmQl6KOPGLJgk2hV37YZWCjzN9L1vPcnpRewKjF0=;
 b=BLX4bf94fYaBoUKMqlTw0G3EnCcQNfQQC2U+/VFzlpUzLzEOjNKAV4vDzGcRvc2iQZ3dTB
 o2HA5XSCe+KlcmWn794wn+EXClv6Eb8mItfis8GLSi3TlIqTIDi1YVSyXwEvvcCuwq8HSP
 kTMD2kS4+4sFfGLU4Un5VPrTGG5uYc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-scDMFCPvNrW16L_0KRRFGQ-1; Tue, 21 Jan 2020 07:31:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F57E107ACCC;
 Tue, 21 Jan 2020 12:31:24 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 319FA60BE0;
 Tue, 21 Jan 2020 12:31:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 080/109] virtiofsd: fix memory leak on lo.source
Date: Tue, 21 Jan 2020 12:24:04 +0000
Message-Id: <20200121122433.50803-81-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: scDMFCPvNrW16L_0KRRFGQ-1
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Bo <bo.liu@linux.alibaba.com>

valgrind reported that lo.source is leaked on quiting, but it was defined
as (const char*) as it may point to a const string "/".

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 4e01a37ddb..462c250382 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -115,7 +115,7 @@ struct lo_data {
     int writeback;
     int flock;
     int xattr;
-    const char *source;
+    char *source;
     double timeout;
     int cache;
     int timeout_set;
@@ -2497,9 +2497,8 @@ int main(int argc, char *argv[])
             fuse_log(FUSE_LOG_ERR, "source is not a directory\n");
             exit(1);
         }
-
     } else {
-        lo.source =3D "/";
+        lo.source =3D strdup("/");
     }
     if (!lo.timeout_set) {
         switch (lo.cache) {
@@ -2570,5 +2569,7 @@ err_out1:
         close(lo.root.fd);
     }
=20
+    free(lo.source);
+
     return ret ? 1 : 0;
 }
--=20
2.24.1


