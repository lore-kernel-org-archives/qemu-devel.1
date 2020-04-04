Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2D3C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 04:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8AD2051A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 04:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCPByA7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8AD2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKaJu-0007IS-AT
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 00:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dnbrdsky@gmail.com>) id 1jKaJ4-0006B2-HB
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 00:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dnbrdsky@gmail.com>) id 1jKaJ3-0005DP-BP
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 00:21:18 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dnbrdsky@gmail.com>) id 1jKaJ3-0005CS-48
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 00:21:17 -0400
Received: by mail-pf1-x442.google.com with SMTP id f206so4635031pfa.10
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 21:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WDNgH8TyYnmqTPxz2CDj5/AODsJMGgFpNcBmolWpUa8=;
 b=sCPByA7w8DvWJkHk+ApD7Zay99LEC+TKM6DNxBzA1NGdwmaFtIxtNigjL5Ks1spNid
 2yI786zBu017rb6TEhXEEOh7GeevhD635G7xBCD97nZcbygVcbe1Pf+o5hxExkCqazS6
 0Etpwb1Nq68Mnoe0V01WwBi50Di9MZwmrFryaSv/VcrSG+hkCU9vjNUMofUgWtGROJPn
 AaQ1PGSvYc1dq2uTYh40j42As91DDG78vcGlWEsOY4ZTsB68eyty3bCEDzbPJmRnAfxG
 xhoFwJQU21li0X2QEk2HtNqvA7W/nvqyON6sh/xvmVWO45vN/aAXvT70sHst/F6bhT8H
 jgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WDNgH8TyYnmqTPxz2CDj5/AODsJMGgFpNcBmolWpUa8=;
 b=ho95t49BrMEidjyeTDTAAOLeaZl6f0wZHOrahEomGLpiw7Ua/j4We9cuNglYc/LnYA
 yYmvOoB75snNGal8achRZ9DbmmGxbNq3ZCCp8ja+qEsEoOEjx0PFxyaxU71lNmjEGrVj
 CVFZ65ivmk6REC7mRhzoRuYLS2pRcfQy/jqh84RegLa/1q2HCQ4BtKfcRZ2VdUEaIBv+
 p2T6w3Il48wv4wq60uJweGxNoAve5W4yJvf7LF51ryHUGGRRi0uE/QRMTN1dY+LYnZOm
 0ko09rJvnlxZuzDREdh/d7Bg2KGJ8S60oGU9BJ8zolfMnlM7fFwoy30QXTrSbbTZtZGb
 EcUQ==
X-Gm-Message-State: AGi0PuZ5yFnRsvQvhLQtYCmYANnuPL4j6Wt9lxd7FmnnljWgy5UkVAoz
 QXL70kYX3n/Oj1XYHdJWt9Q=
X-Google-Smtp-Source: APiQypLVdA/3EP2WOdU8unsXccc/YFWIjUut1MhLOBkBWpy5J7eJHhYyYleCQq8C7d539l4CDPH/LA==
X-Received: by 2002:a62:ae05:: with SMTP id q5mr11771670pff.307.1585974075777; 
 Fri, 03 Apr 2020 21:21:15 -0700 (PDT)
Received: from esc.telus (d216-232-186-112.bchsia.telus.net. [216.232.186.112])
 by smtp.gmail.com with ESMTPSA id 189sm6746048pfg.170.2020.04.03.21.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 21:21:15 -0700 (PDT)
From: dnbrdsky@gmail.com
To: dnbrdsky@gmail.com
Subject: [PATCH v5 0/2] Replaced locks with lock guard macros
Date: Fri,  3 Apr 2020 21:21:06 -0700
Message-Id: <20200404042108.389635-1-dnbrdsky@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

v4 -> v5:
- added G_GNUC_UNUSED to lock guard macro to supress unused var warning

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
 include/qemu/lockable.h |  7 +++---
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
 17 files changed, 88 insertions(+), 110 deletions(-)

-- 
2.26.0


