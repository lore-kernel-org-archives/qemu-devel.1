Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDF7C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71D12064A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzrru/7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71D12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkYm-000218-TW
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVY-0004SL-Ay
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34820
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVX-00020v-Fw
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZIo/ym+GwChrjVctsSvXHZCFHOcswzIaMYFLtwhZ4lE=;
 b=dzrru/7fz/mklnskO3+tTD7YiOLp6j/uEV3iRgqg8if48FKApN0SIHBjinWraYOfUDefMU
 2QVbWCzBgjMfrltEUOFVQ/v86nrXEq9oueoGAiU7XBRglC3GoADl1s0GAJ3yqq7Kigd/zP
 E2eHZgTZmo5y6T3cLXDI9QT9iC9AGq4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-FmDPm5V4PCOmGm1V3jHKFw-1; Thu, 07 May 2020 13:40:22 -0400
X-MC-Unique: FmDPm5V4PCOmGm1V3jHKFw-1
Received: by mail-wr1-f70.google.com with SMTP id u4so3869705wrm.13
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i0MZMfJVODlK5BEAJP5UwDYJxQ9slk7d2GJvo0cW21A=;
 b=cSabAA1Zr7ui2QAjubogGow4xWJYlL8KSVvIBqspuwZRGdWYN+tWaBX1Fum+o9cShK
 Ls2/lgDAQsguUtQcaqyBndg+lp9UtAtm2ZVVHwA+rnsc4CP5Dxy/2SjrA/AUDUEpQCIQ
 PrIMdkTKRU77QSmFqQbLvehQq3KEOVRjL9qrLUe0uduzprvlfnpXc3daoKXBZcbFBKvk
 JFP7qZ+/xsTXlPAemOKtsvHT2cD0FLM4ieVjMeY++z2awpBRhepKi2tRTHTZYtWK+ziQ
 2BqwJt0uLrzhIwGsA75Wb16Q+yoI+4ygvVmKMRjgLjXsGJMGgCXyUQ9MT/tO5ASOZpYG
 X98Q==
X-Gm-Message-State: AGi0PuYpt1ENq0oHvfuTbmf8RfuSe5gAUsWFJ2CVI3EpP1M6MNU38vlQ
 0VsJlXQLHqx6fW0hV2Bf5eIdGlANr60dcSNMaOb1h0j+zJbi0Z301G8K6C+qXcp/VTZp1G2e7UZ
 k6TArMQKLvbeNNv4=
X-Received: by 2002:a1c:2e91:: with SMTP id u139mr11194544wmu.18.1588873221696; 
 Thu, 07 May 2020 10:40:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypLjd6hp7wq7mFKudq18rc8BGau0g28R6juxYKJghEkCTOt96u7gXk2f7QLvYsavtxvXfsaWtw==
X-Received: by 2002:a1c:2e91:: with SMTP id u139mr11194521wmu.18.1588873221496; 
 Thu, 07 May 2020 10:40:21 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v131sm9445838wmb.19.2020.05.07.10.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:40:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 03/10] exec: Move tb_invalidate_phys_range() to
 'exec/exec-all.h'
Date: Thu,  7 May 2020 19:39:51 +0200
Message-Id: <20200507173958.25894-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move tb_invalidate_phys_range() to "exec/exec-all.h" with the
other TranslationBlock invalidate functions. Move all these
functions altogether. Check for the CONFIG_SOFTMMU definition
which is more explicit than CONFIG_USER_ONLY.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/exec-all.h | 14 ++++++++------
 include/exec/ram_addr.h |  2 --
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 350c4b451b..f1a9b8a576 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -454,12 +454,15 @@ static inline uint32_t curr_cflags(void)
 }
=20
 /* TranslationBlock invalidate API */
-#if defined(CONFIG_USER_ONLY)
+#ifdef CONFIG_SOFTMMU
+void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs att=
rs);
+void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end);
+void tb_flush_jmp_cache(CPUState *cpu, target_ulong addr);
+#else
 void tb_invalidate_phys_addr(target_ulong addr);
 void tb_invalidate_phys_range(target_ulong start, target_ulong end);
-#else
-void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs att=
rs);
-#endif
+#endif /* CONFIG_SOFTMMU */
+
 void tb_flush(CPUState *cpu);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
@@ -583,7 +586,6 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, =
ram_addr_t length);
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr);
=20
 /* exec.c */
-void tb_flush_jmp_cache(CPUState *cpu, target_ulong addr);
=20
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr addr,
@@ -591,7 +593,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int as=
idx, hwaddr addr,
                                   MemTxAttrs attrs, int *prot);
 hwaddr memory_region_section_get_iotlb(CPUState *cpu,
                                        MemoryRegionSection *section);
-#endif
+#endif /* CONFIG_USER_ONLY */
=20
 /* vl.c */
 extern int singlestep;
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 7b5c24e928..06096e8c6a 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -147,8 +147,6 @@ static inline void qemu_ram_block_writeback(RAMBlock *b=
lock)
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_COD=
E))
=20
-void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end);
-
 static inline bool cpu_physical_memory_get_dirty(ram_addr_t start,
                                                  ram_addr_t length,
                                                  unsigned client)
--=20
2.21.3


