Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D6BCA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB0621928
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dG22qFIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB0621928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNLou-0006WK-4K
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 14:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKVF-0003Yq-Tv
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:32:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKVC-0001dC-VB
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:32:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKVC-0001cZ-RT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571851971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erhtuldwyK3E+RzzrVrDprCGejZBAHO61QUqKFkdfAk=;
 b=dG22qFIcLj67y7xp+me9hIDc/Bb12Wz771k0Vl0c2Ye8+Ddfb3yNQdC1VxAhaE7z9OpYPk
 8EabNW9zdLV/Ib3mdMPGA8+lrIYckceoyQtJUK872VA6DVtlmV1E7BK2PJi0wGf3byCb0R
 h/WbVs8FcPzZxJ+GkTHUf1Dtpu5Gnis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-AG7nAZJIM1C5TrTsB32LxA-1; Wed, 23 Oct 2019 13:32:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F31DA801E72;
 Wed, 23 Oct 2019 17:32:39 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF47D60C63;
 Wed, 23 Oct 2019 17:32:14 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/33] sysbus: remove unused sysbus_try_create*
Date: Wed, 23 Oct 2019 19:31:23 +0200
Message-Id: <20191023173154.30051-3-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: AG7nAZJIM1C5TrTsB32LxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/core/sysbus.c    | 32 --------------------------------
 hw/i386/pc.c        |  1 -
 include/hw/sysbus.h |  9 +--------
 3 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 9e69c83aed..08b0311c5f 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -250,38 +250,6 @@ DeviceState *sysbus_create_varargs(const char *name,
     return dev;
 }
=20
-DeviceState *sysbus_try_create_varargs(const char *name,
-                                       hwaddr addr, ...)
-{
-    DeviceState *dev;
-    SysBusDevice *s;
-    va_list va;
-    qemu_irq irq;
-    int n;
-
-    dev =3D qdev_try_create(NULL, name);
-    if (!dev) {
-        return NULL;
-    }
-    s =3D SYS_BUS_DEVICE(dev);
-    qdev_init_nofail(dev);
-    if (addr !=3D (hwaddr)-1) {
-        sysbus_mmio_map(s, 0, addr);
-    }
-    va_start(va, addr);
-    n =3D 0;
-    while (1) {
-        irq =3D va_arg(va, qemu_irq);
-        if (!irq) {
-            break;
-        }
-        sysbus_connect_irq(s, n, irq);
-        n++;
-    }
-    va_end(va);
-    return dev;
-}
-
 static void sysbus_dev_print(Monitor *mon, DeviceState *dev, int indent)
 {
     SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4b1904237e..00ee16ccab 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1902,7 +1902,6 @@ void pc_basic_device_init(ISABus *isa_bus, qemu_irq *=
gsi,
      * when the HPET wants to take over. Thus we have to disable the latte=
r.
      */
     if (!no_hpet && (!kvm_irqchip_in_kernel() || kvm_has_pit_state2())) {
-        /* In order to set property, here not using sysbus_try_create_simp=
le */
         hpet =3D qdev_try_create(NULL, TYPE_HPET);
         if (hpet) {
             /* For pc-piix-*, hpet's intcap is always IRQ2. For pc-q35-1.7
diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 27e80881da..2eb0484388 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -117,8 +117,7 @@ void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc=
 *func, void *opaque);
 /* Legacy helper function for creating devices.  */
 DeviceState *sysbus_create_varargs(const char *name,
                                  hwaddr addr, ...);
-DeviceState *sysbus_try_create_varargs(const char *name,
-                                       hwaddr addr, ...);
+
 static inline DeviceState *sysbus_create_simple(const char *name,
                                               hwaddr addr,
                                               qemu_irq irq)
@@ -126,11 +125,5 @@ static inline DeviceState *sysbus_create_simple(const =
char *name,
     return sysbus_create_varargs(name, addr, irq, NULL);
 }
=20
-static inline DeviceState *sysbus_try_create_simple(const char *name,
-                                                    hwaddr addr,
-                                                    qemu_irq irq)
-{
-    return sysbus_try_create_varargs(name, addr, irq, NULL);
-}
=20
 #endif /* HW_SYSBUS_H */
--=20
2.23.0.606.g08da6496b6


