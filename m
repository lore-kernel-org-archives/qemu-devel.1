Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC765C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8F0206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tW6S/bP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8F0206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYat-00054b-LI
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKX-000788-Ju
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKV-0001go-D3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:17 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:35405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKV-0001gI-9R
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:15 -0400
Received: by mail-qk1-x741.google.com with SMTP id k13so8205838qki.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yA2MVFEgaNK4nASIU4YwfLKatFbmzL92LfjZ1EBu5j0=;
 b=tW6S/bP1K8jbImgGY810ZRZ5TTGl80HzzkmPWP2sFPhQ/bjUMQa63XOid8gBfBnbZu
 ubkStz5VHgUNOWAej8EEDCTEioaMMb7swf0vpXm0rLA9aCj99WWm5/ibM0wfLRR3yz0N
 MlcUAy0yzwDol10jS9RDJt9WgMY5pGkSzTw/7GdkjmmX3rZy39FScA9SJmx/AWkv2IMt
 KamhVaYuLi8XOMY0t0SLTg0pCY7mhaDfJTzkkFqOqm4XDIa2IUKb9Tht27OGWOWB44t3
 wvRhAJdnqbzelkbACyYquktykQDFjN42qAUJpuVyT4J5UuQGQ41rR7XJTNW0V3LX6hKu
 /5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yA2MVFEgaNK4nASIU4YwfLKatFbmzL92LfjZ1EBu5j0=;
 b=WBQi3u5KHTc5hEwoNU7oDmxxivlP4hvCfscprNb5iIozfWCXJhDLOykf7nqUDTPq7Z
 ztWJK9WAXxSybQQEa2yaUEs8WjjeD0IbRdKWUUxZ5XPbvrhHoocAPuAbTCer35QSJHAP
 5vEOAfh1o7ygYVCHl7Oei9mV5DmgzWyVxbLqOAabW0YDEiXTiLV6CnfH3INQQ6WDxApA
 jldM+ZIJrTsYrjeBz1IXcxXEQWPFOlUqJNCWfr1pCLlJcJHaMTMWzdES3D5V22PnP9/w
 ytyn7PNzRNMOyc37A+LIt/fgm+ELMAqNO55GgIx8BzS144I8EjZP3O+P0vmwzAeKNtWj
 U+Rg==
X-Gm-Message-State: ANhLgQ10jw/LBu8giPiOQRSpCOQ7/AaZHAOwInF8VefCFOpIPBES7wiX
 XKfY11V50IpphlOhawJ7WSQTJqhLnrd7jw==
X-Google-Smtp-Source: ADFU+vuhkl+JVA8iANM0+T9c3E9/A5b6tcnFQb3UhXHhSw3T1MNf8s4/FRr6zkJWT6lMhy+UhoLinQ==
X-Received: by 2002:a37:9dc9:: with SMTP id g192mr10248319qke.50.1585251493546; 
 Thu, 26 Mar 2020 12:38:13 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:13 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 29/74] gdbstub: convert to cpu_halted
Date: Thu, 26 Mar 2020 15:31:11 -0400
Message-Id: <20200326193156.4322-30-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 013fb1ac0f..d95c32997a 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2063,10 +2063,10 @@ static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user_ctx)
         g_autofree char *cpu_name;
         cpu_name  = object_get_canonical_path_component(OBJECT(cpu));
         g_string_printf(rs, "%s %s [%s]", cpu_model, cpu_name,
-                        cpu->halted ? "halted " : "running");
+                        cpu_halted(cpu) ? "halted " : "running");
     } else {
         g_string_printf(rs, "CPU#%d [%s]", cpu->cpu_index,
-                        cpu->halted ? "halted " : "running");
+                                   cpu_halted(cpu) ? "halted " : "running");
     }
     trace_gdbstub_op_extra_info(rs->str);
     memtohex(gdbserver_state.str_buf, (uint8_t *)rs->str, rs->len);
-- 
2.17.1


