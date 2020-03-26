Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F1C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B1F2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CNcsArkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B1F2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZ03-00041z-UY
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLY-0000i5-4a
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYLV-0002Gp-AI
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:19 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:34736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYLV-0002Gc-5T
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:39:17 -0400
Received: by mail-qk1-x742.google.com with SMTP id i6so8212093qke.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8/INgrBRrXZ0Qg0hlrPjtYk/o1iCoQLqecnKNHF18P8=;
 b=CNcsArkPLB4nV0TVUu+9o0Ov9HCuKuWCO81KgbPvvVGb3OEk+I7JBFpalb3ThcqAnx
 AQQqtaLYox4C0dKKz/kZ5qFHpB9KU82Z8Agz3HsMJ45D7yfS/QrrwDbNI1w+AO3mh+ee
 Tloe0ByuBUdiExXYdTq/+4R5axUp/J5h7ZkUE1jGZ/0fjDEviLBenkJhVk59NlCc49Zw
 z1+BG0/jYSB0dsZD9EE2iQrY16wXb5cgTHvqBxdMDEWcS1giNJ62YNPe/CGQzR43UNsc
 nLl6fHHiElaIvrZDIa2akm3ZadWYOwcd8D30kr3mk4pwPkxYerBin2t1VD4MCLRzTu0b
 H9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8/INgrBRrXZ0Qg0hlrPjtYk/o1iCoQLqecnKNHF18P8=;
 b=PkAslw4BuVM5DfNiVz54Q966GaTtm4myAgJ5m4ucAM48X3IT7djktwDU8kimCoTkbL
 XPVuY/aeWbGsk2g/NW1bClDWxjYI/aFax8goosrWXoX2hxOvLVx06Z5zA/QWtpJveQzu
 Slc0AC5AhpfsZ2RLR5kR5itK7rCEWF5J5wxYzKoRdJ2Gebu4BhVPAaxqK22m5TT2Zxlo
 L6FNvY8Nv/j2D8JobQ0HggZGQIUoAtqTk6GE6nTE26zdmJYiNuUTqavc96F7R3BZe2Eb
 PQQd8FyoY7GVM2ITg3Ik4SbuO8tOmppEf3TAWLmeBC2a1LOkcryy76z0bFVyh1oJW8jf
 oaUw==
X-Gm-Message-State: ANhLgQ3BhnL4FeKCT2HyJa8VYYdgd+ybZBeji8Z4TL6zvShY9da66eCR
 JAuTu12vUBq+MBzWqrKsba7bE34FNVsGjQ==
X-Google-Smtp-Source: ADFU+vtXYB6vwfOsaddy4ft3/Kskj1TZdXrUN5i1HBhwSqxlkzy/wbDrl1+bfNXLtKiZK/drX+AVIA==
X-Received: by 2002:a37:b986:: with SMTP id
 j128mr10019113qkf.109.1585251556222; 
 Thu, 26 Mar 2020 12:39:16 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:39:15 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 74/74] cputlb: queue async flush jobs without the BQL
Date: Thu, 26 Mar 2020 15:31:56 -0400
Message-Id: <20200326193156.4322-75-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This yields sizable scalability improvements, as the below results show.

Host: Two Intel E5-2683 v3 14-core CPUs at 2.00 GHz (Haswell)

Workload: Ubuntu 18.04 ppc64 compiling the linux kernel with
"make -j N", where N is the number of cores in the guest.

                      Speedup vs a single thread (higher is better):

         14 +---------------------------------------------------------------+
            |       +    +       +      +       +      +      $$$$$$  +     |
            |                                            $$$$$              |
            |                                      $$$$$$                   |
         12 |-+                                $A$$                       +-|
            |                                $$                             |
            |                             $$$                               |
         10 |-+                         $$    ##D#####################D   +-|
            |                        $$$ #####**B****************           |
            |                      $$####*****                   *****      |
            |                    A$#*****                             B     |
          8 |-+                $$B**                                      +-|
            |                $$**                                           |
            |               $**                                             |
          6 |-+           $$*                                             +-|
            |            A**                                                |
            |           $B                                                  |
            |           $                                                   |
          4 |-+        $*                                                 +-|
            |          $                                                    |
            |         $                                                     |
          2 |-+      $                                                    +-|
            |        $                                 +cputlb-no-bql $$A$$ |
            |       A                                   +per-cpu-lock ##D## |
            |       +    +       +      +       +      +     baseline **B** |
          0 +---------------------------------------------------------------+
                    1    4       8      12      16     20      24     28
                                       Guest vCPUs
  png: https://imgur.com/zZRvS7q

