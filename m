Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD80BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3664B2224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+Lxxypv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3664B2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0HP-0007Oh-7D
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AG-0007NP-LC
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AD-0008IH-4s
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJzeX7lyaDemOB2QTG1Y3n+OWt54ICMjUzceGOoInIo=;
 b=Q+LxxypvE6g+ZM+ktQfVwLlihNtVGZcnBAv9xMHHsdJwVSCM+8TcJ40nKUmTzVE7y6OcUT
 z78jYvU2+x9mCpYGgjvensyE9SkGoC+HGv440Ay9BGBcsaGP5FjKy69Nsy9DhtpkoEipZR
 kC6edl97NJewPXaZbmrdFNyOT3xgLsk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-oQB53aw1PDOqW1BfcWTBUA-1; Mon, 26 Oct 2020 06:55:42 -0400
X-MC-Unique: oQB53aw1PDOqW1BfcWTBUA-1
Received: by mail-wr1-f69.google.com with SMTP id r8so8183841wrp.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jJzeX7lyaDemOB2QTG1Y3n+OWt54ICMjUzceGOoInIo=;
 b=IuCFA1BQHMblhgKTMnmhQB1gw8t7kCuLTqrOc/+uEgxCHPJCDvcuh6yOXVT3cdi/lg
 ZO6fTpLNv0j5QwyzYY09xCB/LwJ23zbhDMoFflGM/OJ6kC/bsXpAEgHlHpID8UxjeXRb
 0sEn6GcGUzQ0E2CMbD2b8nu4J8F2VVQjbN/wyM7F3A7SmRkFTZvmjTe1teMFbyykGtAU
 Ay+r2k8mQsmxKKVf3/Vq+cmm/htDYEpKEA1DXfaqkZNN8FjZuUc3H58/nGbb48a9FFbg
 ukIzy/gEjyUf+dyZsbedl5lvp9ZoTVTlFSddEsI/+oH8A/uvtVHgdJCJNqBjZ6x/YmFJ
 dAJg==
X-Gm-Message-State: AOAM531Lzytwx+qLpEV93NAEX2JXwqf+OI/cD3c/Kp0JF5DlxwydgQyP
 /UviN87of17egN4jVFwZvssyGxqh7r2vui70lOclUccuVN1gql5sM6C5eyzVY98gWERGlWr2Zqt
 W8ZZa3lA5b+b/5Go=
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr16284941wmj.154.1603709740674; 
 Mon, 26 Oct 2020 03:55:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe2y0OyvBqzoh3Dpf17wbm5M1CkR3WwDvAihIJrU9Z14iJ8ablrFpUKe264tnVOoW2Gu1G8g==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr16284916wmj.154.1603709740480; 
 Mon, 26 Oct 2020 03:55:40 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id b131sm1160966wmc.3.2020.10.26.03.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/19] util/vfio-helpers: Trace PCI BAR region info
Date: Mon, 26 Oct 2020 11:54:52 +0100
Message-Id: <20201026105504.4023620-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For debug purpose, trace BAR regions info.

Reviewed-by: Fam Zheng <fam@euphon.net>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 8 ++++++++
 util/trace-events   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 1d4efafcaa4..cd6287c3a98 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -136,6 +136,7 @@ static inline void assert_bar_index_valid(QEMUVFIOState *s, int index)
 
 static int qemu_vfio_pci_init_bar(QEMUVFIOState *s, int index, Error **errp)
 {
+    g_autofree char *barname = NULL;
     assert_bar_index_valid(s, index);
     s->bar_region_info[index] = (struct vfio_region_info) {
         .index = VFIO_PCI_BAR0_REGION_INDEX + index,
@@ -145,6 +146,10 @@ static int qemu_vfio_pci_init_bar(QEMUVFIOState *s, int index, Error **errp)
         error_setg_errno(errp, errno, "Failed to get BAR region info");
         return -errno;
     }
+    barname = g_strdup_printf("bar[%d]", index);
+    trace_qemu_vfio_region_info(barname, s->bar_region_info[index].offset,
+                                s->bar_region_info[index].size,
+                                s->bar_region_info[index].cap_offset);
 
     return 0;
 }
@@ -416,6 +421,9 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
         ret = -errno;
         goto fail;
     }
+    trace_qemu_vfio_region_info("config", s->config_region_info.offset,
+                                s->config_region_info.size,
+                                s->config_region_info.cap_offset);
 
     for (i = 0; i < ARRAY_SIZE(s->bar_region_info); i++) {
         ret = qemu_vfio_pci_init_bar(s, i, errp);
diff --git a/util/trace-events b/util/trace-events
index c048f85f828..4d40c74a21f 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -87,3 +87,4 @@ qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *io
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
 qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
+qemu_vfio_region_info(const char *desc, uint64_t offset, uint64_t size, uint32_t cap_offset) "region '%s' ofs 0x%"PRIx64" size %"PRId64" cap_ofs %"PRId32
-- 
2.26.2


