Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80681C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49F762072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjINkwWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F762072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDr7H-0004sC-As
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDr4N-0000C5-Kz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:22:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35680
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDr4L-00081F-1J
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599146552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ncL3MwxzJsCd1kf/SACKaGDcExKE2Jw+i5yqXBhHZf8=;
 b=TjINkwWKA/X9krKbej/UN/RwJcuZT5QG11UFX/1n9rCppJYAFOGCxNpuPs+Yfp5DkHHWIa
 fMC6+ic4ul4wIi0VxpuZwIVXmf8IO5OyLML3C/2umMdYECLcodvTgICCllEmbCIrrtISmI
 CW5Lmo1iPYPag2o+v/QCWinE2G9FauI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-NP4US8uuN7WKT16hLWX-EQ-1; Thu, 03 Sep 2020 11:22:30 -0400
X-MC-Unique: NP4US8uuN7WKT16hLWX-EQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B6011007470;
 Thu,  3 Sep 2020 15:22:29 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9FADC80931;
 Thu,  3 Sep 2020 15:22:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 6/8] util: introduce qemu_open and qemu_create with error
 reporting
Date: Thu,  3 Sep 2020 16:22:08 +0100
Message-Id: <20200903152210.1917355-7-berrange@redhat.com>
In-Reply-To: <20200903152210.1917355-1-berrange@redhat.com>
References: <20200903152210.1917355-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_open_old() works like open(): set errno and return -1 on failure.
It has even more failure modes, though.  Reporting the error clearly
to users is basically impossible for many of them.

Our standard cure for "errno is too coarse" is the Error object.
Introduce two new helper methods:

  int qemu_open(const char *name, int flags, Error **errp);
  int qemu_create(const char *name, int flags, mode_t mode, Error **errp);

Note that with this design we no longer require or even accept the
O_CREAT flag. Avoiding overloading the two distinct operations
means we can avoid variable arguments which would prevent 'errp' from
being the last argument. It also gives us a guarantee that the 'mode' is
given when creating files, avoiding a latent security bug.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/osdep.h |  6 ++++++
 util/osdep.c         | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index ae1234104c..577d9e8315 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -497,7 +497,13 @@ int qemu_madvise(void *addr, size_t len, int advice);
 int qemu_mprotect_rwx(void *addr, size_t size);
 int qemu_mprotect_none(void *addr, size_t size);
 
+/*
+ * Don't introduce new usage of this function, prefer the following
+ * qemu_open/qemu_create that take an "Error **errp"
+ */
 int qemu_open_old(const char *name, int flags, ...);
+int qemu_open(const char *name, int flags, Error **errp);
+int qemu_create(const char *name, int flags, mode_t mode, Error **errp);
 int qemu_close(int fd);
 int qemu_unlink(const char *name);
 #ifndef _WIN32
diff --git a/util/osdep.c b/util/osdep.c
index 28aa89adc9..c99f1e7db2 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -341,6 +341,22 @@ qemu_open_internal(const char *name, int flags, mode_t mode, Error **errp)
 }
 
 
+int qemu_open(const char *name, int flags, Error **errp)
+{
+    assert(!(flags & O_CREAT));
+
+    return qemu_open_internal(name, flags, 0, errp);
+}
+
+
+int qemu_create(const char *name, int flags, mode_t mode, Error **errp)
+{
+    assert(!(flags & O_CREAT));
+
+    return qemu_open_internal(name, flags | O_CREAT, mode, errp);
+}
+
+
 int qemu_open_old(const char *name, int flags, ...)
 {
     va_list ap;
-- 
2.26.2


