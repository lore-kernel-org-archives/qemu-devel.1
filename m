Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD134CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8660420663
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3TOwmWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8660420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQUi-00018u-8f
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 14:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOQQA-0001q8-HZ
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOQQ8-0007sy-OC
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOQQ8-0007sj-Jm
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572113052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P72P8oJYt+/4WQxh4nVCZd3h2uPcYKTRBPpr6Adz7C0=;
 b=H3TOwmWTt9DARwqbIxJnQFvPBTJViPqa5yFNsV13MSAa4iwk5Zy0zyxZ1qQsSYHPQCo3g6
 kcTUi3ydvJ/pOdnDUNV7V8LNFMPlp1kh18Wm3E4kQ82x1oODaMuxqU7z3HYBxugEEscAzG
 1M1pF/Bys6UZeMyoG7eSdJMSRCgeRLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-Wf1yjgEwPvmw7DXlBTwPrA-1; Sat, 26 Oct 2019 14:04:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89BD3801E6F;
 Sat, 26 Oct 2019 18:04:05 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A158C60F82;
 Sat, 26 Oct 2019 18:03:58 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/20] hw/i386: Remove obsolete
 LoadStateHandler::load_state_old handlers
Date: Sat, 26 Oct 2019 20:01:35 +0200
Message-Id: <20191026180143.7369-13-philmd@redhat.com>
In-Reply-To: <20191026180143.7369-1-philmd@redhat.com>
References: <20191026180143.7369-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Wf1yjgEwPvmw7DXlBTwPrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These devices implemented their load_state_old() handler 10 years
ago, previous to QEMU v0.12.
Since commit cc425b5ddf removed the pc-0.10 and pc-0.11 machines,
we can drop this code.

Note: the mips_r4k machine started to use the i8254 device just
after QEMU v0.5.0, but the MIPS machine types are not versioned,
so there is no migration compatibility issue removing this handler.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/piix4.c         | 40 ---------------------------------
 hw/intc/apic_common.c   | 49 -----------------------------------------
 hw/pci-host/piix.c      | 25 ---------------------
 hw/timer/i8254_common.c | 40 ---------------------------------
 4 files changed, 154 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 2efd1605b8..93aec2dd2c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -41,7 +41,6 @@
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/xen/xen.h"
-#include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "hw/core/cpu.h"
 #include "trace.h"
@@ -204,43 +203,6 @@ static const VMStateDescription vmstate_pci_status =3D=
 {
     }
 };
=20
-static int acpi_load_old(QEMUFile *f, void *opaque, int version_id)
-{
-    PIIX4PMState *s =3D opaque;
-    int ret, i;
-    uint16_t temp;
-
-    ret =3D pci_device_load(PCI_DEVICE(s), f);
-    if (ret < 0) {
-        return ret;
-    }
-    qemu_get_be16s(f, &s->ar.pm1.evt.sts);
-    qemu_get_be16s(f, &s->ar.pm1.evt.en);
-    qemu_get_be16s(f, &s->ar.pm1.cnt.cnt);
-
-    ret =3D vmstate_load_state(f, &vmstate_apm, &s->apm, 1);
-    if (ret) {
-        return ret;
-    }
-
-    timer_get(f, s->ar.tmr.timer);
-    qemu_get_sbe64s(f, &s->ar.tmr.overflow_time);
-
-    qemu_get_be16s(f, (uint16_t *)s->ar.gpe.sts);
-    for (i =3D 0; i < 3; i++) {
-        qemu_get_be16s(f, &temp);
-    }
-
-    qemu_get_be16s(f, (uint16_t *)s->ar.gpe.en);
-    for (i =3D 0; i < 3; i++) {
-        qemu_get_be16s(f, &temp);
-    }
-
-    ret =3D vmstate_load_state(f, &vmstate_pci_status,
-        &s->acpi_pci_hotplug.acpi_pcihp_pci_status[ACPI_PCIHP_BSEL_DEFAULT=
], 1);
-    return ret;
-}
-
 static bool vmstate_test_use_acpi_pci_hotplug(void *opaque, int version_id=
)
 {
     PIIX4PMState *s =3D opaque;
@@ -312,8 +274,6 @@ static const VMStateDescription vmstate_acpi =3D {
     .name =3D "piix4_pm",
     .version_id =3D 3,
     .minimum_version_id =3D 3,
-    .minimum_version_id_old =3D 1,
-    .load_state_old =3D acpi_load_old,
     .post_load =3D vmstate_acpi_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PIIX4PMState),
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index aafd8e0e33..375cb6abe9 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -31,7 +31,6 @@
 #include "sysemu/kvm.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
-#include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
=20
 static int apic_irq_delivered;
@@ -262,52 +261,6 @@ static void apic_reset_common(DeviceState *dev)
     apic_init_reset(dev);
 }
