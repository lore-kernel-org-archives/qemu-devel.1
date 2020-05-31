Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3E7C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6EE2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWvbj1D8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6EE2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR3o-0000Lc-IL
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0I-0002hD-Qf
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0H-0006ta-PI
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssulewpBrPPL8AloNMkgJXTsJOTpzeqWq+VA42pqYDs=;
 b=XWvbj1D85UL2lqIEe248yC8q0WMVmVSze081OkDsVl4R2mLiZzq8lnhxm5beCCdLi0RJ7D
 xmkHfPtIUxGCC1XwKLNuaagt50lMySf83Zs93x0/l928/5mWv3YakCAilGiMVqgm0ZiW4e
 KHQS/0rn7zHAZTWVMRi97NoqzNV9zig=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-hGp2kGzjMdmaTSUtToySag-1; Sun, 31 May 2020 12:40:02 -0400
X-MC-Unique: hGp2kGzjMdmaTSUtToySag-1
Received: by mail-wr1-f69.google.com with SMTP id o1so3590178wrm.17
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ssulewpBrPPL8AloNMkgJXTsJOTpzeqWq+VA42pqYDs=;
 b=I/DBAzG8EGUAPlRoNVoX5jg0DZy1WPlx7fEJh5hDfumseISHz10I0nsk45XaFE1Rmu
 2bRpP6HBfMGwjRHNxP3fxASKvvJbCCef92hMyvSf4ep/FFCe3/K52bVxZivnPAxBA5v2
 m5y+PSDA6uDbqmJGrzlWwBXIlSCR3zzFDFpK/YdtC9FCt1ZpcMTk6rkNiEfq/MBosA7a
 4CgEEgtbWuMKTa9O3YbTFEsmZAGOuMNEKyM9DOijxkcJwecdQ4cz3doDAFxXokMwEIJO
 roztQRTm9iOPaPlCMRZbGfR8yhegpTTrRQYUpw/vrRPz2koq28mriBYH7i+70RqwkWEv
 /lJA==
X-Gm-Message-State: AOAM5311gAk8XmJmgYy/mSkPmaZ024RRGIh5mP0qUMphDZE5CaqytOOx
 tuP4A7SZXCvTr+upEbPmOfgYls3YtzOfMbufeWEhe1Um8NZCdY3ijTwB4Na11muWDDbsm064iE7
 yWl2aiROksFaF1gw=
X-Received: by 2002:a7b:c046:: with SMTP id u6mr17054029wmc.57.1590943201017; 
 Sun, 31 May 2020 09:40:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIdvNLMI//OZsjdo+C0sjBhIjuTUkjfNnTxiKuC1ShLlJgATsXVMG+s/5lIguCBK7zduo/Bw==
X-Received: by 2002:a7b:c046:: with SMTP id u6mr17054012wmc.57.1590943200820; 
 Sun, 31 May 2020 09:40:00 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id o9sm8676600wmh.37.2020.05.31.09.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/25] python/qemu: Adjust traceback typing
Date: Sun, 31 May 2020 18:38:35 +0200
Message-Id: <20200531163846.25363-15-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:39:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

mypy considers it incorrect to use `bool` to statically return false,
because it will assume that it could conceivably return True, and gives
different analysis in that case. Use a None return to achieve the same
effect, but make mypy happy.

Note: Pylint considers function signatures as code that might trip the
duplicate-code checker. I'd rather not disable this as it does not
trigger often in practice, so I'm disabling it as a one-off and filed a
change request; see https://github.com/PyCQA/pylint/issues/3619

Signed-off-by: John Snow <jsnow@redhat.com>
Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200514055403.18902-14-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py |  8 ++++++--
 python/qemu/qmp.py     | 10 ++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 95a20a17f9..041c615052 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -24,6 +24,8 @@
 import shutil
 import socket
 import tempfile
+from typing import Optional, Type
+from types import TracebackType
 
 from . import qmp
 
@@ -124,9 +126,11 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
     def __enter__(self):
         return self
 
-    def __exit__(self, exc_type, exc_val, exc_tb):
+    def __exit__(self,
+                 exc_type: Optional[Type[BaseException]],
+                 exc_val: Optional[BaseException],
+                 exc_tb: Optional[TracebackType]) -> None:
         self.shutdown()
-        return False
 
     def add_monitor_null(self):
         """
diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 73d49050ed..b91c9d5c1c 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -14,7 +14,9 @@
 from typing import (
     Optional,
     TextIO,
+    Type,
 )
+from types import TracebackType
 
 
 class QMPError(Exception):
@@ -146,10 +148,14 @@ def __enter__(self):
         # Implement context manager enter function.
         return self
 
-    def __exit__(self, exc_type, exc_value, exc_traceback):
+    def __exit__(self,
+                 # pylint: disable=duplicate-code
+                 # see https://github.com/PyCQA/pylint/issues/3619
+                 exc_type: Optional[Type[BaseException]],
+                 exc_val: Optional[BaseException],
+                 exc_tb: Optional[TracebackType]) -> None:
         # Implement context manager exit function.
         self.close()
-        return False
 
     def connect(self, negotiate=True):
         """
-- 
2.21.3


