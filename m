Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAFAC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C0C20707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4xtKclO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C0C20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAx86-0000yw-8l
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAx6l-0007iB-W7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:13:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:39353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAx6g-0003yw-BL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:13:02 -0400
Received: by mail-pg1-x544.google.com with SMTP id v15so1170285pgh.6
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7+MsaJjYLlKc/kuo4dhCFuDpn67NQClb7RmuHL3RlA8=;
 b=f4xtKclOiCLcv+sCFFhbwanX01YzyvKkfYKiilgrl8OdP3KnLl8OTLv54YGxBgMdV6
 aeFbSPdoZWT6veu8mlCcv5P/ug3pLcJemL4mtpqMsbbm86kt7pNgeVB3YtStbyzvkFa6
 nHrRptqD2Q514lnadg7Cs1LWilUyTKtFUDvxZkIgC3G6wuIdXnZWTpl1IyK22b1H68Hv
 ab1rY5qtp3Y0Unv1HI3UF16A2d8Lavpnx/DiHntZEaHPBbQqFyuGZFUTYl1txYjTN71w
 L1n7am8wFerTL9LOhMMlWD5bF6ujypVV8fY7bPCItevZfRr5AXfrVvJH6iWbQ8OSfB0W
 n8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7+MsaJjYLlKc/kuo4dhCFuDpn67NQClb7RmuHL3RlA8=;
 b=jHE7et2b2WdMJKKKql5VJEi1Ox3bJ1eeDB7gQ8dEAsGpDKaL5xbJJdQmJ/BB/5ZU2F
 lyxkwTDPktQ11m8FK9SK1V//e84yJ7LdJRzTZWRX2p9+4vG70wBD4cyWRaXCVyotdcmK
 siBlRjTb11ul43JvZ8U0NRDabn31W964xcq0F0mgsGfl+1lC150ub6oNpaxOsBJtgzzD
 MXq/6GoraMNYKhxWA0Y69DCRfwUjH7kbAB/tttGbmBIFtxkKFdws0nwcJHn5fy/DhNm6
 s6l8gwE7GcFvM9rmcaDbDN8lWl4VKC8AKF1PisEZp6OpzwAImHSvd0JZrVmF1L5jEusH
 r/uA==
X-Gm-Message-State: AOAM533JPkS778T0htUau4SfEAjm7hmyblnLEuBrxHxdF08sKmyzpUTV
 oJOrWr3DCs74SygR73TsZGnRKkMQzlUEKxPu
X-Google-Smtp-Source: ABdhPJx23u/MEvog3du3zKXK2Km44BSDbvghLU6FvgS6AzPMwoeilYwi4CYMunCAZqj9AoxD91CuAw==
X-Received: by 2002:a65:4787:: with SMTP id e7mr10076394pgs.402.1598454776476; 
 Wed, 26 Aug 2020 08:12:56 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 27sm2423169pgk.89.2020.08.26.08.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 08:12:55 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/6] meson: fixes relpath may fail on win32.
Date: Wed, 26 Aug 2020 23:10:02 +0800
Message-Id: <20200826151006.80-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200826151006.80-1-luoyonggang@gmail.com>
References: <20200826151006.80-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

On win32, os.path.relpath would raise exception when do the following relpath:
C:/msys64/mingw64/x.exe relative to E:/path/qemu-build would fail.
So we try catch it for stopping it from raise exception on msys2

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 scripts/mtest2make.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index bdb257bbd9..d7a51bf97e 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -53,9 +53,16 @@ i = 0
 for test in json.load(sys.stdin):
     env = ' '.join(('%s=%s' % (shlex.quote(k), shlex.quote(v))
                     for k, v in test['env'].items()))
-    executable = os.path.relpath(test['cmd'][0])
+    executable = test['cmd'][0]
+    try:
+        executable = os.path.relpath(executable)
+    except:
+        pass
     if test['workdir'] is not None:
-        test['cmd'][0] = os.path.relpath(test['cmd'][0], test['workdir'])
+        try:
+            test['cmd'][0] = os.path.relpath(executable, test['workdir'])
+        except:
+            test['cmd'][0] = executable
     else:
         test['cmd'][0] = executable
     cmd = '$(.test.env) %s %s' % (env, ' '.join((shlex.quote(x) for x in test['cmd'])))
-- 
2.27.0.windows.1


