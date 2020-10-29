Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9039C55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0592076D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2uK52qp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0592076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4Ou-0005bD-1d
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4JE-0005h8-Fd
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4JC-0006NG-Nx
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iwpBUyVm11cIWEap1iOuTMpnwVQgkzK5ulnL1uzeS8=;
 b=N2uK52qpJDGHHvNNfQAfmv1Ke0N3IG9Ecu98CwZamatgsw2w/O4nDP8t0yfVjIZU0X5IAV
 S/6GKDmzk31hlOAp2DmHZ8bQAqkuVKTsXGAZO6wG4aGhykh31pS0sCTE63dUUM0vaqHorF
 dk+bwj7642k251QUiN97X0FrS7GcDEY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-WoUxsB_XOdWsVBRwcc_F0Q-1; Thu, 29 Oct 2020 05:33:21 -0400
X-MC-Unique: WoUxsB_XOdWsVBRwcc_F0Q-1
Received: by mail-ej1-f69.google.com with SMTP id lf18so934093ejb.13
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/iwpBUyVm11cIWEap1iOuTMpnwVQgkzK5ulnL1uzeS8=;
 b=ijHdp/+9y/jf4IqTUI9Kmwi5JK9kA+1VtXSg2/q9drQLZ0gg2y2rqCoMf897s5BI+O
 7yNcgKjb1XKQvG3vicCOLbuAiKntJkZKsFZJqm+z5LYsiCsj7noocU4Fap2lhPVoPU0x
 Q2m3QGwdC1qJiEEXBhti4ziNYLAfCH6BOmkhyWt5yOIjrYxgbDRzNYM0l2giWXwLdyNo
 IGn/mJewqYtKAMxcH2b94pwpKVUlShE1GwnkoFbWOKttcKKuRp0hIQWwG0HO2L6UjO/s
 FtCnwHJV99ivDA1LObqUWLDPiJEgy+Guh9eTxKjdJ9zaBt8WITwrdilSmq8pHKwhLVWx
 DJZg==
X-Gm-Message-State: AOAM532zRBLuJ6Zf2lnIgwBOJXwUtnqUxisFZr7UjbMoGPl39JCZyVRc
 xydtguIz4x0FHydjNKJCZvARwtNANkRmemKHLevwMvRKiP8SE+7vR/ZFzQsTqlDlJ1ZJJWzXYZr
 8oyGULCQCYBHIQXg=
X-Received: by 2002:aa7:c68b:: with SMTP id n11mr2903233edq.340.1603964000425; 
 Thu, 29 Oct 2020 02:33:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd9Y8hKZV4slTVUtEz8KDCwuGq5dGIoeff9nHapDqnvlJpaa0B5kAJ5yY0eat74Q20PwHb9A==
X-Received: by 2002:aa7:c68b:: with SMTP id n11mr2903216edq.340.1603964000288; 
 Thu, 29 Oct 2020 02:33:20 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id e14sm1170048ejc.15.2020.10.29.02.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:33:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 02/25] block/nvme: Use hex format to display offset
 in trace events
Date: Thu, 29 Oct 2020 10:32:43 +0100
Message-Id: <20201029093306.1063879-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029093306.1063879-1-philmd@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the same format used for the hw/vfio/ trace events.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/trace-events | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/trace-events b/block/trace-events
index 0e351c3fa3d..0955c85c783 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -144,13 +144,13 @@ nvme_submit_command(void *s, int index, int cid) "s %p queue %d cid %d"
 nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6, int c7) "%02x %02x %02x %02x %02x %02x %02x %02x"
 nvme_handle_event(void *s) "s %p"
 nvme_poll_cb(void *s) "s %p"
-nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, int flags, int niov) "s %p is_write %d offset %"PRId64" bytes %"PRId64" flags %d niov %d"
-nvme_write_zeroes(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offset %"PRId64" bytes %"PRId64" flags %d"
+nvme_prw_aligned(void *s, int is_write, uint64_t offset, uint64_t bytes, int flags, int niov) "s %p is_write %d offset 0x%"PRIx64" bytes %"PRId64" flags %d niov %d"
+nvme_write_zeroes(void *s, uint64_t offset, uint64_t bytes, int flags) "s %p offset 0x%"PRIx64" bytes %"PRId64" flags %d"
 nvme_qiov_unaligned(const void *qiov, int n, void *base, size_t size, int align) "qiov %p n %d base %p size 0x%zx align 0x%x"
-nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int is_write) "s %p offset %"PRId64" bytes %"PRId64" niov %d is_write %d"
-nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s %p is_write %d offset %"PRId64" bytes %"PRId64" ret %d"
-nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset %"PRId64" bytes %"PRId64""
-nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset %"PRId64" bytes %"PRId64" ret %d"
+nvme_prw_buffered(void *s, uint64_t offset, uint64_t bytes, int niov, int is_write) "s %p offset 0x%"PRIx64" bytes %"PRId64" niov %d is_write %d"
+nvme_rw_done(void *s, int is_write, uint64_t offset, uint64_t bytes, int ret) "s %p is_write %d offset 0x%"PRIx64" bytes %"PRId64" ret %d"
+nvme_dsm(void *s, uint64_t offset, uint64_t bytes) "s %p offset 0x%"PRIx64" bytes %"PRId64""
+nvme_dsm_done(void *s, uint64_t offset, uint64_t bytes, int ret) "s %p offset 0x%"PRIx64" bytes %"PRId64" ret %d"
 nvme_dma_map_flush(void *s) "s %p"
 nvme_free_req_queue_wait(void *q) "q %p"
 nvme_cmd_map_qiov(void *s, void *cmd, void *req, void *qiov, int entries) "s %p cmd %p req %p qiov %p entries %d"
-- 
2.26.2


