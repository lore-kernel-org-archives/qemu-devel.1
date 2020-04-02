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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D5DC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33C62078B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X88Ku/mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33C62078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK4cK-000782-1y
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 14:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <singhalsimran0@gmail.com>) id 1jK4aK-00058c-CT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <singhalsimran0@gmail.com>) id 1jK4aH-0006Nh-U2
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:28:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <singhalsimran0@gmail.com>)
 id 1jK4aH-0006NM-Oh
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:28:57 -0400
Received: by mail-pg1-x542.google.com with SMTP id b1so2220408pgm.8
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 11:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=Mb05tnqjr3/PFwxnbA3V4ie/CsDaajNsdY5rXT4XyEE=;
 b=X88Ku/mbvBpCr3HN9SnATbWjsOM1oZXwnL7PRy+/o+TqW6lCpGH/T8QA0S5tHDxUFM
 Op2zM2xo/EtEQJ80puQzAH74MkIrqmSyzcDU79/8NEVaqpE0qfvDY/fkAAGGFX6TwKnT
 ogQi2r6Hv9AMWCGwjjr+wJyyZQXz/qFMyH0X4uUjN2rnvbWBjcLzyAIBzI5A/M7sac36
 DRSt3O9w6zkHcybzdfDRYVksnaM+NQL7HorzcYQqzJRy+kNDQCAvjYDR/y1NRc6/kXdM
 3tXmo4baI67fUJ5b54dPsR7nW2/dP6/zFixkYEHACv/HFgcsb75d/XRizg2pviQ9IsLH
 6TDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=Mb05tnqjr3/PFwxnbA3V4ie/CsDaajNsdY5rXT4XyEE=;
 b=HfKMg0z9UA6xYQjfPdwVdb79BuyHAcGrN207hPpB7VgZsUPacBpjQ8F18+GZEuwJEo
 HMQ7phljEhNT4QGUJBqS2toe8+mJYZurcnk9HUq/nzZlXn/4dVy/O/uLoBssCNgWiTE2
 yhD/yXRnCyuU9NRntD7uxk9YXOo8Swqj33ZG2UwaKLj8V1hj5O3QwC6Hi63DRpCPeH6C
 gOxIx0CsjKXq4ujQe1YtWQMLnYoPU/uvnKWL7MbLUddZs8R+kB0oD6bwlZAaqz/z6T2k
 7C8HsEfvuGeV2s79WGqhcP5ppXxBcE7D6MV/JioSI7WffYgtmtQ6qOzGZ5NT7QY4R3IL
 vjCQ==
X-Gm-Message-State: AGi0PuYJDEFLuMSymMUsX6qxeVxi4e0SyNWaFsfOKxNt/uemSXYhFK6T
 rnbm2xQp+Dg9VBOsaVZNst8=
X-Google-Smtp-Source: APiQypLvs88+6uUGw7GQfbA6QGWa028+jHH96qatxmG+lK9UYdKHqegNUpt5zVlDqXFy65bCLCfPRQ==
X-Received: by 2002:a63:df42:: with SMTP id h2mr4609096pgj.216.1585852136512; 
 Thu, 02 Apr 2020 11:28:56 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2405:205:1380:eac:4926:6e0b:60ca:635c])
 by smtp.gmail.com with ESMTPSA id
 b2sm4164130pjc.6.2020.04.02.11.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 11:28:55 -0700 (PDT)
Date: Thu, 2 Apr 2020 23:58:48 +0530
From: Simran Singhal <singhalsimran0@gmail.com>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3] qobject: json-streamer: Change bracket_count to brace_count
Message-ID: <20200402182848.GA3023@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

Change the "parser->bracket_count >= 0" to "parser->brace_count >= 0"
to fix the typo.

Fixes: 8d3265b3

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
Changes in v3:
	-Add "Fixes: 8d3265b3" in commit message.

Changes in v2:
        -No need to remove the duplicate occurrence of "parser->bracket_count >= 0"
        but actually it is a typo and one occurence should be "parser->brace_count >= 0".

 qobject/json-streamer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qobject/json-streamer.c b/qobject/json-streamer.c
index 47dd7ea576..b93d97b995 100644
--- a/qobject/json-streamer.c
+++ b/qobject/json-streamer.c
@@ -85,7 +85,7 @@ void json_message_process_token(JSONLexer *lexer, GString *input,
     g_queue_push_tail(&parser->tokens, token);
 
     if ((parser->brace_count > 0 || parser->bracket_count > 0)
-        && parser->bracket_count >= 0 && parser->bracket_count >= 0) {
+        && parser->brace_count >= 0 && parser->bracket_count >= 0) {
         return;
     }
 
-- 
2.17.1


