Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724B2ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC1C2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMPbKjDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC1C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOC9-0000lJ-VB
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lantianyu1986@gmail.com>) id 1iKNvy-0006qu-E9
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lantianyu1986@gmail.com>) id 1iKNvx-0003Mg-AF
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:36:22 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lantianyu1986@gmail.com>)
 id 1iKNvx-0003MI-2U
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:36:21 -0400
Received: by mail-pl1-x642.google.com with SMTP id e5so9681253pls.9
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=cLAwBrnafbrt9J1uJn5jsQACw4S4ae1p8THVsWr/E1g=;
 b=hMPbKjDkqDoi0WTHeuY3YNKQOZURFyiBP95maDFM8tmxUOUUb5LxRgI8zktGTVcF5S
 40qdEJLj4Tv6MITgm3lvDhtfRXIwhdExKHpln6zYABvcUPrBcibPxzn+oPCsyoa0cSGi
 SSWMF29uPKgpRPix6BL5YV/38X6io8hhwci8tCVzYAREAOmRIRXcgO/jTYphbQNB7c9Y
 srgLqZz/gsc+1qJPjJBD8txC+K/WVNghN9EL7l4T8rAKHEYxdvCOmp8PJIhzZbBEWim4
 1BLc/+su3BDOyDN5SxHJNtEPvXnPR+DwP3g1rYBhImPvz5OQPhLyVzpjiaHaKuFcMPzw
 hmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=cLAwBrnafbrt9J1uJn5jsQACw4S4ae1p8THVsWr/E1g=;
 b=iX7eJxvTT+IL3EXEWh0syyy/Xi7/soe1O3/mT2i9p/BZOM+n9NbzCaLEXousLcONin
 +4VkARLM0IvwppcIqBdJS27qI1dcLM2hDPjD+RvyJ7qliMGLhnHhTRsf4OjeX8pTkA+Y
 WJLldkCAwdJqTxqAbSbBbLQwwHjHIQiNCOaG+B39Zy8EtcIGsRzHalDRUIKGlQkhPqTG
 DPapMqRz7OdF6vkyNXpwCNlUuR0GuYgSlqQ95AFszKz8AR4Rwbb8hmxMPlElPDdvh3MV
 MywBV42XUa8EyyOVgHZg2GjScS9psbCZpPA0r51DjNxZ+vyAZWTtbs+Rb+hm9w1gGCbE
 xKuw==
X-Gm-Message-State: APjAAAXQTZIkCyHoEVjvD9GMTWxaYDiLkQPdkgnJHSp9M2oeJgWKVzyx
 /dX50QlgSHUyEGebunW6HPU=
X-Google-Smtp-Source: APXvYqzF5pVPQErQhvHW99GLzPBhE8631lYzEVomzsVgfCIHBcKlZ9qSzfVbW15Q253AW9Hl83LDHw==
X-Received: by 2002:a17:902:8ecc:: with SMTP id
 x12mr36755018plo.189.1571150179735; 
 Tue, 15 Oct 2019 07:36:19 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.39])
 by smtp.googlemail.com with ESMTPSA id v43sm4913165pjb.1.2019.10.15.07.36.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Oct 2019 07:36:18 -0700 (PDT)
From: lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com, mtosatti@redhat.com, rkagan@virtuozzo.com
Subject: [PATCH V2 0/2] target/i386/kvm: Add Hyper-V direct tlb flush support
Date: Tue, 15 Oct 2019 22:36:08 +0800
Message-Id: <20191015143610.31857-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

This patchset is to enable Hyper-V direct tlbflush
feature. The feature is to let L0 hypervisor to handle
tlb flush hypercall for L1 hypervisor.

Tianyu Lan (2):
  linux headers: update against Linux 5.4-rc2
  target/i386/kvm: Add Hyper-V direct tlb flush support

 docs/hyperv.txt                              | 12 +++++
 include/standard-headers/asm-x86/bootparam.h |  2 +
 include/standard-headers/asm-x86/kvm_para.h  |  1 +
 include/standard-headers/linux/ethtool.h     | 24 ++++++++++
 include/standard-headers/linux/pci_regs.h    | 19 +++++++-
 include/standard-headers/linux/virtio_ids.h  |  2 +
 include/standard-headers/linux/virtio_pmem.h |  6 +--
 linux-headers/asm-arm/kvm.h                  | 16 ++++++-
 linux-headers/asm-arm/unistd-common.h        |  2 +
 linux-headers/asm-arm64/kvm.h                | 21 +++++++-
 linux-headers/asm-generic/mman-common.h      | 18 ++++---
 linux-headers/asm-generic/mman.h             | 10 ++--
 linux-headers/asm-generic/unistd.h           | 10 +++-
 linux-headers/asm-mips/mman.h                |  3 ++
 linux-headers/asm-mips/unistd_n32.h          |  2 +
 linux-headers/asm-mips/unistd_n64.h          |  2 +
 linux-headers/asm-mips/unistd_o32.h          |  2 +
 linux-headers/asm-powerpc/mman.h             |  6 +--
 linux-headers/asm-powerpc/unistd_32.h        |  2 +
 linux-headers/asm-powerpc/unistd_64.h        |  2 +
 linux-headers/asm-s390/kvm.h                 |  6 +++
 linux-headers/asm-s390/unistd_32.h           |  2 +
 linux-headers/asm-s390/unistd_64.h           |  2 +
 linux-headers/asm-x86/kvm.h                  | 28 ++++++++---
 linux-headers/asm-x86/unistd.h               |  2 +-
 linux-headers/asm-x86/unistd_32.h            |  2 +
 linux-headers/asm-x86/unistd_64.h            |  2 +
 linux-headers/asm-x86/unistd_x32.h           |  2 +
 linux-headers/linux/kvm.h                    | 12 ++++-
 linux-headers/linux/psp-sev.h                |  5 +-
 linux-headers/linux/vfio.h                   | 71 ++++++++++++++++++++--------
 target/i386/cpu.c                            |  2 +
 target/i386/cpu.h                            |  1 +
 target/i386/kvm.c                            | 23 +++++++++
 34 files changed, 263 insertions(+), 59 deletions(-)

-- 
2.14.5


