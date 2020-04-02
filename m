Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D54BC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDBF206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 12:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObmSfAgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDBF206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJyje-0002QE-2N
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 08:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <singhalsimran0@gmail.com>) id 1jJyio-0001zN-VM
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <singhalsimran0@gmail.com>) id 1jJyin-000071-Uu
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:13:22 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55987)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <singhalsimran0@gmail.com>)
 id 1jJyin-00006X-PP
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 08:13:21 -0400
Received: by mail-pj1-x1043.google.com with SMTP id fh8so1449698pjb.5
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 05:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=nKCkeZrC8oFdq0zgwOe4LzwhiZdVsuP3A47EovsJSZo=;
 b=ObmSfAgP4dXfxcI4AkJkDuDR4Sg8OyXMLO3Qz90Ny/+lqI+OnUvOy3I7xHuSOlvrSR
 wmATmCBCGcDsYSPh+/G2PFo4gbf4+IA7kQqSOVVPrwChvnGt3LSne8Qg1e3lm3/6zHw/
 hlRy4SY+gvTrRF5fhILeDrz6W1dSfyr82otMDv4xh5Utx1SZq6s2YxZpQsg6K3qFwp7Y
 2qOK8yDIZlsiVQB+NEVQb0bhwfKbHNn/8EJMDNJeCmN1KwBmi6PPiNLAmIrspIIR3bPs
 kI4gQKx7y97z1H1xCTpE/ZIa/2xgRZDBw+VLGrvWy+a2Hq68XJvVyaA2ydiTLKM5Vc81
 m8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=nKCkeZrC8oFdq0zgwOe4LzwhiZdVsuP3A47EovsJSZo=;
 b=crtpGe+q7BnMzTlUqocbufTjriJqGWbIS0a3L/LpcBvrWEsy5yxghNmJ6G5Sdx8X51
 8n3Varp3dFvvCb8BCBZoacCIJkVEnH9GHxtVUu9X58UqncqDJqso3q4sGoNdT7EzHV4F
 4uJvQfJs7UwyVRcttdu+01OkfavBYYp8ON+cdYump+cb2Kwo6fPkhZ2RqvSO2OmqBuQD
 Oqnjio2SBlJr0YWrreFW3+956q0SYo70D/HuEEecR5dpbfHCAEsjjwkd0MGGJzMlaYfV
 V9BJmxPAMvc+PRi2Yqosr2nY7GeE0bhRwjUft7NQ1SyOfypOjYjpZtduwyODzq5YbzfU
 wjGw==
X-Gm-Message-State: AGi0PuYCAF9NVDYSA76jXOK9EmfdxaE+gctnhA/yGB9SctR2Z2SyyUQH
 nxik+VhAA2P9Ez9mhFL2zUc=
X-Google-Smtp-Source: APiQypLEJzIdsU3efKXGQ+xciHDpM3HWDt/Snqe8N6ddBk9DzD7kG7gLyi6ugBzcclMrbVGBdSd5Xw==
X-Received: by 2002:a17:902:7603:: with SMTP id
 k3mr2758929pll.100.1585829600136; 
 Thu, 02 Apr 2020 05:13:20 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:99d:cf8:4926:6e0b:60ca:635c])
 by smtp.gmail.com with ESMTPSA id
 kb18sm3989420pjb.14.2020.04.02.05.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 05:13:19 -0700 (PDT)
Date: Thu, 2 Apr 2020 17:43:13 +0530
From: Simran Singhal <singhalsimran0@gmail.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] qobject: json-streamer: Remove double test
Message-ID: <20200402121313.GA5563@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the duplicate test "parser->bracket_count >= 0".

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 qobject/json-streamer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 47dd7ea576..ef48185283 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -85,7 +85,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
     g_queue_push_tail(&parser->tokens, token);
 
     if ((parser->brace_count > 0 || parser->bracket_count > 0)
-        && parser->bracket_count >= 0 && parser->bracket_count >= 0) {
+        && parser->bracket_count >= 0) {
         return;
     }
 
-- 
2.17.1


