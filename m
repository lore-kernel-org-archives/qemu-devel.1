Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DD6C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A5BC22527
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSIQ/pKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5BC22527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSIH-00061h-Dy
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWj-0007LR-HP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWf-00049i-EX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53456
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWf-00048l-8O
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pq1CJKkq0WwiRzlJEPbbHglPzJxjc0gV++NdCoQ7UVg=;
 b=KSIQ/pKFsx+OlE41DB1SMRnkHVXxPNlVm432YBcQ++oUtEncti+0yHzX/xbMaMQ4iL8Wyv
 zCs11pWut8fHlela4/nCRHQl3ez/bm+vC5tEC7QOMn0KLY9OVD6eQ9JvroS1H09EWl3gB3
 FIIiGDdE4kvEvvh7XgcFNmOMwx2d6tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-tduYwVoJP5q9HRcBmmUoTA-1; Thu, 12 Dec 2019 11:41:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02D85477
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:41:15 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1B1B60BF3;
 Thu, 12 Dec 2019 16:41:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 079/104] virtiofsd: fix memory leak on lo.source
Date: Thu, 12 Dec 2019 16:38:39 +0000
Message-Id: <20191212163904.159893-80-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: tduYwVoJP5q9HRcBmmUoTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Bo <bo.liu@linux.alibaba.com>

valgrind reported that lo.source is leaked on quiting, but it was defined
as (const char*) as it may point to a const string "/".

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 tools/virtiofsd/passthrough_ll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 33092de65a..45cf466178 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2529,9 +2529,8 @@ int main(int argc, char *argv[])
             fuse_log(FUSE_LOG_ERR, "source is not a directory\n");
             exit(1);
         }
-
     } else {
-        lo.source =3D "/";
+        lo.source =3D strdup("/");
     }
     lo.root.is_symlink =3D false;
     if (!lo.timeout_set) {
@@ -2610,5 +2609,7 @@ err_out1:
         close(lo.root.fd);
     }
=20
+    free((char *)lo.source);
+
     return ret ? 1 : 0;
 }
--=20
2.23.0


