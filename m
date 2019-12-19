Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E6DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:40:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356E821D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng5tnbUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356E821D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihwyk-0006zC-Sf
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwws-0004gT-Cn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwwr-0005GK-9U
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24618
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwwr-0005DF-1i
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dk61yWfDOddI3UUwPOJpvkQE7B71zRPhPnSg+tPhN/o=;
 b=Ng5tnbUqMQzA3YVG5L5Zt1umJOtGEgcTxD5EFFmtxyxYQBm1SzhTk0Fwbdh7MTRSiIQ/w4
 Kmxi1mTO9G//aWM/VJEFmLVoFMJCi4d7NVMlpdhASsIn/6dUaDvDhYnOZFk3azyfgS03Vf
 bYUnxRQvJZGhoHqcX7I0b4dK00jfocM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-UCr0XucYO2Cx6mzpuCd-iA-1; Thu, 19 Dec 2019 09:38:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EDAE802B93;
 Thu, 19 Dec 2019 14:38:38 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD5CE60C81;
 Thu, 19 Dec 2019 14:38:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 04/18] fuse: Add fuse-export-remove
Date: Thu, 19 Dec 2019 15:38:04 +0100
Message-Id: <20191219143818.1646168-5-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: UCr0XucYO2Cx6mzpuCd-iA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/fuse.c    | 16 ++++++++++++++++
 qapi/block.json | 15 +++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/block/fuse.c b/block/fuse.c
index f18e8e7591..4e662e6dfb 100644
--- a/block/fuse.c
+++ b/block/fuse.c
@@ -123,6 +123,22 @@ fail:
     close_fuse_session(session);
 }
=20
+void qmp_fuse_export_remove(const char *mountpoint, Error **errp)
+{
+    BdrvFuseSession *session =3D NULL;
+
+    if (sessions) {
+        session =3D g_hash_table_lookup(sessions, mountpoint);
+    }
+
+    if (!session) {
+        error_setg(errp, "No export found on '%s'", mountpoint);
+        return;
+    }
+
+    g_hash_table_remove(sessions, mountpoint);
+}
+
 /**
  * Drop all FUSE exports.
  */
diff --git a/qapi/block.json b/qapi/block.json
index 03f8d1b537..26768dc8ef 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -340,6 +340,21 @@
   },
   'if': 'defined(CONFIG_FUSE)' }
=20
+##
+# @fuse-export-remove:
+#
+# Unmount an exported block graph node.
+#
+# @mountpoint: The export path given to fuse-export-add
+#
+# Since: 5.0
+##
+{ 'command': 'fuse-export-remove',
+  'data': {
+      'mountpoint': 'str'
+  },
+  'if': 'defined(CONFIG_FUSE)' }
+
 ##
 # @DEVICE_TRAY_MOVED:
 #
--=20
2.23.0


