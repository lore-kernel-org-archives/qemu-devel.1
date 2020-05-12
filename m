Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C46C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F7B206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 10:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZIU0Ww4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F7B206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYSKs-0007ud-16
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 06:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYSDh-0006vE-6Y
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:33:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44778
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYSDg-0007Vs-9X
 for qemu-devel@nongnu.org; Tue, 12 May 2020 06:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589279583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FN/9Q7LqiT7yOKM3lyj2/vvjplGjuC96R8PuYHJ2hZI=;
 b=gZIU0Ww45T4NOkydmmW8o3DwsdQh6YE2PlmO9wbkJqyEnzAuKPWPoEwvrsS1lUl/rv6YJ5
 DVphspOgjdWRfOp4CSD1+e18naRMtqbZu96GAs2zlegfaTRv4ZvcFxU9T8AkG/aoo3uLmD
 PLQdUDyds05qxOmcLDkofGQjs75MuxQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-V9GJXPDbOq6KNBOWe_sAGA-1; Tue, 12 May 2020 06:33:02 -0400
X-MC-Unique: V9GJXPDbOq6KNBOWe_sAGA-1
Received: by mail-wr1-f72.google.com with SMTP id r11so6723438wrx.21
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 03:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FN/9Q7LqiT7yOKM3lyj2/vvjplGjuC96R8PuYHJ2hZI=;
 b=eDtrdjuusINDUHjx4c+EmBPufvXKEmvMj7Sb1LdgFOavveAmTRL3W6lrHskjVgrwCB
 o6BybF36pAmJltRLl4w0A6YhyCpgU9gQ5ySALbSOAESWgnh2CXGN2p+6lzl/pVzGgjmz
 DA7D/wlp5D+ctKJiGQSMjBfq3tvbwIyT/GoOh98sfrVlzk6b/Nllwc9pVchcxiiZD9sK
 jervJmLrfPQO03P4iahKvE89whwmI9XyvfvyrpD+DF2LWqnI0h+wm7ReaRvn1lYi8AgB
 rQaryJr4VwgBaw1qTAXlCsDkWRjpssPKpxONj8yFnyCC4gKqUkI02QEP5r/bY4j2c9oy
 hd5g==
X-Gm-Message-State: AGi0PuaJgOqK8115jMz1H76cgSSqTDzwrt08Dgu0PHmjbPQg0qUp0Z64
 h7kgqo8WL8+AkOK74GmJKdImB+NanWorZjEQOdg6D4P2DQ1r3HC5PTlr+D1WJmW3L63nIvjalQw
 v0L/uvw0ushH8t38=
X-Received: by 2002:a1c:a3c1:: with SMTP id m184mr18797672wme.91.1589279579783; 
 Tue, 12 May 2020 03:32:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypLoVobmiuPPC5yzEHiFpfHm0s+HDrmev5jafrGVEC8Jo2mwsLRcy5dqC4UGFChZXKNb5cxJ4A==
X-Received: by 2002:a1c:a3c1:: with SMTP id m184mr18797645wme.91.1589279579565; 
 Tue, 12 May 2020 03:32:59 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v131sm3712043wmb.27.2020.05.12.03.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 03:32:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/6] scripts/kvm/vmxcap: Use Python 3 interpreter and add
 pseudo-main()
Date: Tue, 12 May 2020 12:32:36 +0200
Message-Id: <20200512103238.7078-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200512103238.7078-1-philmd@redhat.com>
References: <20200512103238.7078-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 01:41:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, kvm@vger.kernel.org, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/kvm/vmxcap | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 971ed0e721..6fe66d5f57 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 #
 # tool for querying VMX capabilities
 #
@@ -275,5 +275,6 @@ controls = [
         ),
     ]
 
-for c in controls:
-    c.show()
+if __name__ == '__main__':
+    for c in controls:
+        c.show()
-- 
2.21.3


