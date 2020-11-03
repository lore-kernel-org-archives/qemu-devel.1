Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E9DC00A89
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D136222264
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 02:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXRwW54A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D136222264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZlyC-0004ok-01
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 21:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZljy-0002El-BA
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZljw-0003e4-H3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 21:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604369283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxz0K8Rx7B0HHvdzSABsXnGF+kDXzjJU6AYfb2kJrPg=;
 b=hXRwW54AjGJ05TijHa97gYGvUhG7r9BBRkKOzZt8f8RIx4KBktJlRbSDjM2ZkAUOERXM+L
 z7xNcUsD789NbSIP9nCeQpR1VMH5WPIvSBveVGRK+Evo90VwSZddhUDmoWP8lgZ671QfY4
 D0vYtWPwlYKs2egOIwxgG2EI98iaOkg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-_o3AJTSQM96SY8ln2E6Dtw-1; Mon, 02 Nov 2020 21:08:00 -0500
X-MC-Unique: _o3AJTSQM96SY8ln2E6Dtw-1
Received: by mail-wm1-f71.google.com with SMTP id u207so4057573wmu.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 18:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rxz0K8Rx7B0HHvdzSABsXnGF+kDXzjJU6AYfb2kJrPg=;
 b=OHx4lDrEUwDN2Zhl/+YcOCloKufIBzgAqYQSKfpcX/e4wiS1QuVXvpwjcHqTUAPXzS
 BuOKFC8BpISbUFvZX/Z8VROazOeNZ4DHTDYxPhxPWmyquQYKusmWZ0Ofx0EfVPvNBJDO
 KMXInxk0aBNeGCo+PgIigS+cyPlFko1XwDkNNB6gNJGjx/4TxguZTiquAvsDmrdNtDve
 7jPFfUrj5xqQEk3EBUQ2j3rNtaJD7BcMveX56urp0jyHA9db/qApsFRvip3kvX9JpLt8
 eSzOy3rTSjZ7FLntJ5wY/TAPBJjtGzs6smd2tUsG90HJ4WFVPdFuD2uKjoleB2zZtti2
 3ezA==
X-Gm-Message-State: AOAM530nD1GY7HhNs53GroljX0/n+yeSphBLtD6H0CppM78ugG0hdSP0
 cjl0xat6bHLxRa7jPzbvGFxQooHgVUvoOp1cz45Sga4lB+nWH1Yiz0cWdn99OEVUDKnxXhizJiX
 nKEoL8h0HTf8+Rt4=
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr23596525wrm.80.1604369278692; 
 Mon, 02 Nov 2020 18:07:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsX3gsJC8u9RlFrPaiMyavPKnXzu6zJwhqOZNGQt+ckmqKHEkfLkTrjzuOepnazkna1ClCMg==
X-Received: by 2002:adf:ea0b:: with SMTP id q11mr23596510wrm.80.1604369278571; 
 Mon, 02 Nov 2020 18:07:58 -0800 (PST)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id y187sm1213180wmg.33.2020.11.02.18.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 18:07:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v3 4/7] util/vfio-helpers: Trace where BARs are mapped
Date: Tue,  3 Nov 2020 03:07:30 +0100
Message-Id: <20201103020733.2303148-5-philmd@redhat.com>
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
index 0753e4a0ed1..52d43cda3f3 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -88,3 +88,4 @@ qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size 0x%x (region addr 0x%"PRIx64" size 0x%"PRIx64")"
 qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size 0x%x (region addr 0x%"PRIx64" size 0x%"PRIx64")"
 qemu_vfio_region_info(const char *desc, uint64_t region_ofs, uint64_t region_size, uint32_t cap_offset) "region '%s' addr 0x%"PRIx64" size 0x%"PRIx64" cap_ofs 0x%"PRIx32
+qemu_vfio_pci_map_bar(int index, uint64_t region_ofs, uint64_t region_size, int ofs, void *host) "map region bar#%d addr 0x%"PRIx64" size 0x%"PRIx64" ofs 0x%x host %p"
-- 
2.26.2


