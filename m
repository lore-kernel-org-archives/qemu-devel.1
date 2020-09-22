Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBDFC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D08623A34
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mf6CqC9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D08623A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdpg-0006gY-D1
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdom-0005F9-Cx
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdok-00088i-9B
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600763908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WBRxjzGTI8JYRDVG+YO73PB8o7vHpI9q0JBwjZppJGE=;
 b=Mf6CqC9B5+M3aYTXkFjbodEAnLgA66P9pyHQQPWaOb1YhgVEg/q0IP/02ioAPHx6oYR7LF
 VwH9I5EwjgwblYwZyWumf2C0MGVkaGIJx8flKZ6TjRanf9wM9A558iQMlZ4Gq5h8dBx/ve
 dilev/UKTmwy/b8aWBYdl3qxNa6kD5g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-ie9NwhWgOUmRqRpbXDEkuQ-1; Tue, 22 Sep 2020 04:38:26 -0400
X-MC-Unique: ie9NwhWgOUmRqRpbXDEkuQ-1
Received: by mail-wr1-f69.google.com with SMTP id r16so7082122wrm.18
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WBRxjzGTI8JYRDVG+YO73PB8o7vHpI9q0JBwjZppJGE=;
 b=tdDLTB//RSM//qaZA3A7MtDD3L29oZZKuwBaZqlXQJ7b9ucHyrtH9iIH9mo+K9iWOB
 kgLKmrHtfb2JoS4t2UNp/0RfgJVUgF1DAcoc2JkTOgDP61byTpYHMEBeC6WUMsZ+gSk2
 CNdILn98QPD6G73A8PKnZFPTluS8gmIEuluTWp4X1XoIwiectiubZHkHDA9EPCZ9vx7q
 ARvF/BNGGQdK+6Y6dC5u9+P7AlTsM0qP/jSZ7Hs71AbvxoxpaeXLF2WAmneSvevXUOve
 1rIlXJRnTFlCoVfuByuNKUmf/ag/tysggO2/FIAyNonHLA3nVl9qYMfslzAd2WnGNK0K
 5qRg==
X-Gm-Message-State: AOAM5329zJ2PSpGo0JRlP2p6QZ9ak8zLZYYw3tXV3sjxibYEEagLRzbS
 OYqwzuwvIRiGDnIXpkNerFAYpVtHWTOJh8m78P7sAgAOKn0a3+QZOI92/0UUQgCeMe43o/X5osi
 s1bu4m7DBe3c5USM=
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr3459058wmy.51.1600763904468; 
 Tue, 22 Sep 2020 01:38:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUeg6ZuI9W37xWPpS3bWPSx4uImfCDHI2pDaIbYGlfuwn6f276CsVt3ZNlhMEMYE5R1mAm/w==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr3459042wmy.51.1600763904298; 
 Tue, 22 Sep 2020 01:38:24 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h17sm26219164wro.27.2020.09.22.01.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 01:38:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/6] block/nvme: Map doorbells pages write-only, remove
 magic from nvme_init
Date: Tue, 22 Sep 2020 10:38:15 +0200
Message-Id: <20200922083821.578519-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 04:19:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of mapping 8K of I/O + doorbells as RW during the whole
execution, maps I/O temporarly at init, and map doorbells WO.

Replace various magic values by slighly more explicit macros from
"block/nvme.h".

Since v1: Fix uninitialized regs* (patchew)

Philippe Mathieu-Daudé (6):
  util/vfio-helpers: Pass page protections to qemu_vfio_pci_map_bar()
  block/nvme: Map doorbells pages write-only
  block/nvme: Reduce I/O registers scope
  block/nvme: Drop NVMeRegs structure, directly use NvmeBar
  block/nvme: Use register definitions from 'block/nvme.h'
  block/nvme: Replace magic value by SCALE_MS definition

 include/qemu/vfio-helpers.h |  2 +-
 block/nvme.c                | 73 +++++++++++++++++++++----------------
 util/vfio-helpers.c         |  4 +-
 3 files changed, 44 insertions(+), 35 deletions(-)

-- 
2.26.2


