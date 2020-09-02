Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54203C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC0B2072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K4br/FT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC0B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVXy-00049V-9i
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1kDVWw-0002wU-K7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:22:38 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:43348)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1kDVWr-0002tk-Mr
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=8UIiwRgsKl8WlxdmkY
 LeQLB+g8f0Xe5OXlpajz/OoiE=; b=K4br/FT4nUH1f/lHlLxGzYz/2pGJEph2zC
 ABIlXFP3O17u1KnZKwVTvbxdzEg1gL0OL/ebVxi3OnZpWjELc2Hhz1a/fSXso3yX
 LKSXkn06AAUNgutBfNh1DtZCXB9jqKnt6Amn/lnvMQkMaPhL1Ttl+NTlmiZNp35N
 Ri8V8+wmA=
Received: from localhost.localdomain (unknown [183.134.168.235])
 by smtp1 (Coremail) with SMTP id GdxpCgAXbyO1xk9fAIYUAQ--.82S4;
 Thu, 03 Sep 2020 00:22:14 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: mst@redhat.com, kraxel@redhat.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, alxndr@bu.edu, peter.maydell@linaro.org,
 pbonzini@redhat.com
Subject: [RFC 0/3] try to solve the DMA to MMIO issue
Date: Wed,  2 Sep 2020 09:22:03 -0700
Message-Id: <20200902162206.101872-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgAXbyO1xk9fAIYUAQ--.82S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1DZryrZrW3CF48Zw4xWFg_yoW5GF4rpF
 WFga4rCr1DKFnIkw1fZr48Wr1Yyr1kCr4rWFyxW3yUKws8Jry5Zry7tw4UW3y7Ar18KFyU
 WFWjgr1UGr4vv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGQ6XUUUUU=
X-Originating-IP: [183.134.168.235]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBLxeTbVUMN7h+dAAAsa
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 12:22:24
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qemu device fuzzer has found several DMA to MMIO issue.
These issues is caused by the guest driver programs the DMA
address, then in the device MMIO handler it trigger the DMA
and as the DMA address is MMIO it will trigger another dispatch
and reenter the MMIO handler again. However most of the device
is not reentrant.

DMA to MMIO will cause issues depend by the device emulator,
mostly it will crash the qemu. Following is three classic 
DMA to MMIO issue.

e1000e: https://bugs.launchpad.net/qemu/+bug/1886362
xhci: https://bugs.launchpad.net/qemu/+bug/1891354
virtio-gpu: https://bugs.launchpad.net/qemu/+bug/1888606

The DMA to MMIO issue I think can be classified as following:
1. DMA to the device itself
2. device A DMA to device B and to device C
3. device A DMA to device B and to device A

The first case of course should not be allowed.
The second case I think it ok as the device IO handler has no
assumption about the IO data came from no matter it come from
device or other device. This is for P2P DMA.
The third case I think it also should not be allowed.

So our issue has been reduced by one case: not allowed the
device's IO handler reenter.

Paolo suggested that we can refactor the device emulation with
BH. However it is a lot of work.
I have thought several propose to address this, also discuss
this with Jason Wang in private email.

I have can solve this issue in core framework or in specific device.
After try several methods I choose address it in per-device for
following reason:
1. If we address it in core framwork we have to recored and check the 
device or MR info in MR dispatch write function. Unfortunally we have
no these info in core framework.
2. The performance will also be decrease largely
3. Only the device itself know its IO

The (most of the) device emulation is protected by BQL one time only
a device emulation code can be run. We can add a flag to indicate the
IO is running. The first two patches does this. For simplicity at the
RFC stage I just set it while enter the IO callback and clear it exit
the IO callback. It should be check/set/clean according the per-device's
IO emulation.
The second issue which itself suffers a race condition so I uses a
atomic.




Li Qiang (3):
  e1000e: make the IO handler reentrant
  xhci: make the IO handler reentrant
  virtio-gpu: make the IO handler reentrant

 hw/display/virtio-gpu.c        | 10 ++++++
 hw/net/e1000e.c                | 35 +++++++++++++++++++-
 hw/usb/hcd-xhci.c              | 60 ++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci.h              |  1 +
 include/hw/virtio/virtio-gpu.h |  1 +
 5 files changed, 106 insertions(+), 1 deletion(-)

-- 
2.17.1


