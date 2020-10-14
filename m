Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3230C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFC020848
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 12:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDm56l+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFC020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSfSN-0000WU-Mv
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 08:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLP-0008MW-6d
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSfLN-0000Ul-Hv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 07:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602676400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcXE6uNqT5zarSCdiyYz+Zw4SYDb1bSV+Wf41cxg400=;
 b=NDm56l+2RVbTjLCde02WeHWPr3FAqoGh+TOurKy5z90O6Z0H/ay3sAQ2+8i+c6fBCTfTkD
 Gmfw7RDT49UwVuU7mSfWAcivvIc2MfnEldVUcIjLjv9vBoASYvLXlMIIfed5CQANoEUxud
 S8qXCD4idbQWacw3SG9Jg2LHg5NMMkE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-PqBcULVnOfGuS9JAC0Xgag-1; Wed, 14 Oct 2020 07:53:16 -0400
X-MC-Unique: PqBcULVnOfGuS9JAC0Xgag-1
Received: by mail-wr1-f71.google.com with SMTP id b11so1186899wrm.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 04:53:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fcXE6uNqT5zarSCdiyYz+Zw4SYDb1bSV+Wf41cxg400=;
 b=TbW8W9QX7OlNdIi1Vb2sYmlVdAAi9mOVk+Hvc7rfkgXMrSjlAbEqXMVN8daA++IZ77
 UVCRloGFrIOKe3CEELki1WcfwVsMzLr93Ge3PxRe8QqI851LRUD/Ux3BJYy6oqsfd1oT
 un6A6JgutKusSMb7CqMDU2w3iK90+rj9fCm9eoQPEA//ltogOqMZqvayhVz+kpPoM0b5
 Ilus/ylTr1HlHV7+r0Jf0LkF+rC2nldxxtT5vUsSdr3VlZREVtbBv8DJMXao/knvuh5q
 eEYPo7KmXBbb4+8GZcMENlE3RH5U1k1Z0ZwDETL/bCq0NP6cVhrbq+BcI9v+mDIlBqEo
 LpEg==
X-Gm-Message-State: AOAM533uDrlKZTCuEt0mzhdOofedFJMUdBip4CWxbqMgELsmiERa8QKc
 7CE0v/iEr2ajxxL32mPc9Cx0YDOWboX/w0373Zy6v1x/O+Jj1NkRDmf7DOR/P9RS9fbp+QOaGiF
 kRtCry+9DFteGsWU=
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr5284752wrm.423.1602676395233; 
 Wed, 14 Oct 2020 04:53:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTgo4v/FSt9mSGD+KFD2dC/8duzlFdXCK8/kUP4osNTTHueQC1g5n6SbB5Xh9X8IY8TLOTHw==
X-Received: by 2002:adf:e6c4:: with SMTP id y4mr5284728wrm.423.1602676395088; 
 Wed, 14 Oct 2020 04:53:15 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u202sm3624238wmu.23.2020.10.14.04.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 04:53:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/9] util/vfio-helpers: Trace where BARs are mapped
Date: Wed, 14 Oct 2020 13:52:48 +0200
Message-Id: <20201014115253.25276-5-philmd@redhat.com>
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

For debugging purpose, trace where a BAR is mapped.

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


