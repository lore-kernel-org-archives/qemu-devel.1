Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3ECC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAF7D21734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="x4Z+PHtO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF7D21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueim-0005Dw-E5
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iucXQ-0005CG-3t
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iucXN-0003lY-UJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:28:47 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:56806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iucXM-0003jU-EL; Thu, 23 Jan 2020 08:28:45 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id E725A96F59;
 Thu, 23 Jan 2020 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579786123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6+U1oJsCmH2eeSC5C8mhxV+iyr1rypS54LYkSNE/cs=;
 b=x4Z+PHtOImlhO9pYcAuiR6W11R6Oimmw5hC3I3GpxXbEesDOWT30vkpyd1DraRet+sywsx
 DQJ3jtTYJF4i97BaUuUvu26DVk7mc7opE7agqzFhqQV651eZ8WbJwN42C81eTFCv30n2Un
 ftPqzO/YdJLMRGakgztlcdvL7tDvJg4=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 10/11] vl: replace deprecated qbus_reset_all registration
Date: Thu, 23 Jan 2020 14:28:22 +0100
Message-Id: <20200123132823.1117486-11-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123132823.1117486-1-damien.hedde@greensocs.com>
References: <20200123132823.1117486-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579786123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z6+U1oJsCmH2eeSC5C8mhxV+iyr1rypS54LYkSNE/cs=;
 b=pAjM0YxZr0v5OqrvFFWQ4DjqwVtYP1MaXUJp9FP4GVXlfE1723ckJOcBIA1c2ewimjDRKW
 EFGSh3aFOhohlDatdu28N6ZJ6JZ0flqDolSB0hzUQV/QliTT3Txo4QIlqFdxhy/1zyhyFD
 oIqf6D7n1mFy0CvDSp4qfuVTTDV8r8E=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579786123; a=rsa-sha256; cv=none;
 b=dQtQId/0L6PpL7YToTc2PSQq9nt65S95XgJExGoiwZtWFxw+7PwycdqXE+U3I3+ouGjIGB
 yplWpx9TUROiKND38Wi8hdSDwhYzbQ463KT684XR/0aLD06jyEKvylxgNRryyJ4G8m2RZ1
 nmgvFZ/egHP57zWVuCxqtiDNzyPBeFE=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, philmd@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace deprecated qbus_reset_all by resettable_cold_reset_fn for
the sysbus reset registration.

Apart for the raspi machines, this does not impact the behavior
because:
+ at this point resettable just calls the old reset methods of devices
  and buses in the same order as qdev/qbus.
+ resettable handlers registered with qemu_register_reset are
  serialized; there is no interleaving.
+ eventual explicit calls to legacy reset API (device_reset or
  qdev/qbus_reset) inside this reset handler will not be masked out
  by resettable mechanism; they do not go through resettable api.

For the raspi machines, during the sysbus reset the sd-card is not
reset twice anymore but only once. This is a consequence of switching
both sysbus reset and changing parent to resettable; it detects the
second reset is not needed. This has no impact on the state after
reset; the sd-card reset method only reset local state and query
information from the block backend.

The raspi reset change can be observed by using the following command
(reset will occurs, then do Ctrl-C to end qemu; no firmware is
given here).
qemu-system-aarch64 -M raspi3 \
    -trace resettable_phase_hold_exec \
    -trace qdev_update_parent_bus \
    -trace resettable_change_parent \
    -trace qdev_reset -trace qbus_reset

Before the patch, the qdev/qbus_reset traces show when reset method are
called. After the patch, the resettable_phase_hold_exec show when reset
method are called.

The traced reset order of the raspi3 is listed below. I've added empty
lines and the tree structure.

 +->bcm2835-peripherals reset
 |
 |       +->sd-card reset
 |   +->sd-bus reset
 +->bcm2835_gpio reset
 |      -> dev_update_parent_bus (move the sd-card on the sdhci-bus)
 |      -> resettable_change_parent
 |
 +->bcm2835-dma reset
 |
 |   +->bcm2835-sdhost-bus reset
 +->bcm2835-sdhost reset
 |
 |       +->sd-card (reset ONLY BEFORE BEFORE THE PATCH)
 |   +->sdhci-bus reset
 +->generic-sdhci reset
 |
 +->bcm2835-rng reset
 +->bcm2835-property reset
 +->bcm2835-fb reset
 +->bcm2835-mbox reset
 +->bcm2835-aux reset
 +->pl011 reset
 +->bcm2835-ic reset
 +->bcm2836-control reset
System reset

In both case, the sd-card is reset (being on bcm2835_gpio/sd-bus) then mo=
ved
to generic-sdhci/sdhci-bus by the bcm2835_gpio reset method.

Before the patch, it is then reset again being part of generic-sdhci/sdhc=
i-bus.
After the patch, it considered again for reset but its reset method is no=
t
called because it is already flagged as reset.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 vl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 71d3e7eefb..d3c4a8b149 100644
--- a/vl.c
+++ b/vl.c
@@ -4364,7 +4364,15 @@ int main(int argc, char **argv, char **envp)
=20
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
-    qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
+    /*
+     * TODO: If we had a main 'reset container' that the whole system
+     * lived in, we could reset that using the multi-phase reset
+     * APIs. For the moment, we just reset the sysbus, which will cause
+     * all devices hanging off it (and all their child buses, recursivel=
y)
+     * to be reset. Note that this will *not* reset any Device objects
+     * which are not attached to some part of the qbus tree!
+     */
+    qemu_register_reset(resettable_cold_reset_fn, sysbus_get_default());
     qemu_run_machine_init_done_notifiers();
=20
     if (rom_check_and_register_reset() !=3D 0) {
--=20
2.24.1


