Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB51C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:54:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509EB2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6loAQFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509EB2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVE9-0007YS-K5
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34120)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUjz-0004EM-Ps
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hjUjx-0002iE-AO
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:31 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:39487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hjUjt-0002fZ-Gp
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:23:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id z23so10803843wma.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 13:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7oTLlrL+kWrx1wogDdhfFI1GowG7GhBWapH2sls1gao=;
 b=d6loAQFeiI7Fl8mJKreiScE/qcMTczTfsPs7EIy0K7i0Hiwia30Yisgh7WCqZEEwDT
 EgP5wFW4ACJbQHxjDVWrtWDvla/RK0PYf9xf7hroK03jKaOljCbvwW0qyPnCahq858Xx
 D1a9FAh2JdOHMXnv/E0+i3stUyRQO1IjMmAgUc6gTusKF1eOy2J9ByTdHRfZ5CqYTz3t
 riikpK7K1wY1O9TswvyuVwULMQOhh20q8IE0OXdRCEi4xjIqT+0AH1tRnj+B/67sZ+/b
 acN0OnuoMdLdZp7YgHit0jo5fo9NAkVxPY4dkUj2FRAUEJuIfc8Nfnmt16uNpoLRShBE
 AEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=7oTLlrL+kWrx1wogDdhfFI1GowG7GhBWapH2sls1gao=;
 b=BzEJ9rI08lWSXq8viaendGYZfWT8ZfJzfu5udrVXBkwfCP3q8iQc5qhhDOLYGMulkf
 sHVfzo2H9p2dzn85OQXkP6Sx8c1UopInAhhn7xKDH0DiPm6Q/ZpRdbfA59r5xnhZOcjR
 0LDMuIMf1fFG/bPaM94QkkqPRqwevEw2RKHWtgGymnAeEREnKZEzVbLHHkV0Q72nMaFh
 00Dgwphy4SZDZEW4NRt2FvCQIkP8hb487SrHlK9oKjyIvdl60zngQ5D8HFkJyVnnaAEr
 ZL1v1jufGQzJa7X1BsQwL+G1AiukbuhLKe2XHZOYxWZ1JKnM0sG4+vgX1o3hi3khEk6+
 Fw3g==
X-Gm-Message-State: APjAAAXm1XOjgnXA1RrPp2DKVjpS3KKLhQuMZ+wUqqZHszhVl3+D2dY8
 zt3ZJlcCTE5spm5NUTOFXUZiMBSpnWY=
X-Google-Smtp-Source: APXvYqyxIM0q7rB8CzjH7mmlBbYgJ2uyuqnLXEyZSnuANnaLBTYwUKUH3IRhswF1Pe4z00XOWztCMw==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr4802759wmc.89.1562358204108; 
 Fri, 05 Jul 2019 13:23:24 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id v23sm3035875wmj.32.2019.07.05.13.23.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 13:23:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 22:23:10 +0200
Message-Id: <1562358202-28008-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
Subject: [Qemu-devel] [PULL 00/12] Misc bugfixes for QEMU hard freeze
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

The following changes since commit 39d1b92b810793e02558e05efa23059f67520bc9:

  Merge remote-tracking branch 'remotes/bkoppelmann2/tags/pull-tricore-20190625' into staging (2019-07-01 13:47:21 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 03f990a5e31e28c9a2794729638f2117e028bfa5:

  ioapic: use irq number instead of vector in ioapic_eoi_broadcast (2019-07-05 22:19:59 +0200)

----------------------------------------------------------------
Bugfixes.

----------------------------------------------------------------
Alex Bennée (1):
      target/i386: fix feature check in hyperv-stub.c

Igor Mammedov (1):
      pc: fix possible NULL pointer dereference in pc_machine_get_device_memory_region_size()

Julio Montes (2):
      Makefile: generate header file with the list of devices enabled
      hw/i386: Fix linker error when ISAPC is disabled

Li Qiang (2):
      ioapic: clear irq_eoi when updating the ioapic redirect table entry
      ioapic: use irq number instead of vector in ioapic_eoi_broadcast

Liran Alon (1):
      target/i386: kvm: Fix when nested state is needed for migration

Max Reitz (1):
      i386/kvm: Fix build with -m32

Paolo Bonzini (2):
      checkpatch: do not warn for multiline parenthesized returned value
      minikconf: do not include variables from MINIKCONF_ARGS in config-all-devices.mak

Peter Xu (1):
      intel_iommu: Fix unexpected unmaps during global unmap

Yan Zhao (1):
      intel_iommu: Fix incorrect "end" for vtd_address_space_unmap

 Makefile.target           |  4 +++
 hw/i386/intel_iommu.c     | 71 ++++++++++++++++++++++++++++-------------------
 hw/i386/pc.c              |  6 +++-
 hw/i386/pc_piix.c         | 12 ++++++--
 hw/intc/ioapic.c          | 11 ++++----
 scripts/checkpatch.pl     |  3 +-
 scripts/create_config     |  2 ++
 scripts/minikconf.py      |  5 +++-
 target/i386/hyperv-stub.c |  2 +-
 target/i386/kvm.c         |  7 +++--
 target/i386/machine.c     |  5 ++--
 11 files changed, 82 insertions(+), 46 deletions(-)
-- 
1.8.3.1


