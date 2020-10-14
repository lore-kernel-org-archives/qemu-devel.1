Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31332C43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EFC20878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCrCwrdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EFC20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfPN-0004ss-EK
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLa-0008TX-KV
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLW-0000VL-81
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NZRNchyf6KqIGqa3qU7RafRDqVFOV3THBQqMLA8r2rk=;
 b=TCrCwrdOBwCXYU3tmqgO64CcdGA4Zu4aQX03ECiQOJGz7sYcD9Sg2muF91ExPNlQsih7MR
 mfh+aop6LFZLob2c4yP6yU4bzodP9Eg0K/UEfAbSSzSHqDc1It5AW6Dvi7sdP/j+Vm6RDa
 qfHqRP7k5GxCppMZfgg0i7ga77XyZ0g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-Zgs9E0LlPZqmwQMcx9uycQ-1; Wed, 14 Oct 2020 07:53:27 -0400
X-MC-Unique: Zgs9E0LlPZqmwQMcx9uycQ-1
Received: by mail-wm1-f70.google.com with SMTP id c204so530001wmd.5
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NZRNchyf6KqIGqa3qU7RafRDqVFOV3THBQqMLA8r2rk=;
 b=YFzJuem3PYjaQ86y5mkFlj2LI9RvC4OMbp5Rbfcg5JSS0nCU0ZQ+UUbRpfE4FCk6Vg
 Jl6+bT9KFcw+uy2MTotf0HXPxTGH4JV36rBtL+N13vOucRlE39mgrFxilmKJdLM0LrDL
 ufNqdJIh9HT+RFn8cP2Cp0tApZZuh1mHLchRhv3sv9FK6p4n6eAOI/geBPB1RsVYOHNH
 Bq4DyMiC4DFLVELrcjofVlbbqkZCj+KvNEpb2J0YK84jsjrRPCx+4EzBgRg9iOWhLUEi
 ZTPaRaHB3uSrOdngimCzufsl5mAk/yKa89xfaZFHNfHA/9+WQK6mfkKDpvVpJiCbFED9
 I+1g==
X-Gm-Message-State: AOAM530DcX2YHPwlqz3zQZOkOM5Sr7keDTrZGAf+nFC5YTDE5f4mixQC
 r4t2EnvA021EOb8UbCgrhrHfSxsJd+3mXGesWyCY2Zh6yhYzYUQfN5Njfx9JOpdPZNCpx3ldvJC
 RoV0IvGVlKINL+gg=
X-Received: by 2002:adf:fe09:: with SMTP id n9mr5290307wrr.144.1602676405575; 
 Wed, 14 Oct 2020 04:53:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg5JvYw9Ikt1i2TBNxCpLvTcvfsn2s1ANx5vtPbSfyN3FzTJMj6EJUgvtZqLhXOksiVF2MWA==
X-Received: by 2002:adf:fe09:: with SMTP id n9mr5290282wrr.144.1602676405322; 
 Wed, 14 Oct 2020 04:53:25 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 71sm4912323wrm.20.2020.10.14.04.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 04:53:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/9] util/vfio-helpers: Convert vfio_dump_mapping to trace
 events
Date: Wed, 14 Oct 2020 13:52:50 +0200
Message-Id: <20201014115253.25276-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014115253.25276-1-philmd@redhat.com>
References: <20201014115253.25276-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU_VFIO_DEBUG definition is only modifiable at build-time.
Trace events can be enabled at run-time. As we prefer the latter,
convert qemu_vfio_dump_mappings() to use trace events instead
of fprintf().

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
index 8598066acdb..7faad2a718c 100644
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


