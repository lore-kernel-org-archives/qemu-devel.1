Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699FEC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF24920719
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ac/z/Jsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF24920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWaU-0001G8-N7
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <603cc76a60691b288947c88ad63b7b0d616f98b6@lizzy.crudebyte.com>)
 id 1kZWTe-0002Ea-4o
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:50:14 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:45525)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <603cc76a60691b288947c88ad63b7b0d616f98b6@lizzy.crudebyte.com>)
 id 1kZWTb-0006jz-Ki
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=9mbFW1L9cJNMO3v79t1MYLd1hVqVwJ9dF+hqdbpIaYc=; b=ac/z/
 JsqpqZOdo4X3sf0TyqKFMjzw06ZGX5tJroMZErIEyXepEUkcQDoZDGzvIklv9GpZMaCV7q59xLabe
 q7j/p81LsGSjvmP16wyG+/vamw+tvDeCugzPGtRli3/q5YvNmcVLGEq3Rc8TbaPD0hLkK2Exmg23A
 hX21+uQjaCJS5OHw+NGxp+c7Au3X3RdyHhrHnyUrKbMFqZyFxAJ6h+E3kuPB5BdZQec2xWX1pfaU+
 ugRgDsnHcpUhy2gtuyjDL6nsWg4g64stad+qj7Gy4z8nPpSecunQ0LAJZFKIUej6UJ1aj21jKfyX4
 +mVfXs4nU+z6lrZzblIkXOi/rXjQQ==;
Message-Id: <603cc76a60691b288947c88ad63b7b0d616f98b6.1604309512.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604309512.git.qemu_oss@crudebyte.com>
References: <cover.1604309512.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 30 Oct 2020 13:46:34 +0100
Subject: [PULL v3 04/17] tests/9pfs: Force removing of local 9pfs test
 directory
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=603cc76a60691b288947c88ad63b7b0d616f98b6@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 04:48:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

No need to get a complaint from "rm" if some path disappeared for some
reason.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160406199444.312256.8319835906008559151.stgit@bahia.lan>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
index 3671043108..be91662c6f 100644
--- a/tests/qtest/libqos/virtio-9p.c
+++ b/tests/qtest/libqos/virtio-9p.c
@@ -67,7 +67,7 @@ void virtio_9p_create_local_test_dir(void)
 void virtio_9p_remove_local_test_dir(void)
 {
     g_assert(local_test_path != NULL);
-    char *cmd = g_strdup_printf("rm -r '%s'\n", local_test_path);
+    char *cmd = g_strdup_printf("rm -fr '%s'\n", local_test_path);
     int res = system(cmd);
     if (res < 0) {
         /* ignore error, dummy check to prevent compiler error */
-- 
2.20.1


