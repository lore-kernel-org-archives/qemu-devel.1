Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F13C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098442225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="FNH8u0l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098442225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZWgv-0003E3-UU
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <472c18b8bf20f111b02abc403407efd88b6281d7@lizzy.crudebyte.com>)
 id 1kZWUp-0003ZY-5i
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:51:27 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:35155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <472c18b8bf20f111b02abc403407efd88b6281d7@lizzy.crudebyte.com>)
 id 1kZWUl-0007DM-1z
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 04:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=7g6F1Ukgu57xGK4R3WuXTx4Ntw5GtnOnSXJXaKwMoTw=; b=FNH8u
 0l3W/maBlBi/GkNampWLkTOhUArzo46dwlrPJhUbZqfPfyxDpKh7R8BrPmufW25/7cPFjCUhSDARy
 T0F7RB1MOLmxJx4+tieKWNHDXH0rhIg0kFEP1iW5AsOzj041/Xm7+6BDshlyv6mNJ0LQ1wOsJNYOv
 hQl5qsBJumMVnslctuc/0XifpAVszCcWf6UD0yiqdlg3/KdPKJecqZREhBK1aKssnZDh/sEyMSMt3
 WzxJLgHCrM27ygQZFvJHr04AR+HwhjyyXx9G+26E1VlFuFlXyGHbNlIBrY8vi01rTaSh8Eb4FvDNQ
 rkIRkEPoji+eeJHQGMJoxRpL6z24A==;
Message-Id: <472c18b8bf20f111b02abc403407efd88b6281d7.1604309512.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604309512.git.qemu_oss@crudebyte.com>
References: <cover.1604309512.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 21 Oct 2020 14:28:37 +0200
Subject: [PULL v3 13/17] tests/9pfs: add local Tunlinkat file test
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=472c18b8bf20f111b02abc403407efd88b6281d7@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 04:48:35
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

This test case uses a Tunlinkat request to remove a regular file using
the 9pfs 'local' fs driver.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <4eabeed7f662721dd5664cb77fe36ea0aa08b1ec.1603285620.git.qemu_oss@crudebyte.com>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index c685db27d9..52ecdfab7a 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -1196,6 +1196,29 @@ static void fs_create_file(void *obj, void *data, QGuestAllocator *t_alloc)
     g_free(new_file);
 }
 
+static void fs_unlinkat_file(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtio9P *v9p = obj;
+    alloc = t_alloc;
+    struct stat st;
+    char *new_file = virtio_9p_test_path("04/doa_file");
+
+    do_attach(v9p);
+    do_mkdir(v9p, "/", "04");
+    do_lcreate(v9p, "04", "doa_file");
+
+    /* check if created file exists now ... */
+    g_assert(stat(new_file, &st) == 0);
+    /* ... and is a regular file */
+    g_assert((st.st_mode & S_IFMT) == S_IFREG);
+
+    do_unlinkat(v9p, "04", "doa_file", 0);
+    /* file should be gone now */
+    g_assert(stat(new_file, &st) != 0);
+
+    g_free(new_file);
+}
+
 static void *assign_9p_local_driver(GString *cmd_line, void *arg)
 {
     virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
@@ -1238,6 +1261,7 @@ static void register_virtio_9p_test(void)
     qos_add_test("local/create_dir", "virtio-9p", fs_create_dir, &opts);
     qos_add_test("local/unlinkat_dir", "virtio-9p", fs_unlinkat_dir, &opts);
     qos_add_test("local/create_file", "virtio-9p", fs_create_file, &opts);
+    qos_add_test("local/unlinkat_file", "virtio-9p", fs_unlinkat_file, &opts);
 }
 
 libqos_init(register_virtio_9p_test);
-- 
2.20.1


