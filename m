Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB44C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6B720771
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="WErC3bnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6B720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDWA-0003Wr-4a
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDV9-0001fr-8B
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:28:31 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:58078 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqDV7-0000T7-Gw
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:28:30 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 60BEE4C84A;
 Tue, 30 Jun 2020 10:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1593512906; x=
 1595327307; bh=ZStU+clCFaEFFqspZAhFJWYa/8oJ3kn0EhvtgcIu0PE=; b=W
 ErC3bnv7kzYd+jkqvLNn19wL6J4qEGDeJF6YvpShAds3s1qukiTAjRBqR9eNdDXC
 OZ7ARaD+zdyDB6M4vdCHiGhsCI/3EFgq4QEka5AtZLcxO4RULN36e881rB6869Ko
 R60030srEGFTUS57welLN5zcGJuQ/W6oapyUXF68M0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x2bGgV4QO1Ro; Tue, 30 Jun 2020 13:28:26 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 6BCDF412C8;
 Tue, 30 Jun 2020 13:28:26 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 30
 Jun 2020 13:28:26 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 0/9] Improve synchronization between QEMU and HVF
Date: Tue, 30 Jun 2020 13:28:15 +0300
Message-ID: <20200630102824.77604-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 06:12:32
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The series is a prerequisite to implement gdbstub support for HVF and mostly
concerns improvements of cpu_synchronize_* functions wrt to HVF and addresses
old TODO's in the related code.

Changes since v1:
 - Reduced kick loss race (Paolo) and removed SIG_IPI blocking in the
   kick patch
 - Added an old patch from Cameron that improves readibility
 - Moved LMA Guest Entry control sync to macvm_set_cr0() (Paolo)
 - Dropped hvf_vcpu_reset() and PDPTE's initialization in one patch

Cameron Esfahani (1):
  i386: hvf: Make long mode enter and exit clearer

Roman Bolshakov (8):
  i386: hvf: Set env->eip in macvm_set_rip()
  i386: hvf: Move synchronize functions to sysemu
  i386: hvf: Add hvf_cpu_synchronize_pre_loadvm()
  i386: hvf: Implement CPU kick
  i386: hvf: Move Guest LMA reset to macvm_set_cr0()
  i386: hvf: Don't duplicate register reset
  i386: hvf: Clean up synchronize functions
  MAINTAINERS: Add Cameron as HVF co-maintainer

 MAINTAINERS               |   2 +
 cpus.c                    |  25 ++----
 include/hw/core/cpu.h     |   2 +-
 include/sysemu/hvf.h      |   3 +-
 include/sysemu/hw_accel.h |  13 +++
 target/i386/cpu.c         |   3 -
 target/i386/cpu.h         |   1 +
 target/i386/hvf/hvf.c     | 179 ++++++++++++--------------------------
 target/i386/hvf/vmcs.h    |   1 +
 target/i386/hvf/vmx.h     |  17 ++--
 10 files changed, 95 insertions(+), 151 deletions(-)

-- 
2.26.1


