Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B78C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9805D21734
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 11:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKAmBpKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9805D21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imz83-0006ba-N6
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 06:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1imz5g-0002v1-RR
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1imz5f-0007gV-MQ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:56:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60291
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1imz5f-0007gL-Ie
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 06:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577966195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWpV14O1SwpY09dfHGy2OUMa9GddTvXPTc1StMy0gqs=;
 b=ZKAmBpKxULPQxH1DuaAZ5zO3KdIfkR5Bxraurkum2YvnPbYJXL3hMTAJx+twHMdl0W8SWr
 wt99FZwMpmPU8TyZRw9n4xB5RohbIN0V1iFoPvTokvB/svzAcRkBTjS+oZJ1ryfJ5eL4TJ
 sna4JP1iv6Rhn2iTtLoxDHMzsGiNlIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-G9FsUW72OQ-nxDSQX1GLxA-1; Thu, 02 Jan 2020 06:56:34 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47B8A104ED3D
 for <qemu-devel@nongnu.org>; Thu,  2 Jan 2020 11:56:33 +0000 (UTC)
Received: from localhost (ovpn-112-28.ams2.redhat.com [10.36.112.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E842E19C58;
 Thu,  2 Jan 2020 11:56:24 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] osdep: add qemu_unlink()
Date: Thu,  2 Jan 2020 15:54:58 +0400
Message-Id: <20200102115459.854103-7-marcandre.lureau@redhat.com>
In-Reply-To: <20200102115459.854103-1-marcandre.lureau@redhat.com>
References: <20200102115459.854103-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: G9FsUW72OQ-nxDSQX1GLxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a helper function to match qemu_open() which may return files
under the /dev/fdset prefix. Those shouldn't be removed, since it's
only a qemu namespace.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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
2.24.0.308.g228f53135a


