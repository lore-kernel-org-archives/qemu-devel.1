Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31A4C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5883E20753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 18:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xs2Pl85Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5883E20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbuJ-0004IJ-An
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 14:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jMbs7-0001yS-VR
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jMbs6-0006jR-FV
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:25:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jMbs6-0006jK-CA
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 14:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586456750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RqXrpKI0mE3/hUQ2AM6vqbuPQRfTIg6Z844cRK/kSmw=;
 b=Xs2Pl85YsjskPpV4MbFna7YK88zhfYIrb1Sz1pE2+r5lmO23TgSWHZvlRfGZnfu/YNwbep
 lWM7Xv+L7kr4Z6zzb8eycNqEqr9Q07BfWeIfh5ZkWcJIPRC0wk3pP4821qkPRwuFeCnJ5o
 YzItebfM4XgpdOqC+SpEFaA/kbN01mc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-pNPSjhLmMZiz0PnXad7wgw-1; Thu, 09 Apr 2020 14:25:48 -0400
X-MC-Unique: pNPSjhLmMZiz0PnXad7wgw-1
Received: by mail-wr1-f72.google.com with SMTP id v14so7019291wrq.13
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 11:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cffX4MrmggT23maUJWPQXr4qj7SC2ubmE9gy9f7kJs8=;
 b=KXCA8BqMtLqSIOeSY0NEXJmix0a2jv/Bpi6Q2hZoicl9iCZN4QbN5rLn9Ilj11/6OE
 kYHifR61YKCYY0BXfI/G2O71sutAAPu8yyXB3Vj561wTvcZNr/zGcG8a2kwQaJlM5gOh
 uCc0fpf4boUU8ZGRUcfYhaJ66waE+p4YhYxHorsJ0tDyk33DvGOXCsEhkRXHTwhSfqDD
 ofQBIVhSysSXP3NP2DEscHuyPx5uTyA2bknxlC4gF6tUataBYnvmKbNbnUXRgCrnkgw4
 Re27xWbcULjZEk0mNM6/KmYqXxdWcjo0tG25aNnTegiHp7nvFeiGDhHrTH4zyZT2JrCn
 s2og==
X-Gm-Message-State: AGi0PuYGUm/7oZg54fgTCj7Wo+R6vIsPTl4Ck1dBbDBBZG8HZZl3c3Se
 OSz2hgFXaKe6WIb09QabdHAlp93ruc0BFYw0p78X7CAbRMqM3+2YvZc7VEWdEE6NgM3ELkgrLbc
 q2KI08qXtsxjS/o0=
X-Received: by 2002:adf:92a3:: with SMTP id 32mr514611wrn.254.1586456747153;
 Thu, 09 Apr 2020 11:25:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypKakBdFqhbAHvUpBRceralisIeVvxfK4jSk2syX+7vmgV/djq7CyemxbLQS2k3RmcEwl3oY2Q==
X-Received: by 2002:adf:92a3:: with SMTP id 32mr514598wrn.254.1586456746978;
 Thu, 09 Apr 2020 11:25:46 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id p13sm40373704wru.3.2020.04.09.11.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 11:25:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] gdbstub: Assert len read from each register
Date: Thu,  9 Apr 2020 14:25:37 -0400
Message-Id: <20200409182538.40816-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409182538.40816-1-peterx@redhat.com>
References: <20200409182538.40816-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This can expose the issue earlier on which register returned the wrong
result.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 gdbstub.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 171e150950..69656e1052 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -911,17 +911,23 @@ static int gdb_read_register(CPUState *cpu, GByteArra=
y *buf, int reg)
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     CPUArchState *env =3D cpu->env_ptr;
     GDBRegisterState *r;
+    int len =3D 0, orig_len =3D buf->len;
=20
     if (reg < cc->gdb_num_core_regs) {
-        return cc->gdb_read_register(cpu, buf, reg);
+        len =3D cc->gdb_read_register(cpu, buf, reg);
+        goto out;
     }
=20
     for (r =3D cpu->gdb_regs; r; r =3D r->next) {
         if (r->base_reg <=3D reg && reg < r->base_reg + r->num_regs) {
-            return r->get_reg(env, buf, reg - r->base_reg);
+            len =3D r->get_reg(env, buf, reg - r->base_reg);
+            break;
         }
     }
-    return 0;
+
+out:
+    assert(len =3D=3D buf->len - orig_len);
+    return len;
 }
=20
 static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
--=20
2.24.1