Some notes:
- baseline corresponds to the commit before this series

- per-cpu-lock is the commit that converts the CPU loop to per-cpu locks.

- cputlb-no-bql is this commit.

- I'm using taskset to assign cores to threads, favouring locality whenever
  possible but not using SMT. When N=1, I'm using a single host core, which
  leads to superlinear speedups (since with more cores the I/O thread can execute
  while vCPU threads sleep). In the future I might use N+1 host cores for N
  guest cores to avoid this, or perhaps pin guest threads to cores one-by-one.

Single-threaded performance is affected very lightly. Results
below for debian aarch64 bootup+test for the entire series
on an Intel(R) Core(TM) i7-6700K CPU @ 4.00GHz host:

- Before:

 Performance counter stats for 'taskset -c 0 ../img/aarch64/die.sh' (10 runs):

       7269.033478      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.06% )
    30,659,870,302      cycles                    #    4.218 GHz                      ( +-  0.06% )
    54,790,540,051      instructions              #    1.79  insns per cycle          ( +-  0.05% )
     9,796,441,380      branches                  # 1347.695 M/sec                    ( +-  0.05% )
       165,132,201      branch-misses             #    1.69% of all branches          ( +-  0.12% )

       7.287011656 seconds time elapsed                                          ( +-  0.10% )

- After:

       7375.924053      task-clock (msec)         #    0.998 CPUs utilized            ( +-  0.13% )
    31,107,548,846      cycles                    #    4.217 GHz                      ( +-  0.12% )
    55,355,668,947      instructions              #    1.78  insns per cycle          ( +-  0.05% )
     9,929,917,664      branches                  # 1346.261 M/sec                    ( +-  0.04% )
       166,547,442      branch-misses             #    1.68% of all branches          ( +-  0.09% )

       7.389068145 seconds time elapsed                                          ( +-  0.13% )

That is, a 1.37% slowdown.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/cputlb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e3b5750c3b..d13feaf3a3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -284,7 +284,7 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
 
     CPU_FOREACH(cpu) {
         if (cpu != src) {
-            async_run_on_cpu(cpu, fn, d);
+            async_run_on_cpu_no_bql(cpu, fn, d);
         }
     }
 }
@@ -352,8 +352,8 @@ void tlb_flush_by_mmuidx(CPUState *cpu, uint16_t idxmap)
     tlb_debug("mmu_idx: 0x%" PRIx16 "\n", idxmap);
 
     if (cpu->created && !qemu_cpu_is_self(cpu)) {
-        async_run_on_cpu(cpu, tlb_flush_by_mmuidx_async_work,
-                         RUN_ON_CPU_HOST_INT(idxmap));
+        async_run_on_cpu_no_bql(cpu, tlb_flush_by_mmuidx_async_work,
+                                RUN_ON_CPU_HOST_INT(idxmap));
     } else {
         tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
     }
@@ -547,7 +547,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
          * we can stuff idxmap into the low TARGET_PAGE_BITS, avoid
          * allocating memory for this operation.
          */
-        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_1,
+        async_run_on_cpu_no_bql(cpu, tlb_flush_page_by_mmuidx_async_1,
                          RUN_ON_CPU_TARGET_PTR(addr | idxmap));
     } else {
         TLBFlushPageByMMUIdxData *d = g_new(TLBFlushPageByMMUIdxData, 1);
@@ -555,7 +555,7 @@ void tlb_flush_page_by_mmuidx(CPUState *cpu, target_ulong addr, uint16_t idxmap)
         /* Otherwise allocate a structure, freed by the worker.  */
         d->addr = addr;
         d->idxmap = idxmap;
-        async_run_on_cpu(cpu, tlb_flush_page_by_mmuidx_async_2,
+        async_run_on_cpu_no_bql(cpu, tlb_flush_page_by_mmuidx_async_2,
                          RUN_ON_CPU_HOST_PTR(d));
     }
 }
-- 
2.17.1


