Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443EBC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E2E420724
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="CJpuABko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2E420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVkr-000102-6o
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b103dd70c775d6c449cff186f663b3c61d161a98@lizzy.crudebyte.com>)
 id 1kYVee-0000yJ-IT
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:45:24 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:48181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b103dd70c775d6c449cff186f663b3c61d161a98@lizzy.crudebyte.com>)
 id 1kYVec-00037D-1K
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=SZ1nQMn8oa+srNc/3IYZzRo1jg+81bKQghHy2wmTYYk=; b=CJpuA
 BkoSnrf+nyOjpIPg4+AIVzMI/Pz6lpq5H1tOdOoF0ZhSRAOXfm7/9IHcGIB4a/RmobcQB4qEIhsmG
 vrp2OY6YRZ/0fqSdzrUL9ahkVa++EXREh6uCRhD9MiE7VkmWckYP0yCWqGL6N7jZ+okLL3w1wPb2J
 zM2/bsD2w75ILCOpc9DclVBD9FRDEf8pksxS0VXVudWPDhnojviG0xzBQQF4ThFWRKXyTmmZXfQOF
 5ElzpwCQOzEXz2b5LxM6gtMxvj6kN+dGY76Ur+smbX2ULxy115ubAdmUfsga2+9XuPMoASDmaczoI
 XUfrUQHiLDqUx6w7FXsia5JYgYfRw==;
Message-Id: <b103dd70c775d6c449cff186f663b3c61d161a98.1604067568.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604067568.git.qemu_oss@crudebyte.com>
References: <cover.1604067568.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 20 Oct 2020 18:09:27 +0200
Subject: [PULL v2 05/16] tests/9pfs: Set alloc in fs_create_dir()
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=b103dd70c775d6c449cff186f663b3c61d161a98@lizzy.crudebyte.com;
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

fs_create_dir() is a top level test function. It should set alloc.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160321016764.266767.3763279057643874020.stgit@bahia.lan>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 59bcea4c30..93a2a4cd76 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -1019,6 +1019,7 @@ static void fs_readdir_split_512(void *obj, void *data,
 static void fs_create_dir(void *obj, void *data, QGuestAllocator *t_alloc)
 {
     QVirtio9P *v9p = obj;
+    alloc = t_alloc;
     struct stat st;
     char *root_path = virtio_9p_test_path("");
     char *new_dir = virtio_9p_test_path("01");
-- 
2.20.1


