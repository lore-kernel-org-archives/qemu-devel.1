Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C716EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EFC520658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEkiEZCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFC520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXkc-0002LF-Nb
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgb-0004rG-IR
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:46:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22363
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgZ-00044C-Ud
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588585611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhOlEPdV1MPRa1bhWdiFiaKD4sTZExgyZBrWdNh/d4I=;
 b=NEkiEZCNWrxelnDujwEvNL+zpD9zUy8jqNZt8iKL1PshQ5I3subJPw1D6A8kFxhCm0nPk+
 KZFHunVtFfYhbLEaB278D0hGkTIsD4A1uo+d8zUVw77Twm4bBvUTDeK+46CldwcTI6NxmV
 DhWa5YJhniRj3lB717uVcr+uK7daBBk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-PKpxtiWPOCC29jxLKp6yRQ-1; Mon, 04 May 2020 05:46:50 -0400
X-MC-Unique: PKpxtiWPOCC29jxLKp6yRQ-1
Received: by mail-wm1-f71.google.com with SMTP id b203so3212760wmd.6
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fe9XuSKHStEMPdZ3hwHFEgn1Ge5bLQXbUaYotgjFj4E=;
 b=KKBDczEK2dNGaqNM49J+v/GZ3r9KHDWnZbaUmx/owa+hJWPkP+X9CI8v2ygB+Gb/K/
 seFj3PZ8EyPQUAi3v72sEpeIQ8vRqs21cgAk5kCydyxHfrNRHxuFKx0LcQ6VB4D6GK1E
 UtLzR9SxWcgFWoF0K1ABxlHPBsmuxQoQ7ZrZN7v3KoLtDi7uN9GXrNc7u0YdUNR4VC16
 y+/yHhclypYfeuZGXgJs/dZ8m1uOL8/rS7mL65YaI3u0xGlI855S/7JSRs2jCeW9IEgI
 Ghbh2p7ADPiwmhxgR2giuxcRdWIj8IiHenBS4W0Zwmno7NBQ/RHKXXM+1/Istk7sy0+b
 cGDg==
X-Gm-Message-State: AGi0PuY1+0zwz65bz2HwmrnjB4pmku9VNPnrHid8MWv25IEWxJeb///a
 747ZjVANQ2IRcAALPWs+p8F8p2NK2egdntb6+6GiomlDEcs/Y1j4VcadecEsEto1EScTeqTLyWs
 R4myBVXnJBXP5pIA=
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr13126525wmg.1.1588585608433; 
 Mon, 04 May 2020 02:46:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypL1J0dxwdFdpgEDg8RfuSauWRqWbXCT2JLum/eK1/uv9/8nuQGi696XSk/esqWqO1+WztmEdw==
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr13126493wmg.1.1588585608190; 
 Mon, 04 May 2020 02:46:48 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id q4sm11501353wrx.9.2020.05.04.02.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:46:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] qemu/osdep: Document qemu_memalign() and friends
Date: Mon,  4 May 2020 11:46:36 +0200
Message-Id: <20200504094641.4963-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504094641.4963-1-philmd@redhat.com>
References: <20200504094641.4963-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:21:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Document allocator functions that require a specific
de-allocator call.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/block/block.h          | 4 ++++
 include/qemu/osdep.h           | 3 +++
 include/sysemu/block-backend.h | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 8b62429aa4..c57fdecf9a 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -526,9 +526,13 @@ void bdrv_img_create(const char *filename, const char =
*fmt,
 size_t bdrv_min_mem_align(BlockDriverState *bs);
 /* Returns optimal alignment in bytes for bounce buffer */
 size_t bdrv_opt_mem_align(BlockDriverState *bs);
+/* callers must free the returned pointer with qemu_vfree() */
 void *qemu_blockalign(BlockDriverState *bs, size_t size);
+/* callers must free the returned pointer with qemu_vfree() */
 void *qemu_blockalign0(BlockDriverState *bs, size_t size);
+/* callers must free the returned pointer with qemu_vfree() */
 void *qemu_try_blockalign(BlockDriverState *bs, size_t size);
+/* callers must free the returned pointer with qemu_vfree() */
 void *qemu_try_blockalign0(BlockDriverState *bs, size_t size);
 bool bdrv_qiov_is_aligned(BlockDriverState *bs, QEMUIOVector *qiov);
=20
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 20f5c5f197..778c459c22 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -294,8 +294,11 @@ extern int daemon(int, int);
 #endif
=20
 int qemu_daemon(int nochdir, int noclose);
+/* callers must free the returned pointer with qemu_vfree() */
 void *qemu_try_memalign(size_t alignment, size_t size);
+/* callers must free the returned pointer with qemu_vfree() */
 void *qemu_memalign(size_t alignment, size_t size);
+/* callers must free the returned pointer with qemu_anon_ram_free() */
 void *qemu_anon_ram_alloc(size_t size, uint64_t *align, bool shared);
 void qemu_vfree(void *ptr);
 void qemu_anon_ram_free(void *ptr, size_t size);
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.=
h
index 34de7faa81..f2dcf63ae3 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -203,7 +203,9 @@ uint32_t blk_get_request_alignment(BlockBackend *blk);
 uint32_t blk_get_max_transfer(BlockBackend *blk);
 int blk_get_max_iov(BlockBackend *blk);
 void blk_set_guest_block_size(BlockBackend *blk, int align);
+/* callers must free the returned pointer with qemu_vfree() */
 void *blk_try_blockalign(BlockBackend *blk, size_t size);
+/* callers must free the returned pointer with qemu_vfree() */
 void *blk_blockalign(BlockBackend *blk, size_t size);
 bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp);
 void blk_op_unblock(BlockBackend *blk, BlockOpType op, Error *reason);
--=20
2.21.3