=20
-/* This function is only used for old state version 1 and 2 */
-static int apic_load_old(QEMUFile *f, void *opaque, int version_id)
-{
-    APICCommonState *s =3D opaque;
-    APICCommonClass *info =3D APIC_COMMON_GET_CLASS(s);
-    int i;
-
-    if (version_id > 2) {
-        return -EINVAL;
-    }
-
-    /* XXX: what if the base changes? (registered memory regions) */
-    qemu_get_be32s(f, &s->apicbase);
-    qemu_get_8s(f, &s->id);
-    qemu_get_8s(f, &s->arb_id);
-    qemu_get_8s(f, &s->tpr);
-    qemu_get_be32s(f, &s->spurious_vec);
-    qemu_get_8s(f, &s->log_dest);
-    qemu_get_8s(f, &s->dest_mode);
-    for (i =3D 0; i < 8; i++) {
-        qemu_get_be32s(f, &s->isr[i]);
-        qemu_get_be32s(f, &s->tmr[i]);
-        qemu_get_be32s(f, &s->irr[i]);
-    }
-    for (i =3D 0; i < APIC_LVT_NB; i++) {
-        qemu_get_be32s(f, &s->lvt[i]);
-    }
-    qemu_get_be32s(f, &s->esr);
-    qemu_get_be32s(f, &s->icr[0]);
-    qemu_get_be32s(f, &s->icr[1]);
-    qemu_get_be32s(f, &s->divide_conf);
-    s->count_shift =3D qemu_get_be32(f);
-    qemu_get_be32s(f, &s->initial_count);
-    s->initial_count_load_time =3D qemu_get_be64(f);
-    s->next_time =3D qemu_get_be64(f);
-
-    if (version_id >=3D 2) {
-        s->timer_expiry =3D qemu_get_be64(f);
-    }
-
-    if (info->post_load) {
-        info->post_load(s);
-    }
-    return 0;
-}
-
 static const VMStateDescription vmstate_apic_common;
=20
 static void apic_common_realize(DeviceState *dev, Error **errp)
@@ -408,8 +361,6 @@ static const VMStateDescription vmstate_apic_common =3D=
 {
     .name =3D "apic",
     .version_id =3D 3,
     .minimum_version_id =3D 3,
-    .minimum_version_id_old =3D 1,
-    .load_state_old =3D apic_load_old,
     .pre_load =3D apic_pre_load,
     .pre_save =3D apic_dispatch_pre_save,
     .post_load =3D apic_dispatch_post_load,
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 135c645535..2f4cbcbfe9 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -33,7 +33,6 @@
 #include "qapi/error.h"
 #include "qemu/range.h"
 #include "hw/xen/xen.h"
-#include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "hw/pci-host/pam.h"
 #include "sysemu/reset.h"
@@ -174,28 +173,6 @@ static void i440fx_write_config(PCIDevice *dev,
     }
 }
=20
-static int i440fx_load_old(QEMUFile* f, void *opaque, int version_id)
-{
-    PCII440FXState *d =3D opaque;
-    PCIDevice *pd =3D PCI_DEVICE(d);
-    int ret, i;
-    uint8_t smm_enabled;
-
-    ret =3D pci_device_load(pd, f);
-    if (ret < 0)
-        return ret;
-    i440fx_update_memory_mappings(d);
-    qemu_get_8s(f, &smm_enabled);
-
-    if (version_id =3D=3D 2) {
-        for (i =3D 0; i < PIIX_NUM_PIRQS; i++) {
-            qemu_get_be32(f); /* dummy load for compatibility */
-        }
-    }
-
-    return 0;
-}
-
 static int i440fx_post_load(void *opaque, int version_id)
 {
     PCII440FXState *d =3D opaque;
@@ -208,8 +185,6 @@ static const VMStateDescription vmstate_i440fx =3D {
     .name =3D "I440FX",
     .version_id =3D 3,
     .minimum_version_id =3D 3,
-    .minimum_version_id_old =3D 1,
-    .load_state_old =3D i440fx_load_old,
     .post_load =3D i440fx_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PCII440FXState),
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index 57bf10cc94..050875b497 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -29,7 +29,6 @@
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
-#include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
=20
 /* val must be 0 or 1 */
@@ -202,43 +201,6 @@ static const VMStateDescription vmstate_pit_channel =
=3D {
     }
 };
=20
-static int pit_load_old(QEMUFile *f, void *opaque, int version_id)
-{
-    PITCommonState *pit =3D opaque;
-    PITCommonClass *c =3D PIT_COMMON_GET_CLASS(pit);
-    PITChannelState *s;
-    int i;
-
-    if (version_id !=3D 1) {
-        return -EINVAL;
-    }
-
-    for (i =3D 0; i < 3; i++) {
-        s =3D &pit->channels[i];
-        s->count =3D qemu_get_be32(f);
-        qemu_get_be16s(f, &s->latched_count);
-        qemu_get_8s(f, &s->count_latched);
-        qemu_get_8s(f, &s->status_latched);
-        qemu_get_8s(f, &s->status);
-        qemu_get_8s(f, &s->read_state);
-        qemu_get_8s(f, &s->write_state);
-        qemu_get_8s(f, &s->write_latch);
-        qemu_get_8s(f, &s->rw_mode);
-        qemu_get_8s(f, &s->mode);
-        qemu_get_8s(f, &s->bcd);
-        qemu_get_8s(f, &s->gate);
-        s->count_load_time =3D qemu_get_be64(f);
-        s->irq_disabled =3D 0;
-        if (i =3D=3D 0) {
-            s->next_transition_time =3D qemu_get_be64(f);
-        }
-    }
-    if (c->post_load) {
-        c->post_load(pit);
-    }
-    return 0;
-}
-
 static int pit_dispatch_pre_save(void *opaque)
 {
     PITCommonState *s =3D opaque;
@@ -266,8 +228,6 @@ static const VMStateDescription vmstate_pit_common =3D =
{
     .name =3D "i8254",
     .version_id =3D 3,
     .minimum_version_id =3D 2,
-    .minimum_version_id_old =3D 1,
-    .load_state_old =3D pit_load_old,
     .pre_save =3D pit_dispatch_pre_save,
     .post_load =3D pit_dispatch_post_load,
     .fields =3D (VMStateField[]) {
--=20
2.21.0


