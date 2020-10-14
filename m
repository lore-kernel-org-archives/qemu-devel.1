Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2DAC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F6020878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F6020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbN1-00034q-G0
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSbKe-00007N-9t
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:36:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1kSbKa-0006hx-AI
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:36:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4979FAD63;
 Wed, 14 Oct 2020 07:36:07 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC v1 0/2] tcg-cpus: split into 3 tcg variants
Date: Wed, 14 Oct 2020 09:36:03 +0200
Message-Id: <20201014073605.6155-1-cfontana@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Claudio Fontana <cfontana@suse.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The purpose of this series is to split the tcg-cpus into
3 variants:

tcg_cpus_mttcg    (multithreaded tcg vcpus)
tcg_cpus_rr       (single threaded round robin vcpus)
tcg_cpus_icount   (same as RR, but using icount)

Alex, I read the comment in tcg_start_vcpu_thread saying:

    /*
     * Initialize TCG regions--once. Now is a good time, because:
     * (1) TCG's init context, prologue and target globals have been set up.
     * (2) qemu_tcg_mttcg_enabled() works now (TCG init code runs before the
     *     -accel flag is processed, so the check doesn't work then).
     */

Is this actually current?

I tried to refactor this (see patch 2), and it seems to work to do
the init of regions in tcg_init, and it seems that mttcg_enabled is known
already at that point..

Ciao,

Claudio

Claudio Fontana (2):
  accel/tcg: split CpusAccel into three TCG variants
  accel/tcg: split tcg_start_vcpu_thread

 accel/tcg/meson.build       |   9 +-
 accel/tcg/tcg-all.c         |  13 +-
 accel/tcg/tcg-cpus-icount.c | 145 +++++++++++
 accel/tcg/tcg-cpus-icount.h |  20 ++
 accel/tcg/tcg-cpus-mttcg.c  | 142 ++++++++++
 accel/tcg/tcg-cpus-mttcg.h  |  25 ++
 accel/tcg/tcg-cpus-rr.c     | 305 ++++++++++++++++++++++
 accel/tcg/tcg-cpus-rr.h     |  26 ++
 accel/tcg/tcg-cpus.c        | 500 +-----------------------------------
 accel/tcg/tcg-cpus.h        |   9 +-
 softmmu/icount.c            |   2 +-
 11 files changed, 697 insertions(+), 499 deletions(-)
 create mode 100644 accel/tcg/tcg-cpus-icount.c
 create mode 100644 accel/tcg/tcg-cpus-icount.h
 create mode 100644 accel/tcg/tcg-cpus-mttcg.c
 create mode 100644 accel/tcg/tcg-cpus-mttcg.h
 create mode 100644 accel/tcg/tcg-cpus-rr.c
 create mode 100644 accel/tcg/tcg-cpus-rr.h

-- 
2.26.2


