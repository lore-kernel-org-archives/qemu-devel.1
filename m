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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A6EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5B220757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMK00R9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5B220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3YJ-0005JA-NE
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <singhalsimran0@gmail.com>) id 1jK3VN-00029g-Bz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <singhalsimran0@gmail.com>) id 1jK3VM-0002ZU-3P
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:19:49 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43233)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <singhalsimran0@gmail.com>)
 id 1jK3VL-0002WW-Tk
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:19:48 -0400
Received: by mail-pf1-x444.google.com with SMTP id f206so2044603pfa.10
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 10:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=Sd4HKvpMJXeiLcbFDPVmWsncn84n6qzrDO2U7j/YgLc=;
 b=KMK00R9RJUPzJkf2PTYQky+05tYAy6ZaM3dacWovz7xxxLgyz7t/bn/2x+wAwPbuzj
 08kc46aCq7/UaCjsO3n3jre82vJevNRkbAVhy8oCyIvkXQFh5/TNgPKqFjY7D1wpu7i1
 x5Om/l0ywhXPLoLZMOi6ASG7fYdCEB1KTslgLSWgCKDF8Bn9OUrXF+9xRZbKDBV3oxVA
 o6S5vpZfUqwl1t8wGorZMNYAk6uEt8jLMEBOKj0ul1dR2OkR8hAfA7TIMG3i+rCjZmPL
 WL97fyEC2OjLIHeFKmUXKxvAVxy7LW7aHGysBtVDMvzMRT211rTI4GJ8ijVl9djDu+Ts
 doaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=Sd4HKvpMJXeiLcbFDPVmWsncn84n6qzrDO2U7j/YgLc=;
 b=eyT+cfFVqyDe22uo6a/iEcSWwwhYUukpsoyVAoN+lNCJoHT+uByygIEviTHGPMkFLw
 ltn3pdlFMvMrujxuLbevjQO8u6D3Q1BgUG82coCMxvRMXaDDT7StK1nkQj+Hun7Bx2qx
 tLTV7Jv7yAOYQBKP0LHs3oqgPmMTx1KTOJ9pQGl0HEcyYKpwdK5w/JhbKtFQZGKPURdw
 L4VTPJJW4/yGizBaYLsAQx1SiG8fpG21QleOWC4uY0PtEteX95QOhPVT+XfwO5/uv2Xk
 fC+QY1ZpWhkbsIAG4MbezxZliKJ/bgJe7WpIfJ5WKxpRvf/cLHt1YzNSKzZJB3d74n9e
 Rnmw==
X-Gm-Message-State: AGi0PuY2n9RgebP3VSBB/YcrNoxbAxrCESZx3Old9zzuPxuT6rOiLTUB
 DadFEZ2c5G/7wT1aAeHjB5w=
X-Google-Smtp-Source: APiQypL9zA3kYaaZfErh7gG9f2O45YJP6hVd1c5a3bbviOU+dzL6Sf425h0oNRAFC68ZPb1LcamJ/w==
X-Received: by 2002:a65:6101:: with SMTP id z1mr3713424pgu.224.1585847986566; 
 Thu, 02 Apr 2020 10:19:46 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2405:205:1380:eac:4926:6e0b:60ca:635c])
 by smtp.gmail.com with ESMTPSA id
 i124sm4118296pfg.14.2020.04.02.10.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 10:19:45 -0700 (PDT)
Date: Thu, 2 Apr 2020 22:49:40 +0530
From: Simran Singhal <singhalsimran0@gmail.com>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2] qobject: json-streamer: Change bracket_count to brace_count
Message-ID: <20200402171940.GA21781@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
Changes in v2:
        -No need to remove the duplicate occurence of "parser->bracket_count >= 0"
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


