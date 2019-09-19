Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3717AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40D621D56
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJBYcXKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40D621D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwet-0001st-Al
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAw3z-0001FZ-Nr
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:01:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iAw3y-0007oP-9l
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:01:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33165)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iAw3y-0007j9-0q
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:01:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id b9so3053665wrs.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sGOXzi5ZsuNGi1Cd4gJPvQa18cyrbKBjt28OnHQ1ECU=;
 b=OJBYcXKGhstSS519cHOjRVNOmG+gaqlVUPGeJlKNHo2y0rf1VeIDFhuE2YlVtE3OjQ
 hAsHRIWbwosPa6TOjl7OkulQ8YJNxDy12efAeqcvnNiq0P6R/PtM1Zu6FaBjc7BGWJgy
 NlHGFvAmGDXXDsvbkMzPFylpPv+DW7sIPEEdzG35J7Elzf8RIePYjFdx/nmNuqrBgP4a
 e3VYYJIKaXK682zWGbjaYIRR47+Mj4WQIXN2aSfQL1QqfV46Yj+V4sfS0aSYQ1EtGui+
 S/LA2gWqyp/Hf5oN/gzf+xFV0Uwp1wNafM1nvBfQhq8yK355yR0uUaZV7B6V1BNMc74L
 fJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=sGOXzi5ZsuNGi1Cd4gJPvQa18cyrbKBjt28OnHQ1ECU=;
 b=QWGETsAxavssA7vnSqkP2siw4QnygbEK7MunXSKthRRZ8ymIgZAlvrieEfGnR91WI8
 GV36aahOaDCOYXPRd+uYpazm8pTx8RDCCDh6eCdYxqlQEKoKKWCevdBogpnYyWh0ZV/i
 23bxmrjsT8QYMWwQLeplbPucdwU+g00Z+jNsXp2QuP1jhnbO6dq3P2bvyeUoeZT0DxKy
 BP3jNKQSoUyFDOyb+VlXblGwpBllDzc3p+dVSSafHY57sF5LzqgVYornfFeUxgbr6QG6
 8AuCmP103uXugtBqM/xd9EcRtksUY0ymEdk3xE3F7tdJKNj+D2wGsYa+cFcgDrHeosFd
 n3lA==
X-Gm-Message-State: APjAAAX1rNtUsi7/AnuayFeBxUu3bS/iefqofYVQDxCpQbqRjEDhNi6M
 UJ5MMQ8D4DpPBz7CCjIhR1jqwVdV
X-Google-Smtp-Source: APXvYqzYahwpgslgpqjFEQLPdrOciZPV7SQzWFec6fYO/iaPgJk/kIMm7o7qOBqlVHD6cEgqqbXcHg==
X-Received: by 2002:a5d:4985:: with SMTP id r5mr6989362wrq.139.1568898090894; 
 Thu, 19 Sep 2019 06:01:30 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:c46c:2acb:d8d2:21d8])
 by smtp.gmail.com with ESMTPSA id k26sm2019623wmj.33.2019.09.19.06.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 06:01:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 15:01:28 +0200
Message-Id: <20190919130128.28770-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [qemu-web PATCH] Gemfile: use a fixed version of sassc
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
Cc: thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jekyll failed to run with sassc 2.2.0 due to a LoadError, so the
Gemfile was requiring an earlier version (2.1.0 in practice).
Since the bug has been fixed, remove the workaround and instead
require a fixed version.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Gemfile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Gemfile b/Gemfile
index b76a4fd..2117bba 100644
--- a/Gemfile
+++ b/Gemfile
@@ -24,4 +24,4 @@ group :jekyll_plugins do
 end
 
 # for https://github.com/sass/sassc-ruby/issues/146
-gem "sassc", "< 2.2.0"
+gem "sassc", ">= 2.2.1"
-- 
2.21.0


