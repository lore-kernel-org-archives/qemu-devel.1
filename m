Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EECC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64B492133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 19:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/GazzT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64B492133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUMs-0007Vg-OI
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 15:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55663)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEP-0005Wx-DY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUEO-0004Cf-Eu
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:53 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:53116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUEO-0004C4-8G
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 15:50:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id s3so10219422wms.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 12:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=hD3kbFvZZ3EzTHJ9PgPfFOKh05+UxEjCQiiQlxvG2pQ=;
 b=L/GazzT1zkbF8TSIvZubIFTiW3kJakHnSA1vULketHlMfw8D+3r8kaK9Qy8tWRok+t
 H/5pMy/Ki9O4917VesFP4Loigy53kkRO6gA47VxT+cCHpsvpITLxjCJnHZP2dGO6PTmK
 c1gSE9FygVfN0P0i47Jd6TXKbVVH5+LBkEssUiFHYOptZf4vtUsbAfyZenCFaLSwH6Rb
 zIIvrygXu0l/Qeo+hXzj4I1DAApGq3OG6f3w2hveUU6vIJ9Gg2KYiTYUqfJvlzSY8dST
 Nu4PCWG3UDXXrddHtDFMEuok5BudXp+YK5dUIelLHnNWoDMzA4XjmqeiGEgcbHvtUG5t
 d2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=hD3kbFvZZ3EzTHJ9PgPfFOKh05+UxEjCQiiQlxvG2pQ=;
 b=KRwvT64m1dIg1ztatUaptJF7+r4A8vi/c9ua3mk5hT5bDN/0ideln9+c5t6Vd/jHfs
 qihc37//zkOMv1dyGl+sx5fP3AZUJdFiGQWMLMNQcwhSOsLmaQwoVxC4EeNas/HBhH1D
 KDos9j/HK2sOxl7548onU3929BEoCpHdz/Rv71GSlnJkGe9tNqCfO32wLr1YyPXDkwDZ
 w/Ys6ZhhlP6oVZ7Lx+/pz8tItPL8AfJkQ5Hv2qGAWOfaskTX9vAXVdkOL7ZRydsTO2oJ
 GDv/Ql+9SBUT9ao+7uvMqffoUPK0IyDDhUAtF1b31/xfSVQyWl0LMu89DLTxaZjGHYij
 zOJw==
X-Gm-Message-State: APjAAAXA6XuyJkfffKTmpamhYc9U3JNjiaxS894Q7D0OnZs+tbD9jqXS
 u00U45i+k+g6jvZUHvfofCzavPdOr4k=
X-Google-Smtp-Source: APXvYqylYBEzGDQiSd2QkNJXu37b3cEiULeK6+TfCGuLRnhU13Bg5ZcGTTrwNY/A+lo6LNotYV+YMw==
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr4516690wme.29.1562356250974; 
 Fri, 05 Jul 2019 12:50:50 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id d10sm11478625wro.18.2019.07.05.12.50.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 12:50:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 21:50:35 +0200
Message-Id: <1562356239-19391-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
References: <1562356239-19391-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 08/12] minikconf: do not include variables from
 MINIKCONF_ARGS in config-all-devices.mak
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When minikconf writes config-devices.mak, it includes all variables including
those from MINIKCONF_ARGS.  This causes values from config-host.mak to "stick" to
the ones used in generating config-devices.mak, because config-devices.mak is
included after config-host.mak.  Avoid this by omitting assignments coming
from the command line in the output of minikconf.

Reported-by: Christophe de Dinechin <dinechin@redhat.com>
Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>
Tested-by: Christophe de Dinechin <dinechin@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 0ffc6c3..3109a81 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -688,11 +688,13 @@ if __name__ == '__main__':
 
     data = KconfigData(mode)
     parser = KconfigParser(data)
+    external_vars = set()
     for arg in argv[3:]:
         m = re.match(r'^(CONFIG_[A-Z0-9_]+)=([yn]?)$', arg)
         if m is not None:
             name, value = m.groups()
             parser.do_assignment(name, value == 'y')
+            external_vars.add(name[7:])
         else:
             fp = open(arg, 'r')
             parser.parse_file(fp)
@@ -700,7 +702,8 @@ if __name__ == '__main__':
 
     config = data.compute_config()
     for key in sorted(config.keys()):
-        print ('CONFIG_%s=%s' % (key, ('y' if config[key] else 'n')))
+        if key not in external_vars:
+            print ('CONFIG_%s=%s' % (key, ('y' if config[key] else 'n')))
 
     deps = open(argv[2], 'w')
     for fname in data.previously_included:
-- 
1.8.3.1



