Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB261C47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755E6216FD
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABeC/jY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755E6216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUY0l-0004Es-GC
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUXwd-0005kt-GH
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1jUXwO-0006nZ-OQ
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:51:19 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jUXwO-0006jB-AL; Fri, 01 May 2020 11:51:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id d3so4718776pgj.6;
 Fri, 01 May 2020 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=srawoezEgSmPn22VCIB6frZQfxQjs2PbeiLzmPf/rHs=;
 b=ABeC/jY/zQnBVtjU+9xWUvokPhNu+xhBrU8Ub8bNS4UA/+Jh0Ny4sRPzsjtrLFXItR
 zUk9vBGgCVfwoHYcQUmsjKzjVoo8GgCNhSeZh5SD8rSN8d9Qi1i/0nDrGN2uf99T1ZVk
 pSCV88q8ZKacDwN/aHXyWiWfQ2moTmxuWvv8EpnWiOF6xESozfJj+cpmnPS0aFiDloQ6
 MjXaJZgZzEPQJw8zyTLvxp1e/JcjygqCb9jzM6bgsRJ+LHvM0mJeGvZjNSlIC94EcIvS
 +I+74i3ph6nAq3ZoEAKeGYfN6x25TmIt7uPG3OXGCiSELsqL7ZWGBrqeJRNRlyWNk1Dt
 qd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=srawoezEgSmPn22VCIB6frZQfxQjs2PbeiLzmPf/rHs=;
 b=qAYUCT2Al40hnSpxU/NGacpofl4G+mFs/89Spflzihfow1zrPjrUItH/L979AzoZZm
 wE755ueigiowwBEHBiqFXdKPzSdb2NGdz/na3FLtWncyegwsg8gKe98Q9AHtGdbAVluO
 Q1wXXkUU0caIl8DDj4+PAT/tywcPdFoZfZdq86tNgrO7VPlIZyQHv5lojFh/tj6lo1ZW
 KzoiJi2dehz+HdYH0VQdeTtK9+i6K8K0MABLsAFWmyLkpKfc04qseaBNaWW8MMZ0E5a9
 TsX/h6WRKxMbPFQfAScD/Zfw6pGraR6h1SNg55rXA2jm/J5lrHPqD4uZJEFQqvF0WzmZ
 Mi5w==
X-Gm-Message-State: AGi0PuZuWNQ7tmBsj32izWwjByxv0u/zBcpjd9dzsFCfo7Bz+8nV/BCj
 tU2IS4RvGjfHCjqfjeTsago=
X-Google-Smtp-Source: APiQypKVk6qQhterxBuBXLSX2nyvmoEnXlzEJbbZQSrXuanjxT06HVFqZiyxrIjiO9hI02FXX47BhQ==
X-Received: by 2002:a05:6a00:12:: with SMTP id
 h18mr4672831pfk.293.1588348262588; 
 Fri, 01 May 2020 08:51:02 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id e4sm2385968pge.45.2020.05.01.08.51.01
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 01 May 2020 08:51:02 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 2/5] gitlab-ci/opensbi: Update GitLab CI to build generic
 platform
Date: Fri,  1 May 2020 08:50:51 -0700
Message-Id: <1588348254-7241-3-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
References: <1588348254-7241-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Bin Meng <bin.meng@windriver.com>, Anup Patel <Anup.Patel@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This updates the GitLab CI opensbi job to build opensbi bios images
for the generic platform.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 .gitlab-ci-opensbi.yml | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/.gitlab-ci-opensbi.yml b/.gitlab-ci-opensbi.yml
index dd051c0..26092bb 100644
--- a/.gitlab-ci-opensbi.yml
+++ b/.gitlab-ci-opensbi.yml
@@ -34,18 +34,12 @@ build-opensbi:
    when: always
  artifacts:
    paths: # 'artifacts.zip' will contains the following files:
-   - pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
-   - pc-bios/opensbi-riscv32-virt-fw_jump.bin
-   - pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
-   - pc-bios/opensbi-riscv64-virt-fw_jump.bin
-   - opensbi32-virt-stdout.log
-   - opensbi32-virt-stderr.log
-   - opensbi64-virt-stdout.log
-   - opensbi64-virt-stderr.log
-   - opensbi32-sifive_u-stdout.log
-   - opensbi32-sifive_u-stderr.log
-   - opensbi64-sifive_u-stdout.log
-   - opensbi64-sifive_u-stderr.log
+   - pc-bios/opensbi-riscv32-generic-fw_jump.bin
+   - pc-bios/opensbi-riscv64-generic-fw_jump.bin
+   - opensbi32-generic-stdout.log
+   - opensbi32-generic-stderr.log
+   - opensbi64-generic-stdout.log
+   - opensbi64-generic-stderr.log
  image: $CI_REGISTRY_IMAGE:opensbi-cross-build
  variables:
    GIT_DEPTH: 3
@@ -54,10 +48,6 @@ build-opensbi:
  - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
  - echo "=== Using ${JOBS} simultaneous jobs ==="
  - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi32-virt 2>&1 1>opensbi32-virt-stdout.log | tee -a opensbi32-virt-stderr.log >&2
+ - make -j${JOBS} -C roms opensbi32-generic 2>&1 1>opensbi32-generic-stdout.log | tee -a opensbi32-generic-stderr.log >&2
  - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi64-virt 2>&1 1>opensbi64-virt-stdout.log | tee -a opensbi64-virt-stderr.log >&2
- - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi32-sifive_u 2>&1 1>opensbi32-sifive_u-stdout.log | tee -a opensbi32-sifive_u-stderr.log >&2
- - make -j${JOBS} -C roms/opensbi clean
- - make -j${JOBS} -C roms opensbi64-sifive_u 2>&1 1>opensbi64-sifive_u-stdout.log | tee -a opensbi64-sifive_u-stderr.log >&2
+ - make -j${JOBS} -C roms opensbi64-generic 2>&1 1>opensbi64-generic-stdout.log | tee -a opensbi64-generic-stderr.log >&2
-- 
2.7.4


