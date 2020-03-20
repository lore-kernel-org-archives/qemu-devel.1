Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9A7C4332E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEDA2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 12:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFoJZHOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEDA2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGqC-00042g-NN
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 08:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGog-0002Wn-Dd
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jFGof-0000cH-Ft
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:31:58 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jFGof-0000c4-Au
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 08:31:57 -0400
Received: by mail-pg1-x542.google.com with SMTP id b22so3007242pgb.6
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l2eyW9dI7eROn1GZH8sBPDMPjHSoQSidJeS1nTR8P0E=;
 b=cFoJZHODzOdYGoijlm/LluhWJQm1uE2+UvFgME4LscFrj35eN1QhDbjZ1b3xUtYIy5
 dkM4QYjCbhbYi56/qzZk47GdVommp8niQN8SRXd8ZDrH1UCjiN8A+Lsba5DKQBjW0hqr
 SJW9ERrZ2iPViXnUC4RVVAuBjrg6RC3KuZIoxxg+w0f88CwqBv4b/FQqNbnNn8jFZiaP
 lIc7k4e7qlysGVenZYQXQntQJTaQf6ef5SxxxfuIZKwJpX/We3THmfxoxj2Uygy92KWr
 rV4pPUc+0E+C6vRs+N0fGkH3oac//4wjI9k5Z5eB2tj9VlTDPc0bh76qAVW72JV66GNn
 bA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l2eyW9dI7eROn1GZH8sBPDMPjHSoQSidJeS1nTR8P0E=;
 b=BBBUiAVZhcAJr8IynxVOECt2+fyUjhCWA+OTM2IvuBtk8/02rFbkPWC6Ir00txvGzc
 9j3t7Ye/yvPvX3tL1yE7KRgeL8uBIU+6afaQKW5sfZnqbkGCLQpPluebRyj2kmXAiG/B
 A7AbFOkvZPEsnzvBfbhyyQrAt2uAdQTr/Hk3T1OJIg3RxlNXF0Cg0iotFRYBoTXEZv/U
 DYfKTZ5Ug1SaGLS2qsVUwfWZsqsU9ci5AujZEkmD6o1x1j8/GQMqnu+O4DFgHbmo9vP+
 +YYhTorWPe0VZZgJGocYXG5wBisQw0Jxe2kCywF5WKEfanu5IonqrTZtPwnNTIGjJ+Yl
 6Ytw==
X-Gm-Message-State: ANhLgQ1Rt1sx8huvzGjGhJ/vtuAieTyuJUO/eNnizqUoiEjG2Zo7Ox+4
 aCXnmFvR31s+Op4NJbn9Q6Q=
X-Google-Smtp-Source: ADFU+vsoL0phKBffKgsvqsJgQX1atifC/AkhLVZ6kdUtINIVNW4IZhTfozoQoHk5x9+kMZAVODbNMQ==
X-Received: by 2002:a62:648f:: with SMTP id y137mr9747152pfb.199.1584707516127; 
 Fri, 20 Mar 2020 05:31:56 -0700 (PDT)
Received: from esc.telus (node-1w7jr9qmilj27lake3duljaz9.ipv6.telus.net.
 [2001:569:75e3:4100:12ba:ab1b:8ad3:bb55])
 by smtp.gmail.com with ESMTPSA id 1sm4766550pjo.10.2020.03.20.05.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 05:31:55 -0700 (PDT)
From: dnbrdsky@gmail.com
To: dnbrdsky@gmail.com
Subject: [PATCH v4 0/2] Replaced locks with lock guard macros
Date: Fri, 20 Mar 2020 05:31:35 -0700
Message-Id: <20200320123137.1937091-1-dnbrdsky@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: stefanha@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Brodsky <dnbrdsky@gmail.com>

This patch set adds:
- a fix for lock guard macros so they can be used multiple times in
the same function
- replacement of locks with lock guards where appropriate

v3 -> v4:
- removed unneeded unlocks from areas where lock guards are now used
- dropped change to lock guard in iscsi.c as it changed old functionality

v2 -> v3:
- added __COUNTER__ fix for additional lock guard macro
- added missing include header in platform.c

v1 -> v2:
- fixed whitespace churn
- added cover letter so patch set referenced correctly

Daniel Brodsky (2):
  lockable: fix __COUNTER__ macro to be referenced properly
  lockable: replaced locks with lock guard macros where appropriate

 block/iscsi.c           |  7 ++----
 block/nfs.c             | 51 +++++++++++++++++++----------------------
 cpus-common.c           | 14 ++++-------
 hw/display/qxl.c        | 43 ++++++++++++++++------------------
 hw/vfio/platform.c      |  5 ++--
 include/qemu/lockable.h |  4 ++--
 include/qemu/rcu.h      |  2 +-
 migration/migration.c   |  3 +--
 migration/multifd.c     |  8 +++----
 migration/ram.c         |  3 +--
 monitor/misc.c          |  4 +---
 ui/spice-display.c      | 14 +++++------
 util/log.c              |  4 ++--
 util/qemu-timer.c       | 17 +++++++-------
 util/rcu.c              |  8 +++----
 util/thread-pool.c      |  3 +--
 util/vfio-helpers.c     |  5 ++--
 17 files changed, 86 insertions(+), 109 deletions(-)

-- 
2.25.1


