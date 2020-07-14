Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F52C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58ECF2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsmy7iX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58ECF2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTRW-0006Qd-IQ
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJw-0001Iy-3o
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJr-0004mW-NR
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hzthc4qYvhQKW4qzzIgQcGvyaWLPgPNTx6+69cJTCU=;
 b=fsmy7iX3dmfRVchp5g2FdxstGo+V/X6Ey4wFat02jc0epxC1lYmRnXr00ztzLGQJDQmSdJ
 dlXqsU2nAtEtDz2Jnxhmm1PLQOM68n/9KOSy3t1jQifOLeRubEFio5frKVZoBKSVKvSnW4
 VBmgcknlNAjDE52IPavrJ7GWr+AfRE8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-vmVq7gf8NDOjhmpU18Zz4g-1; Tue, 14 Jul 2020 18:22:32 -0400
X-MC-Unique: vmVq7gf8NDOjhmpU18Zz4g-1
Received: by mail-wr1-f70.google.com with SMTP id j16so24307wrw.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8hzthc4qYvhQKW4qzzIgQcGvyaWLPgPNTx6+69cJTCU=;
 b=QmrJCsuEWQdHEaYnYrw//XSBGOU0Q7ZE0V/RP9at1ZL3zY/fR/RYu+iERtYv9kXtJr
 Kj+opY/VKUFWB8JpVcYHp1u4h5sU5+1NasSM0Q+ZONfzbIw/b0uG44Zqn4swZtHzHlmI
 5NtoPVcpeJ1wMbBpuNGBrn75Twkqao8FUHlkbcSrRYtOuJIgh3zEPbF+iJNgvuL29XJJ
 AlU71DWGh96CnbYf14msPCWgNUCl7GQV0cwnv7UvoNc2XEYLpnvJ3PVeOWraGFAThbOz
 SyUOyicJY8IEDHx2w/zQ6aPLCketG+3u4OCpi+5mwMT97yT6Geg9YRShZiFzTSe57Nbx
 F7iQ==
X-Gm-Message-State: AOAM530duhG/XiVWzOwfwRfxXb1XUf0bO/6M+/j9KjCjimFwoOXyMEg2
 zqQH+TrxOolyNL2nzHI9d4lNafNTK5QfsOK8s35e5iDN38xnAmwUZmUUdcHylVPUPprzjeROSWF
 0SZBABoB55EscdtE=
X-Received: by 2002:a1c:4143:: with SMTP id o64mr5968361wma.28.1594765351521; 
 Tue, 14 Jul 2020 15:22:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUaBM960e1W2k0JPK2oz/7iOCe0w8tZXN2hSZVzOC+HuJsoZl+NLiRrqi5sJLjA9e40K7m6w==
X-Received: by 2002:a1c:4143:: with SMTP id o64mr5968348wma.28.1594765351309; 
 Tue, 14 Jul 2020 15:22:31 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c25sm299889wml.18.2020.07.14.15.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/19] python/machine.py: re-add sigkill warning suppression
Date: Wed, 15 Jul 2020 00:21:25 +0200
Message-Id: <20200714222132.10815-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

If the user kills QEMU on purpose, we don't need to warn
them about that having happened: they know already.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200710050649.32434-12-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index a955e3f221..736a3c906f 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -22,6 +22,7 @@
 import os
 import subprocess
 import shutil
+import signal
 import socket
 import tempfile
 from typing import Optional, Type
@@ -133,6 +134,7 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
         self._console_address = None
         self._console_socket = None
         self._remove_files = []
+        self._user_killed = False
         self._console_log_path = console_log
         if self._console_log_path:
             # In order to log the console, buffering needs to be enabled.
@@ -327,7 +329,8 @@ def _post_shutdown(self):
             self._remove_if_exists(self._remove_files.pop())
 
         exitcode = self.exitcode()
-        if exitcode is not None and exitcode < 0:
+        if (exitcode is not None and exitcode < 0
+                and not (self._user_killed and exitcode == -signal.SIGKILL)):
             msg = 'qemu received signal %i; command: "%s"'
             if self._qemu_full_args:
                 command = ' '.join(self._qemu_full_args)
@@ -335,6 +338,7 @@ def _post_shutdown(self):
                 command = ''
             LOG.warning(msg, -int(exitcode), command)
 
+        self._user_killed = False
         self._launched = False
 
     def launch(self):
@@ -469,6 +473,7 @@ def shutdown(self, has_quit: bool = False,
 
         try:
             if hard:
+                self._user_killed = True
                 self._hard_shutdown()
             else:
                 self._do_shutdown(has_quit, timeout=timeout)
-- 
2.21.3


