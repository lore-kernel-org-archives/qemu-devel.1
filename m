Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C7DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 02:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132F12087D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 02:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lvJL9m8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132F12087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNoUu-0001HU-I9
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 22:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gongwilliam@163.com>)
 id 1kNoUE-0000pY-Ce; Wed, 30 Sep 2020 22:38:26 -0400
Received: from m12-15.163.com ([220.181.12.15]:38405)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <gongwilliam@163.com>)
 id 1kNoU6-0000kr-7U; Wed, 30 Sep 2020 22:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4b2/c
 bMtJBXy9Hc5/wPmNYe5sKGJeE/1UJcc0lxxC04=; b=lvJL9m8rYsx4dy06K0E0h
 wfsi7j+G2f1Hk472H3Hhzt9TlY3uh+Q7dUbUYvFG8ytvobvk5Qu64FQE0FlCDUFQ
 QdT1Om/y0XKGwJOWxmBro6WlvG9a6n1Tf7ZbGE9XvcygrNQez8cs78qL7MRniPmn
 Zdr5UwAJ5BG225ItE++BbE=
Received: from 163.com (unknown [119.136.88.182])
 by smtp11 (Coremail) with SMTP id D8CowACH+hApPXVfUEwKAg--.58217S2;
 Thu, 01 Oct 2020 10:21:29 +0800 (CST)
From: mingwei <gongwilliam@163.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] sheepdog driver patch: fixs the problem of qemu
 process become crashed when the sheepdog gateway break the IO and then
 recover
Date: Wed, 30 Sep 2020 19:21:27 -0700
Message-Id: <20201001022127.7315-1-gongwilliam@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowACH+hApPXVfUEwKAg--.58217S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr47tw18XrW3Kr1rJryfXrb_yoW8JFyfpF
 9Igw45trykGFn7WFsrA34kA348CwsxGFyIqr4Uur45G345XwnIqFyxK3yUAr45ZrsYk345
 tryqq39xJF4jg3DanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmzuAUUUUU=
X-Originating-IP: [119.136.88.182]
X-CM-SenderInfo: 5jrqw45looxtrp6rljoofrz/1tbiWQqwVlWBs02LFAAAsA
Received-SPF: pass client-ip=220.181.12.15; envelope-from=gongwilliam@163.com;
 helo=m12-15.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 22:21:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, sheepdog@lists.wpkg.org, qemu-block@nongnu.org,
 mreitz@redhat.com, mingwei <gongwilliam@163.com>, namei.unix@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

this patch fixs the problem of qemu process become crashed when the sheepdog gateway break the IO for a few seconds and then recover.

problem reproduce:
1.start a fio process in qemu to produce IOs to sheepdog gateway, whatever IO type you like.
2.kill the sheepdog gateway.
3.wait for a few seconds.
4.restart the sheepdog gateway.
5.qemu process crashed with segfault error 6.

problem cause:
the last io coroutine will be destroyed after reconnect to sheepdog gateway, but the coroutine still be scheduled and the s->co_recv is still the last io coroutine pointer which had been destroyed, so when this coroutine go to coroutine context switch, it will make qemu process crashed.

problem fix:
just make s->co_recv = NULL when the last io coroutine reconnect to sheepdog gateway.

Signed-off-by: mingwei <gongwilliam@163.com>
---
 block/sheepdog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 2f5c0eb376..3a00f0c1e1 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -727,6 +727,7 @@ static coroutine_fn void reconnect_to_sdog(void *opaque)
                        NULL, NULL, NULL);
     close(s->fd);
     s->fd = -1;
+    s->co_recv = NULL;
 
     /* Wait for outstanding write requests to be completed. */
     while (s->co_send != NULL) {
-- 
2.25.1



