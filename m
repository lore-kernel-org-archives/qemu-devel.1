Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82625C388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0587822243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVsJmo0/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0587822243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZluy-00022b-69
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZljs-00020r-VZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZljp-0003cD-IG
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GnhEUSVbX2k40m2RlE9VVXSMEC+QBtiNwMvHdvHW/EI=;
 b=SVsJmo0/8KedgTu1ItAJXizN+zIlXtCjOqZ7yeOPjar2JIUDKUT/AkzrU5wNBD28RCK0RD
 j+XkZ6ZHssKBmew/MPgSdJ5apYlvT5zCteKKROyMsp677OyXTahU/eEfnBh0KJFovA7z7I
 r4Ux6GDcvkLNW5fcJVeX5uEvLf+gnKM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-J4nOxP0cOvS9KkPUwTVhIg-1; Mon, 02 Nov 2020 21:07:54 -0500
X-MC-Unique: J4nOxP0cOvS9KkPUwTVhIg-1
Received: by mail-wr1-f71.google.com with SMTP id 33so7144708wrf.22
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GnhEUSVbX2k40m2RlE9VVXSMEC+QBtiNwMvHdvHW/EI=;
 b=VTTil7SuaRvMHRHGZp+ABBOZ/7q+7dLudcxfxXd0Do6PHcQdi4Y/ZKeAs4ebMYXOLx
 +4kP5232Ar7mo+Ivo9ggdrJ48Slct2YktnjSVBoAOgrQ7tPXgiydNmIwaLGwONUwCpFN
 frJJ/y3vzEdj8npIk0nWZCw32j1N86G36NZe2t625ii9mhrsfQjlJBa3ru8Jkmnmhq87
 OiFL6EIV+Sq+moBGNIYI2saDemv6wriDVowp5Y1s9Zt2RaacOIvtl8I//HFGSMeAcN7v
 HP1ivQZBDljBaN94HA6HD5KkEwL3i3UCvorihcR+w0qPKX5NxUMDqvplvrVrNxnKKr2R
 LsXw==
X-Gm-Message-State: AOAM531Gr9ESpcCLB7pcRs7Gj/8FO025nZXZEn8mCS9r35qY1sN6FdVk
 3QsGO9E+5OyzjKNMWkL4sq4V/npfu93BLFPlDMV4GSKW1ufVQ+FyDwNtlK3Q1zhz2A3gtjpcL7e
 cWxsClS532XRZ8Aw=
X-Received: by 2002:adf:e70f:: with SMTP id c15mr23777645wrm.239.1604369273151; 
 Mon, 02 Nov 2020 18:07:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHud+c98W7/OBo91l52MA1SFTpH+x9U3SiXjg4wj31Fd7tW+bfKPeaW4IYUh+VnM2bbpK/pg==
X-Received: by 2002:adf:e70f:: with SMTP id c15mr23777628wrm.239.1604369273018; 
 Mon, 02 Nov 2020 18:07:53 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id p1sm23200762wrx.3.2020.11.02.18.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 18:07:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 3/7] util/vfio-helpers: Trace PCI BAR region info
Date: Tue,  3 Nov 2020 03:07:29 +0100
Message-Id: <20201103020733.2303148-4-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 20:52:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
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
index 8d3615e717b..0753e4a0ed1 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -87,3 +87,4 @@ qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *io
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size 0x%x (region addr 0x%"PRIx64" size 0x%"PRIx64")"
 qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size 0x%x (region addr 0x%"PRIx64" size 0x%"PRIx64")"
+qemu_vfio_region_info(const char *desc, uint64_t region_ofs, uint64_t region_size, uint32_t cap_offset) "region '%s' addr 0x%"PRIx64" size 0x%"PRIx64" cap_ofs 0x%"PRIx32
-- 
2.26.2


