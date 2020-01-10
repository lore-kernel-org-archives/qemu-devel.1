Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D028C33CA4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0F52072A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ZCnGyjz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0F52072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprCp-000722-6p
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pizhenwei@bytedance.com>) id 1iprBn-0005mz-Nv
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pizhenwei@bytedance.com>) id 1iprBm-0003Vt-JE
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:06:47 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pizhenwei@bytedance.com>)
 id 1iprBm-0003Sc-Ci
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:06:46 -0500
Received: by mail-pj1-x1042.google.com with SMTP id s94so1770798pjc.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 02:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dAhOey3cqiOp5/b6uTfIau2ZiRzs6yslTIYzXyRfd0c=;
 b=ZCnGyjz4JtzHSiIKTawQQFFawClt0WRij9NbnhP7RUUYZVdjjy1D9p2jpTH6nJ8Tmv
 jg14A971WglswnMZ4qFHpRKI3KbEv3y/J1PkACZdJhUJgE3VCR5rvKwXXJhvN478mZu7
 QAq9H4WCPHGe6yjVCU8a3QuVHEb9pl3jhxejEIX4dXJfgyuxGRnJd54LXW1hIVGT6+SB
 9XZUXRXaDfzBleyop6DCKdkSlL6sWtqlzy7cZ5P4pcZ2I7bjGAzFttaVcatZb+u8b3zu
 YiHN/37SOWbvCCiW2ndN5YG9eTyIuqeY6HCFMoSygQV6MPX3TdoauyvSqe+P/MJseMP1
 CqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dAhOey3cqiOp5/b6uTfIau2ZiRzs6yslTIYzXyRfd0c=;
 b=HbDzlmWpWkfQ+9wWgKXGK1VxE3IPCG3lT0ZHPfXpuvaGxBfmomoKdq0VGiyw5zns5f
 iSsqhkSleJW0weerR3+P2H4mKSrtV0tIpCbzMDZ8SzVo55FjoseiNQHSStaRHcKid2PL
 I3c7FIxk2QMKPJ8XBj/CMf8/EVrxJM9Hba90IuDo0it+ciR2ebTfatTuV1eocWVzgp7/
 ZMVrgs6DUurMcmQ0og3WBRubG3GDfdB2XSiiawzlInAqhQFNcJYt/xY7TnuFZLSmDlGI
 w6JGGptqp9QFlOhC0grOHoWQR/xEU5lpME0pDbsHabiYcp/NCpB+SIPcmf6l9mntnpGY
 NfHg==
X-Gm-Message-State: APjAAAVpElR5dpY3xoM4VORyUPRNejUAOAg5+BQctfPPIhrNsvc44mk3
 Uvkk6toQuo50d3SvbDVxpbU1NQ==
X-Google-Smtp-Source: APXvYqyqnZ9lf3ppNVir68eoZT7u3buRR7s7HIwujRNHxEUEdVG6qsr88g9VM/pC+0jZaZIEUqzprA==
X-Received: by 2002:a17:90a:1b4d:: with SMTP id
 q71mr3653557pjq.82.1578650805378; 
 Fri, 10 Jan 2020 02:06:45 -0800 (PST)
Received: from libai.bytedance.net ([61.120.150.71])
 by smtp.gmail.com with ESMTPSA id q21sm2179039pff.105.2020.01.10.02.06.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jan 2020 02:06:44 -0800 (PST)
From: zhenwei pi <pizhenwei@bytedance.com>
To: pbonzini@redhat.com
Subject: [PATCH 1/2] pvpanic: introduce crashloaded for pvpanic
Date: Fri, 10 Jan 2020 18:06:33 +0800
Message-Id: <20200110100634.491936-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200110100634.491936-1-pizhenwei@bytedance.com>
References: <20200110100634.491936-1-pizhenwei@bytedance.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: yelu@bytedance.com, libvir-list@redhat.com, gregkh@linuxfoundation.org,
 qemu-devel@nongnu.org, zhenwei pi <pizhenwei@bytedance.com>,
 linux-kernel@vger.kernel.org, mprivozn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add bit 1 for pvpanic. This bit means that guest hits a panic, but
guest wants to handle error by itself. Typical case: Linux guest runs
kdump in panic. It will help us to separate the abnormal reboot from
normal operation.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 docs/specs/pvpanic.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/docs/specs/pvpanic.txt b/docs/specs/pvpanic.txt
index c7bbacc778..bdea68a430 100644
--- a/docs/specs/pvpanic.txt
+++ b/docs/specs/pvpanic.txt
@@ -16,8 +16,12 @@ pvpanic exposes a single I/O port, by default 0x505. On read, the bits
 recognized by the device are set. Software should ignore bits it doesn't
 recognize. On write, the bits not recognized by the device are ignored.
 Software should set only bits both itself and the device recognize.
-Currently, only bit 0 is recognized, setting it indicates a guest panic
-has happened.
+
+Bit Definition
+--------------
+bit 0: setting it indicates a guest panic has happened.
+bit 1: named crashloaded. setting it indicates a guest panic and run
+       kexec to handle error by guest itself.
 
 ACPI Interface
 --------------
-- 
2.11.0


