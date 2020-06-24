Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60C8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA5A2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 23:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="G3KEujVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA5A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joEPP-00019m-LC
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 19:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO5-0007xj-Q6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:01 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:32842 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joEO3-0006jZ-H7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 19:01:01 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 7C6E04C8AF;
 Wed, 24 Jun 2020 23:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1593039655; x=
 1594854056; bh=CYdx229BSWiqVtHUH3A18xu5PU209CK4I807CpzXHwc=; b=G
 3KEujVFQYmNIePgRy4zaMhbw97UjR0U1PtUPRjj2zKjz+kKV/aFhx6xLWFwyfRDW
 qPJCePfCLm4CpxCZEAjxA/Q+t+udeDt2j7u29TUGspXBGhOKybu7G6K8/oqumv37
 6SiNDBk4n+0uWmE9LZEXe+MdCrPZjaMwjtWZRJ8bW8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gb_vs8E_Yczv; Thu, 25 Jun 2020 02:00:55 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id A2CF64C879;
 Thu, 25 Jun 2020 02:00:55 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 25
 Jun 2020 02:00:55 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 0/8] Improve synchronization between QEMU and HVF
Date: Thu, 25 Jun 2020 01:58:43 +0300
Message-ID: <20200624225850.16982-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 19:00:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Claudio Fontana <cfontana@suse.de>,
 Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The series is a prerequisite to implement gdbstub support for HVF and mostly
concerns improvements of cpu_synchronize_* functions wrt to HVF and addresses
old TODO's in the related code.

Unfortunately live snapshots don't seem to work yet but they don't work with
tcg (on macOS) either.

Roman Bolshakov (8):
  i386: hvf: Set env->eip in macvm_set_rip()
  i386: hvf: Move synchronize functions to sysemu
  i386: hvf: Add hvf_cpu_synchronize_pre_loadvm()
  i386: hvf: Implement CPU kick
  i386: hvf: Don't duplicate register reset
  i386: hvf: Drop hvf_reset_vcpu()
  i386: hvf: Clean up synchronize functions
  MAINTAINERS: Add Cameron as HVF co-maintainer

 MAINTAINERS               |   2 +
 cpus.c                    |  25 +++---
 include/hw/core/cpu.h     |   2 +-
 include/sysemu/hvf.h      |   3 +-
 include/sysemu/hw_accel.h |  13 ++++
 target/i386/cpu.c         |   3 -
 target/i386/hvf/hvf.c     | 159 ++++++++++++--------------------------
 target/i386/hvf/vmx.h     |   1 +
 8 files changed, 77 insertions(+), 131 deletions(-)

-- 
2.26.1


