Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A84C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B8620848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 11:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bCNy9nMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B8620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfP8-0004Rz-Ki
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 07:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLL-0008JH-H0
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLJ-0000UI-TK
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0nQOcSXgGeFKLC8eBLeMm+CVlg7cM+j+4WzFi+JgNU=;
 b=bCNy9nMGq19DoBIluT5sZrdI6UZvejVpHIfKkLwU6295HiaOGS52HWbF/GLNYV/IzT+zWS
 gWlatvu8pERJWHGaxTmQPhZMV9R2W5fCtVRZKLIhMx7AG0Qjdcgnc/f2sni7lbBOi/xYH1
 Bwr/VFdqnIzMvYu6Q0f4NLtbyIyX7ro=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-C_62GhaUNsqoUOnr0-YNzg-1; Wed, 14 Oct 2020 07:53:12 -0400
X-MC-Unique: C_62GhaUNsqoUOnr0-YNzg-1
Received: by mail-wm1-f70.google.com with SMTP id r19so522385wmh.9
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s0nQOcSXgGeFKLC8eBLeMm+CVlg7cM+j+4WzFi+JgNU=;
 b=RmOpLYgcFO06V+eQWlhrg6tUeBmlUNLWuahJLQBbnlu4G3niT8sOXlOaiURIUuF9jt
 1vxSXXWcGB1HFXbTdWGQf6tom/QsBSmQ2eWjdaYK0uQE/J/vyntnscKGqhI75TKeJhGc
 L0w1t1MQRx8cgcSWrl8NlUWxYFL7JrSeWmHcc0msBMvzYo5P+sFVeRhFt9byhuskt/W+
 vbl30Ny0voM4vRc4ra22SV5mK8fOwAM1vJZ74vhU26hgzB0b50YxQBjXO1R3c+ZsaBO2
 V4u7pJLZLU7nVtXDbFio+nTvfC9VdExPFrsFtpGkpCgAoBjJh71YL3nrFzTE9kn/TkdP
 0jxg==
X-Gm-Message-State: AOAM531O5h3JXMFnK9b9CrGtNV5Km3VoT8ORl8hDNR97uC4q8hsN2Vry
 PzZmWTBAF1jIG5yOAs87+n8P9dh7UwFYnAJnlWWN5Isrm2AwWZRtzI0f+XM7eqsqoM/NQV9z8LK
 yd23tgjxkjg+oBcE=
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr5135587wrr.19.1602676390432; 
 Wed, 14 Oct 2020 04:53:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNpBqJ3zXQsezdDi+f724BoFg593jbXlwPGhLcc/apofSvYXfqyG6eLyZJlm+ggWdBiv49CQ==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr5135566wrr.19.1602676390275; 
 Wed, 14 Oct 2020 04:53:10 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id q9sm4759658wrd.57.2020.10.14.04.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 04:53:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/9] util/vfio-helpers: Trace PCI BAR region info
Date: Wed, 14 Oct 2020 13:52:47 +0200
Message-Id: <20201014115253.25276-4-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For debug purpose, trace BAR regions info.

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


