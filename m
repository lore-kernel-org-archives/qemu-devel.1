Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0BAC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EE622243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwKnLGmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EE622243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlo0-00053w-3Q
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlkE-0002PB-L4
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZlkB-0003fD-6T
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5DLckUUyoP1dg/42Pfez6Z6RF3ehTTuZJk5kW+hkoI=;
 b=VwKnLGmSgIcCO14VKWnThgInb4s7Ev1Qit8zdRAmWNA/Asw5UGu6BJh45Lz+YDVoSgRzid
 FO25PMEFof2rvkPMmbfKo9px3gnaPPf6Fre5uq/KOHtYc/csJCtbgNe/G8EM8Hx7hc3DXy
 S5eqM2s87mJN1tZvwfsfacjsZU6ERUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-atG_iCFVMhW6Gmk8GuIebw-1; Mon, 02 Nov 2020 21:08:12 -0500
X-MC-Unique: atG_iCFVMhW6Gmk8GuIebw-1
Received: by mail-wr1-f72.google.com with SMTP id h11so4245787wrq.20
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:08:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i5DLckUUyoP1dg/42Pfez6Z6RF3ehTTuZJk5kW+hkoI=;
 b=dqvnA9XqxMzscAz2NEZbuT5c2vwX3f+zDT6WMhMj3mgDTsPmI8403Nvojvb3KZce0V
 mXxh+tDOsCmsPp22vlbfeOMUTFoaPnMQAB/9hGR0KjwdP19B2LoSoFnGRTngCKDLjRVn
 WpDLRToIQAfVj3q/m5RabQ2kKXFVIWd1BxSMRFKOubHEgsqBsxTfjMYEZY6Vbsm0/a/8
 hpH1WfljOgudCbFUJu6UTOXTLOMgUnwwT1eUaK7qpzUECDaf1oNZQCQxcF7XGzfWPtx3
 kSrrphNyHWiF7UrZ0KZgdYxP3+RM8b7zqhTeqcWa4u2vOb07UItCXPD+hF/6b/fIvJUr
 UDQw==
X-Gm-Message-State: AOAM532YM9jnBcUyfSBj4zHkP2spills7Vv0RY54Ov+59txa0Bnp3svI
 9UepbxDW9rDYqU21l/hmHi2fGM/m0n5FhumOoeg+lctN4dbD8OjJgSfR0QJkbVqMDY4sIzv/MQJ
 jZRaxDdJZRl+K5aM=
X-Received: by 2002:a1c:2487:: with SMTP id k129mr979325wmk.86.1604369290363; 
 Mon, 02 Nov 2020 18:08:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBtmB2NIKAVc3MMmzoovcuJTysX+oxuXirRD39f7lUZ5ixg7t654Ru/gxmLO4+j2OmvMdKLA==
X-Received: by 2002:a1c:2487:: with SMTP id k129mr979304wmk.86.1604369290095; 
 Mon, 02 Nov 2020 18:08:10 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o129sm1283042wmb.25.2020.11.02.18.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 18:08:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 6/7] util/vfio-helpers: Convert vfio_dump_mapping
 to trace events
Date: Tue,  3 Nov 2020 03:07:32 +0100
Message-Id: <20201103020733.2303148-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201103020733.2303148-1-philmd@redhat.com>
References: <20201103020733.2303148-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU_VFIO_DEBUG definition is only modifiable at build-time.
Trace events can be enabled at run-time. As we prefer the latter,
convert qemu_vfio_dump_mappings() to use trace events instead
of fprintf().

Reviewed-by: Fam Zheng <fam@euphon.net>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 19 ++++---------------
 util/trace-events   |  1 +
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index c24a510df82..73f7bfa7540 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -521,23 +521,12 @@ QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp)
     return s;
 }
 
-static void qemu_vfio_dump_mapping(IOVAMapping *m)
-{
-    if (QEMU_VFIO_DEBUG) {
-        printf("  vfio mapping %p %" PRIx64 " to %" PRIx64 "\n", m->host,
-               (uint64_t)m->size, (uint64_t)m->iova);
-    }
-}
-
 static void qemu_vfio_dump_mappings(QEMUVFIOState *s)
 {
-    int i;
-
-    if (QEMU_VFIO_DEBUG) {
-        printf("vfio mappings\n");
-        for (i = 0; i < s->nr_mappings; ++i) {
-            qemu_vfio_dump_mapping(&s->mappings[i]);
-        }
+    for (int i = 0; i < s->nr_mappings; ++i) {
+        trace_qemu_vfio_dump_mapping(s->mappings[i].host,
+                                     s->mappings[i].iova,
+                                     s->mappings[i].size);
     }
 }
 
diff --git a/util/trace-events b/util/trace-events
index 08239941cb2..61e0d4bcdfe 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -80,6 +80,7 @@ qemu_mutex_unlock(void *mutex, const char *file, const int line) "released mutex
 qemu_vfio_dma_reset_temporary(void *s) "s %p"
 qemu_vfio_ram_block_added(void *s, void *p, size_t size) "s %p host %p size 0x%zx"
 qemu_vfio_ram_block_removed(void *s, void *p, size_t size) "s %p host %p size 0x%zx"
+qemu_vfio_dump_mapping(void *host, uint64_t iova, size_t size) "vfio mapping %p to iova 0x%08" PRIx64 " size 0x%zx"
 qemu_vfio_find_mapping(void *s, void *p) "s %p host %p"
 qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova) "s %p host %p size 0x%zx index %d iova 0x%"PRIx64
 qemu_vfio_do_mapping(void *s, void *host, uint64_t iova, size_t size) "s %p host %p <-> iova 0x%"PRIx64 " size 0x%zx"
-- 
2.26.2


