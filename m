Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21813C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3C5206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahdCRh3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3C5206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLie-0007ey-0F
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhD-0005wF-3y
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:13:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhA-0005VO-0r
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593544407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9YRbo/UhOb1CmcNeW/PB2xmFFgsU/55SRfJR/9kEmto=;
 b=ahdCRh3VUgOpfziHsgFN6F5OVXkkXvhgNDd3Rlo4QyRBdmSmIZ8iaheJjGLRNpbB/xQuti
 Etcy90cbEBfnJjWxnbDhX2xUuCJzhBPq0o4PklJSi6j00IpFDmzzXizjYSoSPP2Q/UMTXb
 IEaD05bpS3d8rms2y0SFxod9bKt95mM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-hYMTRQkzOwyLDM3GTO8Iow-1; Tue, 30 Jun 2020 15:13:23 -0400
X-MC-Unique: hYMTRQkzOwyLDM3GTO8Iow-1
Received: by mail-wm1-f70.google.com with SMTP id g124so21425481wmg.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9YRbo/UhOb1CmcNeW/PB2xmFFgsU/55SRfJR/9kEmto=;
 b=FVLOUDVYANormRBm2uDCO9ndOzeNXTmrRnLFTcSf8rpjc7MOYvf3usV8j2aWzIiN6K
 WCPqpz7N5xQwTmRnrBu+nbm2pCjoJIfHVUty9bEyGsIlY+VD7gFuobExHglYEtBaT0cn
 o1aLh8Exu6fqlh+KgSk1b5O5Nvu3VOQTkm0HLYcSRkyoSlKByJykqP7GLnXLziainYaZ
 0wDxZ/h0s7H4iSII6Bk1NcqahJ/RjYZEQ4j1TENoKHOQlMHatUXKaMRmMM1sArSlHj87
 9GGh7LSlfSVDaWjtIBw3xfbjYZ9Drj3j6JcdyRkOwsGSvNAmmyJTLlgavUVSk0xc4R44
 Q2zw==
X-Gm-Message-State: AOAM530yI4mAjIe3cb+Q/CzW8l3BJDyoDZ9AEQENnaN56e1Ydh02LFLC
 vXQay/Ptvs08zpr0w//jzIa74IAEOz1lO/wqZSnTSQBqAgiZExUROfsn5akCSSvT70NjXYVIdYc
 5BA/pQdJe8lYb7yM=
X-Received: by 2002:a5d:4002:: with SMTP id n2mr24410054wrp.255.1593544401760; 
 Tue, 30 Jun 2020 12:13:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfpxK3MiMk8oy9c1P8XR4yPPfvtdr3cPR/93PMhkwqeeJ65KdPzoCogF1rXkeGr7HQIeZQag==
X-Received: by 2002:a5d:4002:: with SMTP id n2mr24410011wrp.255.1593544400901; 
 Tue, 30 Jun 2020 12:13:20 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 104sm4781595wrl.25.2020.06.30.12.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:13:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/12] block/nvme: Various cleanups required to use
 multiple queues
Date: Tue, 30 Jun 2020 21:13:06 +0200
Message-Id: <20200630191318.30021-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series is mostly code rearrangement (cleanups) to be
able to split the hardware code from the block driver code,
to be able to use multiple queues on the same hardware, or
multiple block drivers on the same hardware.

Missing review: 1, 2, 5, 6, 8, 12.

Since v1:
- rebased
- use SCALE_MS definition
- added Stefan's R-b
- addressed Stefan's review comments
  - use union { NvmeIdCtrl / NvmeIdNs }
  - move irq_notifier to NVMeQueuePair
  - removed patches depending on "a tracable hardware stateo
    object instead of BDRVNVMeState".

Please review,

Phil.

$ git backport-diff -u v1
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/12:[down] 'block/nvme: Replace magic value by SCALE_MS definition'
002/12:[----] [--] 'block/nvme: Avoid further processing if trace event not enabled'
003/12:[0002] [FC] 'block/nvme: Let nvme_create_queue_pair() fail gracefully'
004/12:[----] [-C] 'block/nvme: Define QUEUE_INDEX macros to ease code review'
005/12:[down] 'block/nvme: Rename local variable'
006/12:[down] 'block/nvme: Use union of NvmeIdCtrl / NvmeIdNs structures'
007/12:[0011] [FC] 'block/nvme: Replace qemu_try_blockalign0 by qemu_try_blockalign/memset'
008/12:[0004] [FC] 'block/nvme: Replace qemu_try_blockalign(bs) by qemu_try_memalign(pg_sz)'
009/12:[----] [-C] 'block/nvme: Simplify nvme_init_queue() arguments'
010/12:[----] [-C] 'block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE'
011/12:[0010] [FC] 'block/nvme: Simplify nvme_create_queue_pair() arguments'
012/12:[0056] [FC] 'block/nvme: Use per-queue AIO context'

Philippe Mathieu-Daudé (12):
  block/nvme: Replace magic value by SCALE_MS definition
  block/nvme: Avoid further processing if trace event not enabled
  block/nvme: Let nvme_create_queue_pair() fail gracefully
  block/nvme: Define QUEUE_INDEX macros to ease code review
  block/nvme: Rename local variable
  block/nvme: Use union of NvmeIdCtrl / NvmeIdNs structures
  block/nvme: Replace qemu_try_blockalign0 by qemu_try_blockalign/memset
  block/nvme: Replace qemu_try_blockalign(bs) by
    qemu_try_memalign(pg_sz)
  block/nvme: Simplify nvme_init_queue() arguments
  block/nvme: Replace BDRV_POLL_WHILE by AIO_WAIT_WHILE
  block/nvme: Simplify nvme_create_queue_pair() arguments
  block/nvme: Use per-queue AIO context

 block/nvme.c | 186 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 103 insertions(+), 83 deletions(-)

-- 
2.21.3


