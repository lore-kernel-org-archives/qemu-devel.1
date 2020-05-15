Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D51C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B8D206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKhme/IY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B8D206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWYt-0003Lg-DC
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWVX-0005qo-CO
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:19:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49565
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZWVV-0005ar-VT
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589534393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oppWO9uqXABY1yc2ERvzqgw+FDGJGsndHoPWBL1+Ex8=;
 b=MKhme/IYJzqhm6CbMEBibXuygnQB0oVVgp/i9Zeo4hXTnCAg4Si5+JvrBruetuO6ejy6AH
 SuIQ8YHfnvqQ5I2vIchV9kJ2oEM/9ucUf2CCmP4HB4Q+spjEAnQsw9sQ7/JoFXUtl36KG8
 YE0Dr1IzSPFEI7+Ku2GZ9YbRZ/AyK9w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-IlwiMWMMM1-Pup1enXH0Qw-1; Fri, 15 May 2020 05:19:51 -0400
X-MC-Unique: IlwiMWMMM1-Pup1enXH0Qw-1
Received: by mail-wr1-f71.google.com with SMTP id y7so872753wrd.12
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oppWO9uqXABY1yc2ERvzqgw+FDGJGsndHoPWBL1+Ex8=;
 b=W6khaIwoAnNKjMU+xeWBaBtUx7NOwRafX9pZ2Owb9sdjeC8EN2d3FJGpPreouJV+vq
 Zfpvcj1jBVcrZ67V6rMgn/ZjNivGAhJX9mn//zIvWG8zmXNdu/dgsne42gotHMbzb1J7
 H5DMeKVqU3YsnYHrC1fL7jsIpTvhe5ETu/7ZzAhjgtVUHuWPzyQFFKH5cmK7UIUUTt2k
 J759Ss7l2d2RUSwRtihXuLFamH7SeuhYsuhRGrBsrREYOGkd0bHpIHm31c45UIO6CRH7
 +hn1vBx/ihfmXGPM4j38sSJH/PYUpiBCEHe7VESsh6gMwAS0/bQgPzAaGrQ+fA2vPygz
 3pug==
X-Gm-Message-State: AOAM532cDgQCuMWwqmhH60IRKqJYTKwzW880Q0gr50H1pUI6wkxkJPPF
 IKR3WDWOnaF87QYxouNY5CYadnVZyRlXo58YQVZ4MwxUUOZl2ltgUdOMloSykKiivy1xDrsnxvr
 KrVpTDxlmif0GLuA=
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr3154202wme.177.1589534390435; 
 Fri, 15 May 2020 02:19:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLco0pWeL3yIn0rtov5zBpzlfd/V0HoMnf9mibAcSjvFtUAMgTeaXr/WMl87/cxoCkqVs56Q==
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr3154179wme.177.1589534390221; 
 Fri, 15 May 2020 02:19:50 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id n7sm2643021wro.94.2020.05.15.02.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 02:19:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] sysemu/block-backend: Document blk_read()/blk_pwrite()
Date: Fri, 15 May 2020 11:19:23 +0200
Message-Id: <20200515091924.14380-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515091924.14380-1-philmd@redhat.com>
References: <20200515091924.14380-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The blk_read()/blk_pwrite() return value is not obvious,
document it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: 's/ - /: /' (stefanha)
---
 include/sysemu/block-backend.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 7996cb61bb..b693dfb8f0 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -155,7 +155,31 @@ BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
                                   int bytes, BdrvRequestFlags flags,
                                   BlockCompletionFunc *cb, void *opaque);
 int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags);
+
+/**
+ * blk_pread:
+ *
+ * @blk: the block backend where the buffer content is going to be read from
+ * @offset: position in bytes to read at
+ * @buf: the data buffer
+ * @bytes: number of bytes to read
+ *
+ * Returns: the number of bytes read on success, or a negative errno otherwise.
+ */
 int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int bytes);
+
+/**
+ * blk_pwrite:
+ *
+ * @blk: the block backend where the buffer content is going to be written to
+ * @offset: position in bytes to write at
+ * @buf: the data buffer
+ * @bytes: number of bytes of @buf to write
+ * @flags: request flags
+ *
+ * Returns: the number of bytes consumed on success,
+ *          or a negative errno otherwise.
+ */
 int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int bytes,
                BdrvRequestFlags flags);
 int64_t blk_getlength(BlockBackend *blk);
-- 
2.21.3


