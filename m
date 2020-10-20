Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4E1C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:49:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4E22075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="lv64FwYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4E22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVip-00065a-Jd
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0364a281a649eb6eb2ef1e5c92c700fb1d1ad1dc@lizzy.crudebyte.com>)
 id 1kYVf2-0001gA-LY
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:45:48 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:55991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0364a281a649eb6eb2ef1e5c92c700fb1d1ad1dc@lizzy.crudebyte.com>)
 id 1kYVez-00038v-M1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=9wx9tN7qlWoS6hALtpkXOw4Corur4LktIe88EM4Me8A=; b=lv64F
 wYmJps2siisHE5ramtXEUUTtZT9bP3xqR4uzSSEGJ8bTQ1VB0G11h/K7ns5EsYqxx4bSJvFfek/8f
 YVXwtD0svoPBQ8Xetp2wQpVmKoz7k+9LThS5AKyzmg49iKU8MIuMB+U6zS50rExQ06VTj9c0K/m5D
 xVfqKCJ+arQoOSCWAF2wQ9yYPviCbT2K4zvY/eXZa/WJzp5CwjrQJRQk4wmnqgRp2M0FA8OOoiacL
 O5ScDOYqmKCLKJsyh9OhHE2Ep4hxALN7kutOa5FGbE0bD4jvXpO5Nlxc03lv6WAuLLaNd0H18NHD/
 qiHguFXUmG3eRiFZ0MemmZT5ib/Yw==;
Message-Id: <0364a281a649eb6eb2ef1e5c92c700fb1d1ad1dc.1604067568.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604067568.git.qemu_oss@crudebyte.com>
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 18:09:41 +0200
Subject: [PULL v2 08/16] tests/9pfs: Turn fs_mkdir() into a helper
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=0364a281a649eb6eb2ef1e5c92c700fb1d1ad1dc@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 07:59:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

fs_mkdir() isn't a top level test function and thus shouldn't take
the "void *obj, void *data, QGuestAllocator *t_alloc" arguments.
Turn it into a helper to be used by test functions.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160321018148.266767.15959608711038504029.stgit@bahia.lan>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 3c187cdc08..2ea555fa04 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -972,11 +972,8 @@ static void fs_flush_ignored(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(wnames[0]);
 }
 
-static void fs_mkdir(void *obj, void *data, QGuestAllocator *t_alloc,
-                     const char *path, const char *cname)
+static void do_mkdir(QVirtio9P *v9p, const char *path, const char *cname)
 {
-    QVirtio9P *v9p = obj;
-    alloc = t_alloc;
     char **wnames;
     char *const name = g_strdup(cname);
     P9Req *req;
@@ -1031,7 +1028,7 @@ static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
     g_assert(root_path != NULL);
 
     do_attach(v9p);
-    fs_mkdir(v9p, data, t_alloc, "/", "01");
+    do_mkdir(v9p, "/", "01");
 
     /* check if created directory really exists now ... */
     g_assert(stat(new_dir, &st) == 0);
-- 
2.20.1


