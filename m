Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011DBC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0D8E218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="M8yNqi+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0D8E218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6afj-0007sD-QZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6a2r-00087I-Bp
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1j6a2p-00029K-VY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:14:41 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:57276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1j6a2m-00023e-NE; Tue, 25 Feb 2020 08:14:37 -0500
Received: from crumble.bar.greensocs.com (crumble.bar.greensocs.com
 [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPS id DABC796F58;
 Tue, 25 Feb 2020 13:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582636471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BY1+FZJ6Sc88VMCwdRv2dHSvQOitapgHxjmgcsZpkn8=;
 b=M8yNqi+RvEHXXXwjvfY1Wov13PFLjm2pa+fm8jYVC6pLe7bDyIs+HJh+hxHRPgGwL776s6
 8hmf5SoHb1KiQj99hsXbsuj5kx6es4CqV4/Y6DZT+yq8OqVcSO5+5iArUN4Yo2SHaq3+5Z
 giY4o3Yr+0Ou9nXdHQIhLTja/jiM7qY=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 9/9] qdev-monitor: print the device's clock with info qtree
Date: Tue, 25 Feb 2020 14:14:22 +0100
Message-Id: <20200225131422.53368-10-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225131422.53368-1-damien.hedde@greensocs.com>
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582636471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BY1+FZJ6Sc88VMCwdRv2dHSvQOitapgHxjmgcsZpkn8=;
 b=EEDnW8UBwiQZD+e+/XYQpHeb/s9ZPlZTfyy4ZO5ZaNPCVy4Nmu0gQhuhs/rziLElWsJ3dl
 Sp0VM4mFArIjohO1ZyYtsOzVwe0ziwTYIHMdLXiFaS//FSj+MkxhuhBhOEhJ9OCYaIk4Ru
 kF2ybIvx6FG+q4FdalrsZPRvvygUhG8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582636471; a=rsa-sha256; cv=none;
 b=pX5nhivfIYc00FbkaBWiQQJw+1evdMG1mBgssoNSe5OdoaBrsyx4BjAGAxG5qL4Jybd499
 FbHC3/laR+Yi/k9YnN5xpHOpOuE4ykYdjl1HAjVsX19xiOhc1KGTnph2QeyNOqTfJmfyoO
 qpurQ2hTu0qob50kSrWwhsu/Zpy/Cg8=
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
 berrange@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com,
 alistair@alistair23.me, mark.burton@greensocs.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, edgar.iglesias@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This prints the clocks attached to a DeviceState when using
"info qtree" monitor command. For every clock, it displays the
direction, the name and if the clock is forwarded. For input clock,
it displays also the frequency.

This is based on the original work of Frederic Konrad.

Here follows a sample of `info qtree` output on xilinx_zynq machine
after linux boot with only one uart clocked:
> bus: main-system-bus
>  type System
>  [...]
>  dev: cadence_uart, id ""
>    gpio-out "sysbus-irq" 1
>    clock-in "refclk" freq_hz=3D0.000000e+00
>    chardev =3D ""
>    mmio 00000000e0001000/0000000000001000
>  dev: cadence_uart, id ""
>    gpio-out "sysbus-irq" 1
>    clock-in "refclk" freq_hz=3D1.375661e+07
>    chardev =3D "serial0"
>    mmio 00000000e0000000/0000000000001000
>  [...]
>  dev: xilinx,zynq_slcr, id ""
>    clock-out "uart1_ref_clk" freq_hz=3D0.000000e+00
>    clock-out "uart0_ref_clk" freq_hz=3D1.375661e+07
>    clock-in "ps_clk" freq_hz=3D3.333333e+07
>    mmio 00000000f8000000/0000000000001000

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

v7:
 + print output clocks frequencies too
 + add sample of qtree message above
 + display frequencies in floating-point
---
 qdev-monitor.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 8ce71a206b..1d84b4e416 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -38,6 +38,7 @@
 #include "migration/misc.h"
 #include "migration/migration.h"
 #include "qemu/cutils.h"
+#include "hw/clock.h"
=20
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -736,6 +737,7 @@ static void qdev_print(Monitor *mon, DeviceState *dev=
, int indent)
     ObjectClass *class;
     BusState *child;
     NamedGPIOList *ngl;
+    NamedClockList *ncl;
=20
     qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev))=
,
                 dev->id ? dev->id : "");
@@ -750,6 +752,13 @@ static void qdev_print(Monitor *mon, DeviceState *de=
v, int indent)
                         ngl->num_out);
         }
     }
+    QLIST_FOREACH(ncl, &dev->clocks, node) {
+        qdev_printf("clock-%s%s \"%s\" freq_hz=3D%e\n",
+                    ncl->output ? "out" : "in",
+                    ncl->alias ? " (alias)" : "",
+                    ncl->name,
+                    CLOCK_PERIOD_TO_HZ(1.0 * clock_get(ncl->clock)));
+    }
     class =3D object_get_class(OBJECT(dev));
     do {
         qdev_print_props(mon, dev, DEVICE_CLASS(class)->props_, indent);
--=20
2.25.1


