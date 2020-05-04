Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE9EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE872071C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgCChtIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE872071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXl5-0003M6-2r
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgl-0004zk-Be
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:47:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56347
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVXgk-0004EJ-DB
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588585620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOoRSFUD32uShqGqJeGiHJdxg36QvfSMrGROhUVpi4c=;
 b=AgCChtIZvXKH8Gjd9bILDXyiiBlShzXtr+axBojLPQdVDrWKGoTvMuX5/FiO+f2fMGuJTf
 /fQXypO/plNge+thD5QJFE/Em/H7cz+PkejH25y+u5/cUKyDq+eo3s+s3XGXrqF1xnSuCe
 4zn80ArqLWe9KgJeQCeuE3zLrlkvO3U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-ILmlFRz8OEC1lzIdiiSMQw-1; Mon, 04 May 2020 05:46:59 -0400
X-MC-Unique: ILmlFRz8OEC1lzIdiiSMQw-1
Received: by mail-wr1-f72.google.com with SMTP id g7so10433283wrw.18
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 02:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jqr2MbWG5qDVE72NJQlyIDzc23rCOzvleinSwfktvqM=;
 b=VYbcdPeGDqHEmzSszY51R1DfobfY6sydDG/gmRC7sP9m49bHEEKAxFCLm3+XQYXzr6
 5pULtL/a1iouQ5CgfCNzxJdJFXLyxs4ctEk2KTtHCicyUnZjz4ef67xxOdZ+BpNRGHPQ
 gBObK6CkmyvTMAo1CcWhxAd1zkwJn8xsS88MeDIegTZWm04LJm965KfdgO6xRCEpst90
 yFMG4x4t+N+5eL9xBrCsC3nzrhrgPxDk8jnapPYAULa/Jy+h2LtoKJuMrY8tCMSC1/aD
 l1DBxu9vXUf7qDkXHLjPzWYTdylBsFm0OWFX8DIfFytVPFjerQowjVUDqI+S3qnAYJd/
 D3vw==
X-Gm-Message-State: AGi0PuZpDUotRKEj0tIOCm2OOFuMlZ6tNH4Y3bKCTub7oRiF4HmIwkVW
 u7jXb+v0etfvLshkOt9mKOgh04574wB+lCgjLDsNtc2o2yc+KYOIePdvmGQ3dAdb/96HoGXTokB
 otmDZIr3y6wXFtYI=
X-Received: by 2002:a5d:5703:: with SMTP id a3mr17393242wrv.53.1588585617718; 
 Mon, 04 May 2020 02:46:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypKRlXQhcOWnVxbUEExVA4635H7zp8oLcYLgcINZAFRoGyP+yAZN0t2Ty8e+2GE6VLyEZwspmQ==
X-Received: by 2002:a5d:5703:: with SMTP id a3mr17393220wrv.53.1588585617497; 
 Mon, 04 May 2020 02:46:57 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id k6sm12762713wma.19.2020.05.04.02.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 02:46:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] sysemu/block-backend: Document blk_read()/blk_pwrite()
Date: Mon,  4 May 2020 11:46:38 +0200
Message-Id: <20200504094641.4963-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504094641.4963-1-philmd@redhat.com>
References: <20200504094641.4963-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

The blk_read()/blk_pwrite() return value is not obvious,
document it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/sysemu/block-backend.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.=
h
index f2dcf63ae3..823b8e94a7 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -153,7 +153,31 @@ BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, i=
nt64_t offset,
                                   int bytes, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque);
 int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags);
+
+/**
+ * blk_pread:
+ *
+ * @blk - the block backend where the buffer content is going to be read f=
rom
+ * @offset: position in bytes to read at
+ * @buf: the data buffer
+ * @bytes: number of bytes to read
+ *
+ * Returns: the number of bytes read on success, or a negative errno other=
wise.
+ */
 int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int bytes);
+
+/**
+ * blk_pwrite:
+ *
+ * @blk - the block backend where the buffer content is going to be writte=
n to
+ * @offset: position in bytes to write at
+ * @buf: the data buffer
+ * @bytes: number of bytes of @buf to write
+ * @flags: request flags
+ *
+ * Returns: the number of bytes consumed on success,
+ *          or a negative errno otherwise.
+ */
 int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int byt=
es,
                BdrvRequestFlags flags);
 int64_t blk_getlength(BlockBackend *blk);
--=20
2.21.3


