Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB2C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 05:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C591206D8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 05:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="whbEFPTj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C591206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZSYn-0006rt-6f
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 00:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1kZSXc-0006PR-9o
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 00:38:04 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:38078)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rvkagan@yandex-team.ru>)
 id 1kZSXX-0007aA-Hq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 00:38:01 -0500
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net
 (vla1-fdfb804fb3f3.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 4D9902E14A5;
 Mon,  2 Nov 2020 08:37:51 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 eYdk0TlvHf-bpxmXQJt; Mon, 02 Nov 2020 08:37:51 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1604295471; bh=w1p+M4bytOYcc9eybEp8vVRX5dHM418kcy618LYUs3Q=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=whbEFPTj1ufR4hIPqVqs8NvBuLpZ/M+XnOWHs/0EGh7Mf87img4nF84L8SJOPLSa5
 nV6YJNDTeh3WcJGuYDiUOGFRKPHNUS5TrnDqBkPzxK2GgQY+4fKWZmSNKm7p3eMFJs
 wKmPCg4bcl3c215UIgj0OjS5epmJQbHTYHy9RC58=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:114::1:2])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 xsYJakoIsR-boneZij0; Mon, 02 Nov 2020 08:37:51 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Roman Kagan <rvkagan@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH] pci/shpc: don't push attention button when ejecting
 powered-off device
Date: Mon,  2 Nov 2020 08:37:50 +0300
Message-Id: <20201102053750.2281818-1-rvkagan@yandex-team.ru>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.45.199.163; envelope-from=rvkagan@yandex-team.ru;
 helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 00:37:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the slot is in steady powered-off state and the device is being
removed, there's no need to press the attention button.  Nor is it
mandated by the Standard Hot-Plug Controller Specification, Rev. 1.0.

Moreover it confuses the guest, Linux in particular, as it assumes that
the attention button pressed in this state indicates that the device has
been inserted and will need to be powered on.  Therefore it transitions
the slot into BLINKING_ON state for 5 seconds, and discovers at the end
that no device is actually inserted:

... unplug request
[12685.451329] shpchp 0000:01:00.0: Button pressed on Slot(2)
[12685.455478] shpchp 0000:01:00.0: PCI slot #2 - powering off due to button press
... in 5 seconds OS powers off the slot, QEMU ejects the device
[12690.632282] shpchp 0000:01:00.0: Latch open on Slot(2)
... excessive button press in steady powered-off state
[12690.634267] shpchp 0000:01:00.0: Button pressed on Slot(2)
[12690.636256] shpchp 0000:01:00.0: Card not present on Slot(2)
... the last button press spawns powering on the slot
[12690.638909] shpchp 0000:01:00.0: PCI slot #2 - powering on due to button press
... in 5 more seconds attempt to power on discovers empty slot
[12695.735986] shpchp 0000:01:00.0: No adapter on slot(2)

Worse, if the real device insertion happens within 5 seconds from the
apparent completion of the previous device removal (signaled via
DEVICE_DELETED event), the new button press will be interpreted as the
cancellation of that misguided powering on:

[13448.965295] shpchp 0000:01:00.0: Button pressed on Slot(2)
[13448.969430] shpchp 0000:01:00.0: PCI slot #2 - powering off due to button press
[13454.025107] shpchp 0000:01:00.0: Latch open on Slot(2)
[13454.027101] shpchp 0000:01:00.0: Button pressed on Slot(2)
[13454.029165] shpchp 0000:01:00.0: Card not present on Slot(2)
... the excessive button press spawns powering on the slot
... device has already been ejected by QEMU
[13454.031949] shpchp 0000:01:00.0: PCI slot #2 - powering on due to button press
... new device is inserted in the slot
[13456.861545] shpchp 0000:01:00.0: Latch close on Slot(2)
... valid button press arrives before 5 s since the wrong one
[13456.864894] shpchp 0000:01:00.0: Button pressed on Slot(2)
[13456.869211] shpchp 0000:01:00.0: Card present on Slot(2)
... the valid button press is counted as cancellation of the wrong one
[13456.873173] shpchp 0000:01:00.0: Button cancel on Slot(2)
[13456.877101] shpchp 0000:01:00.0: PCI slot #2 - action canceled due to button press

As a result, the newly inserted device isn't brought up by the guest.

Avoid this situation by not pushing the attention button when the device
in the slot is in powered-off state and is being ejected.

FWIW pcie implementation doesn't suffer from this problem.

Signed-off-by: Roman Kagan <rvkagan@yandex-team.ru>
---
 hw/pci/shpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index b00dce629c..837159c5bd 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -300,7 +300,6 @@ static void shpc_slot_command(SHPCDevice *shpc, uint8_t target,
             shpc_set_status(shpc, slot, SHPC_SLOT_STATUS_PRSNT_EMPTY,
                             SHPC_SLOT_STATUS_PRSNT_MASK);
             shpc->config[SHPC_SLOT_EVENT_LATCH(slot)] |=
-                SHPC_SLOT_EVENT_BUTTON |
                 SHPC_SLOT_EVENT_MRL |
                 SHPC_SLOT_EVENT_PRESENCE;
         }
@@ -566,7 +565,6 @@ void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         return;
     }
 
-    shpc->config[SHPC_SLOT_EVENT_LATCH(slot)] |= SHPC_SLOT_EVENT_BUTTON;
     state = shpc_get_status(shpc, slot, SHPC_SLOT_STATE_MASK);
     led = shpc_get_status(shpc, slot, SHPC_SLOT_PWR_LED_MASK);
     if (state == SHPC_STATE_DISABLED && led == SHPC_LED_OFF) {
@@ -577,6 +575,8 @@ void shpc_device_unplug_request_cb(HotplugHandler *hotplug_dev,
         shpc->config[SHPC_SLOT_EVENT_LATCH(slot)] |=
             SHPC_SLOT_EVENT_MRL |
             SHPC_SLOT_EVENT_PRESENCE;
+    } else {
+        shpc->config[SHPC_SLOT_EVENT_LATCH(slot)] |= SHPC_SLOT_EVENT_BUTTON;
     }
     shpc_set_status(shpc, slot, 0, SHPC_SLOT_STATUS_66);
     shpc_interrupt_update(pci_hotplug_dev);
-- 
2.28.0


