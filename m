Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03928C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6F4A2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXV0hb/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6F4A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6H4Z-0006BJ-UM
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3J-0004YN-U6
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47477
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3G-0008DR-CZ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597339805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iIsO47OICOrprzBG+svo3nIxF/amwSjvmDFey5k/vy8=;
 b=dXV0hb/rGsnjNXtoJ89nbjumNMqbbldHB/2SwnHkTD3ERGkhzOmVzP51gmC1EtqbMh985L
 0dFtFibmImLJ2yMEL0HOHxLOdkfhY2O8TaBgyJ0KX1SZLNDvF2h6EGK5zvdaieQLhOvVzh
 uix0ePIRA7CFd+qJUnji9qMb+VIqnU8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-to_hg7rCMvOICrQu19A-lQ-1; Thu, 13 Aug 2020 13:30:01 -0400
X-MC-Unique: to_hg7rCMvOICrQu19A-lQ-1
Received: by mail-wr1-f69.google.com with SMTP id b8so2362336wrr.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 10:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iIsO47OICOrprzBG+svo3nIxF/amwSjvmDFey5k/vy8=;
 b=Wqe3AfdZ8dECPDmm+QSx7YrDnlAg6C3MMDLBNoOnTyy9BR5wYzZclbd5Ao/ixTPxzO
 LXQA2TTYNBtcr+xFzPUYhSAHTxge0KOZLbdB/tj1hnGHQrjq71CobMoZD5ZdUXt0XUcZ
 rBKQ2Dh2Ms+T9t4Wt4UCmpIDFjNFTaArkByM8alyhFvA8ZY7a6X7La3rtEvpF2fZxGiA
 ScGfFp7wsVNQFBeQsDbGkYso1xAUn6ZRdD3MN4SMmNCGeKM5T9HXQGuZVec+KlzbFy3H
 JOKdNRTmdSwCYzBVDucOy4c+e4A6AnYJYiqmAcC1EpCmYLmRY4EKoKnvJhtiYmdF5Jw4
 hj4Q==
X-Gm-Message-State: AOAM530+Uay3/COk8ZcGYXOqm+pZ0W2EZ+ntgbnTrR49Bl8KKucPSKgv
 DIomN3kqVI0rxW/gAul87Nu3l6SOz9MwGHfhyLA2X9aI4U1Bgp7atz3sSLhXk0FJaQaklDvJJcF
 +M9IbS0diMO5eMJw=
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr5616015wmn.78.1597339800352; 
 Thu, 13 Aug 2020 10:30:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+CELtMHvuCDb5wFGuZi6g7JGF7EKyGM3dlMlK9DHFcGtQnHdXoX9vQLGBp9lQFINNW923vw==
X-Received: by 2002:a1c:27c2:: with SMTP id n185mr5615987wmn.78.1597339800105; 
 Thu, 13 Aug 2020 10:30:00 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 3sm9710997wms.36.2020.08.13.10.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 10:29:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 0/7] util/vfio-helpers: Add support for multiple IRQs
Date: Thu, 13 Aug 2020 19:29:50 +0200
Message-Id: <20200813172957.8289-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 12:29:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series intends to setup the VFIO helper to allow
binding notifiers on different IRQs. Only MSIX IRQ type
considered so far.

Stefan suggested me to publish earlier to discuss.
If not too bad feedbacks I'll add some documentation in
"qemu/vfio-helpers.h" before reposting.

(NVMe block driver series will follow).

Based-on: <20200812185014.18267-1-philmd@redhat.com>
"block/nvme: Various cleanups required to use multiple queues"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg729395.html
Supersedes: <20200811172845.16698-1-philmd@redhat.com>

Philippe Mathieu-Daudé (7):
  util/vfio-helpers: Store eventfd using int32_t type
  util/vfio-helpers: Move IRQ 'type' from pci_init_irq() to open_pci()
  util/vfio-helpers: Introduce 'irq_count' variable
  util/vfio-helpers: Check the device allow up to 'irq_count' IRQs
  util/vfio-helpers: Support multiple eventfd
  util/vfio-helpers: Allow to set EventNotifier to particular IRQ
  util/vfio-helpers: Allow opening device requesting for multiple IRQs

 include/qemu/vfio-helpers.h |  5 +++--
 block/nvme.c                |  9 +++++---
 util/vfio-helpers.c         | 42 ++++++++++++++++++++++++++++++-------
 util/trace-events           |  1 +
 4 files changed, 45 insertions(+), 12 deletions(-)

-- 
2.21.3


