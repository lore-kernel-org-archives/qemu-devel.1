Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20BDC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 11:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8E1206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 11:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXZZFns+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8E1206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZvyS-0006cn-I5
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 06:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iZvt3-0000Yu-OG
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 06:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iZvt1-0006DV-Ap
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 06:53:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41896
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iZvsw-0006AC-Q6
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 06:53:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574855610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8tsVTUfoEfZv9VhDPcAAEq3rQMQDEoIiccaTGADpU8=;
 b=ZXZZFns+sYE8CiQLbjDkeIv69+5T8k/AZLpuQBFcUtfZY/Jaz/JkbkHKrH4uscsz5iiMTw
 QFrzjyteJlnn7hjQhx7wsYBWkWamfF+bVx0MNWnv70CIm4xtBwD5eXv/4OtvNlUvlItbf4
 xDbUmy0D+Ta1KFbwfe0ar2k3IYD8VPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-S04vU510OGONQCQnN3iTjg-1; Wed, 27 Nov 2019 06:53:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDA6E107ACE3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 11:53:25 +0000 (UTC)
Received: from localhost (ovpn-112-17.ams2.redhat.com [10.36.112.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C9E610246E3;
 Wed, 27 Nov 2019 11:53:19 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] osdep: add qemu_unlink()
Date: Wed, 27 Nov 2019 15:52:01 +0400
Message-Id: <20191127115202.375107-7-marcandre.lureau@redhat.com>
In-Reply-To: <20191127115202.375107-1-marcandre.lureau@redhat.com>
References: <20191127115202.375107-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: S04vU510OGONQCQnN3iTjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a helper function to match qemu_open() which may return files
under the /dev/fdset prefix. Those shouldn't be removed, since it's
only a qemu namespace.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/osdep.h |  1 +
 util/osdep.c         | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0f97d68586..9bd3dcfd13 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -462,6 +462,7 @@ int qemu_mprotect_none(void *addr, size_t size);
=20
 int qemu_open(const char *name, int flags, ...);
 int qemu_close(int fd);
+int qemu_unlink(const char *name);
 #ifndef _WIN32
 int qemu_dup(int fd);
 #endif
diff --git a/util/osdep.c b/util/osdep.c
index 3f04326040..f7d06050f7 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -370,6 +370,21 @@ int qemu_close(int fd)
     return close(fd);
 }
=20
+/*
+ * Delete a file from the filesystem, unless the filename is /dev/fdset/..=
.
+ *
+ * Returns: On success, zero is returned.  On error, -1 is returned,
+ * and errno is set appropriately.
+ */
+int qemu_unlink(const char *name)
+{
+    if (g_str_has_prefix(name, "/dev/fdset/")) {
+        return 0;
+    }
+
+    return unlink(name);
+}
+
 /*
  * A variant of write(2) which handles partial write.
  *
--=20
2.24.0


