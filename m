Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70315C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DB220659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TQkexZoJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DB220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWJp-0004qO-Eq
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jgWHJ-0001yJ-FQ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:30:09 -0400
Received: from mail-m975.mail.163.com ([123.126.97.5]:52790)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jgWHC-0007mR-AT
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=w0qGcowd9x8TqbX6yJ
 0T0CA8Zf4P1IdC+K0kSwC9fYI=; b=TQkexZoJPz3DUz0bbgLY6l1DXCkzAYCKE5
 2+mlDbqhdSCoEq0ZumrBhnMgGKbpc5QwDSvvqeyr3fEquzEz6RNcCkBWbvlbahPr
 ic5n3hAljBlePuG4RtpwoHOOwYDILM6RjEZnY7BLYh7VTwEhaSYQplYIaLAruaDI
 CA47cSR9U=
Received: from localhost.localdomain (unknown [115.200.200.105])
 by smtp5 (Coremail) with SMTP id HdxpCgDneQpXzNdeUoupAQ--.290S4;
 Thu, 04 Jun 2020 00:14:18 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: berrange@redhat.com,
	marcandre.lureau@redhat.com,
	zxq_yx_007@163.com
Subject: [PATCH] tests: fix a memory in test_socket_unix_abstract_good
Date: Wed,  3 Jun 2020 09:14:09 -0700
Message-Id: <20200603161409.54682-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgDneQpXzNdeUoupAQ--.290S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jr4UKryxXF4UuryxZFy5urg_yoW8Jr13pw
 n8JFyIkr4xJrykuF4DG3W7KrW8Aa97Cw4Yvry8Aw1UZF4DCF1kJwn5tryUt34DGr4rZr1a
 yFyDKrn09w1UAF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRHv3nUUUUU=
X-Originating-IP: [115.200.200.105]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFBg4bVaD58wyUQABsF
Received-SPF: pass client-ip=123.126.97.5; envelope-from=liq3ea@163.com;
 helo=mail-m975.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:14:23
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Li Qiang <liq3ea@163.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After build qemu with '-fsanitize=address' extra-cflags,
'make check' show following leak:

=================================================================
==44580==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 2500 byte(s) in 1 object(s) allocated from:
    #0 0x7f1b5a8b8d28 in __interceptor_calloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xded28)
    #1 0x7f1b5a514b10 in g_malloc0 (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x51b10)
    #2 0xd79ea4e4c0ad31c3  (<unknown module>)

SUMMARY: AddressSanitizer: 2500 byte(s) leaked in 1 allocation(s).

Call 'g_rand_free' in the end of function to avoid this.

Fixes: 4d3a329af59("tests/util-sockets: add abstract unix socket cases")
Signed-off-by: Li Qiang <liq3ea@163.com>
---
 tests/test-util-sockets.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/test-util-sockets.c b/tests/test-util-sockets.c
index 2ca1e99f17..ca6671f9bf 100644
--- a/tests/test-util-sockets.c
+++ b/tests/test-util-sockets.c
@@ -312,6 +312,7 @@ static void test_socket_unix_abstract_good(void)
     g_thread_join(serv);
 
     g_free(abstract_sock_name);
+    g_rand_free(r);
 }
 #endif
 
-- 
2.17.1


