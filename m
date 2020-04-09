Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF1FC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:53:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469E720753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDI1+tB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469E720753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMaQy-0006Ug-DI
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 12:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jMaNY-00040S-WF
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jMaNV-0004Hm-Uh
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jMaNV-0004HQ-RE
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586451008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83VDjDS4t7UbAcIlk5RNPhROXasu3MLja0CFwm1jYMc=;
 b=YDI1+tB4eSihqeZtuLJdsFbpdSprVm7c4SGLEs9+TQT/+cw+86LhzNN5v2B2H4chEd9FpA
 RGmeI82j5lfymuF/yPyl/MKBnSnXq+s1iqW2NcnpUqU50XVZ2IyTom7yq7TLRyHh8tS4SZ
 9oe9NKzRVsfm21OUm2FEC4PwKt2krts=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-g1FpVgIRPHaJEOlnNipopg-1; Thu, 09 Apr 2020 12:50:02 -0400
X-MC-Unique: g1FpVgIRPHaJEOlnNipopg-1
Received: by mail-wm1-f72.google.com with SMTP id o5so274257wmo.6
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 09:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KbRwcfAlvsMLh5EY7Ycxn7t4bf3uXxDpsBXPo8uidoI=;
 b=hwjIcZrzbbnyrz+B10NlQOqLciHqFzsEi261LTJb4hsWGqLky7Gr04FG8qvEcezC1B
 3zcd5qjZMYy4UMXwFE4qXCjoAQMdW0xJnCCq9bKrDfs0Dh2nUgJl6FhfUhjTHW+DEugM
 xUBFLEECLXB4m6l0NZjQeE2ZxsXyYydVS37lq639Xm9N25NFabRC4wKCm8J3YS2JfmEn
 PZL/T7zN/1egGUyP+/eZEHIUGbXpO13TnDXZVHRpKQ3Kiw2hxwAZ2YeYsg9zc5I+3Nbs
 WX8zYOjuz3+D5zo3MZbtuegiQzy9UVNefQgvZbqYYOX78tCmi97mug8Tn0zFWQU9YJ80
 yhKg==
X-Gm-Message-State: AGi0PuaV0RaNL7F4306pPqvITkt4pS9FhifEdeSna6AwQcSpkYezMoAj
 N/la3gTs9DOmFgWJlUjHwIDJf5uULw1J+PVPldrXZ96O2672zJmhaaKKwkSJgKr8LBvfAXIxvru
 oTqG5JAnfUEvUUhE=
X-Received: by 2002:adf:f88b:: with SMTP id u11mr96690wrp.84.1586451001046;
 Thu, 09 Apr 2020 09:50:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypIS9lhqO6UPIH4XeX7RggNPHS5aJK3bmQSHOqa3PfOrmBnW7x3pbkdutt8pp/NoBCm0drlYpw==
X-Received: by 2002:adf:f88b:: with SMTP id u11mr96678wrp.84.1586451000892;
 Thu, 09 Apr 2020 09:50:00 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id h2sm3310915wmf.34.2020.04.09.09.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 09:50:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] gdbstub: Assert len read from each register
Date: Thu,  9 Apr 2020 12:49:53 -0400
Message-Id: <20200409164954.36902-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409164954.36902-1-peterx@redhat.com>
References: <20200409164954.36902-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This can expose the issue earlier on which register returned the wrong
result.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 gdbstub.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 171e150950..f763545e81 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -911,17 +911,22 @@ static int gdb_read_register(CPUState *cpu, GByteArra=
y *buf, int reg)
     CPUClass *cc =3D CPU_GET_CLASS(cpu);
     CPUArchState *env =3D cpu->env_ptr;
     GDBRegisterState *r;
+    int len =3D 0, orig_len =3D buf->len;
=20
     if (reg < cc->gdb_num_core_regs) {
-        return cc->gdb_read_register(cpu, buf, reg);
+        len =3D cc->gdb_read_register(cpu, buf, reg);
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
+    assert(len =3D=3D buf->len - orig_len);
+
+    return len;
 }
=20
 static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
--=20
2.24.1


