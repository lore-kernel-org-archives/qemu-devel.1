Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DABC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1E222258
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J19eMQCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1E222258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPYp-00017r-Nb
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSJ-0002p8-4B
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34305)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSH-0004DZ-Bj
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603806964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=faAds+I3T/QXPAYkC+t4lGLvv4Dkjc5SBZjt6RcJJiw=;
 b=J19eMQCOODSJ+LPgOBasVzhKYKZgy0hWSUQkDMAlM1IX9Xsu4oXzJdEubHvCl/aiks4CQF
 hDkXXewno+dCV3cfdxH7ZrWZNtTHz5JUnr2t8e0ETqGq6l0i6b1Tf8OIO5QSaPBKrcBkxo
 hJpuYkJpwIx+A3IKUkRV3JgEDhM9TjQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-jytlUp0uO2aYVaq06FdxYg-1; Tue, 27 Oct 2020 09:56:02 -0400
X-MC-Unique: jytlUp0uO2aYVaq06FdxYg-1
Received: by mail-ej1-f71.google.com with SMTP id z8so939921ejw.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=faAds+I3T/QXPAYkC+t4lGLvv4Dkjc5SBZjt6RcJJiw=;
 b=pvmqaYZIBrpQAffocS7dKbr5obhL/zJNsplyzKNEjmRCndGeoXAZNqs6nN+Og3lRHa
 Vdv8f+iabXgGYdwEWp4rIZ6NIiIls1VJBiqbGblVrI0jG5VlKuxBgaknXQ0DC6FXVltW
 aGero57to5CNOoEUL8wOqrZmYT5t2jZUpggZXjmyKcBAv3MwktuuxYBRgqDa41U1RnY7
 wl1XRj61eGTYuEj29fgovWd8BVZaV9KL91QXduP6Eet284Kpa6xAeKTKLcZRlfkryQd6
 LWelZXucvKBSBDOfIsehNcUa2KRuTn88IjGbXQ/SwegImEHdcZtHfy027K7UOiA4j9Sc
 MEkA==
X-Gm-Message-State: AOAM531u9f582QjA56bmIXjDsRiy7+HxNFQmf2nj4/3FpCr3lSGKjXTJ
 RIAd9DcHLavk/SjvrtzPO+cJYKH2NVfv4VPCYOUx0Cv7lCNdbquso6Wl8aZbqWGgI0Nodkmgw2J
 sp29JZZGP1Y6tR0A=
X-Received: by 2002:aa7:c84b:: with SMTP id g11mr2282892edt.86.1603806961310; 
 Tue, 27 Oct 2020 06:56:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0FF6H+9NW/CpsE27BDUdX+VEQ9qNYcDYjbD83uhjrsFxaVSQUtGW42sbTbKdvm6WVr5HfDA==
X-Received: by 2002:aa7:c84b:: with SMTP id g11mr2282868edt.86.1603806961082; 
 Tue, 27 Oct 2020 06:56:01 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id hb6sm1109168ejb.65.2020.10.27.06.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:56:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/25] block/nvme: Use hex format to display offset in trace
 events
Date: Tue, 27 Oct 2020 14:55:24 +0100
Message-Id: <20201027135547.374946-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the same format used for the hw/vfio/ trace events.

Suggested-by: Eric Auger <eric.auger@redhat.com>
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


