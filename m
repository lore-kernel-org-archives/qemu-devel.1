Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD71C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E352224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tkv23GZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E352224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Ji-00017b-Ru
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AL-0007SO-MO
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41294)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AH-0008Jv-76
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isOyGHI7YG22yBJfURVToP+mUwE5y2Znz4P6pSCuvUw=;
 b=Tkv23GZ5o32w7zS+mlXb5jFySrGIiFnvSQpEv7YyUP3AI33PUd3E+i1AiqwTKWnuxd7c6W
 y84d11yniwjqHqafjicbOA2ZVtfS0fIIzhnW3i6W0x/M9xtbA8kdbzZwp2EjPo/NI6cnyY
 eL9c2uiLQE6U8ep7vZ8yenpAFtZ/tkc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-QuKfS_NRNB6HHqXYMulH2w-1; Mon, 26 Oct 2020 06:55:46 -0400
X-MC-Unique: QuKfS_NRNB6HHqXYMulH2w-1
Received: by mail-wr1-f71.google.com with SMTP id t17so8210879wrm.13
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=isOyGHI7YG22yBJfURVToP+mUwE5y2Znz4P6pSCuvUw=;
 b=nh9i5o7m40x/n4QfBXkB7mMEetJvFLAFQAi0zt6jtTJfA4wCrOb2hUfFnyLXHmZev7
 tl1s6KDPgPFPgFavQ8InMOH0BacaSVtZ1tI4oyrmNBCEfGGgzZKfNz+yhxip9qXWrhTy
 7KaBiZ0bU9CmYszxIz+oAU/AvqFaH9gvTsvyd5oA02RHsVUI+g0g9ZyseAMy3x9pNsfi
 6TTihC3WHWDdCdGRJg8TbzjbL9wD52dkwU6I2VJOjj8/lhp9xKcikuDDOkbkHCOaowqL
 xNMqID862WbKSXd9bk+gYmf/5BzcgkVRlpk0mu13MlElUklaXNpFD2UGnDlYDhA64WGN
 YHKw==
X-Gm-Message-State: AOAM5326dLzpFP87yiDJwIc5HVl5zbq1C2YBcrj+K1Can0N01StVQI6j
 /uoozrr55KPz0hlDATSzC45hNv2P8diyTh4cRL4svrB3TPDkRxevx/6TXbJVsJEbNrWJpyXHZ2Q
 jvONoufnkw5yPRa4=
X-Received: by 2002:adf:979c:: with SMTP id s28mr16987782wrb.62.1603709745509; 
 Mon, 26 Oct 2020 03:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4uVRXAgqCRafveEWRhY/2RI8BHRsJQOhKlSUDghUTKUVh3YiudCiZuB7eVHY8s4odg/WsFg==
X-Received: by 2002:adf:979c:: with SMTP id s28mr16987755wrb.62.1603709745334; 
 Mon, 26 Oct 2020 03:55:45 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 26sm7671180wmk.42.2020.10.26.03.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/19] util/vfio-helpers: Trace where BARs are mapped
Date: Mon, 26 Oct 2020 11:54:53 +0100
Message-Id: <20201026105504.4023620-9-philmd@redhat.com>
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
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For debugging purpose, trace where a BAR is mapped.

Reviewed-by: Fam Zheng <fam@euphon.net>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 2 ++
 util/trace-events   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index cd6287c3a98..278c54902e7 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -166,6 +166,8 @@ void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
     p = mmap(NULL, MIN(size, s->bar_region_info[index].size - offset),
              prot, MAP_SHARED,
              s->device, s->bar_region_info[index].offset + offset);
+    trace_qemu_vfio_pci_map_bar(index, s->bar_region_info[index].offset ,
+                                size, offset, p);
     if (p == MAP_FAILED) {
         error_setg_errno(errp, errno, "Failed to map BAR region");
         p = NULL;
diff --git a/util/trace-events b/util/trace-events
index 4d40c74a21f..50652761a58 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -88,3 +88,4 @@ qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
 qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
 qemu_vfio_region_info(const char *desc, uint64_t offset, uint64_t size, uint32_t cap_offset) "region '%s' ofs 0x%"PRIx64" size %"PRId64" cap_ofs %"PRId32
+qemu_vfio_pci_map_bar(int index, uint64_t region_ofs, uint64_t region_size, int ofs, void *host) "map region bar#%d ofs 0x%"PRIx64" size %"PRId64" ofs %d host %p"
-- 
2.26.2


