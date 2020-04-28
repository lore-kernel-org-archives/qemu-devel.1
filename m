Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_LOAN
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A102CC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AF82063A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gzx2eE3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AF82063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTT6-0005to-RU
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTFX-00071g-N1
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTBw-0000uW-B9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTTBv-0000uL-Em
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6rsZ/Hc1Qwl9AOTDNmqWG+O3SJULKyIhgdCm2ISxrTg=;
 b=Gzx2eE3oJFGpTytIStOZLfPN8hOK1Cy+NY0pW5yWuzYnM+BjgJ2Lo+BawgMNowIqt6G4Jf
 u4wJIphPCR1vptVkNqnvU4n78MyJDFLAhZUiDzGsCa+f9ZDB+T2w4AoPIlzIArhnmYAMsr
 7v+sbhJj1+g8Stwa4nPpxVfN4dpsTig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-ESXFGOmMMRqTXNhjKqkEfg-1; Tue, 28 Apr 2020 12:34:33 -0400
X-MC-Unique: ESXFGOmMMRqTXNhjKqkEfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD1C5835B49
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 16:34:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 649B91025EB7;
 Tue, 28 Apr 2020 16:34:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2C62D11358CA; Tue, 28 Apr 2020 18:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/17] qom: Drop parameter @errp of object_property_add() &
 friends
Date: Tue, 28 Apr 2020 18:34:15 +0200
Message-Id: <20200428163419.4483-14-armbru@redhat.com>
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only way object_property_add() can fail is when a property with
the same name already exists.  Since our property names are all
hardcoded, failure is a programming error, and the appropriate way to
handle it is passing &error_abort.

Same for its variants, except for object_property_add_child(), which
additionally fails when the child already has a parent.  Parentage is
also under program control, so this is a programming error, too.

We have a bit over 500 callers.  Almost half of them pass
&error_abort, slightly fewer ignore errors, one test case handles
errors, and the remaining few callers pass them to their own callers.

The previous few commits demonstrated once again that ignoring
programming errors is a bad idea.

Of the few ones that pass on errors, several violate the Error API.
The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.  ich9_pm_add_properties(), sparc32_ledma_realize(),
sparc32_dma_realize(), xilinx_axidma_realize(), xilinx_enet_realize()
are wrong that way.

When the one appropriate choice of argument is &error_abort, letting
users pick the argument is a bad idea.

Drop parameter @errp and assert the preconditions instead.

There's one exception to "duplicate property name is a programming
error": the way object_property_add() implements the magic (and
undocumented) "automatic arrayification".  Don't drop @errp there.
Instead, rename object_property_add() to object_property_try_add(),
and add the obvious wrapper object_property_add().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h                |  81 +++-----
 accel/kvm/kvm-all.c                 |   4 +-
 accel/tcg/tcg-all.c                 |   5 +-
 authz/list.c                        |   5 +-
 authz/listfile.c                    |   6 +-
 authz/pamacct.c                     |   3 +-
 authz/simple.c                      |   3 +-
 backends/cryptodev-vhost-user.c     |   3 +-
 backends/cryptodev.c                |   2 +-
 backends/dbus-vmstate.c             |   6 +-
 backends/hostmem-file.c             |  11 +-
 backends/hostmem-memfd.c            |   8 +-
 backends/hostmem.c                  |  19 +-
 backends/rng-egd.c                  |   3 +-
 backends/rng-random.c               |   3 +-
 backends/rng.c                      |   3 +-
 backends/vhost-user.c               |   2 +-
 block/throttle-groups.c             |   6 +-
 bootdevice.c                        |   8 +-
 chardev/char-socket.c               |   4 +-
 chardev/char.c                      |   7 +-
 crypto/secret.c                     |  18 +-
 crypto/tlscreds.c                   |  12 +-
 crypto/tlscredsanon.c               |   3 +-
 crypto/tlscredspsk.c                |   6 +-
 crypto/tlscredsx509.c               |   9 +-
 hw/acpi/ich9.c                      |  23 +--
 hw/acpi/pcihp.c                     |   7 +-
 hw/acpi/piix4.c                     |  15 +-
 hw/arm/allwinner-a10.c              |   2 +-
 hw/arm/allwinner-h3.c               |  12 +-
 hw/arm/armv7m.c                     |   2 +-
 hw/arm/aspeed.c                     |   2 +-
 hw/arm/aspeed_ast2600.c             |  13 +-
 hw/arm/aspeed_soc.c                 |  13 +-
 hw/arm/bcm2835_peripherals.c        |  26 +--
 hw/arm/bcm2836.c                    |  16 +-
 hw/arm/cubieboard.c                 |   3 +-
 hw/arm/mcimx6ul-evk.c               |   2 +-
 hw/arm/mcimx7d-sabre.c              |   2 +-
 hw/arm/msf2-soc.c                   |   3 +-
 hw/arm/nrf51_soc.c                  |   3 +-
 hw/arm/orangepi.c                   |   3 +-
 hw/arm/raspi.c                      |   3 +-
 hw/arm/sabrelite.c                  |   2 +-
 hw/arm/sbsa-ref.c                   |   5 +-
 hw/arm/vexpress.c                   |   4 +-
 hw/arm/virt.c                       |  19 +-
 hw/arm/xlnx-versal-virt.c           |   3 +-
 hw/arm/xlnx-versal.c                |  10 +-
 hw/arm/xlnx-zcu102.c                |   4 +-
 hw/arm/xlnx-zynqmp.c                |   9 +-
 hw/audio/marvell_88w8618.c          |   2 +-
 hw/audio/pcspk.c                    |   2 +-
 hw/core/bus.c                       |   7 +-
 hw/core/machine.c                   |  46 ++---
 hw/core/qdev-properties.c           |   9 +-
 hw/core/qdev.c                      |  40 ++--
 hw/cpu/core.c                       |   4 +-
 hw/display/bochs-display.c          |   3 +-
 hw/display/sm501.c                  |   2 +-
 hw/display/vga-pci.c                |   4 +-
 hw/display/vhost-user-gpu-pci.c     |   3 +-
 hw/display/vhost-user-gpu.c         |   2 +-
 hw/display/vhost-user-vga.c         |   3 +-
 hw/display/xlnx_dp.c                |   7 +-
 hw/dma/sparc32_dma.c                |  10 +-
 hw/dma/xilinx_axidma.c              |   9 +-
 hw/dma/xlnx-zdma.c                  |   3 +-
 hw/gpio/aspeed_gpio.c               |   2 +-
 hw/hyperv/hyperv.c                  |   2 +-
 hw/i386/microvm.c                   |  15 +-
 hw/i386/pc.c                        |  12 +-
 hw/i386/pc_piix.c                   |   2 +-
 hw/i386/pc_q35.c                    |   4 +-
 hw/i386/pc_sysfw.c                  |   5 +-
 hw/i386/x86.c                       |   8 +-
 hw/ide/macio.c                      |   2 +-
 hw/ide/qdev.c                       |   2 +-
 hw/input/vhost-user-input.c         |   2 +-
 hw/intc/apic_common.c               |   2 +-
 hw/intc/s390_flic.c                 |   4 +-
 hw/intc/xics.c                      |   2 +-
 hw/intc/xive.c                      |   2 +-
 hw/ipmi/ipmi.c                      |   3 +-
 hw/isa/isa-superio.c                |  15 +-
 hw/isa/lpc_ich9.c                   |   6 +-
 hw/mem/nvdimm.c                     |   4 +-
 hw/mem/pc-dimm.c                    |   2 +-
 hw/microblaze/petalogix_ml605_mmu.c |   6 +-
 hw/misc/aspeed_sdmc.c               |   2 +-
 hw/misc/edu.c                       |   3 +-
 hw/misc/mac_via.c                   |   4 +-
 hw/misc/macio/gpio.c                |   2 +-
 hw/misc/macio/macio.c               |   4 +-
 hw/misc/macio/pmu.c                 |   2 +-
 hw/misc/pca9552.c                   |   2 +-
 hw/misc/tmp105.c                    |   2 +-
 hw/misc/tmp421.c                    |   8 +-
 hw/net/cadence_gem.c                |   3 +-
 hw/net/can/can_kvaser_pci.c         |   2 +-
 hw/net/can/can_mioe3680_pci.c       |   4 +-
 hw/net/can/can_pcm3680_pci.c        |   4 +-
 hw/net/ne2000-isa.c                 |   2 +-
 hw/net/xilinx_axienet.c             |   9 +-
 hw/nios2/10m50_devboard.c           |   3 +-
 hw/nvram/fw_cfg.c                   |   4 +-
 hw/pci-host/grackle.c               |   2 +-
 hw/pci-host/i440fx.c                |  12 +-
 hw/pci-host/pnv_phb3_msi.c          |   3 +-
 hw/pci-host/pnv_phb3_pbcq.c         |   3 +-
 hw/pci-host/q35.c                   |  20 +-
 hw/pci-host/sabre.c                 |   2 +-
 hw/pci-host/uninorth.c              |   8 +-
 hw/pcmcia/pxa2xx.c                  |   2 +-
 hw/ppc/e500.c                       |   8 +-
 hw/ppc/mac_newworld.c               |   4 +-
 hw/ppc/mac_oldworld.c               |   2 +-
 hw/ppc/pnv.c                        |  13 +-
 hw/ppc/pnv_bmc.c                    |   5 +-
 hw/ppc/pnv_core.c                   |   2 +-
 hw/ppc/pnv_psi.c                    |   2 +-
 hw/ppc/prep.c                       |   6 +-
 hw/ppc/spapr.c                      |  25 +--
 hw/ppc/spapr_caps.c                 |   8 +-
 hw/ppc/spapr_cpu_core.c             |   5 +-
 hw/ppc/spapr_drc.c                  |  18 +-
 hw/ppc/spapr_iommu.c                |   2 +-
 hw/ppc/spapr_irq.c                  |   2 +-
 hw/ppc/spapr_rtc.c                  |   2 +-
 hw/riscv/sifive_u.c                 |   2 +-
 hw/riscv/virt.c                     |   5 +-
 hw/rtc/mc146818rtc.c                |   4 +-
 hw/s390x/ap-bridge.c                |   2 +-
 hw/s390x/css-bridge.c               |   4 +-
 hw/s390x/event-facility.c           |   6 +-
 hw/s390x/s390-skeys.c               |   4 +-
 hw/s390x/s390-stattrib.c            |   4 +-
 hw/s390x/s390-virtio-ccw.c          |  10 +-
 hw/s390x/sclp.c                     |   5 +-
 hw/s390x/tod.c                      |   2 +-
 hw/s390x/virtio-ccw-balloon.c       |   4 +-
 hw/s390x/virtio-ccw-blk.c           |   2 +-
 hw/s390x/virtio-ccw-net.c           |   2 +-
 hw/scsi/scsi-bus.c                  |   2 +-
 hw/sparc/sun4m.c                    |   4 +-
 hw/sparc64/sun4u.c                  |   2 +-
 hw/ssi/xilinx_spips.c               |   3 +-
 hw/usb/bus.c                        |   6 +-
 hw/usb/dev-storage.c                |   2 +-
 hw/vfio/pci-quirks.c                |   6 +-
 hw/virtio/vhost-scsi-pci.c          |   2 +-
 hw/virtio/vhost-user-blk-pci.c      |   2 +-
 hw/virtio/vhost-user-input-pci.c    |   3 +-
 hw/virtio/vhost-user-scsi-pci.c     |   2 +-
 hw/virtio/virtio-balloon-pci.c      |   4 +-
 hw/virtio/virtio-balloon.c          |   4 +-
 hw/virtio/virtio-blk-pci.c          |   2 +-
 hw/virtio/virtio-net-pci.c          |   2 +-
 hw/virtio/virtio-rng.c              |   2 +-
 hw/xen/xen-common.c                 |   3 +-
 iothread.c                          |   6 +-
 memory.c                            |  10 +-
 net/can/can_host.c                  |   3 +-
 net/can/can_socketcan.c             |   3 +-
 net/colo-compare.c                  |  20 +-
 net/dump.c                          |   4 +-
 net/filter-buffer.c                 |   2 +-
 net/filter-mirror.c                 |  10 +-
 net/filter-rewriter.c               |   2 +-
 net/filter.c                        |  15 +-
 qdev-monitor.c                      |   4 +-
 qom/container.c                     |   2 +-
 qom/object.c                        | 302 +++++++++-------------------
 qom/object_interfaces.c             |   5 +-
 scsi/pr-manager-helper.c            |   3 +-
 softmmu/vl.c                        |   7 +-
 target/arm/cpu.c                    |  11 +-
 target/arm/cpu64.c                  |   8 +-
 target/arm/kvm.c                    |   2 +-
 target/i386/cpu.c                   |  83 ++++----
 target/i386/sev.c                   |  17 +-
 target/ppc/compat.c                 |   9 +-
 target/s390x/cpu.c                  |   2 +-
 target/s390x/cpu_models.c           |  11 +-
 tests/check-qom-proplist.c          |  29 +--
 tests/test-qdev-global-props.c      |   4 +-
 ui/console.c                        |   7 +-
 ui/input-barrier.c                  |  14 +-
 ui/input-linux.c                    |   8 +-
 190 files changed, 643 insertions(+), 987 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index a26c7bbf90..7458fefc7b 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1036,7 +1036,6 @@ void object_unref(Object *obj);
  *   meant to allow a property to free its opaque upon object
  *   destruction.  This may be NULL.
  * @opaque: an opaque pointer to pass to the callbacks for the property
- * @errp: returns an error if this function fails
  *
  * Returns: The #ObjectProperty; this can be used to set the @resolve
  * callback for child and link properties.
@@ -1046,7 +1045,7 @@ ObjectProperty *object_property_add(Object *obj, cons=
t char *name,
                                     ObjectPropertyAccessor *get,
                                     ObjectPropertyAccessor *set,
                                     ObjectPropertyRelease *release,
-                                    void *opaque, Error **errp);
+                                    void *opaque);
=20
 void object_property_del(Object *obj, const char *name, Error **errp);
=20
@@ -1055,7 +1054,7 @@ ObjectProperty *object_class_property_add(ObjectClass=
 *klass, const char *name,
                                           ObjectPropertyAccessor *get,
                                           ObjectPropertyAccessor *set,
                                           ObjectPropertyRelease *release,
-                                          void *opaque, Error **errp);
+                                          void *opaque);
=20
 /**
  * object_property_set_default_bool:
@@ -1494,7 +1493,6 @@ Object *object_resolve_path_component(Object *parent,=
 const char *part);
  * @obj: the object to add a property to
  * @name: the name of the property
  * @child: the child object
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Child properties form the composition tree.  All objects need to be a c=
hild
  * of another object.  Objects can only be a child of one object.
@@ -1509,7 +1507,7 @@ Object *object_resolve_path_component(Object *parent,=
 const char *part);
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_child(Object *obj, const char *name,
-                                          Object *child, Error **errp);
+                                          Object *child);
=20
 typedef enum {
     /* Unref the link pointer when the property is deleted */
@@ -1538,7 +1536,6 @@ void object_property_allow_set_link(const Object *, c=
onst char *,
  * @targetp: a pointer to where the link object reference is stored
  * @check: callback to veto setting or NULL if the property is read-only
  * @flags: additional options for the link
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Links establish relationships between objects.  Links are unidirectiona=
l
  * although two links can be combined to form a bidirectional relationship
@@ -1565,16 +1562,14 @@ ObjectProperty *object_property_add_link(Object *ob=
j, const char *name,
                               const char *type, Object **targetp,
                               void (*check)(const Object *obj, const char =
*name,
                                             Object *val, Error **errp),
-                              ObjectPropertyLinkFlags flags,
-                              Error **errp);
+                              ObjectPropertyLinkFlags flags);
=20
 ObjectProperty *object_class_property_add_link(ObjectClass *oc,
                               const char *name,
                               const char *type, ptrdiff_t offset,
                               void (*check)(const Object *obj, const char =
*name,
                                             Object *val, Error **errp),
-                              ObjectPropertyLinkFlags flags,
-                              Error **errp);
+                              ObjectPropertyLinkFlags flags);
=20
 /**
  * object_property_add_str:
@@ -1583,7 +1578,6 @@ ObjectProperty *object_class_property_add_link(Object=
Class *oc,
  * @get: the getter or NULL if the property is write-only.  This function =
must
  *   return a string to be freed by g_free().
  * @set: the setter or NULL if the property is read-only
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add a string property using getters/setters.  This function will add a
  * property of type 'string'.
@@ -1592,15 +1586,13 @@ ObjectProperty *object_class_property_add_link(Obje=
ctClass *oc,
  */
 ObjectProperty *object_property_add_str(Object *obj, const char *name,
                              char *(*get)(Object *, Error **),
-                             void (*set)(Object *, const char *, Error **)=
,
-                             Error **errp);
+                             void (*set)(Object *, const char *, Error **)=
);
=20
 ObjectProperty *object_class_property_add_str(ObjectClass *klass,
                                    const char *name,
                                    char *(*get)(Object *, Error **),
                                    void (*set)(Object *, const char *,
-                                               Error **),
-                                   Error **errp);
+                                               Error **));
=20
 /**
  * object_property_add_bool:
@@ -1608,7 +1600,6 @@ ObjectProperty *object_class_property_add_str(ObjectC=
lass *klass,
  * @name: the name of the property
  * @get: the getter or NULL if the property is write-only.
  * @set: the setter or NULL if the property is read-only
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add a bool property using getters/setters.  This function will add a
  * property of type 'bool'.
@@ -1617,14 +1608,12 @@ ObjectProperty *object_class_property_add_str(Objec=
tClass *klass,
  */
 ObjectProperty *object_property_add_bool(Object *obj, const char *name,
                               bool (*get)(Object *, Error **),
-                              void (*set)(Object *, bool, Error **),
-                              Error **errp);
+                              void (*set)(Object *, bool, Error **));
=20
 ObjectProperty *object_class_property_add_bool(ObjectClass *klass,
                                     const char *name,
                                     bool (*get)(Object *, Error **),
-                                    void (*set)(Object *, bool, Error **),
-                                    Error **errp);
+                                    void (*set)(Object *, bool, Error **))=
;
=20
 /**
  * object_property_add_enum:
@@ -1633,7 +1622,6 @@ ObjectProperty *object_class_property_add_bool(Object=
Class *klass,
  * @typename: the name of the enum data type
  * @get: the getter or %NULL if the property is write-only.
  * @set: the setter or %NULL if the property is read-only
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an enum property using getters/setters.  This function will add a
  * property of type '@typename'.
@@ -1644,23 +1632,20 @@ ObjectProperty *object_property_add_enum(Object *ob=
j, const char *name,
                               const char *typename,
                               const QEnumLookup *lookup,
                               int (*get)(Object *, Error **),
-                              void (*set)(Object *, int, Error **),
-                              Error **errp);
+                              void (*set)(Object *, int, Error **));
=20
 ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
                                     const char *name,
                                     const char *typename,
                                     const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
-                                    void (*set)(Object *, int, Error **),
-                                    Error **errp);
+                                    void (*set)(Object *, int, Error **));
=20
 /**
  * object_property_add_tm:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @get: the getter or NULL if the property is write-only.
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add a read-only struct tm valued property using a getter function.
  * This function will add a property of type 'struct tm'.
@@ -1668,13 +1653,11 @@ ObjectProperty *object_class_property_add_enum(Obje=
ctClass *klass,
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_tm(Object *obj, const char *name,
-                            void (*get)(Object *, struct tm *, Error **),
-                            Error **errp);
+                            void (*get)(Object *, struct tm *, Error **));
=20
 ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
-                                  const char *name,
-                                  void (*get)(Object *, struct tm *, Error=
 **),
-                                  Error **errp);
+                            const char *name,
+                            void (*get)(Object *, struct tm *, Error **));
=20
 typedef enum {
     /* Automatically add a getter to the property */
@@ -1691,7 +1674,6 @@ typedef enum {
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint8'.
@@ -1699,14 +1681,13 @@ typedef enum {
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *nam=
e,
-                                   const uint8_t *v, ObjectPropertyFlags f=
lags,
-                                   Error **errp);
+                                              const uint8_t *v,
+                                              ObjectPropertyFlags flags);
=20
 ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
                                          const char *name,
                                          const uint8_t *v,
-                                         ObjectPropertyFlags flags,
-                                         Error **errp);
+                                         ObjectPropertyFlags flags);
=20
 /**
  * object_property_add_uint16_ptr:
@@ -1714,7 +1695,6 @@ ObjectProperty *object_class_property_add_uint8_ptr(O=
bjectClass *klass,
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint16'.
@@ -1723,14 +1703,12 @@ ObjectProperty *object_class_property_add_uint8_ptr=
(ObjectClass *klass,
  */
 ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *na=
me,
                                     const uint16_t *v,
-                                    ObjectPropertyFlags flags,
-                                    Error **errp);
+                                    ObjectPropertyFlags flags);
=20
 ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint16_t *v,
-                                          ObjectPropertyFlags flags,
-                                          Error **errp);
+                                          ObjectPropertyFlags flags);
=20
 /**
  * object_property_add_uint32_ptr:
@@ -1738,7 +1716,6 @@ ObjectProperty *object_class_property_add_uint16_ptr(=
ObjectClass *klass,
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint32'.
@@ -1747,14 +1724,12 @@ ObjectProperty *object_class_property_add_uint16_pt=
r(ObjectClass *klass,
  */
 ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *na=
me,
                                     const uint32_t *v,
-                                    ObjectPropertyFlags flags,
-                                    Error **errp);
+                                    ObjectPropertyFlags flags);
=20
 ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint32_t *v,
-                                          ObjectPropertyFlags flags,
-                                          Error **errp);
+                                          ObjectPropertyFlags flags);
=20
 /**
  * object_property_add_uint64_ptr:
@@ -1762,7 +1737,6 @@ ObjectProperty *object_class_property_add_uint32_ptr(=
ObjectClass *klass,
  * @name: the name of the property
  * @v: pointer to value
  * @flags: bitwise-or'd ObjectPropertyFlags
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint64'.
@@ -1771,14 +1745,12 @@ ObjectProperty *object_class_property_add_uint32_pt=
r(ObjectClass *klass,
  */
 ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *na=
me,
                                     const uint64_t *v,
-                                    ObjectPropertyFlags flags,
-                                    Error **Errp);
+                                    ObjectPropertyFlags flags);
=20
 ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
                                           const char *name,
                                           const uint64_t *v,
-                                          ObjectPropertyFlags flags,
-                                          Error **Errp);
+                                          ObjectPropertyFlags flags);
=20
 /**
  * object_property_add_alias:
@@ -1786,7 +1758,6 @@ ObjectProperty *object_class_property_add_uint64_ptr(=
ObjectClass *klass,
  * @name: the name of the property
  * @target_obj: the object to forward property access to
  * @target_name: the name of the property on the forwarded object
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an alias for a property on an object.  This function will add a pro=
perty
  * of the same type as the forwarded property.
@@ -1799,15 +1770,13 @@ ObjectProperty *object_class_property_add_uint64_pt=
r(ObjectClass *klass,
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_alias(Object *obj, const char *name,
-                               Object *target_obj, const char *target_name=
,
-                               Error **errp);
+                               Object *target_obj, const char *target_name=
);
=20
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @target: the object to be referred by the link
- * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Add an unmodifiable link for a property on an object.  This function wi=
ll
  * add a property of type link<TYPE> where TYPE is the type of @target.
@@ -1820,7 +1789,7 @@ ObjectProperty *object_property_add_alias(Object *obj=
, const char *name,
  * Returns: The newly added property on success, or %NULL on failure.
  */
 ObjectProperty *object_property_add_const_link(Object *obj, const char *na=
me,
-                                    Object *target, Error **errp);
+                                               Object *target);
=20
 /**
  * object_property_set_description:
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 2fb6099cf2..426b0612cd 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3075,13 +3075,13 @@ static void kvm_accel_class_init(ObjectClass *oc, v=
oid *data)
=20
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, kvm_set_kernel_irqchip,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, "kernel-irqchip",
         "Configure KVM in-kernel irqchip");
=20
     object_class_property_add(oc, "kvm-shadow-mem", "int",
         kvm_get_kvm_shadow_mem, kvm_set_kvm_shadow_mem,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, "kvm-shadow-mem",
         "KVM shadow MMU size");
 }
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 3398a56ef9..3b4fda5640 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -203,12 +203,11 @@ static void tcg_accel_class_init(ObjectClass *oc, voi=
d *data)
=20
     object_class_property_add_str(oc, "thread",
                                   tcg_get_thread,
-                                  tcg_set_thread,
-                                  NULL);
+                                  tcg_set_thread);
=20
     object_class_property_add(oc, "tb-size", "int",
         tcg_get_tb_size, tcg_set_tb_size,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, "tb-size",
         "TCG translation block cache size");
=20
diff --git a/authz/list.c b/authz/list.c
index 5a48074d0a..8e904bfc93 100644
--- a/authz/list.c
+++ b/authz/list.c
@@ -124,13 +124,12 @@ qauthz_list_class_init(ObjectClass *oc, void *data)
                                    "QAuthZListPolicy",
                                    &QAuthZListPolicy_lookup,
                                    qauthz_list_prop_get_policy,
-                                   qauthz_list_prop_set_policy,
-                                   NULL);
+                                   qauthz_list_prop_set_policy);
=20
     object_class_property_add(oc, "rules", "QAuthZListRule",
                               qauthz_list_prop_get_rules,
                               qauthz_list_prop_set_rules,
-                              NULL, NULL, NULL);
+                              NULL, NULL);
=20
     authz->is_allowed =3D qauthz_list_is_allowed;
 }
diff --git a/authz/listfile.c b/authz/listfile.c
index b71f57d30a..666df872ad 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -221,12 +221,10 @@ qauthz_list_file_class_init(ObjectClass *oc, void *da=
ta)
=20
     object_class_property_add_str(oc, "filename",
                                   qauthz_list_file_prop_get_filename,
-                                  qauthz_list_file_prop_set_filename,
-                                  NULL);
+                                  qauthz_list_file_prop_set_filename);
     object_class_property_add_bool(oc, "refresh",
                                    qauthz_list_file_prop_get_refresh,
-                                   qauthz_list_file_prop_set_refresh,
-                                   NULL);
+                                   qauthz_list_file_prop_set_refresh);
=20
     authz->is_allowed =3D qauthz_list_file_is_allowed;
 }
diff --git a/authz/pamacct.c b/authz/pamacct.c
index a8ad25b6c7..3c6be43916 100644
--- a/authz/pamacct.c
+++ b/authz/pamacct.c
@@ -107,8 +107,7 @@ qauthz_pam_class_init(ObjectClass *oc, void *data)
=20
     object_class_property_add_str(oc, "service",
                                   qauthz_pam_prop_get_service,
-                                  qauthz_pam_prop_set_service,
-                                  NULL);
+                                  qauthz_pam_prop_set_service);
 }
=20
=20
diff --git a/authz/simple.c b/authz/simple.c
index 008912d247..84954b80a5 100644
--- a/authz/simple.c
+++ b/authz/simple.c
@@ -74,8 +74,7 @@ qauthz_simple_class_init(ObjectClass *oc, void *data)
=20
     object_class_property_add_str(oc, "identity",
                                   qauthz_simple_prop_get_identity,
-                                  qauthz_simple_prop_set_identity,
-                                  NULL);
+                                  qauthz_simple_prop_set_identity);
 }
=20
=20
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-use=
r.c
index 6edada8e9e..8b8cbc4223 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -340,8 +340,7 @@ static void cryptodev_vhost_user_instance_int(Object *o=
bj)
 {
     object_property_add_str(obj, "chardev",
                             cryptodev_vhost_user_get_chardev,
-                            cryptodev_vhost_user_set_chardev,
-                            NULL);
+                            cryptodev_vhost_user_set_chardev);
 }
=20
 static void cryptodev_vhost_user_finalize(Object *obj)
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 5a9735684e..a3841c4e41 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -213,7 +213,7 @@ static void cryptodev_backend_instance_init(Object *obj=
)
     object_property_add(obj, "queues", "uint32",
                           cryptodev_backend_get_queues,
                           cryptodev_backend_set_queues,
-                          NULL, NULL, NULL);
+                          NULL, NULL);
     /* Initialize devices' queues property to 1 */
     object_property_set_int(obj, 1, "queues", NULL);
 }
diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
index cc594a722e..56361a6272 100644
--- a/backends/dbus-vmstate.c
+++ b/backends/dbus-vmstate.c
@@ -481,11 +481,9 @@ dbus_vmstate_class_init(ObjectClass *oc, void *data)
     vc->get_id =3D dbus_vmstate_get_id;
=20
     object_class_property_add_str(oc, "addr",
-                                  get_dbus_addr, set_dbus_addr,
-                                  &error_abort);
+                                  get_dbus_addr, set_dbus_addr);
     object_class_property_add_str(oc, "id-list",
-                                  get_id_list, set_id_list,
-                                  &error_abort);
+                                  get_id_list, set_id_list);
 }
=20
 static const TypeInfo dbus_vmstate_info =3D {
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index c8c355f5aa..cdabb412e6 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -184,18 +184,15 @@ file_backend_class_init(ObjectClass *oc, void *data)
     oc->unparent =3D file_backend_unparent;
=20
     object_class_property_add_bool(oc, "discard-data",
-        file_memory_backend_get_discard_data, file_memory_backend_set_disc=
ard_data,
-        &error_abort);
+        file_memory_backend_get_discard_data, file_memory_backend_set_disc=
ard_data);
     object_class_property_add_str(oc, "mem-path",
-        get_mem_path, set_mem_path,
-        &error_abort);
+        get_mem_path, set_mem_path);
     object_class_property_add(oc, "align", "int",
         file_memory_backend_get_align,
         file_memory_backend_set_align,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_add_bool(oc, "pmem",
-        file_memory_backend_get_pmem, file_memory_backend_set_pmem,
-        &error_abort);
+        file_memory_backend_get_pmem, file_memory_backend_set_pmem);
 }
=20
 static void file_backend_instance_finalize(Object *o)
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 5991f31459..1b5e4bfe0d 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -141,21 +141,19 @@ memfd_backend_class_init(ObjectClass *oc, void *data)
     if (qemu_memfd_check(MFD_HUGETLB)) {
         object_class_property_add_bool(oc, "hugetlb",
                                        memfd_backend_get_hugetlb,
-                                       memfd_backend_set_hugetlb,
-                                       &error_abort);
+                                       memfd_backend_set_hugetlb);
         object_class_property_set_description(oc, "hugetlb",
                                               "Use huge pages");
         object_class_property_add(oc, "hugetlbsize", "int",
                                   memfd_backend_get_hugetlbsize,
                                   memfd_backend_set_hugetlbsize,
-                                  NULL, NULL, &error_abort);
+                                  NULL, NULL);
         object_class_property_set_description(oc, "hugetlbsize",
                                               "Huge pages size (ex: 2M, 1G=
)");
     }
     object_class_property_add_bool(oc, "seal",
                                    memfd_backend_get_seal,
-                                   memfd_backend_set_seal,
-                                   &error_abort);
+                                   memfd_backend_set_seal);
     object_class_property_set_description(oc, "seal",
                                           "Seal growing & shrinking");
 }
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 946d176435..4ee4354898 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -463,51 +463,50 @@ host_memory_backend_class_init(ObjectClass *oc, void =
*data)
=20
     object_class_property_add_bool(oc, "merge",
         host_memory_backend_get_merge,
-        host_memory_backend_set_merge, &error_abort);
+        host_memory_backend_set_merge);
     object_class_property_set_description(oc, "merge",
         "Mark memory as mergeable");
     object_class_property_add_bool(oc, "dump",
         host_memory_backend_get_dump,
-        host_memory_backend_set_dump, &error_abort);
+        host_memory_backend_set_dump);
     object_class_property_set_description(oc, "dump",
         "Set to 'off' to exclude from core dump");
     object_class_property_add_bool(oc, "prealloc",
         host_memory_backend_get_prealloc,
-        host_memory_backend_set_prealloc, &error_abort);
+        host_memory_backend_set_prealloc);
     object_class_property_set_description(oc, "prealloc",
         "Preallocate memory");
     object_class_property_add(oc, "prealloc-threads", "int",
         host_memory_backend_get_prealloc_threads,
         host_memory_backend_set_prealloc_threads,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, "prealloc-threads",
         "Number of CPU threads to use for prealloc");
     object_class_property_add(oc, "size", "int",
         host_memory_backend_get_size,
         host_memory_backend_set_size,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, "size",
         "Size of the memory region (ex: 500M)");
     object_class_property_add(oc, "host-nodes", "int",
         host_memory_backend_get_host_nodes,
         host_memory_backend_set_host_nodes,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, "host-nodes",
         "Binds memory to the list of NUMA host nodes");
     object_class_property_add_enum(oc, "policy", "HostMemPolicy",
         &HostMemPolicy_lookup,
         host_memory_backend_get_policy,
-        host_memory_backend_set_policy, &error_abort);
+        host_memory_backend_set_policy);
     object_class_property_set_description(oc, "policy",
         "Set the NUMA policy");
     object_class_property_add_bool(oc, "share",
-        host_memory_backend_get_share, host_memory_backend_set_share,
-        &error_abort);
+        host_memory_backend_get_share, host_memory_backend_set_share);
     object_class_property_set_description(oc, "share",
         "Mark the memory as private to QEMU or shared");
     object_class_property_add_bool(oc, "x-use-canonical-path-for-ramblock-=
id",
         host_memory_backend_get_use_canonical_path,
-        host_memory_backend_set_use_canonical_path, &error_abort);
+        host_memory_backend_set_use_canonical_path);
 }
=20
 static const TypeInfo host_memory_backend_info =3D {
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index e380519408..7aaa6ee239 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -138,8 +138,7 @@ static char *rng_egd_get_chardev(Object *obj, Error **e=
rrp)
 static void rng_egd_init(Object *obj)
 {
     object_property_add_str(obj, "chardev",
-                            rng_egd_get_chardev, rng_egd_set_chardev,
-                            NULL);
+                            rng_egd_get_chardev, rng_egd_set_chardev);
 }
=20
 static void rng_egd_finalize(Object *obj)
diff --git a/backends/rng-random.c b/backends/rng-random.c
index a810581393..32998d8ee7 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -110,8 +110,7 @@ static void rng_random_init(Object *obj)
=20
     object_property_add_str(obj, "filename",
                             rng_random_get_filename,
-                            rng_random_set_filename,
-                            NULL);
+                            rng_random_set_filename);
=20
     s->filename =3D g_strdup("/dev/urandom");
     s->fd =3D -1;
diff --git a/backends/rng.c b/backends/rng.c
index 391888b8b3..597f0ec268 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -108,8 +108,7 @@ static void rng_backend_init(Object *obj)
=20
     object_property_add_bool(obj, "opened",
                              rng_backend_prop_get_opened,
-                             rng_backend_prop_set_opened,
-                             NULL);
+                             rng_backend_prop_set_opened);
 }
=20
 static void rng_backend_finalize(Object *obj)
diff --git a/backends/vhost-user.c b/backends/vhost-user.c
index 2bf3406525..9e6e198546 100644
--- a/backends/vhost-user.c
+++ b/backends/vhost-user.c
@@ -177,7 +177,7 @@ static char *get_chardev(Object *obj, Error **errp)
=20
 static void vhost_user_backend_init(Object *obj)
 {
-    object_property_add_str(obj, "chardev", get_chardev, set_chardev, NULL=
);
+    object_property_add_str(obj, "chardev", get_chardev, set_chardev);
 }
=20
 static void vhost_user_backend_finalize(Object *obj)
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 37695b0cd7..784fa4a16c 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -954,8 +954,7 @@ static void throttle_group_obj_class_init(ObjectClass *=
klass, void *class_data)
                                   "int",
                                   throttle_group_get,
                                   throttle_group_set,
-                                  NULL, &properties[i],
-                                  &error_abort);
+                                  NULL, &properties[i]);
     }
=20
     /* ThrottleLimits */
@@ -963,8 +962,7 @@ static void throttle_group_obj_class_init(ObjectClass *=
klass, void *class_data)
                               "limits", "ThrottleLimits",
                               throttle_group_get_limits,
                               throttle_group_set_limits,
-                              NULL, NULL,
-                              &error_abort);
+                              NULL, NULL);
 }
=20
 static const TypeInfo throttle_group_info =3D {
diff --git a/bootdevice.c b/bootdevice.c
index 03aaffcc8d..d11576d575 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -329,7 +329,6 @@ void device_add_bootindex_property(Object *obj, int32_t=
 *bootindex,
                                    const char *name, const char *suffix,
                                    DeviceState *dev, Error **errp)
 {
-    Error *local_err =3D NULL;
     BootIndexProperty *prop =3D g_malloc0(sizeof(*prop));
=20
     prop->bootindex =3D bootindex;
@@ -340,13 +339,8 @@ void device_add_bootindex_property(Object *obj, int32_=
t *bootindex,
                         device_get_bootindex,
                         device_set_bootindex,
                         property_release_bootindex,
-                        prop, &local_err);
+                        prop);
=20
-    if (local_err) {
-        error_propagate(errp, local_err);
-        g_free(prop);
-        return;
-    }
     /* initialize devices' bootindex property to -1 */
     object_property_set_int(obj, -1, name, NULL);
 }
diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38dda..232e0a8604 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -1489,10 +1489,10 @@ static void char_socket_class_init(ObjectClass *oc,=
 void *data)
=20
     object_class_property_add(oc, "addr", "SocketAddress",
                               char_socket_get_addr, NULL,
-                              NULL, NULL, &error_abort);
+                              NULL, NULL);
=20
     object_class_property_add_bool(oc, "connected", char_socket_get_connec=
ted,
-                                   NULL, &error_abort);
+                                   NULL);
 }
=20
 static const TypeInfo char_socket_type_info =3D {
diff --git a/chardev/char.c b/chardev/char.c
index e77564060d..0196e2887b 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -986,10 +986,7 @@ static Chardev *chardev_new(const char *id, const char=
 *typename,
     }
=20
     if (id) {
-        object_property_add_child(get_chardevs_root(), id, obj, &local_err=
);
-        if (local_err) {
-            goto end;
-        }
+        object_property_add_child(get_chardevs_root(), id, obj);
         object_unref(obj);
     }
=20
@@ -1116,7 +1113,7 @@ ChardevReturn *qmp_chardev_change(const char *id, Cha=
rdevBackend *backend,
=20
     object_unparent(OBJECT(chr));
     object_property_add_child(get_chardevs_root(), chr_new->label,
-                              OBJECT(chr_new), &error_abort);
+                              OBJECT(chr_new));
     object_unref(OBJECT(chr_new));
=20
     ret =3D g_new0(ChardevReturn, 1);
diff --git a/crypto/secret.c b/crypto/secret.c
index 1cf0ad0ce8..a24379d24a 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -368,30 +368,24 @@ qcrypto_secret_class_init(ObjectClass *oc, void *data=
)
=20
     object_class_property_add_bool(oc, "loaded",
                                    qcrypto_secret_prop_get_loaded,
-                                   qcrypto_secret_prop_set_loaded,
-                                   NULL);
+                                   qcrypto_secret_prop_set_loaded);
     object_class_property_add_enum(oc, "format",
                                    "QCryptoSecretFormat",
                                    &QCryptoSecretFormat_lookup,
                                    qcrypto_secret_prop_get_format,
-                                   qcrypto_secret_prop_set_format,
-                                   NULL);
+                                   qcrypto_secret_prop_set_format);
     object_class_property_add_str(oc, "data",
                                   qcrypto_secret_prop_get_data,
-                                  qcrypto_secret_prop_set_data,
-                                  NULL);
+                                  qcrypto_secret_prop_set_data);
     object_class_property_add_str(oc, "file",
                                   qcrypto_secret_prop_get_file,
-                                  qcrypto_secret_prop_set_file,
-                                  NULL);
+                                  qcrypto_secret_prop_set_file);
     object_class_property_add_str(oc, "keyid",
                                   qcrypto_secret_prop_get_keyid,
-                                  qcrypto_secret_prop_set_keyid,
-                                  NULL);
+                                  qcrypto_secret_prop_set_keyid);
     object_class_property_add_str(oc, "iv",
                                   qcrypto_secret_prop_get_iv,
-                                  qcrypto_secret_prop_set_iv,
-                                  NULL);
+                                  qcrypto_secret_prop_set_iv);
 }
=20
=20
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 4e657b850c..b68735f06f 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -226,22 +226,18 @@ qcrypto_tls_creds_class_init(ObjectClass *oc, void *d=
ata)
 {
     object_class_property_add_bool(oc, "verify-peer",
                                    qcrypto_tls_creds_prop_get_verify,
-                                   qcrypto_tls_creds_prop_set_verify,
-                                   NULL);
+                                   qcrypto_tls_creds_prop_set_verify);
     object_class_property_add_str(oc, "dir",
                                   qcrypto_tls_creds_prop_get_dir,
-                                  qcrypto_tls_creds_prop_set_dir,
-                                  NULL);
+                                  qcrypto_tls_creds_prop_set_dir);
     object_class_property_add_enum(oc, "endpoint",
                                    "QCryptoTLSCredsEndpoint",
                                    &QCryptoTLSCredsEndpoint_lookup,
                                    qcrypto_tls_creds_prop_get_endpoint,
-                                   qcrypto_tls_creds_prop_set_endpoint,
-                                   NULL);
+                                   qcrypto_tls_creds_prop_set_endpoint);
     object_class_property_add_str(oc, "priority",
                                   qcrypto_tls_creds_prop_get_priority,
-                                  qcrypto_tls_creds_prop_set_priority,
-                                  NULL);
+                                  qcrypto_tls_creds_prop_set_priority);
 }
=20
=20
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index a235f60146..fc078d5b97 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -187,8 +187,7 @@ qcrypto_tls_creds_anon_class_init(ObjectClass *oc, void=
 *data)
=20
     object_class_property_add_bool(oc, "loaded",
                                    qcrypto_tls_creds_anon_prop_get_loaded,
-                                   qcrypto_tls_creds_anon_prop_set_loaded,
-                                   NULL);
+                                   qcrypto_tls_creds_anon_prop_set_loaded)=
;
 }
=20
=20
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 15d12e2448..f01b64d8bc 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -275,12 +275,10 @@ qcrypto_tls_creds_psk_class_init(ObjectClass *oc, voi=
d *data)
=20
     object_class_property_add_bool(oc, "loaded",
                                    qcrypto_tls_creds_psk_prop_get_loaded,
-                                   qcrypto_tls_creds_psk_prop_set_loaded,
-                                   NULL);
+                                   qcrypto_tls_creds_psk_prop_set_loaded);
     object_class_property_add_str(oc, "username",
                                   qcrypto_tls_creds_psk_prop_get_username,
-                                  qcrypto_tls_creds_psk_prop_set_username,
-                                  NULL);
+                                  qcrypto_tls_creds_psk_prop_set_username)=
;
 }
=20
=20
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 53a4368f49..e337d68c4f 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -806,16 +806,13 @@ qcrypto_tls_creds_x509_class_init(ObjectClass *oc, vo=
id *data)
=20
     object_class_property_add_bool(oc, "loaded",
                                    qcrypto_tls_creds_x509_prop_get_loaded,
-                                   qcrypto_tls_creds_x509_prop_set_loaded,
-                                   NULL);
+                                   qcrypto_tls_creds_x509_prop_set_loaded)=
;
     object_class_property_add_bool(oc, "sanity-check",
                                    qcrypto_tls_creds_x509_prop_get_sanity,
-                                   qcrypto_tls_creds_x509_prop_set_sanity,
-                                   NULL);
+                                   qcrypto_tls_creds_x509_prop_set_sanity)=
;
     object_class_property_add_str(oc, "passwordid",
                                   qcrypto_tls_creds_x509_prop_get_password=
id,
-                                  qcrypto_tls_creds_x509_prop_set_password=
id,
-                                  NULL);
+                                  qcrypto_tls_creds_x509_prop_set_password=
id);
 }
=20
=20
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 336cacea41..9e4c03bef8 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -379,32 +379,27 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMReg=
s *pm, Error **errp)
     pm->s4_val =3D 2;
=20
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
-                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ, er=
rp);
+                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ);
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
-                        NULL, NULL, pm, NULL);
+                        NULL, NULL, pm);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
-                                   &gpe0_len, OBJ_PROP_FLAG_READ, errp);
+                                   &gpe0_len, OBJ_PROP_FLAG_READ);
     object_property_add_bool(obj, "memory-hotplug-support",
                              ich9_pm_get_memory_hotplug_support,
-                             ich9_pm_set_memory_hotplug_support,
-                             NULL);
+                             ich9_pm_set_memory_hotplug_support);
     object_property_add_bool(obj, "cpu-hotplug-legacy",
                              ich9_pm_get_cpu_hotplug_legacy,
-                             ich9_pm_set_cpu_hotplug_legacy,
-                             NULL);
+                             ich9_pm_set_cpu_hotplug_legacy);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE=
,
-                                  NULL);
+                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE=
);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
-                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE=
,
-                                  NULL);
+                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE=
);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
-                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE, NU=
LL);
+                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE);
     object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
                              ich9_pm_get_enable_tco,
-                             ich9_pm_set_enable_tco,
-                             NULL);
+                             ich9_pm_set_enable_tco);
 }
=20
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *=
dev,
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 0dc963e983..fbc86af102 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -80,8 +80,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
=20
         *bus_bsel =3D (*bsel_alloc)++;
         object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                       bus_bsel, OBJ_PROP_FLAG_READ,
-                                       &error_abort);
+                                       bus_bsel, OBJ_PROP_FLAG_READ);
     }
=20
     return bsel_alloc;
@@ -374,9 +373,9 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, =
PCIBus *root_bus,
     memory_region_add_subregion(address_space_io, s->io_base, &s->io);
=20
     object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_=
base,
-                                   OBJ_PROP_FLAG_READ, &error_abort);
+                                   OBJ_PROP_FLAG_READ);
     object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->io_l=
en,
-                                   OBJ_PROP_FLAG_READ, &error_abort);
+                                   OBJ_PROP_FLAG_READ);
 }
=20
 const VMStateDescription vmstate_acpi_pcihp_pci_status =3D {
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 964d6f5990..85c199b30d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -444,17 +444,17 @@ static void piix4_pm_add_propeties(PIIX4PMState *s)
     static const uint16_t sci_int =3D 9;
=20
     object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ, NU=
LL);
+                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD=
,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ, N=
ULL);
+                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
-                                  &gpe0_blk, OBJ_PROP_FLAG_READ, NULL);
+                                  &gpe0_blk, OBJ_PROP_FLAG_READ);
     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
-                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ, NULL)=
;
+                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ);
     object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
-                                  &sci_int, OBJ_PROP_FLAG_READ, NULL);
+                                  &sci_int, OBJ_PROP_FLAG_READ);
     object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                  &s->io_base, OBJ_PROP_FLAG_READ, NULL);
+                                  &s->io_base, OBJ_PROP_FLAG_READ);
 }
=20
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -598,8 +598,7 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion=
 *parent,
     s->cpu_hotplug_legacy =3D true;
     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
                              piix4_get_cpu_hotplug_legacy,
-                             piix4_set_cpu_hotplug_legacy,
-                             NULL);
+                             piix4_set_cpu_hotplug_legacy);
     legacy_acpi_cpu_hotplug_init(parent, OBJECT(s), &s->gpe_cpu,
                                  PIIX4_CPU_HOTPLUG_IO_BASE);
=20
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 62a67a3e1a..6e1329a4a2 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -178,7 +178,7 @@ static void aw_a10_realize(DeviceState *dev, Error **er=
rp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, AW_A10_MMC0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0, qdev_get_gpio_in(dev, =
32));
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
-                              "sd-bus", &error_abort);
+                              "sd-bus");
=20
     /* RTC */
     qdev_init_nofail(DEVICE(&s->rtc));
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 9e4ce36093..f10674da5a 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -205,9 +205,9 @@ static void allwinner_h3_init(Object *obj)
     sysbus_init_child_obj(obj, "timer", &s->timer, sizeof(s->timer),
                           TYPE_AW_A10_PIT);
     object_property_add_alias(obj, "clk0-freq", OBJECT(&s->timer),
-                              "clk0-freq", &error_abort);
+                              "clk0-freq");
     object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
-                              "clk1-freq", &error_abort);
+                              "clk1-freq");
=20
     sysbus_init_child_obj(obj, "ccu", &s->ccu, sizeof(s->ccu),
                           TYPE_AW_H3_CCU);
@@ -221,7 +221,7 @@ static void allwinner_h3_init(Object *obj)
     sysbus_init_child_obj(obj, "sid", &s->sid, sizeof(s->sid),
                           TYPE_AW_SID);
     object_property_add_alias(obj, "identifier", OBJECT(&s->sid),
-                              "identifier", &error_abort);
+                              "identifier");
=20
     sysbus_init_child_obj(obj, "mmc0", &s->mmc0, sizeof(s->mmc0),
                           TYPE_AW_SDHOST_SUN5I);
@@ -232,9 +232,9 @@ static void allwinner_h3_init(Object *obj)
     sysbus_init_child_obj(obj, "dramc", &s->dramc, sizeof(s->dramc),
                           TYPE_AW_H3_DRAMC);
     object_property_add_alias(obj, "ram-addr", OBJECT(&s->dramc),
-                             "ram-addr", &error_abort);
+                             "ram-addr");
     object_property_add_alias(obj, "ram-size", OBJECT(&s->dramc),
-                              "ram-size", &error_abort);
+                              "ram-size");
=20
     sysbus_init_child_obj(obj, "rtc", &s->rtc, sizeof(s->rtc),
                           TYPE_AW_RTC_SUN6I);
@@ -366,7 +366,7 @@ static void allwinner_h3_realize(DeviceState *dev, Erro=
r **errp)
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_MMC=
0));
=20
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
-                              "sd-bus", &error_abort);
+                              "sd-bus");
=20
     /* EMAC */
     if (nd_table[0].used) {
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7531b97ccd..7da57f56d3 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -138,7 +138,7 @@ static void armv7m_instance_init(Object *obj)
=20
     sysbus_init_child_obj(obj, "nvnic", &s->nvic, sizeof(s->nvic), TYPE_NV=
IC);
     object_property_add_alias(obj, "num-irq",
-                              OBJECT(&s->nvic), "num-irq", &error_abort);
+                              OBJECT(&s->nvic), "num-irq");
=20
     for (i =3D 0; i < ARRAY_SIZE(s->bitband); i++) {
         sysbus_init_child_obj(obj, "bitband[*]", &s->bitband[i],
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index b9a34cab75..3181cce706 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -420,7 +420,7 @@ static void aspeed_machine_class_props_init(ObjectClass=
 *oc)
 {
     object_class_property_add_bool(oc, "execute-in-place",
                                    aspeed_get_mmio_exec,
-                                   aspeed_set_mmio_exec, &error_abort);
+                                   aspeed_set_mmio_exec);
     object_class_property_set_description(oc, "execute-in-place",
                            "boot directly from CE0 flash device");
 }
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 1a869e09b9..f958cd6a2e 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -138,11 +138,11 @@ static void aspeed_soc_ast2600_init(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
                          sc->silicon_rev);
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
-                              "hw-strap1", &error_abort);
+                              "hw-strap1");
     object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
-                              "hw-strap2", &error_abort);
+                              "hw-strap2");
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
-                              "hw-prot-key", &error_abort);
+                              "hw-prot-key");
=20
     sysbus_init_child_obj(obj, "a7mpcore", &s->a7mpcore,
                           sizeof(s->a7mpcore), TYPE_A15MPCORE_PRIV);
@@ -161,8 +161,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
     sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc),
                           typename);
-    object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
-                              &error_abort);
+    object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs");
=20
     for (i =3D 0; i < sc->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, soc=
name);
@@ -179,9 +178,9 @@ static void aspeed_soc_ast2600_init(Object *obj)
     sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc),
                           typename);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
-                              "ram-size", &error_abort);
+                              "ram-size");
     object_property_add_alias(obj, "max-ram-size", OBJECT(&s->sdmc),
-                              "max-ram-size", &error_abort);
+                              "max-ram-size");
=20
     for (i =3D 0; i < sc->wdts_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 696c7fda14..cf6b6dd116 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -153,11 +153,11 @@ static void aspeed_soc_init(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
                          sc->silicon_rev);
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
-                              "hw-strap1", &error_abort);
+                              "hw-strap1");
     object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
-                              "hw-strap2", &error_abort);
+                              "hw-strap2");
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
-                              "hw-prot-key", &error_abort);
+                              "hw-prot-key");
=20
     sysbus_init_child_obj(obj, "vic", OBJECT(&s->vic), sizeof(s->vic),
                           TYPE_ASPEED_VIC);
@@ -176,8 +176,7 @@ static void aspeed_soc_init(Object *obj)
     snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
     sysbus_init_child_obj(obj, "fmc", OBJECT(&s->fmc), sizeof(s->fmc),
                           typename);
-    object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs",
-                              &error_abort);
+    object_property_add_alias(obj, "num-cs", OBJECT(&s->fmc), "num-cs");
=20
     for (i =3D 0; i < sc->spis_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1, soc=
name);
@@ -194,9 +193,9 @@ static void aspeed_soc_init(Object *obj)
     sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc),
                           typename);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
-                              "ram-size", &error_abort);
+                              "ram-size");
     object_property_add_alias(obj, "max-ram-size", OBJECT(&s->sdmc),
-                              "max-ram-size", &error_abort);
+                              "max-ram-size");
=20
     for (i =3D 0; i < sc->wdts_num; i++) {
         snprintf(typename, sizeof(typename), "aspeed.wdt-%s", socname);
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 8b399d67ff..f1bcc14f55 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -74,26 +74,25 @@ static void bcm2835_peripherals_init(Object *obj)
                           TYPE_BCM2835_MBOX);
=20
     object_property_add_const_link(OBJECT(&s->mboxes), "mbox-mr",
-                                   OBJECT(&s->mbox_mr), &error_abort);
+                                   OBJECT(&s->mbox_mr));
=20
     /* Framebuffer */
     sysbus_init_child_obj(obj, "fb", &s->fb, sizeof(s->fb), TYPE_BCM2835_F=
B);
-    object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-si=
ze",
-                              &error_abort);
+    object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-si=
ze");
=20
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
-                                   OBJECT(&s->gpu_bus_mr), &error_abort);
+                                   OBJECT(&s->gpu_bus_mr));
=20
     /* Property channel */
     sysbus_init_child_obj(obj, "property", &s->property, sizeof(s->propert=
y),
                           TYPE_BCM2835_PROPERTY);
     object_property_add_alias(obj, "board-rev", OBJECT(&s->property),
-                              "board-rev", &error_abort);
+                              "board-rev");
=20
     object_property_add_const_link(OBJECT(&s->property), "fb",
-                                   OBJECT(&s->fb), &error_abort);
+                                   OBJECT(&s->fb));
     object_property_add_const_link(OBJECT(&s->property), "dma-mr",
-                                   OBJECT(&s->gpu_bus_mr), &error_abort);
+                                   OBJECT(&s->gpu_bus_mr));
=20
     /* Random Number Generator */
     sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
@@ -112,7 +111,7 @@ static void bcm2835_peripherals_init(Object *obj)
                           TYPE_BCM2835_DMA);
=20
     object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
-                                   OBJECT(&s->gpu_bus_mr), &error_abort);
+                                   OBJECT(&s->gpu_bus_mr));
=20
     /* Thermal */
     sysbus_init_child_obj(obj, "thermal", &s->thermal, sizeof(s->thermal),
@@ -123,9 +122,9 @@ static void bcm2835_peripherals_init(Object *obj)
                           TYPE_BCM2835_GPIO);
=20
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
-                                   OBJECT(&s->sdhci.sdbus), &error_abort);
+                                   OBJECT(&s->sdhci.sdbus));
     object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
-                                   OBJECT(&s->sdhost.sdbus), &error_abort)=
;
+                                   OBJECT(&s->sdhost.sdbus));
 }
=20
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -359,12 +358,7 @@ static void bcm2835_peripherals_realize(DeviceState *d=
ev, Error **errp)
     memory_region_add_subregion(&s->peri_mr, GPIO_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
=20
-    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-b=
us",
-                              &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-b=
us");
=20
     create_unimp(s, &s->armtmr, "bcm2835-sp804", ARMCTRL_TIMER0_1_OFFSET, =
0x40);
     create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 43022b83f5..e51b4e0c43 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -63,9 +63,9 @@ static void bcm2836_init(Object *obj)
     sysbus_init_child_obj(obj, "peripherals", &s->peripherals,
                           sizeof(s->peripherals), TYPE_BCM2835_PERIPHERALS=
);
     object_property_add_alias(obj, "board-rev", OBJECT(&s->peripherals),
-                              "board-rev", &error_abort);
+                              "board-rev");
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
-                              "vcram-size", &error_abort);
+                              "vcram-size");
 }
=20
 static void bcm2836_realize(DeviceState *dev, Error **errp)
@@ -86,11 +86,7 @@ static void bcm2836_realize(DeviceState *dev, Error **er=
rp)
         return;
     }
=20
-    object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj, &e=
rr);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+    object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj);
=20
     object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &e=
rr);
     if (err) {
@@ -99,11 +95,7 @@ static void bcm2836_realize(DeviceState *dev, Error **er=
rp)
     }
=20
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals)=
,
-                              "sd-bus", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
+                              "sd-bus");
=20
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
                             info->peri_base, 1);
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 0b8ba44976..cd1b6d3e19 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -59,8 +59,7 @@ static void cubieboard_init(MachineState *machine)
     }
=20
     a10 =3D AW_A10(object_new(TYPE_AW_A10));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(a10),
-                              &error_abort);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(a10));
     object_unref(OBJECT(a10));
=20
     object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 23a71ed378..5b5f23a6d4 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -39,7 +39,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
     };
=20
     s =3D FSL_IMX6UL(object_new(TYPE_FSL_IMX6UL));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(s), &error_fa=
tal);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
=20
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index de1e264217..3851cd9e3e 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -41,7 +41,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     };
=20
     s =3D FSL_IMX7(object_new(TYPE_FSL_IMX7));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(s), &error_fa=
tal);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_bool(OBJECT(s), true, "realized", &error_fatal);
=20
     memory_region_add_subregion(get_system_memory(), FSL_IMX7_MMDC_ADDR,
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 588d643b8d..623967230d 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -187,8 +187,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Er=
ror **errp)
         /* Alias controller SPI bus to the SoC itself */
         bus_name =3D g_strdup_printf("spi%d", i);
         object_property_add_alias(OBJECT(s), bus_name,
-                                  OBJECT(&s->spi[i]), "spi",
-                                  &error_abort);
+                                  OBJECT(&s->spi[i]), "spi");
         g_free(bus_name);
     }
=20
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 57eff63f0d..940d28a36b 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -192,8 +192,7 @@ static void nrf51_soc_init(Object *obj)
=20
     sysbus_init_child_obj(obj, "uart", &s->uart, sizeof(s->uart),
                            TYPE_NRF51_UART);
-    object_property_add_alias(obj, "serial0", OBJECT(&s->uart), "chardev",
-                              &error_abort);
+    object_property_add_alias(obj, "serial0", OBJECT(&s->uart), "chardev")=
;
=20
     sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
                            TYPE_NRF51_RNG);
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index a9f64c5680..b291715f27 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -59,8 +59,7 @@ static void orangepi_init(MachineState *machine)
     }
=20
     h3 =3D AW_H3(object_new(TYPE_AW_H3));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(h3),
-                              &error_abort);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(h3));
     object_unref(OBJECT(h3));
=20
     /* Setup timer properties */
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fe3b9bc78b..a2efe0b94d 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -284,8 +284,7 @@ static void raspi_machine_init(MachineState *machine)
     /* Setup the SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc=
),
                             board_soc_type(board_rev), &error_abort, NULL)=
;
-    object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(machine-=
>ram),
-                                   &error_abort);
+    object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(machine-=
>ram));
     object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
                             &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abo=
rt);
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index e31694bb92..6f0e233d77 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -51,7 +51,7 @@ static void sabrelite_init(MachineState *machine)
     }
=20
     s =3D FSL_IMX6(object_new(TYPE_FSL_IMX6));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(s), &error_fa=
tal);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_bool(OBJECT(s), true, "realized", &err);
     if (err !=3D NULL) {
         error_report("%s", error_get_pretty(err));
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 8409ba853d..a6cdb4fb7b 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -222,10 +222,9 @@ static PFlashCFI01 *sbsa_flash_create1(SBSAMachineStat=
e *sms,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
-    object_property_add_child(OBJECT(sms), name, OBJECT(dev),
-                              &error_abort);
+    object_property_add_child(OBJECT(sms), name, OBJECT(dev));
     object_property_add_alias(OBJECT(sms), alias_prop_name,
-                              OBJECT(dev), "drive", &error_abort);
+                              OBJECT(dev), "drive");
     return PFLASH_CFI01(dev);
 }
=20
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 5372ab6c9b..69ee4988f9 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -749,7 +749,7 @@ static void vexpress_instance_init(Object *obj)
     /* EL3 is enabled by default on vexpress */
     vms->secure =3D true;
     object_property_add_bool(obj, "secure", vexpress_get_secure,
-                             vexpress_set_secure, NULL);
+                             vexpress_set_secure);
     object_property_set_description(obj, "secure",
                                     "Set on/off to enable/disable the ARM =
"
                                     "Security Extensions (TrustZone)");
@@ -765,7 +765,7 @@ static void vexpress_a15_instance_init(Object *obj)
      */
     vms->virt =3D true;
     object_property_add_bool(obj, "virtualization", vexpress_get_virt,
-                             vexpress_set_virt, NULL);
+                             vexpress_set_virt);
     object_property_set_description(obj, "virtualization",
                                     "Set on/off to enable/disable the ARM =
"
                                     "Virtualization Extensions "
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5ddcad6f32..fd3babc40f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -936,10 +936,9 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineStat=
e *vms,
     qdev_prop_set_uint16(dev, "id2", 0x00);
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
-    object_property_add_child(OBJECT(vms), name, OBJECT(dev),
-                              &error_abort);
+    object_property_add_child(OBJECT(vms), name, OBJECT(dev));
     object_property_add_alias(OBJECT(vms), alias_prop_name,
-                              OBJECT(dev), "drive", &error_abort);
+                              OBJECT(dev), "drive");
     return PFLASH_CFI01(dev);
 }
=20
@@ -2213,7 +2212,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
=20
     object_class_property_add(oc, "acpi", "OnOffAuto",
         virt_get_acpi, virt_set_acpi,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, "acpi",
         "Enable ACPI");
 }
@@ -2229,7 +2228,7 @@ static void virt_instance_init(Object *obj)
      */
     vms->secure =3D false;
     object_property_add_bool(obj, "secure", virt_get_secure,
-                             virt_set_secure, NULL);
+                             virt_set_secure);
     object_property_set_description(obj, "secure",
                                     "Set on/off to enable/disable the ARM =
"
                                     "Security Extensions (TrustZone)");
@@ -2237,7 +2236,7 @@ static void virt_instance_init(Object *obj)
     /* EL2 is also disabled by default, for similar reasons */
     vms->virt =3D false;
     object_property_add_bool(obj, "virtualization", virt_get_virt,
-                             virt_set_virt, NULL);
+                             virt_set_virt);
     object_property_set_description(obj, "virtualization",
                                     "Set on/off to enable/disable emulatin=
g a "
                                     "guest CPU which implements the ARM "
@@ -2246,13 +2245,13 @@ static void virt_instance_init(Object *obj)
     /* High memory is enabled by default */
     vms->highmem =3D true;
     object_property_add_bool(obj, "highmem", virt_get_highmem,
-                             virt_set_highmem, NULL);
+                             virt_set_highmem);
     object_property_set_description(obj, "highmem",
                                     "Set on/off to enable/disable using "
                                     "physical address space above 32 bits"=
);
     vms->gic_version =3D VIRT_GIC_VERSION_NOSEL;
     object_property_add_str(obj, "gic-version", virt_get_gic_version,
-                        virt_set_gic_version, NULL);
+                        virt_set_gic_version);
     object_property_set_description(obj, "gic-version",
                                     "Set GIC version. "
                                     "Valid values are 2, 3, host and max")=
;
@@ -2265,7 +2264,7 @@ static void virt_instance_init(Object *obj)
         /* Default allows ITS instantiation */
         vms->its =3D true;
         object_property_add_bool(obj, "its", virt_get_its,
-                                 virt_set_its, NULL);
+                                 virt_set_its);
         object_property_set_description(obj, "its",
                                         "Set on/off to enable/disable "
                                         "ITS instantiation");
@@ -2273,7 +2272,7 @@ static void virt_instance_init(Object *obj)
=20
     /* Default disallows iommu instantiation */
     vms->iommu =3D VIRT_IOMMU_NONE;
-    object_property_add_str(obj, "iommu", virt_get_iommu, virt_set_iommu, =
NULL);
+    object_property_add_str(obj, "iommu", virt_get_iommu, virt_set_iommu);
     object_property_set_description(obj, "iommu",
                                     "Set the IOMMU type. "
                                     "Valid values are none and smmuv3");
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 878a275140..2f1820a773 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -385,8 +385,7 @@ static void create_virtio_regions(VersalVirt *s)
=20
         pic_irq =3D qdev_get_gpio_in(DEVICE(&s->soc.fpd.apu.gic), irq);
         dev =3D qdev_create(NULL, "virtio-mmio");
-        object_property_add_child(OBJECT(&s->soc), name, OBJECT(dev),
-                                  &error_fatal);
+        object_property_add_child(OBJECT(&s->soc), name, OBJECT(dev));
         qdev_init_nofail(dev);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
         mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index cb0122a3a6..9d82cc2536 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -44,7 +44,7 @@ static void versal_create_apu_cpus(Versal *s)
         }
=20
         name =3D g_strdup_printf("apu-cpu[%d]", i);
-        object_property_add_child(OBJECT(s), name, obj, &error_fatal);
+        object_property_add_child(OBJECT(s), name, obj);
         g_free(name);
=20
         object_property_set_int(obj, s->cfg.psci_conduit,
@@ -148,7 +148,7 @@ static void versal_create_uarts(Versal *s, qemu_irq *pi=
c)
         dev =3D qdev_create(NULL, TYPE_PL011);
         s->lpd.iou.uart[i] =3D SYS_BUS_DEVICE(dev);
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fat=
al);
+        object_property_add_child(OBJECT(s), name, OBJECT(dev));
         qdev_init_nofail(dev);
=20
         mr =3D sysbus_mmio_get_region(s->lpd.iou.uart[i], 0);
@@ -173,7 +173,7 @@ static void versal_create_gems(Versal *s, qemu_irq *pic=
)
=20
         dev =3D qdev_create(NULL, "cadence_gem");
         s->lpd.iou.gem[i] =3D SYS_BUS_DEVICE(dev);
-        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fat=
al);
+        object_property_add_child(OBJECT(s), name, OBJECT(dev));
         if (nd->used) {
             qemu_check_nic_model(nd, "cadence_gem");
             qdev_set_nic_properties(dev, nd);
@@ -205,7 +205,7 @@ static void versal_create_admas(Versal *s, qemu_irq *pi=
c)
=20
         dev =3D qdev_create(NULL, "xlnx.zdma");
         s->lpd.iou.adma[i] =3D SYS_BUS_DEVICE(dev);
-        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fat=
al);
+        object_property_add_child(OBJECT(s), name, OBJECT(dev));
         qdev_init_nofail(dev);
=20
         mr =3D sysbus_mmio_get_region(s->lpd.iou.adma[i], 0);
@@ -266,7 +266,7 @@ static void versal_unimp_area(Versal *s, const char *na=
me,
=20
     qdev_prop_set_string(dev, "name", name);
     qdev_prop_set_uint64(dev, "size", size);
-    object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
     qdev_init_nofail(dev);
=20
     mr_dev =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 09bd6c8b6d..a6b13f36cc 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -178,7 +178,7 @@ static void xlnx_zcu102_machine_instance_init(Object *o=
bj)
     /* Default to secure mode being disabled */
     s->secure =3D false;
     object_property_add_bool(obj, "secure", zcu102_get_secure,
-                             zcu102_set_secure, NULL);
+                             zcu102_set_secure);
     object_property_set_description(obj, "secure",
                                     "Set on/off to enable/disable the ARM =
"
                                     "Security Extensions (TrustZone)");
@@ -186,7 +186,7 @@ static void xlnx_zcu102_machine_instance_init(Object *o=
bj)
     /* Default to virt (EL2) being disabled */
     s->virt =3D false;
     object_property_add_bool(obj, "virtualization", zcu102_get_virt,
-                             zcu102_set_virt, NULL);
+                             zcu102_set_virt);
     object_property_set_description(obj, "virtualization",
                                     "Set on/off to enable/disable emulatin=
g a "
                                     "guest CPU which implements the ARM "
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index b84d153d56..f08abf60d7 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -554,8 +554,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error=
 **errp)
=20
         /* Alias controller SD bus to the SoC itself */
         bus_name =3D g_strdup_printf("sd-bus%d", i);
-        object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus",
-                                  &error_abort);
+        object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus");
         g_free(bus_name);
     }
=20
@@ -575,8 +574,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error=
 **errp)
         /* Alias controller SPI bus to the SoC itself */
         bus_name =3D g_strdup_printf("spi%d", i);
         object_property_add_alias(OBJECT(s), bus_name,
-                                  OBJECT(&s->spi[i]), "spi0",
-                                  &error_abort);
+                                  OBJECT(&s->spi[i]), "spi0");
         g_free(bus_name);
     }
=20
@@ -597,8 +595,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error=
 **errp)
         bus_name =3D g_strdup_printf("qspi%d", i);
         target_bus =3D g_strdup_printf("spi%d", i);
         object_property_add_alias(OBJECT(s), bus_name,
-                                  OBJECT(&s->qspi), target_bus,
-                                  &error_abort);
+                                  OBJECT(&s->qspi), target_bus);
         g_free(bus_name);
         g_free(target_bus);
     }
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 883ef74c8b..8dfacec693 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -259,7 +259,7 @@ static void mv88w8618_audio_init(Object *obj)
     object_property_add_link(OBJECT(dev), "wm8750", TYPE_WM8750,
                              (Object **) &s->wm,
                              qdev_prop_allow_set_link_before_realize,
-                             0, &error_abort);
+                             0);
 }
=20
 static void mv88w8618_audio_realize(DeviceState *dev, Error **errp)
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index 29dc00bf8d..c37a387861 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -175,7 +175,7 @@ static void pcspk_initfn(Object *obj)
     object_property_add_link(obj, "pit", TYPE_PIT_COMMON,
                              (Object **)&s->pit,
                              qdev_prop_allow_set_link_before_realize,
-                             0, &error_abort);
+                             0);
 }
=20
 static void pcspk_realizefn(DeviceState *dev, Error **errp)
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 3dc0a825f0..4a57ae107e 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -122,7 +122,7 @@ static void qbus_realize(BusState *bus, DeviceState *pa=
rent, const char *name)
     if (bus->parent) {
         QLIST_INSERT_HEAD(&bus->parent->child_bus, bus, sibling);
         bus->parent->num_child_bus++;
-        object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(b=
us), NULL);
+        object_property_add_child(OBJECT(bus->parent), bus->name, OBJECT(b=
us));
         object_unref(OBJECT(bus));
     } else {
         /* The only bus without a parent is the main system bus */
@@ -215,10 +215,9 @@ static void qbus_initfn(Object *obj)
                              TYPE_HOTPLUG_HANDLER,
                              (Object **)&bus->hotplug_handler,
                              object_property_allow_set_link,
-                             0,
-                             NULL);
+                             0);
     object_property_add_bool(obj, "realized",
-                             bus_get_realized, bus_set_realized, NULL);
+                             bus_get_realized, bus_set_realized);
 }
=20
 static char *default_bus_get_fw_dev_path(DeviceState *dev)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 39310acf36..135b422608 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -784,82 +784,78 @@ static void machine_class_init(ObjectClass *oc, void =
*data)
     mc->numa_auto_assign_ram =3D numa_default_auto_assign_ram;
=20
     object_class_property_add_str(oc, "kernel",
-        machine_get_kernel, machine_set_kernel, &error_abort);
+        machine_get_kernel, machine_set_kernel);
     object_class_property_set_description(oc, "kernel",
         "Linux kernel image file");
=20
     object_class_property_add_str(oc, "initrd",
-        machine_get_initrd, machine_set_initrd, &error_abort);
+        machine_get_initrd, machine_set_initrd);
     object_class_property_set_description(oc, "initrd",
         "Linux initial ramdisk file");
=20
     object_class_property_add_str(oc, "append",
-        machine_get_append, machine_set_append, &error_abort);
+        machine_get_append, machine_set_append);
     object_class_property_set_description(oc, "append",
         "Linux kernel command line");
=20
     object_class_property_add_str(oc, "dtb",
-        machine_get_dtb, machine_set_dtb, &error_abort);
+        machine_get_dtb, machine_set_dtb);
     object_class_property_set_description(oc, "dtb",
         "Linux kernel device tree file");
=20
     object_class_property_add_str(oc, "dumpdtb",
-        machine_get_dumpdtb, machine_set_dumpdtb, &error_abort);
+        machine_get_dumpdtb, machine_set_dumpdtb);
     object_class_property_set_description(oc, "dumpdtb",
         "Dump current dtb to a file and quit");
=20
     object_class_property_add(oc, "phandle-start", "int",
         machine_get_phandle_start, machine_set_phandle_start,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, "phandle-start",
         "The first phandle ID we may generate dynamically");
=20
     object_class_property_add_str(oc, "dt-compatible",
-        machine_get_dt_compatible, machine_set_dt_compatible, &error_abort=
);
+        machine_get_dt_compatible, machine_set_dt_compatible);
     object_class_property_set_description(oc, "dt-compatible",
         "Overrides the \"compatible\" property of the dt root node");
=20
     object_class_property_add_bool(oc, "dump-guest-core",
-        machine_get_dump_guest_core, machine_set_dump_guest_core, &error_a=
bort);
+        machine_get_dump_guest_core, machine_set_dump_guest_core);
     object_class_property_set_description(oc, "dump-guest-core",
         "Include guest memory in a core dump");
=20
     object_class_property_add_bool(oc, "mem-merge",
-        machine_get_mem_merge, machine_set_mem_merge, &error_abort);
+        machine_get_mem_merge, machine_set_mem_merge);
     object_class_property_set_description(oc, "mem-merge",
         "Enable/disable memory merge support");
=20
     object_class_property_add_bool(oc, "usb",
-        machine_get_usb, machine_set_usb, &error_abort);
+        machine_get_usb, machine_set_usb);
     object_class_property_set_description(oc, "usb",
         "Set on/off to enable/disable usb");
=20
     object_class_property_add_bool(oc, "graphics",
-        machine_get_graphics, machine_set_graphics, &error_abort);
+        machine_get_graphics, machine_set_graphics);
     object_class_property_set_description(oc, "graphics",
         "Set on/off to enable/disable graphics emulation");
=20
     object_class_property_add_str(oc, "firmware",
-        machine_get_firmware, machine_set_firmware,
-        &error_abort);
+        machine_get_firmware, machine_set_firmware);
     object_class_property_set_description(oc, "firmware",
         "Firmware image");
=20
     object_class_property_add_bool(oc, "suppress-vmdesc",
-        machine_get_suppress_vmdesc, machine_set_suppress_vmdesc,
-        &error_abort);
+        machine_get_suppress_vmdesc, machine_set_suppress_vmdesc);
     object_class_property_set_description(oc, "suppress-vmdesc",
         "Set on to disable self-describing migration");
=20
     object_class_property_add_bool(oc, "enforce-config-section",
-        machine_get_enforce_config_section, machine_set_enforce_config_sec=
tion,
-        &error_abort);
+        machine_get_enforce_config_section, machine_set_enforce_config_sec=
tion);
     object_class_property_set_description(oc, "enforce-config-section",
         "Set on to enforce configuration section migration");
=20
     object_class_property_add_str(oc, "memory-encryption",
-        machine_get_memory_encryption, machine_set_memory_encryption,
-        &error_abort);
+        machine_get_memory_encryption, machine_set_memory_encryption);
     object_class_property_set_description(oc, "memory-encryption",
         "Set memory encryption object to use");
 }
@@ -890,16 +886,14 @@ static void machine_initfn(Object *obj)
=20
         ms->nvdimms_state =3D g_new0(NVDIMMState, 1);
         object_property_add_bool(obj, "nvdimm",
-                                 machine_get_nvdimm, machine_set_nvdimm,
-                                 &error_abort);
+                                 machine_get_nvdimm, machine_set_nvdimm);
         object_property_set_description(obj, "nvdimm",
                                         "Set on/off to enable/disable "
                                         "NVDIMM instantiation");
=20
         object_property_add_str(obj, "nvdimm-persistence",
                                 machine_get_nvdimm_persistence,
-                                machine_set_nvdimm_persistence,
-                                &error_abort);
+                                machine_set_nvdimm_persistence);
         object_property_set_description(obj, "nvdimm-persistence",
                                         "Set NVDIMM persistence"
                                         "Valid values are cpu, mem-ctrl");
@@ -908,8 +902,7 @@ static void machine_initfn(Object *obj)
     if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
         ms->numa_state =3D g_new0(NumaState, 1);
         object_property_add_bool(obj, "hmat",
-                                 machine_get_hmat, machine_set_hmat,
-                                 &error_abort);
+                                 machine_get_hmat, machine_set_hmat);
         object_property_set_description(obj, "hmat",
                                         "Set on/off to enable/disable "
                                         "ACPI Heterogeneous Memory Attribu=
te "
@@ -917,8 +910,7 @@ static void machine_initfn(Object *obj)
     }
=20
     object_property_add_str(obj, "memory-backend",
-                            machine_get_memdev, machine_set_memdev,
-                            &error_abort);
+                            machine_get_memdev, machine_set_memdev);
     object_property_set_description(obj, "memory-backend",
                                     "Set RAM backend"
                                     "Valid value is ID of hostmem based ba=
ckend");
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 2047114fca..2f294ec4a4 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1043,11 +1043,7 @@ static void set_prop_arraylen(Object *obj, Visitor *=
v, const char *name,
                             arrayprop->prop.info->get,
                             arrayprop->prop.info->set,
                             array_element_release,
-                            arrayprop, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
+                            arrayprop);
     }
 }
=20
@@ -1259,8 +1255,7 @@ static void create_link_property(ObjectClass *oc, Pro=
perty *prop, Error **errp)
     object_class_property_add_link(oc, prop->name, prop->link_type,
                                    prop->offset,
                                    qdev_prop_allow_set_link_before_realize=
,
-                                   OBJ_PROP_LINK_STRONG,
-                                   errp);
+                                   OBJ_PROP_LINK_STRONG);
 }
=20
 const PropertyInfo qdev_prop_link =3D {
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 888a1de931..c18bbe24fe 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -90,8 +90,7 @@ static void bus_add_child(BusState *bus, DeviceState *chi=
ld)
                              object_get_typename(OBJECT(child)),
                              (Object **)&kid->child,
                              NULL, /* read-only property */
-                             0, /* return ownership on prop deletion */
-                             NULL);
+                             0);
 }
=20
 void qdev_set_parent_bus(DeviceState *dev, BusState *bus)
@@ -480,7 +479,7 @@ void qdev_init_gpio_in_named_with_opaque(DeviceState *d=
ev,
         gchar *propname =3D g_strdup_printf("%s[%u]", name, i);
=20
         object_property_add_child(OBJECT(dev), propname,
-                                  OBJECT(gpio_list->in[i]), &error_abort);
+                                  OBJECT(gpio_list->in[i]));
         g_free(propname);
     }
=20
@@ -511,8 +510,7 @@ void qdev_init_gpio_out_named(DeviceState *dev, qemu_ir=
q *pins,
         object_property_add_link(OBJECT(dev), propname, TYPE_IRQ,
                                  (Object **)&pins[i],
                                  object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG,
-                                 &error_abort);
+                                 OBJ_PROP_LINK_STRONG);
         g_free(propname);
     }
     gpio_list->num_out +=3D n;
@@ -545,8 +543,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev, cons=
t char *name, int n,
         /* We need a name for object_property_set_link to work */
         object_property_add_child(container_get(qdev_get_machine(),
                                                 "/unattached"),
-                                  "non-qdev-gpio[*]", OBJECT(pin),
-                                  &error_abort);
+                                  "non-qdev-gpio[*]", OBJECT(pin));
     }
     object_property_set_link(OBJECT(dev), OBJECT(pin), propname, &error_ab=
ort);
     g_free(propname);
@@ -604,8 +601,7 @@ void qdev_pass_gpios(DeviceState *dev, DeviceState *con=
tainer,
         char *propname =3D g_strdup_printf("%s[%d]", nm, i);
=20
         object_property_add_alias(OBJECT(container), propname,
-                                  OBJECT(dev), propname,
-                                  &error_abort);
+                                  OBJECT(dev), propname);
         g_free(propname);
     }
     for (i =3D 0; i < ngl->num_out; i++) {
@@ -613,8 +609,7 @@ void qdev_pass_gpios(DeviceState *dev, DeviceState *con=
tainer,
         char *propname =3D g_strdup_printf("%s[%d]", nm, i);
=20
         object_property_add_alias(OBJECT(container), propname,
-                                  OBJECT(dev), propname,
-                                  &error_abort);
+                                  OBJECT(dev), propname);
         g_free(propname);
     }
     QLIST_REMOVE(ngl, node);
@@ -755,7 +750,7 @@ static void qdev_class_add_legacy_property(DeviceClass =
*dc, Property *prop)
     name =3D g_strdup_printf("legacy-%s", prop->name);
     object_class_property_add(OBJECT_CLASS(dc), name, "str",
         prop->info->print ? qdev_get_legacy_property : prop->info->get,
-        NULL, NULL, prop, &error_abort);
+        NULL, NULL, prop);
 }
=20
 void qdev_property_add_static(DeviceState *dev, Property *prop)
@@ -768,7 +763,7 @@ void qdev_property_add_static(DeviceState *dev, Propert=
y *prop)
     op =3D object_property_add(obj, prop->name, prop->info->name,
                              prop->info->get, prop->info->set,
                              prop->info->release,
-                             prop, &error_abort);
+                             prop);
=20
     object_property_set_description(obj, prop->name,
                                     prop->info->description);
@@ -794,7 +789,7 @@ static void qdev_class_add_property(DeviceClass *klass,=
 Property *prop)
                                        prop->name, prop->info->name,
                                        prop->info->get, prop->info->set,
                                        prop->info->release,
-                                       prop, &error_abort);
+                                       prop);
         if (prop->set_default) {
             prop->info->set_default_value(op, prop);
         }
@@ -817,8 +812,7 @@ void qdev_alias_all_properties(DeviceState *target, Obj=
ect *source)
=20
         for (prop =3D dc->props_; prop && prop->name; prop++) {
             object_property_add_alias(source, prop->name,
-                                      OBJECT(target), prop->name,
-                                      &error_abort);
+                                      OBJECT(target), prop->name);
         }
         class =3D object_class_get_parent(class);
     } while (class !=3D object_class_by_name(TYPE_DEVICE));
@@ -869,7 +863,7 @@ static void device_set_realized(Object *obj, bool value=
, Error **errp)
=20
             object_property_add_child(container_get(qdev_get_machine(),
                                                     "/unattached"),
-                                      name, obj, &error_abort);
+                                      name, obj);
             unattached_parent =3D true;
             g_free(name);
         }
@@ -1186,17 +1180,13 @@ static void device_class_init(ObjectClass *class, v=
oid *data)
     rc->get_transitional_function =3D device_get_transitional_reset;
=20
     object_class_property_add_bool(class, "realized",
-                                   device_get_realized, device_set_realize=
d,
-                                   &error_abort);
+                                   device_get_realized, device_set_realize=
d);
     object_class_property_add_bool(class, "hotpluggable",
-                                   device_get_hotpluggable, NULL,
-                                   &error_abort);
+                                   device_get_hotpluggable, NULL);
     object_class_property_add_bool(class, "hotplugged",
-                                   device_get_hotplugged, NULL,
-                                   &error_abort);
+                                   device_get_hotplugged, NULL);
     object_class_property_add_link(class, "parent_bus", TYPE_BUS,
-                                   offsetof(DeviceState, parent_bus), NULL=
, 0,
-                                   &error_abort);
+                                   offsetof(DeviceState, parent_bus), NULL=
, 0);
 }
=20
 void device_class_set_props(DeviceClass *dc, Property *props)
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 9874c5c870..a92ac597ca 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -76,9 +76,9 @@ static void cpu_core_instance_init(Object *obj)
     CPUCore *core =3D CPU_CORE(obj);
=20
     object_property_add(obj, "core-id", "int", core_prop_get_core_id,
-                        core_prop_set_core_id, NULL, NULL, NULL);
+                        core_prop_set_core_id, NULL, NULL);
     object_property_add(obj, "nr-threads", "int", core_prop_get_nr_threads=
,
-                        core_prop_set_nr_threads, NULL, NULL, NULL);
+                        core_prop_set_nr_threads, NULL, NULL);
     core->nr_threads =3D ms->smp.threads;
 }
=20
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 70eb619ef4..f960fd4994 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -331,8 +331,7 @@ static void bochs_display_init(Object *obj)
     /* Expose framebuffer byteorder via QOM */
     object_property_add_bool(obj, "big-endian-framebuffer",
                              bochs_display_get_big_endian_fb,
-                             bochs_display_set_big_endian_fb,
-                             NULL);
+                             bochs_display_set_big_endian_fb);
=20
     dev->cap_present |=3D QEMU_PCI_CAP_EXPRESS;
 }
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index de0ab9d977..296cd56c4a 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -2011,7 +2011,7 @@ static void sm501_sysbus_init(Object *o)
     qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN);
=20
     object_property_add_alias(o, "chardev",
-                              OBJECT(smm), "chardev", &error_abort);
+                              OBJECT(smm), "chardev");
 }
=20
 static const TypeInfo sm501_sysbus_info =3D {
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 6b9db86e36..a640fd866d 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -270,7 +270,7 @@ static void pci_std_vga_init(Object *obj)
 {
     /* Expose framebuffer byteorder via QOM */
     object_property_add_bool(obj, "big-endian-framebuffer",
-                             vga_get_big_endian_fb, vga_set_big_endian_fb,=
 NULL);
+                             vga_get_big_endian_fb, vga_set_big_endian_fb)=
;
 }
=20
 static void pci_secondary_vga_realize(PCIDevice *dev, Error **errp)
@@ -321,7 +321,7 @@ static void pci_secondary_vga_init(Object *obj)
 {
     /* Expose framebuffer byteorder via QOM */
     object_property_add_bool(obj, "big-endian-framebuffer",
-                             vga_get_big_endian_fb, vga_set_big_endian_fb,=
 NULL);
+                             vga_get_big_endian_fb, vga_set_big_endian_fb)=
;
 }
=20
 static void pci_secondary_vga_reset(DeviceState *dev)
diff --git a/hw/display/vhost-user-gpu-pci.c b/hw/display/vhost-user-gpu-pc=
i.c
index 7d9b1f5a8c..23ce655e0f 100644
--- a/hw/display/vhost-user-gpu-pci.c
+++ b/hw/display/vhost-user-gpu-pci.c
@@ -32,8 +32,7 @@ static void vhost_user_gpu_pci_initfn(Object *obj)
     VIRTIO_GPU_PCI_BASE(obj)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
=20
     object_property_add_alias(obj, "chardev",
-                              OBJECT(&dev->vdev), "chardev",
-                              &error_abort);
+                              OBJECT(&dev->vdev), "chardev");
 }
=20
 static const VirtioPCIDeviceTypeInfo vhost_user_gpu_pci_info =3D {
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index f0c7c6fb9a..4cdaee1bde 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -512,7 +512,7 @@ vhost_user_gpu_instance_init(Object *obj)
=20
     g->vhost =3D VHOST_USER_BACKEND(object_new(TYPE_VHOST_USER_BACKEND));
     object_property_add_alias(obj, "chardev",
-                              OBJECT(g->vhost), "chardev", &error_abort);
+                              OBJECT(g->vhost), "chardev");
 }
=20
 static void
diff --git a/hw/display/vhost-user-vga.c b/hw/display/vhost-user-vga.c
index a7195276d9..1690f6b610 100644
--- a/hw/display/vhost-user-vga.c
+++ b/hw/display/vhost-user-vga.c
@@ -33,8 +33,7 @@ static void vhost_user_vga_inst_initfn(Object *obj)
     VIRTIO_VGA_BASE(dev)->vgpu =3D VIRTIO_GPU_BASE(&dev->vdev);
=20
     object_property_add_alias(obj, "chardev",
-                              OBJECT(&dev->vdev), "chardev",
-                              &error_abort);
+                              OBJECT(&dev->vdev), "chardev");
 }
=20
 static const VirtioPCIDeviceTypeInfo vhost_user_vga_info =3D {
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 7058443797..3e5fb44e06 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1237,8 +1237,7 @@ static void xlnx_dp_init(Object *obj)
     object_property_add_link(obj, "dpdma", TYPE_XLNX_DPDMA,
                              (Object **) &s->dpdma,
                              xlnx_dp_set_dpdma,
-                             OBJ_PROP_LINK_STRONG,
-                             &error_abort);
+                             OBJ_PROP_LINK_STRONG);
=20
     /*
      * Initialize AUX Bus.
@@ -1249,11 +1248,11 @@ static void xlnx_dp_init(Object *obj)
      * Initialize DPCD and EDID..
      */
     s->dpcd =3D DPCD(aux_create_slave(s->aux_bus, "dpcd"));
-    object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd), NULL);
+    object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd));
=20
     s->edid =3D I2CDDC(qdev_create(BUS(aux_get_i2c_bus(s->aux_bus)), "i2c-=
ddc"));
     i2c_set_slave_address(I2C_SLAVE(s->edid), 0x50);
-    object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid), NULL);
+    object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid));
=20
     fifo8_create(&s->rx_fifo, 16);
     fifo8_create(&s->tx_fifo, 16);
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 3e4da0c47f..84b9c5dc77 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -264,7 +264,7 @@ static void sparc32_dma_device_init(Object *obj)
     object_property_add_link(OBJECT(dev), "iommu", TYPE_SUN4M_IOMMU,
                              (Object **) &s->iommu,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     qdev_init_gpio_in(dev, dma_set_irq, 1);
     qdev_init_gpio_out(dev, s->gpio, 2);
@@ -302,7 +302,7 @@ static void sparc32_espdma_device_realize(DeviceState *=
dev, Error **errp)
     ESPState *esp;
=20
     d =3D qdev_create(NULL, TYPE_ESP);
-    object_property_add_child(OBJECT(dev), "esp", OBJECT(d), errp);
+    object_property_add_child(OBJECT(dev), "esp", OBJECT(d));
     sysbus =3D ESP_STATE(d);
     esp =3D &sysbus->esp;
     esp->dma_memory_read =3D espdma_memory_read;
@@ -344,7 +344,7 @@ static void sparc32_ledma_device_realize(DeviceState *d=
ev, Error **errp)
     qemu_check_nic_model(nd, TYPE_LANCE);
=20
     d =3D qdev_create(NULL, TYPE_LANCE);
-    object_property_add_child(OBJECT(dev), "lance", OBJECT(d), errp);
+    object_property_add_child(OBJECT(dev), "lance", OBJECT(d));
     qdev_set_nic_properties(d, nd);
     object_property_set_link(OBJECT(d), OBJECT(dev), "dma", errp);
     qdev_init_nofail(d);
@@ -380,7 +380,7 @@ static void sparc32_dma_realize(DeviceState *dev, Error=
 **errp)
=20
     espdma =3D qdev_create(NULL, TYPE_SPARC32_ESPDMA_DEVICE);
     object_property_set_link(OBJECT(espdma), iommu, "iommu", errp);
-    object_property_add_child(OBJECT(s), "espdma", OBJECT(espdma), errp);
+    object_property_add_child(OBJECT(s), "espdma", OBJECT(espdma));
     qdev_init_nofail(espdma);
=20
     esp =3D DEVICE(object_resolve_path_component(OBJECT(espdma), "esp"));
@@ -395,7 +395,7 @@ static void sparc32_dma_realize(DeviceState *dev, Error=
 **errp)
=20
     ledma =3D qdev_create(NULL, TYPE_SPARC32_LEDMA_DEVICE);
     object_property_set_link(OBJECT(ledma), iommu, "iommu", errp);
-    object_property_add_child(OBJECT(s), "ledma", OBJECT(ledma), errp);
+    object_property_add_child(OBJECT(s), "ledma", OBJECT(ledma));
     qdev_init_nofail(ledma);
=20
     lance =3D DEVICE(object_resolve_path_component(OBJECT(ledma), "lance")=
);
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 018f36991b..08396d7942 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -529,16 +529,11 @@ static void xilinx_axidma_realize(DeviceState *dev, E=
rror **errp)
     object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
                              (Object **)&ds->dma,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG,
-                             &local_err);
+                             OBJ_PROP_LINK_STRONG);
     object_property_add_link(OBJECT(cs), "dma", TYPE_XILINX_AXI_DMA,
                              (Object **)&cs->dma,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG,
-                             &local_err);
-    if (local_err) {
-        goto xilinx_axidma_realize_fail;
-    }
+                             OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(ds), OBJECT(s), "dma", &local_err);
     object_property_set_link(OBJECT(cs), OBJECT(s), "dma", &local_err);
     if (local_err) {
diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 880630a0b0..6151ade754 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -790,8 +790,7 @@ static void zdma_init(Object *obj)
     object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
                              (Object **)&s->dma_mr,
                              qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG,
-                             &error_abort);
+                             OBJ_PROP_LINK_STRONG);
 }
=20
 static const VMStateDescription vmstate_zdma =3D {
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index e52fcfd9a0..61b6c22cb0 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -873,7 +873,7 @@ static void aspeed_gpio_init(Object *obj)
         name =3D g_strdup_printf("gpio%s%d", props->group_label[group_idx]=
,
                                pin_idx % GPIOS_PER_GROUP);
         object_property_add(obj, name, "bool", aspeed_gpio_get_pin,
-                            aspeed_gpio_set_pin, NULL, NULL, NULL);
+                            aspeed_gpio_set_pin, NULL, NULL);
         g_free(name);
     }
 }
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 8ca3706f5b..940d049b44 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -130,7 +130,7 @@ void hyperv_synic_add(CPUState *cs)
     obj =3D object_new(TYPE_SYNIC);
     synic =3D SYNIC(obj);
     synic->cs =3D cs;
-    object_property_add_child(OBJECT(cs), "synic", obj, &error_abort);
+    object_property_add_child(OBJECT(cs), "synic", obj);
     object_unref(obj);
     object_property_set_bool(obj, true, "realized", &error_abort);
 }
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 76aaa7a8d8..937db10ae6 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -510,42 +510,39 @@ static void microvm_class_init(ObjectClass *oc, void =
*data)
     object_class_property_add(oc, MICROVM_MACHINE_PIC, "OnOffAuto",
                               microvm_machine_get_pic,
                               microvm_machine_set_pic,
-                              NULL, NULL, &error_abort);
+                              NULL, NULL);
     object_class_property_set_description(oc, MICROVM_MACHINE_PIC,
         "Enable i8259 PIC");
=20
     object_class_property_add(oc, MICROVM_MACHINE_PIT, "OnOffAuto",
                               microvm_machine_get_pit,
                               microvm_machine_set_pit,
-                              NULL, NULL, &error_abort);
+                              NULL, NULL);
     object_class_property_set_description(oc, MICROVM_MACHINE_PIT,
         "Enable i8254 PIT");
=20
     object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
                               microvm_machine_get_rtc,
                               microvm_machine_set_rtc,
-                              NULL, NULL, &error_abort);
+                              NULL, NULL);
     object_class_property_set_description(oc, MICROVM_MACHINE_RTC,
         "Enable MC146818 RTC");
=20
     object_class_property_add_bool(oc, MICROVM_MACHINE_ISA_SERIAL,
                                    microvm_machine_get_isa_serial,
-                                   microvm_machine_set_isa_serial,
-                                   &error_abort);
+                                   microvm_machine_set_isa_serial);
     object_class_property_set_description(oc, MICROVM_MACHINE_ISA_SERIAL,
         "Set off to disable the instantiation an ISA serial port");
=20
     object_class_property_add_bool(oc, MICROVM_MACHINE_OPTION_ROMS,
                                    microvm_machine_get_option_roms,
-                                   microvm_machine_set_option_roms,
-                                   &error_abort);
+                                   microvm_machine_set_option_roms);
     object_class_property_set_description(oc, MICROVM_MACHINE_OPTION_ROMS,
         "Set off to disable loading option ROMs");
=20
     object_class_property_add_bool(oc, MICROVM_MACHINE_AUTO_KERNEL_CMDLINE=
,
                                    microvm_machine_get_auto_kernel_cmdline=
,
-                                   microvm_machine_set_auto_kernel_cmdline=
,
-                                   &error_abort);
+                                   microvm_machine_set_auto_kernel_cmdline=
);
     object_class_property_set_description(oc,
         MICROVM_MACHINE_AUTO_KERNEL_CMDLINE,
         "Set off to disable adding virtio-mmio devices to the kernel cmdli=
ne");
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 88298d421c..fc77916381 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -658,7 +658,7 @@ void pc_cmos_init(PCMachineState *pcms,
                              TYPE_ISA_DEVICE,
                              (Object **)&x86ms->rtc,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG, &error_abort);
+                             OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(pcms), OBJECT(s),
                              "rtc_state", &error_abort);
=20
@@ -1961,22 +1961,22 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
=20
     object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
         pc_machine_get_device_memory_region_size, NULL,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
=20
     object_class_property_add(oc, PC_MACHINE_VMPORT, "OnOffAuto",
         pc_machine_get_vmport, pc_machine_set_vmport,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, PC_MACHINE_VMPORT,
         "Enable vmport (pc & q35)");
=20
     object_class_property_add_bool(oc, PC_MACHINE_SMBUS,
-        pc_machine_get_smbus, pc_machine_set_smbus, &error_abort);
+        pc_machine_get_smbus, pc_machine_set_smbus);
=20
     object_class_property_add_bool(oc, PC_MACHINE_SATA,
-        pc_machine_get_sata, pc_machine_set_sata, &error_abort);
+        pc_machine_get_sata, pc_machine_set_sata);
=20
     object_class_property_add_bool(oc, PC_MACHINE_PIT,
-        pc_machine_get_pit, pc_machine_set_pit, &error_abort);
+        pc_machine_get_pit, pc_machine_set_pit);
 }
=20
 static const TypeInfo pc_machine_info =3D {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 22dee0e76c..6c7459fd4c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -290,7 +290,7 @@ static void pc_init1(MachineState *machine,
                                  TYPE_HOTPLUG_HANDLER,
                                  (Object **)&pcms->acpi_dev,
                                  object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG, &error_abort);
+                                 OBJ_PROP_LINK_STRONG);
         object_property_set_link(OBJECT(machine), OBJECT(piix4_pm),
                                  PC_MACHINE_ACPI_DEVICE_PROP, &error_abort=
);
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d37c425e22..c08a69d50e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -213,7 +213,7 @@ static void pc_q35_init(MachineState *machine)
     /* create pci host bus */
     q35_host =3D Q35_HOST_DEVICE(qdev_create(NULL, TYPE_Q35_HOST_DEVICE));
=20
-    object_property_add_child(qdev_get_machine(), "q35", OBJECT(q35_host),=
 NULL);
+    object_property_add_child(qdev_get_machine(), "q35", OBJECT(q35_host))=
;
     object_property_set_link(OBJECT(q35_host), OBJECT(ram_memory),
                              MCH_HOST_PROP_RAM_MEM, NULL);
     object_property_set_link(OBJECT(q35_host), OBJECT(pci_memory),
@@ -239,7 +239,7 @@ static void pc_q35_init(MachineState *machine)
                              TYPE_HOTPLUG_HANDLER,
                              (Object **)&pcms->acpi_dev,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG, &error_abort);
+                             OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(machine), OBJECT(lpc),
                              PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
=20
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index f5f3f466b0..002133a2d8 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -90,10 +90,9 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcm=
s,
     qdev_prop_set_uint64(dev, "sector-length", FLASH_SECTOR_SIZE);
     qdev_prop_set_uint8(dev, "width", 1);
     qdev_prop_set_string(dev, "name", name);
-    object_property_add_child(OBJECT(pcms), name, OBJECT(dev),
-                              &error_abort);
+    object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
     object_property_add_alias(OBJECT(pcms), alias_prop_name,
-                              OBJECT(dev), "drive", &error_abort);
+                              OBJECT(dev), "drive");
     return PFLASH_CFI01(dev);
 }
=20
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index e2bf601273..7a3bc7ab66 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -350,7 +350,7 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *p=
arent_name)
         dev =3D qdev_create(NULL, TYPE_IOAPIC);
     }
     object_property_add_child(object_resolve_path(parent_name, NULL),
-                              "ioapic", OBJECT(dev), NULL);
+                              "ioapic", OBJECT(dev));
     qdev_init_nofail(dev);
     d =3D SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(d, 0, IO_APIC_DEFAULT_ADDRESS);
@@ -982,19 +982,19 @@ static void x86_machine_class_init(ObjectClass *oc, v=
oid *data)
=20
     object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
         x86_machine_get_max_ram_below_4g, x86_machine_set_max_ram_below_4g=
,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, X86_MACHINE_MAX_RAM_BELOW_4G=
,
         "Maximum ram below the 4G boundary (32bit boundary)");
=20
     object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
         x86_machine_get_smm, x86_machine_set_smm,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, X86_MACHINE_SMM,
         "Enable SMM");
=20
     object_class_property_add(oc, X86_MACHINE_ACPI, "OnOffAuto",
         x86_machine_get_acpi, x86_machine_set_acpi,
-        NULL, NULL, &error_abort);
+        NULL, NULL);
     object_class_property_set_description(oc, X86_MACHINE_ACPI,
         "Enable ACPI");
 }
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index a9f25e5d02..30af0e93e6 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -459,7 +459,7 @@ static void macio_ide_initfn(Object *obj)
=20
     object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
                              (Object **) &s->dbdma,
-                             qdev_prop_allow_set_link_before_realize, 0, N=
ULL);
+                             qdev_prop_allow_set_link_before_realize, 0);
 }
=20
 static Property macio_ide_properties[] =3D {
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index c22afdb8ee..4909b14b91 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -266,7 +266,7 @@ static void ide_dev_instance_init(Object *obj)
 {
     object_property_add(obj, "bootindex", "int32",
                         ide_dev_get_bootindex,
-                        ide_dev_set_bootindex, NULL, NULL, NULL);
+                        ide_dev_set_bootindex, NULL, NULL);
     object_property_set_int(obj, -1, "bootindex", NULL);
 }
=20
diff --git a/hw/input/vhost-user-input.c b/hw/input/vhost-user-input.c
index 544452a234..63984a8ba7 100644
--- a/hw/input/vhost-user-input.c
+++ b/hw/input/vhost-user-input.c
@@ -101,7 +101,7 @@ static void vhost_input_init(Object *obj)
=20
     vhi->vhost =3D VHOST_USER_BACKEND(object_new(TYPE_VHOST_USER_BACKEND))=
;
     object_property_add_alias(obj, "chardev",
-                              OBJECT(vhi->vhost), "chardev", &error_abort)=
;
+                              OBJECT(vhi->vhost), "chardev");
 }
=20
 static void vhost_input_finalize(Object *obj)
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 9ec0f2deb2..243bb69430 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -445,7 +445,7 @@ static void apic_common_initfn(Object *obj)
     s->id =3D s->initial_apic_id =3D -1;
     object_property_add(obj, "id", "uint32",
                         apic_common_get_id,
-                        apic_common_set_id, NULL, NULL, NULL);
+                        apic_common_set_id, NULL, NULL);
 }
=20
 static void apic_common_class_init(ObjectClass *klass, void *data)
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index 5f290f5410..baca4d8a2d 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -65,11 +65,11 @@ void s390_flic_init(void)
     if (kvm_enabled()) {
         dev =3D qdev_create(NULL, TYPE_KVM_S390_FLIC);
         object_property_add_child(qdev_get_machine(), TYPE_KVM_S390_FLIC,
-                                  OBJECT(dev), NULL);
+                                  OBJECT(dev));
     } else {
         dev =3D qdev_create(NULL, TYPE_QEMU_S390_FLIC);
         object_property_add_child(qdev_get_machine(), TYPE_QEMU_S390_FLIC,
-                                  OBJECT(dev), NULL);
+                                  OBJECT(dev));
     }
     qdev_init_nofail(dev);
 }
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index c5d507e707..e56d578841 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -380,7 +380,7 @@ Object *icp_create(Object *cpu, const char *type, XICSF=
abric *xi, Error **errp)
     Object *obj;
=20
     obj =3D object_new(type);
-    object_property_add_child(cpu, type, obj, &error_abort);
+    object_property_add_child(cpu, type, obj);
     object_unref(obj);
     object_property_set_link(obj, OBJECT(xi), ICP_PROP_XICS, &error_abort)=
;
     object_property_set_link(obj, cpu, ICP_PROP_CPU, &error_abort);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d6183f8ae4..8f2b4050cb 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -761,7 +761,7 @@ Object *xive_tctx_create(Object *cpu, XivePresenter *xp=
tr, Error **errp)
     Object *obj;
=20
     obj =3D object_new(TYPE_XIVE_TCTX);
-    object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
+    object_property_add_child(cpu, TYPE_XIVE_TCTX, obj);
     object_unref(obj);
     object_property_set_link(obj, cpu, "cpu", &error_abort);
     object_property_set_link(obj, OBJECT(xptr), "presenter", &error_abort)=
;
diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index 46c6a79527..8d35c9fdd6 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -105,8 +105,7 @@ void ipmi_bmc_find_and_link(Object *obj, Object **bmc)
 {
     object_property_add_link(obj, "bmc", TYPE_IPMI_BMC, bmc,
                              isa_ipmi_bmc_check,
-                             OBJ_PROP_LINK_STRONG,
-                             &error_abort);
+                             OBJ_PROP_LINK_STRONG);
 }
=20
 static Property ipmi_bmc_properties[] =3D {
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 0d9d848280..3dcdc234a4 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -62,8 +62,7 @@ static void isa_superio_realize(DeviceState *dev, Error *=
*errp)
                 qdev_prop_set_uint32(d, "irq", k->parallel.get_irq(sio, i)=
);
             }
             qdev_prop_set_chr(d, "chardev", chr);
-            object_property_add_child(OBJECT(sio), name, OBJECT(isa),
-                                      &error_abort);
+            object_property_add_child(OBJECT(dev), name, OBJECT(isa));
             qdev_init_nofail(d);
             sio->parallel[i] =3D isa;
             trace_superio_create_parallel(i,
@@ -102,8 +101,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
                 qdev_prop_set_uint32(d, "irq", k->serial.get_irq(sio, i));
             }
             qdev_prop_set_chr(d, "chardev", chr);
-            object_property_add_child(OBJECT(sio), name, OBJECT(isa),
-                                      &error_abort);
+            object_property_add_child(OBJECT(dev), name, OBJECT(isa));
             qdev_init_nofail(d);
             sio->serial[i] =3D isa;
             trace_superio_create_serial(i,
@@ -137,8 +135,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
             qdev_prop_set_drive(d, "driveB", blk_by_legacy_dinfo(drive),
                                 &error_fatal);
         }
-        object_property_add_child(OBJECT(sio), "isa-fdc", OBJECT(isa),
-                                  &error_abort);
+        object_property_add_child(OBJECT(sio), "isa-fdc", OBJECT(isa));
         qdev_init_nofail(d);
         sio->floppy =3D isa;
         trace_superio_create_floppy(0,
@@ -150,8 +147,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
=20
     /* Keyboard, mouse */
     isa =3D isa_create(bus, TYPE_I8042);
-    object_property_add_child(OBJECT(sio), TYPE_I8042, OBJECT(isa),
-                              &error_abort);
+    object_property_add_child(OBJECT(sio), TYPE_I8042, OBJECT(isa));
     qdev_init_nofail(DEVICE(isa));
     sio->kbc =3D isa;
=20
@@ -169,8 +165,7 @@ static void isa_superio_realize(DeviceState *dev, Error=
 **errp)
             qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
         }
         qdev_init_nofail(d);
-        object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa),
-                                  &error_abort);
+        object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa));
         sio->ide =3D isa;
         trace_superio_create_ide(0,
                                  k->ide.get_iobase ?
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index fbc3165d03..c975d46675 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -633,11 +633,11 @@ static void ich9_lpc_initfn(Object *obj)
     static const uint8_t acpi_disable_cmd =3D ICH9_APM_ACPI_DISABLE;
=20
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
-                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ, NULL)=
;
+                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CM=
D,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ, NU=
LL);
+                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_C=
MD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ, N=
ULL);
+                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
=20
     ich9_pm_add_properties(obj, &lpc->pm, NULL);
 }
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 8e426d24bb..c5adedcc69 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -110,10 +110,10 @@ static void nvdimm_init(Object *obj)
 {
     object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL=
,
-                        NULL, NULL);
+                        NULL);
=20
     object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid=
,
-                        nvdimm_set_uuid, NULL, NULL, NULL);
+                        nvdimm_set_uuid, NULL, NULL);
 }
=20
 static void nvdimm_finalize(Object *obj)
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 8f50b8afea..ab6d1b41b2 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -165,7 +165,7 @@ static void pc_dimm_get_size(Object *obj, Visitor *v, c=
onst char *name,
 static void pc_dimm_init(Object *obj)
 {
     object_property_add(obj, PC_DIMM_SIZE_PROP, "uint64", pc_dimm_get_size=
,
-                        NULL, NULL, NULL, &error_abort);
+                        NULL, NULL, NULL);
 }
=20
 static void pc_dimm_realize(DeviceState *dev, Error **errp)
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_=
ml605_mmu.c
index 0a2640c40b..536571db7f 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -138,10 +138,8 @@ petalogix_ml605_init(MachineState *machine)
     dma =3D qdev_create(NULL, "xlnx.axi-dma");
=20
     /* FIXME: attach to the sysbus instead */
-    object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth=
0),
-                              NULL);
-    object_property_add_child(qdev_get_machine(), "xilinx-dma", OBJECT(dma=
),
-                              NULL);
+    object_property_add_child(qdev_get_machine(), "xilinx-eth", OBJECT(eth=
0));
+    object_property_add_child(qdev_get_machine(), "xilinx-dma", OBJECT(dma=
));
=20
     ds =3D object_property_get_link(OBJECT(dma),
                                   "axistream-connected-target", NULL);
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 7b466bf19a..e4fbe45c63 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -255,7 +255,7 @@ static void aspeed_sdmc_initfn(Object *obj)
 {
     object_property_add(obj, "ram-size", "int",
                         aspeed_sdmc_get_ram_size, aspeed_sdmc_set_ram_size=
,
-                        NULL, NULL, NULL);
+                        NULL, NULL);
 }
=20
 static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index ff10f5b794..ec617e63f3 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -402,8 +402,7 @@ static void edu_instance_init(Object *obj)
=20
     edu->dma_mask =3D (1UL << 28) - 1;
     object_property_add_uint64_ptr(obj, "dma_mask",
-                                   &edu->dma_mask, OBJ_PROP_FLAG_READWRITE=
,
-                                   NULL);
+                                   &edu->dma_mask, OBJ_PROP_FLAG_READWRITE=
);
 }
=20
 static void edu_class_init(ObjectClass *class, void *data)
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 81343301b1..e05623d730 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -885,10 +885,10 @@ static void mac_via_realize(DeviceState *dev, Error *=
*errp)
     /* Pass through mos6522 output IRQs */
     ms =3D MOS6522(&m->mos6522_via1);
     object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),
-                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
+                              SYSBUS_DEVICE_GPIO_IRQ "[0]");
     ms =3D MOS6522(&m->mos6522_via2);
     object_property_add_alias(OBJECT(dev), "irq[1]", OBJECT(ms),
-                              SYSBUS_DEVICE_GPIO_IRQ "[0]", &error_abort);
+                              SYSBUS_DEVICE_GPIO_IRQ "[0]");
=20
     /* Pass through mos6522 input IRQs */
     qdev_pass_gpios(DEVICE(&m->mos6522_via1), dev, "via1-irq");
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 6cca6b27d6..0fef8fb335 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -170,7 +170,7 @@ static void macio_gpio_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     memory_region_init_io(&s->gpiomem, OBJECT(s), &macio_gpio_ops, obj,
                           "gpio", 0x30);
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 79222192e8..3779865ab2 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -241,7 +241,7 @@ static void macio_oldworld_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_HEATHROW,
                              (Object **) &os->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     macio_init_child_obj(s, "cuda", &s->cuda, sizeof(s->cuda), TYPE_CUDA);
=20
@@ -397,7 +397,7 @@ static void macio_newworld_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &ns->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     macio_init_child_obj(s, "gpio", &ns->gpio, sizeof(ns->gpio),
                          TYPE_MACIO_GPIO);
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index b8466a4a3f..5fa792846c 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -773,7 +773,7 @@ static void pmu_init(Object *obj)
     object_property_add_link(obj, "gpio", TYPE_MACIO_GPIO,
                              (Object **) &s->gpio,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     sysbus_init_child_obj(obj, "mos6522-pmu", &s->mos6522_pmu,
                           sizeof(s->mos6522_pmu), TYPE_MOS6522_PMU);
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index efd961e041..cac729e35a 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -298,7 +298,7 @@ static void pca9552_initfn(Object *obj)
=20
         name =3D g_strdup_printf("led%d", led);
         object_property_add(obj, name, "bool", pca9552_get_led, pca9552_se=
t_led,
-                            NULL, NULL, NULL);
+                            NULL, NULL);
         g_free(name);
     }
 }
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 75ddad3a12..58dbebca90 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -245,7 +245,7 @@ static void tmp105_initfn(Object *obj)
 {
     object_property_add(obj, "temperature", "int",
                         tmp105_get_temperature,
-                        tmp105_set_temperature, NULL, NULL, NULL);
+                        tmp105_set_temperature, NULL, NULL);
 }
=20
 static void tmp105_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index c0bc150bca..74864cd93d 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -347,16 +347,16 @@ static void tmp421_initfn(Object *obj)
 {
     object_property_add(obj, "temperature0", "int",
                         tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL, NULL);
+                        tmp421_set_temperature, NULL, NULL);
     object_property_add(obj, "temperature1", "int",
                         tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL, NULL);
+                        tmp421_set_temperature, NULL, NULL);
     object_property_add(obj, "temperature2", "int",
                         tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL, NULL);
+                        tmp421_set_temperature, NULL, NULL);
     object_property_add(obj, "temperature3", "int",
                         tmp421_get_temperature,
-                        tmp421_set_temperature, NULL, NULL, NULL);
+                        tmp421_set_temperature, NULL, NULL);
 }
=20
 static void tmp421_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 51ec5a072d..386dccd40a 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1586,8 +1586,7 @@ static void gem_init(Object *obj)
     object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
                              (Object **)&s->dma_mr,
                              qdev_prop_allow_set_link_before_realize,
-                             OBJ_PROP_LINK_STRONG,
-                             &error_abort);
+                             OBJ_PROP_LINK_STRONG);
 }
=20
 static const VMStateDescription vmstate_cadence_gem =3D {
diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 16861b8f9f..4b941370d0 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -282,7 +282,7 @@ static void kvaser_pci_instance_init(Object *obj)
     object_property_add_link(obj, "canbus", TYPE_CAN_BUS,
                              (Object **)&d->canbus,
                              qdev_prop_allow_set_link_before_realize,
-                             0, &error_abort);
+                             0);
 }
=20
 static void kvaser_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 965e252d9d..695e762a8d 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -219,11 +219,11 @@ static void mioe3680_pci_instance_init(Object *obj)
     object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
                              (Object **)&d->canbus[0],
                              qdev_prop_allow_set_link_before_realize,
-                             0, &error_abort);
+                             0);
     object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
                              (Object **)&d->canbus[1],
                              qdev_prop_allow_set_link_before_realize,
-                             0, &error_abort);
+                             0);
 }
=20
 static void mioe3680_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index 51b6540072..4218e63eb2 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -220,11 +220,11 @@ static void pcm3680i_pci_instance_init(Object *obj)
     object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
                              (Object **)&d->canbus[0],
                              qdev_prop_allow_set_link_before_realize,
-                             0, &error_abort);
+                             0);
     object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
                              (Object **)&d->canbus[1],
                              qdev_prop_allow_set_link_before_realize,
-                             0, &error_abort);
+                             0);
 }
=20
 static void pcm3680i_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index e744eff153..fdf8faa0d9 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -133,7 +133,7 @@ static void isa_ne2000_instance_init(Object *obj)
 {
     object_property_add(obj, "bootindex", "int32",
                         isa_ne2000_get_bootindex,
-                        isa_ne2000_set_bootindex, NULL, NULL, NULL);
+                        isa_ne2000_set_bootindex, NULL, NULL);
     object_property_set_int(obj, -1, "bootindex", NULL);
 }
 static const TypeInfo ne2000_isa_info =3D {
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 704788811a..40d3b01ede 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -956,16 +956,11 @@ static void xilinx_enet_realize(DeviceState *dev, Err=
or **errp)
     object_property_add_link(OBJECT(ds), "enet", "xlnx.axi-ethernet",
                              (Object **) &ds->enet,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG,
-                             &local_err);
+                             OBJ_PROP_LINK_STRONG);
     object_property_add_link(OBJECT(cs), "enet", "xlnx.axi-ethernet",
                              (Object **) &cs->enet,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG,
-                             &local_err);
-    if (local_err) {
-        goto xilinx_enet_realize_fail;
-    }
+                             OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(ds), OBJECT(s), "enet", &local_err);
     object_property_set_link(OBJECT(cs), OBJECT(s), "enet", &local_err);
     if (local_err) {
diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 33dc2bf511..4c60a27fb7 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -81,8 +81,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
=20
     /* Register: Internal Interrupt Controller (IIC) */
     dev =3D qdev_create(NULL, "altera,iic");
-    object_property_add_const_link(OBJECT(dev), "cpu", OBJECT(cpu),
-                                   &error_abort);
+    object_property_add_const_link(OBJECT(dev), "cpu", OBJECT(cpu));
     qdev_init_nofail(dev);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq[0]);
     for (i =3D 0; i < 32; i++) {
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 4be6c9d9fd..8dd50c2c72 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1105,7 +1105,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint3=
2_t dma_iobase,
     }
=20
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
-                              OBJECT(dev), NULL);
+                              OBJECT(dev));
     qdev_init_nofail(dev);
=20
     sbd =3D SYS_BUS_DEVICE(dev);
@@ -1145,7 +1145,7 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
     }
=20
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
-                              OBJECT(dev), NULL);
+                              OBJECT(dev));
     qdev_init_nofail(dev);
=20
     sbd =3D SYS_BUS_DEVICE(dev);
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 24ccdf6ceb..4b3af0c704 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -109,7 +109,7 @@ static void grackle_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_HEATHROW,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     sysbus_init_mmio(sbd, &phb->conf_mem);
     sysbus_init_mmio(sbd, &phb->data_mem);
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index d980c97049..0adbd77553 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -212,19 +212,19 @@ static void i440fx_pcihost_initfn(Object *obj)
=20
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
                         i440fx_pcihost_get_pci_hole_start,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL);
=20
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
                         i440fx_pcihost_get_pci_hole_end,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL);
=20
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
                         i440fx_pcihost_get_pci_hole64_start,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL);
=20
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
                         i440fx_pcihost_get_pci_hole64_end,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL);
 }
=20
 static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
@@ -275,7 +275,7 @@ PCIBus *i440fx_init(const char *host_type, const char *=
pci_type,
     b =3D pci_root_bus_new(dev, NULL, pci_address_space,
                          address_space_io, 0, TYPE_PCI_BUS);
     s->bus =3D b;
-    object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev), N=
ULL);
+    object_property_add_child(qdev_get_machine(), "i440fx", OBJECT(dev));
     qdev_init_nofail(dev);
=20
     d =3D pci_create_simple(b, 0, pci_type);
@@ -308,7 +308,7 @@ PCIBus *i440fx_init(const char *host_type, const char *=
pci_type,
     memory_region_set_enabled(&f->low_smram, true);
     memory_region_add_subregion(&f->smram, 0xa0000, &f->low_smram);
     object_property_add_const_link(qdev_get_machine(), "smram",
-                                   OBJECT(&f->smram), &error_abort);
+                                   OBJECT(&f->smram));
=20
     init_pam(dev, f->ram_memory, f->system_memory, f->pci_address_space,
              &f->pam_regions[0], PAM_BIOS_BASE, PAM_BIOS_SIZE);
diff --git a/hw/pci-host/pnv_phb3_msi.c b/hw/pci-host/pnv_phb3_msi.c
index d645468f4a..099d2092a2 100644
--- a/hw/pci-host/pnv_phb3_msi.c
+++ b/hw/pci-host/pnv_phb3_msi.c
@@ -282,8 +282,7 @@ static void phb3_msi_instance_init(Object *obj)
     object_property_add_link(obj, "phb", TYPE_PNV_PHB3,
                              (Object **)&msi->phb,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG,
-                             &error_abort);
+                             OBJ_PROP_LINK_STRONG);
=20
     /* Will be overriden later */
     ics->offset =3D 0;
diff --git a/hw/pci-host/pnv_phb3_pbcq.c b/hw/pci-host/pnv_phb3_pbcq.c
index 7b9a121246..a0526aa1ec 100644
--- a/hw/pci-host/pnv_phb3_pbcq.c
+++ b/hw/pci-host/pnv_phb3_pbcq.c
@@ -324,8 +324,7 @@ static void phb3_pbcq_instance_init(Object *obj)
     object_property_add_link(obj, "phb", TYPE_PNV_PHB3,
                              (Object **)&pbcq->phb,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG,
-                             &error_abort);
+                             OBJ_PROP_LINK_STRONG);
 }
=20
 static void pnv_pbcq_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 2bbc90b28f..352aeecfa7 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -222,38 +222,38 @@ static void q35_host_initfn(Object *obj)
                          Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
                         q35_host_get_pci_hole_start,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL);
=20
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
                         q35_host_get_pci_hole_end,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL);
=20
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
                         q35_host_get_pci_hole64_start,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL);
=20
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
                         q35_host_get_pci_hole64_end,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL);
=20
     object_property_add_uint64_ptr(obj, PCIE_HOST_MCFG_SIZE,
-                                   &pehb->size, OBJ_PROP_FLAG_READ, NULL);
+                                   &pehb->size, OBJ_PROP_FLAG_READ);
=20
     object_property_add_link(obj, MCH_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGIO=
N,
                              (Object **) &s->mch.ram_memory,
-                             qdev_prop_allow_set_link_before_realize, 0, N=
ULL);
+                             qdev_prop_allow_set_link_before_realize, 0);
=20
     object_property_add_link(obj, MCH_HOST_PROP_PCI_MEM, TYPE_MEMORY_REGIO=
N,
                              (Object **) &s->mch.pci_address_space,
-                             qdev_prop_allow_set_link_before_realize, 0, N=
ULL);
+                             qdev_prop_allow_set_link_before_realize, 0);
=20
     object_property_add_link(obj, MCH_HOST_PROP_SYSTEM_MEM, TYPE_MEMORY_RE=
GION,
                              (Object **) &s->mch.system_memory,
-                             qdev_prop_allow_set_link_before_realize, 0, N=
ULL);
+                             qdev_prop_allow_set_link_before_realize, 0);
=20
     object_property_add_link(obj, MCH_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION=
,
                              (Object **) &s->mch.address_space_io,
-                             qdev_prop_allow_set_link_before_realize, 0, N=
ULL);
+                             qdev_prop_allow_set_link_before_realize, 0);
 }
=20
 static const TypeInfo q35_host_info =3D {
@@ -638,7 +638,7 @@ static void mch_realize(PCIDevice *d, Error **errp)
                                 &mch->smbase_window);
=20
     object_property_add_const_link(qdev_get_machine(), "smram",
-                                   OBJECT(&mch->smram), &error_abort);
+                                   OBJECT(&mch->smram));
=20
     init_pam(DEVICE(mch), mch->ram_memory, mch->system_memory,
              mch->pci_address_space, &mch->pam_regions[0],
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 2b8503b709..475bcb01d7 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -442,7 +442,7 @@ static void sabre_init(Object *obj)
     object_property_add_link(obj, "iommu", TYPE_SUN4U_IOMMU,
                              (Object **) &s->iommu,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     /* sabre_config */
     memory_region_init_io(&s->sabre_config, OBJECT(s), &sabre_config_ops, =
s,
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index cf70b76fe2..1ed1072eeb 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -175,7 +175,7 @@ static void pci_unin_main_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
@@ -223,7 +223,7 @@ static void pci_u3_agp_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
@@ -262,7 +262,7 @@ static void pci_unin_agp_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
@@ -299,7 +299,7 @@ static void pci_unin_internal_init(Object *obj)
     object_property_add_link(obj, "pic", TYPE_OPENPIC,
                              (Object **) &s->pic,
                              qdev_prop_allow_set_link_before_realize,
-                             0, NULL);
+                             0);
=20
     sysbus_init_mmio(sbd, &h->conf_mem);
     sysbus_init_mmio(sbd, &h->data_mem);
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 14e4dfe8b1..8667244df4 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -189,7 +189,7 @@ static void pxa2xx_pcmcia_initfn(Object *obj)
     object_property_add_link(obj, "card", TYPE_PCMCIA_CARD,
                              (Object **)&s->card,
                              NULL, /* read-only property */
-                             0, NULL);
+                             0);
 }
=20
 /* Insert a new card into a slot */
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 0d1f41197c..2a0b66a152 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -744,8 +744,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500Machi=
neState *pms,
     const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(pms);
=20
     dev =3D qdev_create(NULL, TYPE_OPENPIC);
-    object_property_add_child(OBJECT(machine), "pic", OBJECT(dev),
-                              &error_fatal);
+    object_property_add_child(OBJECT(machine), "pic", OBJECT(dev));
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
     qdev_prop_set_uint32(dev, "nb_cpus", smp_cpus);
=20
@@ -916,7 +915,7 @@ void ppce500_init(MachineState *machine)
=20
     dev =3D qdev_create(NULL, "e500-ccsr");
     object_property_add_child(qdev_get_machine(), "e500-ccsr",
-                              OBJECT(dev), NULL);
+                              OBJECT(dev));
     qdev_init_nofail(dev);
     ccsr =3D CCSR(dev);
     ccsr_addr_space =3D &ccsr->ccsr_space;
@@ -957,8 +956,7 @@ void ppce500_init(MachineState *machine)
=20
     /* PCI */
     dev =3D qdev_create(NULL, "e500-pcihost");
-    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev),
-                              &error_abort);
+    object_property_add_child(qdev_get_machine(), "pci-host", OBJECT(dev))=
;
     qdev_prop_set_uint32(dev, "first_slot", pmc->pci_first_slot);
     qdev_prop_set_uint32(dev, "first_pin_irq", pci_irq_nrs[0]);
     qdev_init_nofail(dev);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 55d1419442..3507f26f6e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -455,7 +455,7 @@ static void ppc_core99_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
-                              OBJECT(fw_cfg), NULL);
+                              OBJECT(fw_cfg));
     qdev_init_nofail(dev);
     s =3D SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, CFG_ADDR);
@@ -628,7 +628,7 @@ static void core99_instance_init(Object *obj)
     /* Default via_config is CORE99_VIA_CONFIG_CUDA */
     cms->via_config =3D CORE99_VIA_CONFIG_CUDA;
     object_property_add_str(obj, "via", core99_get_via_config,
-                            core99_set_via_config, NULL);
+                            core99_set_via_config);
     object_property_set_description(obj, "via",
                                     "Set VIA configuration. "
                                     "Valid values are cuda, pmu and pmu-ad=
b");
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 101bdc5c4d..0b4c1c6373 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -314,7 +314,7 @@ static void ppc_heathrow_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
-                              OBJECT(fw_cfg), NULL);
+                              OBJECT(fw_cfg));
     qdev_init_nofail(dev);
     s =3D SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, CFG_ADDR);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 71b08e2ae7..8d3e108ea0 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -830,7 +830,7 @@ static void pnv_init(MachineState *machine)
         }
=20
         snprintf(chip_name, sizeof(chip_name), "chip[%d]", PNV_CHIP_HWID(i=
));
-        object_property_add_child(OBJECT(pnv), chip_name, chip, &error_fat=
al);
+        object_property_add_child(OBJECT(pnv), chip_name, chip);
         object_property_set_int(chip, PNV_CHIP_HWID(i), "chip-id",
                                 &error_fatal);
         object_property_set_int(chip, machine->smp.cores,
@@ -1058,8 +1058,7 @@ static void pnv_chip_power8_instance_init(Object *obj=
)
     object_property_add_link(obj, "xics", TYPE_XICS_FABRIC,
                              (Object **)&chip8->xics,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG,
-                             &error_abort);
+                             OBJ_PROP_LINK_STRONG);
=20
     object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi),
                             TYPE_PNV8_PSI, &error_abort, NULL);
@@ -1319,7 +1318,7 @@ static void pnv_chip_power9_instance_init(Object *obj=
)
     object_initialize_child(obj, "xive", &chip9->xive, sizeof(chip9->xive)=
,
                             TYPE_PNV_XIVE, &error_abort, NULL);
     object_property_add_alias(obj, "xive-fabric", OBJECT(&chip9->xive),
-                              "xive-fabric", &error_abort);
+                              "xive-fabric");
=20
     object_initialize_child(obj, "psi",  &chip9->psi, sizeof(chip9->psi),
                             TYPE_PNV9_PSI, &error_abort, NULL);
@@ -1737,8 +1736,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Erro=
r **errp)
         pnv_core =3D PNV_CORE(object_new(typename));
=20
         snprintf(core_name, sizeof(core_name), "core[%d]", core_hwid);
-        object_property_add_child(OBJECT(chip), core_name, OBJECT(pnv_core=
),
-                                  &error_abort);
+        object_property_add_child(OBJECT(chip), core_name, OBJECT(pnv_core=
));
         chip->cores[i] =3D pnv_core;
         object_property_set_int(OBJECT(pnv_core), chip->nr_threads,
                                 "nr-threads", &error_fatal);
@@ -1999,8 +1997,7 @@ static void pnv_machine_class_init(ObjectClass *oc, v=
oid *data)
     ispc->print_info =3D pnv_pic_print_info;
=20
     object_class_property_add_bool(oc, "hb-mode",
-                                   pnv_machine_get_hb, pnv_machine_set_hb,
-                                   &error_abort);
+                                   pnv_machine_get_hb, pnv_machine_set_hb)=
;
     object_class_property_set_description(oc, "hb-mode",
                               "Use a hostboot like boot loader");
 }
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 4e018b8b70..5f86453b6a 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -217,8 +217,7 @@ static const IPMINetfn hiomap_netfn =3D {
 void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
 {
     object_ref(OBJECT(pnor));
-    object_property_add_const_link(OBJECT(bmc), "pnor", OBJECT(pnor),
-                                   &error_abort);
+    object_property_add_const_link(OBJECT(bmc), "pnor", OBJECT(pnor));
=20
     /* Install the HIOMAP protocol handlers to access the PNOR */
     ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc), IPMI_NETFN_OEM,
@@ -235,7 +234,7 @@ IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
=20
     obj =3D object_new(TYPE_IPMI_BMC_SIMULATOR);
     object_ref(OBJECT(pnor));
-    object_property_add_const_link(obj, "pnor", OBJECT(pnor), &error_abort=
);
+    object_property_add_const_link(obj, "pnor", OBJECT(pnor));
     object_property_set_bool(obj, true, "realized", &error_fatal);
=20
     /* Install the HIOMAP protocol handlers to access the PNOR */
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 234562040d..7033104676 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -232,7 +232,7 @@ static void pnv_core_realize(DeviceState *dev, Error **=
errp)
         pc->threads[i] =3D POWERPC_CPU(obj);
=20
         snprintf(name, sizeof(name), "thread[%d]", i);
-        object_property_add_child(OBJECT(pc), name, obj, &error_abort);
+        object_property_add_child(OBJECT(pc), name, obj);
=20
         cpu->machine_data =3D g_new0(PnvCPUState, 1);
=20
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index c34a49b000..cfd5b7bc25 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -486,7 +486,7 @@ static void pnv_psi_power8_instance_init(Object *obj)
     object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->ics)=
,
                             TYPE_ICS, &error_abort, NULL);
     object_property_add_alias(obj, ICS_PROP_XICS, OBJECT(&psi8->ics),
-                              ICS_PROP_XICS, &error_abort);
+                              ICS_PROP_XICS);
 }
=20
 static const uint8_t irq_to_xivr[] =3D {
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 44be9d25a2..9266453dd9 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -229,7 +229,7 @@ static int prep_set_cmos_checksum(DeviceState *dev, voi=
d *opaque)
         rtc_set_memory(rtc, 0x3f, checksum >> 8);
=20
         object_property_add_alias(qdev_get_machine(), "rtc-time", OBJECT(r=
tc),
-                                  "date", NULL);
+                                  "date");
     }
     return 0;
 }
@@ -275,7 +275,7 @@ static void ibm_40p_init(MachineState *machine)
     qdev_prop_set_string(dev, "bios-name", bios_name);
     qdev_prop_set_uint32(dev, "elf-machine", PPC_ELF_MACHINE);
     pcihost =3D SYS_BUS_DEVICE(dev);
-    object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev), NU=
LL);
+    object_property_add_child(qdev_get_machine(), "raven", OBJECT(dev));
     qdev_init_nofail(dev);
     pci_bus =3D PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
     if (!pci_bus) {
@@ -343,7 +343,7 @@ static void ibm_40p_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
-                              OBJECT(fw_cfg), NULL);
+                              OBJECT(fw_cfg));
     qdev_init_nofail(dev);
     s =3D SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, CFG_ADDR);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 91138e7c67..6048345496 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1743,7 +1743,7 @@ static void spapr_rtc_create(SpaprMachineState *spapr=
)
     object_property_set_bool(OBJECT(&spapr->rtc), true, "realized",
                               &error_fatal);
     object_property_add_alias(OBJECT(spapr), "rtc-time", OBJECT(&spapr->rt=
c),
-                              "date", &error_fatal);
+                              "date");
 }
=20
 /* Returns whether we want to use VGA or not */
@@ -3315,13 +3315,12 @@ static void spapr_instance_init(Object *obj)
     spapr->htab_fd =3D -1;
     spapr->use_hotplug_event_source =3D true;
     object_property_add_str(obj, "kvm-type",
-                            spapr_get_kvm_type, spapr_set_kvm_type, NULL);
+                            spapr_get_kvm_type, spapr_set_kvm_type);
     object_property_set_description(obj, "kvm-type",
                                     "Specifies the KVM virtualization mode=
 (HV, PR)");
     object_property_add_bool(obj, "modern-hotplug-events",
                             spapr_get_modern_hotplug_events,
-                            spapr_set_modern_hotplug_events,
-                            NULL);
+                            spapr_set_modern_hotplug_events);
     object_property_set_description(obj, "modern-hotplug-events",
                                     "Use dedicated hotplug event mechanism=
 in"
                                     " place of standard EPOW events when p=
ossible"
@@ -3331,22 +3330,20 @@ static void spapr_instance_init(Object *obj)
                             &error_fatal);
=20
     object_property_add_str(obj, "resize-hpt",
-                            spapr_get_resize_hpt, spapr_set_resize_hpt, NU=
LL);
+                            spapr_get_resize_hpt, spapr_set_resize_hpt);
     object_property_set_description(obj, "resize-hpt",
                                     "Resizing of the Hash Page Table (enab=
led, disabled, required)");
     object_property_add_uint32_ptr(obj, "vsmt",
-                                   &spapr->vsmt, OBJ_PROP_FLAG_READWRITE,
-                                   &error_abort);
+                                   &spapr->vsmt, OBJ_PROP_FLAG_READWRITE);
     object_property_set_description(obj, "vsmt",
                                     "Virtual SMT: KVM behaves as if this w=
ere"
                                     " the host's SMT mode");
=20
     object_property_add_bool(obj, "vfio-no-msix-emulation",
-                             spapr_get_msix_emulation, NULL, NULL);
+                             spapr_get_msix_emulation, NULL);
=20
     object_property_add_uint64_ptr(obj, "kernel-addr",
-                                   &spapr->kernel_addr, OBJ_PROP_FLAG_READ=
WRITE,
-                                   &error_abort);
+                                   &spapr->kernel_addr, OBJ_PROP_FLAG_READ=
WRITE);
     object_property_set_description(obj, "kernel-addr",
                                     stringify(KERNEL_LOAD_ADDR)
                                     " for -kernel is the default");
@@ -3354,18 +3351,16 @@ static void spapr_instance_init(Object *obj)
     /* The machine class defines the default interrupt controller mode */
     spapr->irq =3D smc->irq;
     object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
-                            spapr_set_ic_mode, NULL);
+                            spapr_set_ic_mode);
     object_property_set_description(obj, "ic-mode",
                  "Specifies the interrupt controller mode (xics, xive, dua=
l)");
=20
     object_property_add_str(obj, "host-model",
-        spapr_get_host_model, spapr_set_host_model,
-        &error_abort);
+        spapr_get_host_model, spapr_set_host_model);
     object_property_set_description(obj, "host-model",
         "Host model to advertise in guest device tree");
     object_property_add_str(obj, "host-serial",
-        spapr_get_host_serial, spapr_set_host_serial,
-        &error_abort);
+        spapr_get_host_serial, spapr_set_host_serial);
     object_property_set_description(obj, "host-serial",
         "Host serial number to advertise in guest device tree");
 }
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 0870961fc9..184563e608 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -826,7 +826,6 @@ void spapr_caps_cpu_apply(SpaprMachineState *spapr, Pow=
erPCCPU *cpu)
=20
 void spapr_caps_add_properties(SpaprMachineClass *smc, Error **errp)
 {
-    Error *local_err =3D NULL;
     ObjectClass *klass =3D OBJECT_CLASS(smc);
     int i;
=20
@@ -837,12 +836,7 @@ void spapr_caps_add_properties(SpaprMachineClass *smc,=
 Error **errp)
=20
         object_class_property_add(klass, name, cap->type,
                                   cap->get, cap->set,
-                                  NULL, cap, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            g_free(name);
-            return;
-        }
+                                  NULL, cap);
=20
         desc =3D g_strdup_printf("%s", cap->description);
         object_class_property_set_description(klass, name, desc);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ac1c109427..df5c7742ca 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -290,11 +290,8 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc,=
 int i, Error **errp)
     cpu->node_id =3D sc->node_id;
=20
     id =3D g_strdup_printf("thread[%d]", i);
-    object_property_add_child(OBJECT(sc), id, obj, &local_err);
+    object_property_add_child(OBJECT(sc), id, obj);
     g_free(id);
-    if (local_err) {
-        goto err;
-    }
=20
     cpu->machine_data =3D g_new0(SpaprCpuState, 1);
=20
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 0b66d59867..728307a992 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -392,7 +392,7 @@ void spapr_drc_attach(SpaprDrc *drc, DeviceState *d, Er=
ror **errp)
     object_property_add_link(OBJECT(drc), "device",
                              object_get_typename(OBJECT(drc->dev)),
                              (Object **)(&drc->dev),
-                             NULL, 0, NULL);
+                             NULL, 0);
 }
=20
 static void spapr_drc_release(SpaprDrc *drc)
@@ -519,7 +519,6 @@ static void realize(DeviceState *d, Error **errp)
     Object *root_container;
     gchar *link_name;
     char *child_name;
-    Error *err =3D NULL;
=20
     trace_spapr_drc_realize(spapr_drc_index(drc));
     /* NOTE: we do this as part of realize/unrealize due to the fact
@@ -534,13 +533,9 @@ static void realize(DeviceState *d, Error **errp)
     child_name =3D object_get_canonical_path_component(OBJECT(drc));
     trace_spapr_drc_realize_child(spapr_drc_index(drc), child_name);
     object_property_add_alias(root_container, link_name,
-                              drc->owner, child_name, &err);
+                              drc->owner, child_name);
     g_free(child_name);
     g_free(link_name);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
     vmstate_register(VMSTATE_IF(drc), spapr_drc_index(drc), &vmstate_spapr=
_drc,
                      drc);
     trace_spapr_drc_realize_complete(spapr_drc_index(drc));
@@ -570,7 +565,7 @@ SpaprDrc *spapr_dr_connector_new(Object *owner, const c=
har *type,
     drc->owner =3D owner;
     prop_name =3D g_strdup_printf("dr-connector[%"PRIu32"]",
                                 spapr_drc_index(drc));
-    object_property_add_child(owner, prop_name, OBJECT(drc), &error_abort)=
;
+    object_property_add_child(owner, prop_name, OBJECT(drc));
     object_unref(OBJECT(drc));
     object_property_set_bool(OBJECT(drc), true, "realized", NULL);
     g_free(prop_name);
@@ -583,12 +578,11 @@ static void spapr_dr_connector_instance_init(Object *=
obj)
     SpaprDrc *drc =3D SPAPR_DR_CONNECTOR(obj);
     SpaprDrcClass *drck =3D SPAPR_DR_CONNECTOR_GET_CLASS(drc);
=20
-    object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ=
,
-                                   NULL);
+    object_property_add_uint32_ptr(obj, "id", &drc->id, OBJ_PROP_FLAG_READ=
);
     object_property_add(obj, "index", "uint32", prop_get_index,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL);
     object_property_add(obj, "fdt", "struct", prop_get_fdt,
-                        NULL, NULL, NULL, NULL);
+                        NULL, NULL, NULL);
     drc->state =3D drck->empty_state;
 }
=20
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 5704fe6051..601b896214 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -365,7 +365,7 @@ SpaprTceTable *spapr_tce_new_table(DeviceState *owner, =
uint32_t liobn)
     tcet->liobn =3D liobn;
=20
     tmp =3D g_strdup_printf("tce-table-%x", liobn);
-    object_property_add_child(OBJECT(owner), tmp, OBJECT(tcet), NULL);
+    object_property_add_child(OBJECT(owner), tmp, OBJECT(tcet));
     g_free(tmp);
     object_unref(OBJECT(tcet));
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 1f630f296b..0c594aa72e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -307,7 +307,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **e=
rrp)
=20
         obj =3D object_new(TYPE_ICS_SPAPR);
=20
-        object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort)=
;
+        object_property_add_child(OBJECT(spapr), "ics", obj);
         object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
                                  &error_abort);
         object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &error_abor=
t);
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index 42ff72c269..68cfc578a3 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -149,7 +149,7 @@ static void spapr_rtc_realize(DeviceState *dev, Error *=
*errp)
     rtc_ns =3D qemu_clock_get_ns(rtc_clock);
     rtc->ns_offset =3D host_s * NANOSECONDS_PER_SECOND - rtc_ns;
=20
-    object_property_add_tm(OBJECT(rtc), "date", spapr_rtc_qom_date, NULL);
+    object_property_add_tm(OBJECT(rtc), "date", spapr_rtc_qom_date);
 }
=20
 static const VMStateDescription vmstate_spapr_rtc =3D {
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e5802c9bbd..7221682ee2 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -463,7 +463,7 @@ static void riscv_sifive_u_machine_instance_init(Object=
 *obj)
=20
     s->start_in_flash =3D false;
     object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_=
flash,
-                             sifive_u_set_start_in_flash, NULL);
+                             sifive_u_set_start_in_flash);
     object_property_set_description(obj, "start-in-flash",
                                     "Set on to tell QEMU's ROM to jump to =
"
                                     "flash. Otherwise QEMU will jump to DR=
AM");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 85ec9e22aa..0b638bcc7d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -92,10 +92,9 @@ static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s=
,
     qdev_prop_set_uint16(dev, "id3", 0x00);
     qdev_prop_set_string(dev, "name", name);
=20
-    object_property_add_child(OBJECT(s), name, OBJECT(dev),
-                              &error_abort);
+    object_property_add_child(OBJECT(s), name, OBJECT(dev));
     object_property_add_alias(OBJECT(s), alias_prop_name,
-                              OBJECT(dev), "drive", &error_abort);
+                              OBJECT(dev), "drive");
=20
     return PFLASH_CFI01(dev);
 }
diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index dc4269cc55..ae13656440 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -963,7 +963,7 @@ static void rtc_realizefn(DeviceState *dev, Error **err=
p)
     qdev_set_legacy_instance_id(dev, base, 3);
     qemu_register_reset(rtc_reset, s);
=20
-    object_property_add_tm(OBJECT(s), "date", rtc_get_date, NULL);
+    object_property_add_tm(OBJECT(s), "date", rtc_get_date);
=20
     qdev_init_gpio_out(dev, &s->irq, 1);
     QLIST_INSERT_HEAD(&rtc_devices, s, link);
@@ -985,7 +985,7 @@ ISADevice *mc146818_rtc_init(ISABus *bus, int base_year=
, qemu_irq intercept_irq)
     }
=20
     object_property_add_alias(qdev_get_machine(), "rtc-time", OBJECT(isade=
v),
-                              "date", NULL);
+                              "date");
=20
     return isadev;
 }
diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
index 9284de4eec..d0dbd0f1b6 100644
--- a/hw/s390x/ap-bridge.c
+++ b/hw/s390x/ap-bridge.c
@@ -51,7 +51,7 @@ void s390_init_ap(void)
     /* Create bridge device */
     dev =3D qdev_create(NULL, TYPE_AP_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_AP_BRIDGE,
-                              OBJECT(dev), NULL);
+                              OBJECT(dev));
     qdev_init_nofail(dev);
=20
     /* Create bus on bridge device */
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index c9ce06b043..5d5286bc6e 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -103,7 +103,7 @@ VirtualCssBus *virtual_css_bus_init(void)
     /* Create bridge device */
     dev =3D qdev_create(NULL, TYPE_VIRTUAL_CSS_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
-                              OBJECT(dev), NULL);
+                              OBJECT(dev));
     qdev_init_nofail(dev);
=20
     /* Create bus on bridge device */
@@ -141,7 +141,7 @@ static void virtual_css_bridge_class_init(ObjectClass *=
klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_props(dc, virtual_css_bridge_properties);
     object_class_property_add_bool(klass, "cssid-unrestricted",
-                                   prop_get_true, NULL, NULL);
+                                   prop_get_true, NULL);
     object_class_property_set_description(klass, "cssid-unrestricted",
             "A css device can use any cssid, regardless whether virtual"
             " or not (read only, always true)");
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index 9d6972afa8..97a4f0b1f5 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -449,18 +449,18 @@ static void init_event_facility(Object *obj)
     event_facility->allow_all_mask_sizes =3D true;
     object_property_add_bool(obj, "allow_all_mask_sizes",
                              sclp_event_get_allow_all_mask_sizes,
-                             sclp_event_set_allow_all_mask_sizes, NULL);
+                             sclp_event_set_allow_all_mask_sizes);
     /* Spawn a new bus for SCLP events */
     qbus_create_inplace(&event_facility->sbus, sizeof(event_facility->sbus=
),
                         TYPE_SCLP_EVENTS_BUS, sdev, NULL);
=20
     new =3D object_new(TYPE_SCLP_QUIESCE);
-    object_property_add_child(obj, TYPE_SCLP_QUIESCE, new, NULL);
+    object_property_add_child(obj, TYPE_SCLP_QUIESCE, new);
     object_unref(new);
     qdev_set_parent_bus(DEVICE(new), BUS(&event_facility->sbus));
=20
     new =3D object_new(TYPE_SCLP_CPU_HOTPLUG);
-    object_property_add_child(obj, TYPE_SCLP_CPU_HOTPLUG, new, NULL);
+    object_property_add_child(obj, TYPE_SCLP_CPU_HOTPLUG, new);
     object_unref(new);
     qdev_set_parent_bus(DEVICE(new), BUS(&event_facility->sbus));
     /* the facility will automatically realize the devices via the bus */
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index a9a4ae7b39..d304b85640 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -45,7 +45,7 @@ void s390_skeys_init(void)
         obj =3D object_new(TYPE_QEMU_S390_SKEYS);
     }
     object_property_add_child(qdev_get_machine(), TYPE_S390_SKEYS,
-                              obj, NULL);
+                              obj);
     object_unref(obj);
=20
     qdev_init_nofail(DEVICE(obj));
@@ -400,7 +400,7 @@ static void s390_skeys_instance_init(Object *obj)
 {
     object_property_add_bool(obj, "migration-enabled",
                              s390_skeys_get_migration_enabled,
-                             s390_skeys_set_migration_enabled, NULL);
+                             s390_skeys_set_migration_enabled);
     object_property_set_bool(obj, true, "migration-enabled", NULL);
 }
=20
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 58121b9f68..6d1e587527 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -47,7 +47,7 @@ void s390_stattrib_init(void)
     }
=20
     object_property_add_child(qdev_get_machine(), TYPE_S390_STATTRIB,
-                              obj, NULL);
+                              obj);
     object_unref(obj);
=20
     qdev_init_nofail(DEVICE(obj));
@@ -387,7 +387,7 @@ static void s390_stattrib_instance_init(Object *obj)
=20
     object_property_add_bool(obj, "migration-enabled",
                              s390_stattrib_get_migration_enabled,
-                             s390_stattrib_set_migration_enabled, NULL);
+                             s390_stattrib_set_migration_enabled);
     object_property_set_bool(obj, true, "migration-enabled", NULL);
     sas->migration_cur_gfn =3D 0;
 }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 779caf0ecd..b28647d0eb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -202,7 +202,7 @@ static void s390_init_ipl_dev(const char *kernel_filena=
me,
     }
     g_free(netboot_fw_prop);
     object_property_add_child(qdev_get_machine(), TYPE_S390_IPL,
-                              new, NULL);
+                              new);
     object_unref(new);
     qdev_init_nofail(dev);
 }
@@ -265,7 +265,7 @@ static void ccw_init(MachineState *machine)
=20
     dev =3D qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDG=
E,
-                              OBJECT(dev), NULL);
+                              OBJECT(dev));
     qdev_init_nofail(dev);
=20
     /* register hypercalls */
@@ -600,19 +600,19 @@ static inline void s390_machine_initfn(Object *obj)
 {
     object_property_add_bool(obj, "aes-key-wrap",
                              machine_get_aes_key_wrap,
-                             machine_set_aes_key_wrap, NULL);
+                             machine_set_aes_key_wrap);
     object_property_set_description(obj, "aes-key-wrap",
             "enable/disable AES key wrapping using the CPACF wrapping key"=
);
     object_property_set_bool(obj, true, "aes-key-wrap", NULL);
=20
     object_property_add_bool(obj, "dea-key-wrap",
                              machine_get_dea_key_wrap,
-                             machine_set_dea_key_wrap, NULL);
+                             machine_set_dea_key_wrap);
     object_property_set_description(obj, "dea-key-wrap",
             "enable/disable DEA key wrapping using the CPACF wrapping key"=
);
     object_property_set_bool(obj, true, "dea-key-wrap", NULL);
     object_property_add_str(obj, "loadparm",
-            machine_get_loadparm, machine_set_loadparm, NULL);
+            machine_get_loadparm, machine_set_loadparm);
     object_property_set_description(obj, "loadparm",
             "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars conve=
rted"
             " to upper case) to pass to machine loader, boot manager,"
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f0c35aa57a..41141007f3 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -286,8 +286,7 @@ void s390_sclp_init(void)
 {
     Object *new =3D object_new(TYPE_SCLP);
=20
-    object_property_add_child(qdev_get_machine(), TYPE_SCLP, new,
-                              NULL);
+    object_property_add_child(qdev_get_machine(), TYPE_SCLP, new);
     object_unref(OBJECT(new));
     qdev_init_nofail(DEVICE(new));
 }
@@ -349,7 +348,7 @@ static void sclp_init(Object *obj)
     Object *new;
=20
     new =3D object_new(TYPE_SCLP_EVENT_FACILITY);
-    object_property_add_child(obj, TYPE_SCLP_EVENT_FACILITY, new, NULL);
+    object_property_add_child(obj, TYPE_SCLP_EVENT_FACILITY, new);
     object_unref(new);
     sclp->event_facility =3D EVENT_FACILITY(new);
=20
diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
index 2499d6f656..7324e37b5e 100644
--- a/hw/s390x/tod.c
+++ b/hw/s390x/tod.c
@@ -26,7 +26,7 @@ void s390_init_tod(void)
     } else {
         obj =3D object_new(TYPE_QEMU_S390_TOD);
     }
-    object_property_add_child(qdev_get_machine(), TYPE_S390_TOD, obj, NULL=
);
+    object_property_add_child(qdev_get_machine(), TYPE_S390_TOD, obj);
     object_unref(obj);
=20
     qdev_init_nofail(DEVICE(obj));
diff --git a/hw/s390x/virtio-ccw-balloon.c b/hw/s390x/virtio-ccw-balloon.c
index 5d28e72345..ef3308ecab 100644
--- a/hw/s390x/virtio-ccw-balloon.c
+++ b/hw/s390x/virtio-ccw-balloon.c
@@ -32,10 +32,10 @@ static void virtio_ccw_balloon_instance_init(Object *ob=
j)
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_BALLOON);
     object_property_add_alias(obj, "guest-stats", OBJECT(&dev->vdev),
-                              "guest-stats", &error_abort);
+                              "guest-stats");
     object_property_add_alias(obj, "guest-stats-polling-interval",
                               OBJECT(&dev->vdev),
-                              "guest-stats-polling-interval", &error_abort=
);
+                              "guest-stats-polling-interval");
 }
=20
 static Property virtio_ccw_balloon_properties[] =3D {
diff --git a/hw/s390x/virtio-ccw-blk.c b/hw/s390x/virtio-ccw-blk.c
index bf8520e60a..7287932b7e 100644
--- a/hw/s390x/virtio-ccw-blk.c
+++ b/hw/s390x/virtio-ccw-blk.c
@@ -32,7 +32,7 @@ static void virtio_ccw_blk_instance_init(Object *obj)
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_BLK);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
+                              "bootindex");
 }
=20
 static Property virtio_ccw_blk_properties[] =3D {
diff --git a/hw/s390x/virtio-ccw-net.c b/hw/s390x/virtio-ccw-net.c
index cd02699934..26c4d873bf 100644
--- a/hw/s390x/virtio-ccw-net.c
+++ b/hw/s390x/virtio-ccw-net.c
@@ -35,7 +35,7 @@ static void virtio_ccw_net_instance_init(Object *obj)
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_NET);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
+                              "bootindex");
 }
=20
 static Property virtio_ccw_net_properties[] =3D {
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1c980cab38..ab5459a589 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -268,7 +268,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, Blo=
ckBackend *blk,
     }
     dev =3D qdev_create(&bus->qbus, driver);
     name =3D g_strdup_printf("legacy[%d]", unit);
-    object_property_add_child(OBJECT(bus), name, OBJECT(dev), NULL);
+    object_property_add_child(OBJECT(bus), name, OBJECT(dev));
     g_free(name);
=20
     qdev_prop_set_uint32(dev, "scsi-id", unit);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 7472d24e2c..8dda3f7292 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -795,7 +795,7 @@ static void ram_initfn(Object *obj)
     object_property_add_link(obj, "memdev", TYPE_MEMORY_BACKEND,
                              (Object **)&d->memdev,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG, &error_abort);
+                             OBJ_PROP_LINK_STRONG);
     object_property_set_description(obj, "memdev", "Set RAM backend"
                                     "Valid value is ID of a hostmem backen=
d");
 }
@@ -1060,7 +1060,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *h=
wdef,
     qdev_prop_set_uint32(dev, "data_width", 1);
     qdev_prop_set_bit(dev, "dma_enabled", false);
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
-                              OBJECT(fw_cfg), NULL);
+                              OBJECT(fw_cfg));
     qdev_init_nofail(dev);
     s =3D SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, CFG_ADDR);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 6abfcb30f8..3a757ec42e 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -691,7 +691,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem=
,
=20
     dev =3D qdev_create(NULL, TYPE_FW_CFG_IO);
     qdev_prop_set_bit(dev, "dma_enabled", false);
-    object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev), NULL=
);
+    object_property_add_child(OBJECT(ebus), TYPE_FW_CFG, OBJECT(dev));
     qdev_init_nofail(dev);
     memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPOR=
T,
                                 &FW_CFG_IO(dev)->comb_iomem);
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index c57850a505..b490a899bf 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1360,8 +1360,7 @@ static void xlnx_zynqmp_qspips_init(Object *obj)
     object_property_add_link(obj, "stream-connected-dma", TYPE_STREAM_SLAV=
E,
                              (Object **)&rq->dma,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG,
-                             NULL);
+                             OBJ_PROP_LINK_STRONG);
 }
=20
 static int xilinx_spips_post_load(void *opaque, int version_id)
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index c9a390063f..686f492112 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -753,12 +753,10 @@ static void usb_device_instance_init(Object *obj)
=20
     if (klass->attached_settable) {
         object_property_add_bool(obj, "attached",
-                                 usb_get_attached, usb_set_attached,
-                                 NULL);
+                                 usb_get_attached, usb_set_attached);
     } else {
         object_property_add_bool(obj, "attached",
-                                 usb_get_attached, NULL,
-                                 NULL);
+                                 usb_get_attached, NULL);
     }
 }
=20
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 5c4b57b06b..4eba47538d 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -753,7 +753,7 @@ static void usb_msd_instance_init(Object *obj)
 {
     object_property_add(obj, "bootindex", "int32",
                         usb_msd_get_bootindex,
-                        usb_msd_set_bootindex, NULL, NULL, NULL);
+                        usb_msd_set_bootindex, NULL, NULL);
     object_property_set_int(obj, -1, "bootindex", NULL);
 }
=20
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 2d348f8237..3bd05fed12 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1634,7 +1634,7 @@ int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev=
, Error **errp)
=20
     object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
                         vfio_pci_nvlink2_get_tgt, NULL, NULL,
-                        (void *) (uintptr_t) cap->tgt, NULL);
+                        (void *) (uintptr_t) cap->tgt);
     trace_vfio_pci_nvidia_gpu_setup_quirk(vdev->vbasedev.name, cap->tgt,
                                           nv2reg->size);
 free_exit:
@@ -1695,13 +1695,13 @@ int vfio_pci_nvlink2_init(VFIOPCIDevice *vdev, Erro=
r **errp)
=20
     object_property_add(OBJECT(vdev), "nvlink2-tgt", "uint64",
                         vfio_pci_nvlink2_get_tgt, NULL, NULL,
-                        (void *) (uintptr_t) captgt->tgt, NULL);
+                        (void *) (uintptr_t) captgt->tgt);
     trace_vfio_pci_nvlink2_setup_quirk_ssatgt(vdev->vbasedev.name, captgt-=
>tgt,
                                               atsdreg->size);
=20
     object_property_add(OBJECT(vdev), "nvlink2-link-speed", "uint32",
                         vfio_pci_nvlink2_get_link_speed, NULL, NULL,
-                        (void *) (uintptr_t) capspeed->link_speed, NULL);
+                        (void *) (uintptr_t) capspeed->link_speed);
     trace_vfio_pci_nvlink2_setup_quirk_lnkspd(vdev->vbasedev.name,
                                               capspeed->link_speed);
 free_exit:
diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
index 5dce640eaf..5da6bb6449 100644
--- a/hw/virtio/vhost-scsi-pci.c
+++ b/hw/virtio/vhost-scsi-pci.c
@@ -78,7 +78,7 @@ static void vhost_scsi_pci_instance_init(Object *obj)
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VHOST_SCSI);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
+                              "bootindex");
 }
=20
 static const VirtioPCIDeviceTypeInfo vhost_scsi_pci_info =3D {
diff --git a/hw/virtio/vhost-user-blk-pci.c b/hw/virtio/vhost-user-blk-pci.=
c
index 8d3d766427..58d7c31735 100644
--- a/hw/virtio/vhost-user-blk-pci.c
+++ b/hw/virtio/vhost-user-blk-pci.c
@@ -84,7 +84,7 @@ static void vhost_user_blk_pci_instance_init(Object *obj)
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VHOST_USER_BLK);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
+                              "bootindex");
 }
=20
 static const VirtioPCIDeviceTypeInfo vhost_user_blk_pci_info =3D {
diff --git a/hw/virtio/vhost-user-input-pci.c b/hw/virtio/vhost-user-input-=
pci.c
index ae9cff9aed..0a50015599 100644
--- a/hw/virtio/vhost-user-input-pci.c
+++ b/hw/virtio/vhost-user-input-pci.c
@@ -31,8 +31,7 @@ static void vhost_user_input_pci_instance_init(Object *ob=
j)
                                 TYPE_VHOST_USER_INPUT);
=20
     object_property_add_alias(obj, "chardev",
-                              OBJECT(&dev->vhi), "chardev",
-                              &error_abort);
+                              OBJECT(&dev->vhi), "chardev");
 }
=20
 static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info =3D {
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pc=
i.c
index 32febb2daa..6f3375fe55 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -84,7 +84,7 @@ static void vhost_user_scsi_pci_instance_init(Object *obj=
)
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VHOST_USER_SCSI);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
+                              "bootindex");
 }
=20
 static const VirtioPCIDeviceTypeInfo vhost_user_scsi_pci_info =3D {
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.=
c
index 56962aeb43..cc25df0a3d 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -73,10 +73,10 @@ static void virtio_balloon_pci_instance_init(Object *ob=
j)
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_BALLOON);
     object_property_add_alias(obj, "guest-stats", OBJECT(&dev->vdev),
-                                  "guest-stats", &error_abort);
+                                  "guest-stats");
     object_property_add_alias(obj, "guest-stats-polling-interval",
                               OBJECT(&dev->vdev),
-                              "guest-stats-polling-interval", &error_abort=
);
+                              "guest-stats-polling-interval");
 }
=20
 static const VirtioPCIDeviceTypeInfo virtio_balloon_pci_info =3D {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..6d3ddf6449 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -893,12 +893,12 @@ static void virtio_balloon_instance_init(Object *obj)
     VirtIOBalloon *s =3D VIRTIO_BALLOON(obj);
=20
     object_property_add(obj, "guest-stats", "guest statistics",
-                        balloon_stats_get_all, NULL, NULL, s, NULL);
+                        balloon_stats_get_all, NULL, NULL, s);
=20
     object_property_add(obj, "guest-stats-polling-interval", "int",
                         balloon_stats_get_poll_interval,
                         balloon_stats_set_poll_interval,
-                        NULL, s, NULL);
+                        NULL, s);
 }
=20
 static const VMStateDescription vmstate_virtio_balloon =3D {
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index efb2c22a1d..28838fa958 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -81,7 +81,7 @@ static void virtio_blk_pci_instance_init(Object *obj)
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_BLK);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
+                              "bootindex");
 }
=20
 static const VirtioPCIDeviceTypeInfo virtio_blk_pci_info =3D {
diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index 5ca71d4c34..ea43040f7b 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -79,7 +79,7 @@ static void virtio_net_pci_instance_init(Object *obj)
     virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
                                 TYPE_VIRTIO_NET);
     object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
-                              "bootindex", &error_abort);
+                              "bootindex");
 }
=20
 static const VirtioPCIDeviceTypeInfo virtio_net_pci_info =3D {
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 1e363ad07b..672619c780 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -203,7 +203,7 @@ static void virtio_rng_device_realize(DeviceState *dev,=
 Error **errp)
         }
=20
         object_property_add_child(OBJECT(dev), "default-backend",
-                                  default_backend, &error_abort);
+                                  default_backend);
=20
         /* The child property took a reference, we can safely drop ours no=
w */
         object_unref(default_backend);
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index adaab81ce0..70564cc952 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -198,8 +198,7 @@ static void xen_accel_class_init(ObjectClass *oc, void =
*data)
     compat_props_add(ac->compat_props, compat, G_N_ELEMENTS(compat));
=20
     object_class_property_add_bool(oc, "igd-passthru",
-        xen_get_igd_gfx_passthru, xen_set_igd_gfx_passthru,
-        &error_abort);
+        xen_get_igd_gfx_passthru, xen_set_igd_gfx_passthru);
     object_class_property_set_description(oc, "igd-passthru",
         "Set on/off to enable/disable igd passthrou");
 }
diff --git a/iothread.c b/iothread.c
index 7130be58e3..cb082b9b26 100644
--- a/iothread.c
+++ b/iothread.c
@@ -276,15 +276,15 @@ static void iothread_class_init(ObjectClass *klass, v=
oid *class_data)
     object_class_property_add(klass, "poll-max-ns", "int",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
-                              NULL, &poll_max_ns_info, &error_abort);
+                              NULL, &poll_max_ns_info);
     object_class_property_add(klass, "poll-grow", "int",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
-                              NULL, &poll_grow_info, &error_abort);
+                              NULL, &poll_grow_info);
     object_class_property_add(klass, "poll-shrink", "int",
                               iothread_get_poll_param,
                               iothread_set_poll_param,
-                              NULL, &poll_shrink_info, &error_abort);
+                              NULL, &poll_shrink_info);
 }
=20
 static const TypeInfo iothread_info =3D {
diff --git a/memory.c b/memory.c
index 936c1b23d4..fd6f3d6aca 100644
--- a/memory.c
+++ b/memory.c
@@ -1154,7 +1154,7 @@ static void memory_region_do_init(MemoryRegion *mr,
             owner =3D container_get(qdev_get_machine(), "/unattached");
         }
=20
-        object_property_add_child(owner, name_array, OBJECT(mr), &error_ab=
ort);
+        object_property_add_child(owner, name_array, OBJECT(mr));
         object_unref(OBJECT(mr));
         g_free(name_array);
         g_free(escaped_name);
@@ -1230,19 +1230,19 @@ static void memory_region_initfn(Object *obj)
                              "link<" TYPE_MEMORY_REGION ">",
                              memory_region_get_container,
                              NULL, /* memory_region_set_container */
-                             NULL, NULL, &error_abort);
+                             NULL, NULL);
     op->resolve =3D memory_region_resolve_container;
=20
     object_property_add_uint64_ptr(OBJECT(mr), "addr",
-                                   &mr->addr, OBJ_PROP_FLAG_READ, &error_a=
bort);
+                                   &mr->addr, OBJ_PROP_FLAG_READ);
     object_property_add(OBJECT(mr), "priority", "uint32",
                         memory_region_get_priority,
                         NULL, /* memory_region_set_priority */
-                        NULL, NULL, &error_abort);
+                        NULL, NULL);
     object_property_add(OBJECT(mr), "size", "uint64",
                         memory_region_get_size,
                         NULL, /* memory_region_set_size, */
-                        NULL, NULL, &error_abort);
+                        NULL, NULL);
 }
=20
 static void iommu_memory_region_initfn(Object *obj)
diff --git a/net/can/can_host.c b/net/can/can_host.c
index 1dfaf0ced0..be4547d913 100644
--- a/net/can/can_host.c
+++ b/net/can/can_host.c
@@ -79,8 +79,7 @@ static void can_host_instance_init(Object *obj)
     object_property_add_link(obj, "canbus", TYPE_CAN_BUS,
                              (Object **)&ch->bus,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG,
-                             &error_abort);
+                             OBJ_PROP_LINK_STRONG);
 }
=20
 static void can_host_class_init(ObjectClass *klass,
diff --git a/net/can/can_socketcan.c b/net/can/can_socketcan.c
index 807f31fcde..b7ef63ec0e 100644
--- a/net/can/can_socketcan.c
+++ b/net/can/can_socketcan.c
@@ -266,8 +266,7 @@ static void can_host_socketcan_class_init(ObjectClass *=
klass,
=20
     object_class_property_add_str(klass, "if",
                                   can_host_socketcan_get_if,
-                                  can_host_socketcan_set_if,
-                                  &error_abort);
+                                  can_host_socketcan_set_if);
     chc->connect =3D can_host_socketcan_connect;
     chc->disconnect =3D can_host_socketcan_disconnect;
 }
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 10c0239f9d..c07e7c1c09 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1245,34 +1245,30 @@ static void colo_compare_init(Object *obj)
     CompareState *s =3D COLO_COMPARE(obj);
=20
     object_property_add_str(obj, "primary_in",
-                            compare_get_pri_indev, compare_set_pri_indev,
-                            NULL);
+                            compare_get_pri_indev, compare_set_pri_indev);
     object_property_add_str(obj, "secondary_in",
-                            compare_get_sec_indev, compare_set_sec_indev,
-                            NULL);
+                            compare_get_sec_indev, compare_set_sec_indev);
     object_property_add_str(obj, "outdev",
-                            compare_get_outdev, compare_set_outdev,
-                            NULL);
+                            compare_get_outdev, compare_set_outdev);
     object_property_add_link(obj, "iothread", TYPE_IOTHREAD,
                             (Object **)&s->iothread,
                             object_property_allow_set_link,
-                            OBJ_PROP_LINK_STRONG, NULL);
+                            OBJ_PROP_LINK_STRONG);
     /* This parameter just for Xen COLO */
     object_property_add_str(obj, "notify_dev",
-                            compare_get_notify_dev, compare_set_notify_dev=
,
-                            NULL);
+                            compare_get_notify_dev, compare_set_notify_dev=
);
=20
     object_property_add(obj, "compare_timeout", "uint32",
                         compare_get_timeout,
-                        compare_set_timeout, NULL, NULL, NULL);
+                        compare_set_timeout, NULL, NULL);
=20
     object_property_add(obj, "expired_scan_cycle", "uint32",
                         compare_get_expired_scan_cycle,
-                        compare_set_expired_scan_cycle, NULL, NULL, NULL);
+                        compare_set_expired_scan_cycle, NULL, NULL);
=20
     s->vnet_hdr =3D false;
     object_property_add_bool(obj, "vnet_hdr_support", compare_get_vnet_hdr=
,
-                             compare_set_vnet_hdr, NULL);
+                             compare_set_vnet_hdr);
 }
=20
 static void colo_compare_finalize(Object *obj)
diff --git a/net/dump.c b/net/dump.c
index 23b3628dde..61389e7dad 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -232,9 +232,9 @@ static void filter_dump_instance_init(Object *obj)
     nfds->maxlen =3D 65536;
=20
     object_property_add(obj, "maxlen", "uint32", filter_dump_get_maxlen,
-                        filter_dump_set_maxlen, NULL, NULL, NULL);
+                        filter_dump_set_maxlen, NULL, NULL);
     object_property_add_str(obj, "file", file_dump_get_filename,
-                            file_dump_set_filename, NULL);
+                            file_dump_set_filename);
 }
=20
 static void filter_dump_instance_finalize(Object *obj)
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 12e0254287..93050f86cf 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -192,7 +192,7 @@ static void filter_buffer_init(Object *obj)
 {
     object_property_add(obj, "interval", "uint32",
                         filter_buffer_get_interval,
-                        filter_buffer_set_interval, NULL, NULL, NULL);
+                        filter_buffer_set_interval, NULL, NULL);
 }
=20
 static const TypeInfo filter_buffer_info =3D {
diff --git a/net/filter-mirror.c b/net/filter-mirror.c
index d83e815545..e9379ce248 100644
--- a/net/filter-mirror.c
+++ b/net/filter-mirror.c
@@ -392,12 +392,12 @@ static void filter_mirror_init(Object *obj)
     MirrorState *s =3D FILTER_MIRROR(obj);
=20
     object_property_add_str(obj, "outdev", filter_mirror_get_outdev,
-                            filter_mirror_set_outdev, NULL);
+                            filter_mirror_set_outdev);
=20
     s->vnet_hdr =3D false;
     object_property_add_bool(obj, "vnet_hdr_support",
                              filter_mirror_get_vnet_hdr,
-                             filter_mirror_set_vnet_hdr, NULL);
+                             filter_mirror_set_vnet_hdr);
 }
=20
 static void filter_redirector_init(Object *obj)
@@ -405,14 +405,14 @@ static void filter_redirector_init(Object *obj)
     MirrorState *s =3D FILTER_REDIRECTOR(obj);
=20
     object_property_add_str(obj, "indev", filter_redirector_get_indev,
-                            filter_redirector_set_indev, NULL);
+                            filter_redirector_set_indev);
     object_property_add_str(obj, "outdev", filter_redirector_get_outdev,
-                            filter_redirector_set_outdev, NULL);
+                            filter_redirector_set_outdev);
=20
     s->vnet_hdr =3D false;
     object_property_add_bool(obj, "vnet_hdr_support",
                              filter_redirector_get_vnet_hdr,
-                             filter_redirector_set_vnet_hdr, NULL);
+                             filter_redirector_set_vnet_hdr);
 }
=20
 static void filter_mirror_fini(Object *obj)
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 31da08a2f4..1aaad101b6 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -413,7 +413,7 @@ static void filter_rewriter_init(Object *obj)
     s->failover_mode =3D FAILOVER_MODE_OFF;
     object_property_add_bool(obj, "vnet_hdr_support",
                              filter_rewriter_get_vnet_hdr,
-                             filter_rewriter_set_vnet_hdr, NULL);
+                             filter_rewriter_set_vnet_hdr);
 }
=20
 static void colo_rewriter_class_init(ObjectClass *oc, void *data)
diff --git a/net/filter.c b/net/filter.c
index 8221666263..caf6443655 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -214,21 +214,16 @@ static void netfilter_init(Object *obj)
     nf->position =3D g_strdup("tail");
=20
     object_property_add_str(obj, "netdev",
-                            netfilter_get_netdev_id, netfilter_set_netdev_=
id,
-                            NULL);
+                            netfilter_get_netdev_id, netfilter_set_netdev_=
id);
     object_property_add_enum(obj, "queue", "NetFilterDirection",
                              &NetFilterDirection_lookup,
-                             netfilter_get_direction, netfilter_set_direct=
ion,
-                             NULL);
+                             netfilter_get_direction, netfilter_set_direct=
ion);
     object_property_add_str(obj, "status",
-                            netfilter_get_status, netfilter_set_status,
-                            NULL);
+                            netfilter_get_status, netfilter_set_status);
     object_property_add_str(obj, "position",
-                            netfilter_get_position, netfilter_set_position=
,
-                            NULL);
+                            netfilter_get_position, netfilter_set_position=
);
     object_property_add_str(obj, "insert",
-                            netfilter_get_insert, netfilter_set_insert,
-                            NULL);
+                            netfilter_get_insert, netfilter_set_insert);
 }
=20
 static void netfilter_complete(UserCreatable *uc, Error **errp)
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 9833b33549..d66f2a633f 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -561,12 +561,12 @@ void qdev_set_id(DeviceState *dev, const char *id)
=20
     if (dev->id) {
         object_property_add_child(qdev_get_peripheral(), dev->id,
-                                  OBJECT(dev), NULL);
+                                  OBJECT(dev));
     } else {
         static int anon_count;
         gchar *name =3D g_strdup_printf("device[%d]", anon_count++);
         object_property_add_child(qdev_get_peripheral_anon(), name,
-                                  OBJECT(dev), NULL);
+                                  OBJECT(dev));
         g_free(name);
     }
 }
diff --git a/qom/container.c b/qom/container.c
index e635e8ee76..14e7ae485b 100644
--- a/qom/container.c
+++ b/qom/container.c
@@ -39,7 +39,7 @@ Object *container_get(Object *root, const char *path)
         child =3D object_resolve_path_component(obj, parts[i]);
         if (!child) {
             child =3D object_new("container");
-            object_property_add_child(obj, parts[i], child, NULL);
+            object_property_add_child(obj, parts[i], child);
             object_unref(child);
         }
     }
diff --git a/qom/object.c b/qom/object.c
index 61f398817a..14c7efe127 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -557,10 +557,7 @@ void object_initialize_childv(Object *parentobj, const=
 char *propname,
         goto out;
     }
=20
-    object_property_add_child(parentobj, propname, obj, &local_err);
-    if (local_err) {
-        goto out;
-    }
+    object_property_add_child(parentobj, propname, obj);
=20
     uc =3D (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
     if (uc) {
@@ -745,10 +742,7 @@ Object *object_new_with_propv(const char *typename,
     }
=20
     if (id !=3D NULL) {
-        object_property_add_child(parent, id, obj, &local_err);
-        if (local_err) {
-            goto error;
-        }
+        object_property_add_child(parent, id, obj);
     }
=20
     uc =3D (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
@@ -1129,12 +1123,12 @@ void object_unref(Object *obj)
     }
 }
=20
-ObjectProperty *
-object_property_add(Object *obj, const char *name, const char *type,
-                    ObjectPropertyAccessor *get,
-                    ObjectPropertyAccessor *set,
-                    ObjectPropertyRelease *release,
-                    void *opaque, Error **errp)
+static ObjectProperty *
+object_property_try_add(Object *obj, const char *name, const char *type,
+                        ObjectPropertyAccessor *get,
+                        ObjectPropertyAccessor *set,
+                        ObjectPropertyRelease *release,
+                        void *opaque, Error **errp)
 {
     ObjectProperty *prop;
     size_t name_len =3D strlen(name);
@@ -1148,8 +1142,8 @@ object_property_add(Object *obj, const char *name, co=
nst char *type,
         for (i =3D 0; ; ++i) {
             char *full_name =3D g_strdup_printf("%s[%d]", name_no_array, i=
);
=20
-            ret =3D object_property_add(obj, full_name, type, get, set,
-                                      release, opaque, NULL);
+            ret =3D object_property_try_add(obj, full_name, type, get, set=
,
+                                          release, opaque, NULL);
             g_free(full_name);
             if (ret) {
                 break;
@@ -1179,6 +1173,17 @@ object_property_add(Object *obj, const char *name, c=
onst char *type,
     return prop;
 }
=20
+ObjectProperty *
+object_property_add(Object *obj, const char *name, const char *type,
+                    ObjectPropertyAccessor *get,
+                    ObjectPropertyAccessor *set,
+                    ObjectPropertyRelease *release,
+                    void *opaque)
+{
+    return object_property_try_add(obj, name, type, get, set, release,
+                                   opaque, &error_abort);
+}
+
 ObjectProperty *
 object_class_property_add(ObjectClass *klass,
                           const char *name,
@@ -1186,16 +1191,11 @@ object_class_property_add(ObjectClass *klass,
                           ObjectPropertyAccessor *get,
                           ObjectPropertyAccessor *set,
                           ObjectPropertyRelease *release,
-                          void *opaque,
-                          Error **errp)
+                          void *opaque)
 {
     ObjectProperty *prop;
=20
-    if (object_class_property_find(klass, name, NULL) !=3D NULL) {
-        error_setg(errp, "attempt to add duplicate property '%s' to class =
(type '%s')",
-                   name, object_class_get_name(klass));
-        return NULL;
-    }
+    assert(!object_class_property_find(klass, name, NULL));
=20
     prop =3D g_malloc0(sizeof(*prop));
=20
@@ -1681,24 +1681,17 @@ static void object_finalize_child_property(Object *=
obj, const char *name,
=20
 ObjectProperty *
 object_property_add_child(Object *obj, const char *name,
-                          Object *child, Error **errp)
+                          Object *child)
 {
     g_autofree char *type =3D NULL;
     ObjectProperty *op;
=20
-    if (child->parent !=3D NULL) {
-        error_setg(errp, "child object is already parented");
-        return NULL;
-    }
+    assert(!child->parent);
=20
     type =3D g_strdup_printf("child<%s>", object_get_typename(OBJECT(child=
)));
=20
     op =3D object_property_add(obj, name, type, object_get_child_property,=
 NULL,
-                             object_finalize_child_property, child, errp);
-    if (!op) {
-        return NULL;
-    }
-
+                             object_finalize_child_property, child);
     op->resolve =3D object_resolve_child_property;
     object_ref(child);
     child->parent =3D obj;
@@ -1854,8 +1847,7 @@ object_add_link_prop(Object *obj, const char *name,
                      const char *type, void *ptr,
                      void (*check)(const Object *, const char *,
                                    Object *, Error **),
-                     ObjectPropertyLinkFlags flags,
-                     Error **errp)
+                     ObjectPropertyLinkFlags flags)
 {
     LinkProperty *prop =3D g_malloc(sizeof(*prop));
     g_autofree char *full_type =3D NULL;
@@ -1875,13 +1867,7 @@ object_add_link_prop(Object *obj, const char *name,
                              object_get_link_property,
                              check ? object_set_link_property : NULL,
                              object_release_link_property,
-                             prop,
-                             errp);
-    if (!op) {
-        g_free(prop);
-        return NULL;
-    }
-
+                             prop);
     op->resolve =3D object_resolve_link_property;
     return op;
 }
@@ -1891,11 +1877,9 @@ object_property_add_link(Object *obj, const char *na=
me,
                          const char *type, Object **targetp,
                          void (*check)(const Object *, const char *,
                                        Object *, Error **),
-                         ObjectPropertyLinkFlags flags,
-                         Error **errp)
+                         ObjectPropertyLinkFlags flags)
 {
-    return object_add_link_prop(obj, name, type, targetp, check, flags,
-                                errp);
+    return object_add_link_prop(obj, name, type, targetp, check, flags);
 }
=20
 ObjectProperty *
@@ -1904,10 +1888,8 @@ object_class_property_add_link(ObjectClass *oc,
     const char *type, ptrdiff_t offset,
     void (*check)(const Object *obj, const char *name,
                   Object *val, Error **errp),
-    ObjectPropertyLinkFlags flags,
-    Error **errp)
+    ObjectPropertyLinkFlags flags)
 {
-    Error *local_err =3D NULL;
     LinkProperty *prop =3D g_new0(LinkProperty, 1);
     char *full_type;
     ObjectProperty *op;
@@ -1922,28 +1904,21 @@ object_class_property_add_link(ObjectClass *oc,
                                    object_get_link_property,
                                    check ? object_set_link_property : NULL=
,
                                    object_release_link_property,
-                                   prop,
-                                   &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        g_free(prop);
-        goto out;
-    }
+                                   prop);
=20
     op->resolve =3D object_resolve_link_property;
=20
-out:
     g_free(full_type);
     return op;
 }
=20
 ObjectProperty *
 object_property_add_const_link(Object *obj, const char *name,
-                               Object *target, Error **errp)
+                               Object *target)
 {
     return object_add_link_prop(obj, name,
                                 object_get_typename(target), target,
-                                NULL, OBJ_PROP_LINK_DIRECT, errp);
+                                NULL, OBJ_PROP_LINK_DIRECT);
 }
=20
 char *object_get_canonical_path_component(Object *obj)
@@ -2155,51 +2130,36 @@ static void property_release_str(Object *obj, const=
 char *name,
 ObjectProperty *
 object_property_add_str(Object *obj, const char *name,
                         char *(*get)(Object *, Error **),
-                        void (*set)(Object *, const char *, Error **),
-                        Error **errp)
+                        void (*set)(Object *, const char *, Error **))
 {
     StringProperty *prop =3D g_malloc0(sizeof(*prop));
-    ObjectProperty *op;
=20
     prop->get =3D get;
     prop->set =3D set;
=20
-    op =3D object_property_add(obj, name, "string",
-                             get ? property_get_str : NULL,
-                             set ? property_set_str : NULL,
-                             property_release_str,
-                             prop, errp);
-    if (!op) {
-        g_free(prop);
-    }
-    return op;
+    return object_property_add(obj, name, "string",
+                               get ? property_get_str : NULL,
+                               set ? property_set_str : NULL,
+                               property_release_str,
+                               prop);
 }
=20
 ObjectProperty *
 object_class_property_add_str(ObjectClass *klass, const char *name,
                                    char *(*get)(Object *, Error **),
                                    void (*set)(Object *, const char *,
-                                               Error **),
-                                   Error **errp)
+                                               Error **))
 {
-    Error *local_err =3D NULL;
     StringProperty *prop =3D g_malloc0(sizeof(*prop));
-    ObjectProperty *rv;
=20
     prop->get =3D get;
     prop->set =3D set;
=20
-    rv =3D object_class_property_add(klass, name, "string",
-                              get ? property_get_str : NULL,
-                              set ? property_set_str : NULL,
-                              NULL,
-                              prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        g_free(prop);
-    }
-
-    return rv;
+    return object_class_property_add(klass, name, "string",
+                                     get ? property_get_str : NULL,
+                                     set ? property_set_str : NULL,
+                                     NULL,
+                                     prop);
 }
=20
 typedef struct BoolProperty
@@ -2250,50 +2210,35 @@ static void property_release_bool(Object *obj, cons=
t char *name,
 ObjectProperty *
 object_property_add_bool(Object *obj, const char *name,
                          bool (*get)(Object *, Error **),
-                         void (*set)(Object *, bool, Error **),
-                         Error **errp)
+                         void (*set)(Object *, bool, Error **))
 {
     BoolProperty *prop =3D g_malloc0(sizeof(*prop));
-    ObjectProperty *op;
=20
     prop->get =3D get;
     prop->set =3D set;
=20
-    op =3D object_property_add(obj, name, "bool",
-                             get ? property_get_bool : NULL,
-                             set ? property_set_bool : NULL,
-                             property_release_bool,
-                             prop, errp);
-    if (!op) {
-        g_free(prop);
-    }
-    return op;
+    return object_property_add(obj, name, "bool",
+                               get ? property_get_bool : NULL,
+                               set ? property_set_bool : NULL,
+                               property_release_bool,
+                               prop);
 }
=20
 ObjectProperty *
 object_class_property_add_bool(ObjectClass *klass, const char *name,
                                     bool (*get)(Object *, Error **),
-                                    void (*set)(Object *, bool, Error **),
-                                    Error **errp)
+                                    void (*set)(Object *, bool, Error **))
 {
-    Error *local_err =3D NULL;
     BoolProperty *prop =3D g_malloc0(sizeof(*prop));
-    ObjectProperty *rv;
=20
     prop->get =3D get;
     prop->set =3D set;
=20
-    rv =3D object_class_property_add(klass, name, "bool",
-                              get ? property_get_bool : NULL,
-                              set ? property_set_bool : NULL,
-                              NULL,
-                              prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        g_free(prop);
-    }
-
-    return rv;
+    return object_class_property_add(klass, name, "bool",
+                                     get ? property_get_bool : NULL,
+                                     set ? property_set_bool : NULL,
+                                     NULL,
+                                     prop);
 }
=20
 static void property_get_enum(Object *obj, Visitor *v, const char *name,
@@ -2339,25 +2284,19 @@ object_property_add_enum(Object *obj, const char *n=
ame,
                          const char *typename,
                          const QEnumLookup *lookup,
                          int (*get)(Object *, Error **),
-                         void (*set)(Object *, int, Error **),
-                         Error **errp)
+                         void (*set)(Object *, int, Error **))
 {
     EnumProperty *prop =3D g_malloc(sizeof(*prop));
-    ObjectProperty *op;
=20
     prop->lookup =3D lookup;
     prop->get =3D get;
     prop->set =3D set;
=20
-    op =3D object_property_add(obj, name, typename,
-                             get ? property_get_enum : NULL,
-                             set ? property_set_enum : NULL,
-                             property_release_enum,
-                             prop, errp);
-    if (!op) {
-        g_free(prop);
-    }
-    return op;
+    return object_property_add(obj, name, typename,
+                               get ? property_get_enum : NULL,
+                               set ? property_set_enum : NULL,
+                               property_release_enum,
+                               prop);
 }
=20
 ObjectProperty *
@@ -2365,28 +2304,19 @@ object_class_property_add_enum(ObjectClass *klass, =
const char *name,
                                     const char *typename,
                                     const QEnumLookup *lookup,
                                     int (*get)(Object *, Error **),
-                                    void (*set)(Object *, int, Error **),
-                                    Error **errp)
+                                    void (*set)(Object *, int, Error **))
 {
-    Error *local_err =3D NULL;
     EnumProperty *prop =3D g_malloc(sizeof(*prop));
-    ObjectProperty *rv;
=20
     prop->lookup =3D lookup;
     prop->get =3D get;
     prop->set =3D set;
=20
-    rv =3D object_class_property_add(klass, name, typename,
-                              get ? property_get_enum : NULL,
-                              set ? property_set_enum : NULL,
-                              NULL,
-                              prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        g_free(prop);
-    }
-
-    return rv;
+    return object_class_property_add(klass, name, typename,
+                                     get ? property_get_enum : NULL,
+                                     set ? property_set_enum : NULL,
+                                     NULL,
+                                     prop);
 }
=20
 typedef struct TMProperty {
@@ -2450,45 +2380,29 @@ static void property_release_tm(Object *obj, const =
char *name,
=20
 ObjectProperty *
 object_property_add_tm(Object *obj, const char *name,
-                       void (*get)(Object *, struct tm *, Error **),
-                       Error **errp)
+                       void (*get)(Object *, struct tm *, Error **))
 {
     TMProperty *prop =3D g_malloc0(sizeof(*prop));
-    ObjectProperty *op;
=20
     prop->get =3D get;
=20
-    op =3D object_property_add(obj, name, "struct tm",
-                             get ? property_get_tm : NULL, NULL,
-                             property_release_tm,
-                             prop, errp);
-    if (!op) {
-        g_free(prop);
-    }
-    return op;
+    return object_property_add(obj, name, "struct tm",
+                               get ? property_get_tm : NULL, NULL,
+                               property_release_tm,
+                               prop);
 }
=20
 ObjectProperty *
 object_class_property_add_tm(ObjectClass *klass, const char *name,
-                                  void (*get)(Object *, struct tm *, Error=
 **),
-                                  Error **errp)
+                             void (*get)(Object *, struct tm *, Error **))
 {
-    Error *local_err =3D NULL;
     TMProperty *prop =3D g_malloc0(sizeof(*prop));
-    ObjectProperty *rv;
=20
     prop->get =3D get;
=20
-    rv =3D object_class_property_add(klass, name, "struct tm",
-                              get ? property_get_tm : NULL, NULL,
-                              NULL,
-                              prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        g_free(prop);
-    }
-
-    return rv;
+    return object_class_property_add(klass, name, "struct tm",
+                                     get ? property_get_tm : NULL,
+                                     NULL, NULL, prop);
 }
=20
 static char *qdev_get_type(Object *obj, Error **errp)
@@ -2591,8 +2505,7 @@ static void property_set_uint64_ptr(Object *obj, Visi=
tor *v, const char *name,
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-                              ObjectPropertyFlags flags,
-                              Error **errp)
+                              ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2606,14 +2519,13 @@ object_property_add_uint8_ptr(Object *obj, const ch=
ar *name,
     }
=20
     return object_property_add(obj, name, "uint8",
-                               getter, setter, NULL, (void *)v, errp);
+                               getter, setter, NULL, (void *)v);
 }
=20
 ObjectProperty *
 object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
                                     const uint8_t *v,
-                                    ObjectPropertyFlags flags,
-                                    Error **errp)
+                                    ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2627,14 +2539,13 @@ object_class_property_add_uint8_ptr(ObjectClass *kl=
ass, const char *name,
     }
=20
     return object_class_property_add(klass, name, "uint8",
-                                     getter, setter, NULL, (void *)v, errp=
);
+                                     getter, setter, NULL, (void *)v);
 }
=20
 ObjectProperty *
 object_property_add_uint16_ptr(Object *obj, const char *name,
                                const uint16_t *v,
-                               ObjectPropertyFlags flags,
-                               Error **errp)
+                               ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2648,14 +2559,13 @@ object_property_add_uint16_ptr(Object *obj, const c=
har *name,
     }
=20
     return object_property_add(obj, name, "uint16",
-                               getter, setter, NULL, (void *)v, errp);
+                               getter, setter, NULL, (void *)v);
 }
=20
 ObjectProperty *
 object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
                                      const uint16_t *v,
-                                     ObjectPropertyFlags flags,
-                                     Error **errp)
+                                     ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2669,14 +2579,13 @@ object_class_property_add_uint16_ptr(ObjectClass *k=
lass, const char *name,
     }
=20
     return object_class_property_add(klass, name, "uint16",
-                                     getter, setter, NULL, (void *)v, errp=
);
+                                     getter, setter, NULL, (void *)v);
 }
=20
 ObjectProperty *
 object_property_add_uint32_ptr(Object *obj, const char *name,
                                const uint32_t *v,
-                               ObjectPropertyFlags flags,
-                               Error **errp)
+                               ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2690,14 +2599,13 @@ object_property_add_uint32_ptr(Object *obj, const c=
har *name,
     }
=20
     return object_property_add(obj, name, "uint32",
-                               getter, setter, NULL, (void *)v, errp);
+                               getter, setter, NULL, (void *)v);
 }
=20
 ObjectProperty *
 object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
                                      const uint32_t *v,
-                                     ObjectPropertyFlags flags,
-                                     Error **errp)
+                                     ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2711,14 +2619,13 @@ object_class_property_add_uint32_ptr(ObjectClass *k=
lass, const char *name,
     }
=20
     return object_class_property_add(klass, name, "uint32",
-                                     getter, setter, NULL, (void *)v, errp=
);
+                                     getter, setter, NULL, (void *)v);
 }
=20
 ObjectProperty *
 object_property_add_uint64_ptr(Object *obj, const char *name,
                                const uint64_t *v,
-                               ObjectPropertyFlags flags,
-                               Error **errp)
+                               ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2732,14 +2639,13 @@ object_property_add_uint64_ptr(Object *obj, const c=
har *name,
     }
=20
     return object_property_add(obj, name, "uint64",
-                               getter, setter, NULL, (void *)v, errp);
+                               getter, setter, NULL, (void *)v);
 }
=20
 ObjectProperty *
 object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
                                      const uint64_t *v,
-                                     ObjectPropertyFlags flags,
-                                     Error **errp)
+                                     ObjectPropertyFlags flags)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2753,7 +2659,7 @@ object_class_property_add_uint64_ptr(ObjectClass *kla=
ss, const char *name,
     }
=20
     return object_class_property_add(klass, name, "uint64",
-                                     getter, setter, NULL, (void *)v, errp=
);
+                                     getter, setter, NULL, (void *)v);
 }
=20
 typedef struct {
@@ -2795,18 +2701,15 @@ static void property_release_alias(Object *obj, con=
st char *name, void *opaque)
=20
 ObjectProperty *
 object_property_add_alias(Object *obj, const char *name,
-                          Object *target_obj, const char *target_name,
-                          Error **errp)
+                          Object *target_obj, const char *target_name)
 {
     AliasProperty *prop;
     ObjectProperty *op;
     ObjectProperty *target_prop;
     g_autofree char *prop_type =3D NULL;
=20
-    target_prop =3D object_property_find(target_obj, target_name, errp);
-    if (!target_prop) {
-        return NULL;
-    }
+    target_prop =3D object_property_find(target_obj, target_name,
+                                       &error_abort);
=20
     if (object_property_is_child(target_prop)) {
         prop_type =3D g_strdup_printf("link%s",
@@ -2823,12 +2726,7 @@ object_property_add_alias(Object *obj, const char *n=
ame,
                              property_get_alias,
                              property_set_alias,
                              property_release_alias,
-                             prop, errp);
-    if (!op) {
-        g_free(prop);
-        return NULL;
-    }
-
+                             prop);
     op->resolve =3D property_resolve_alias;
     if (target_prop->defval) {
         op->defval =3D qobject_ref(target_prop->defval);
@@ -2863,7 +2761,7 @@ void object_class_property_set_description(ObjectClas=
s *klass,
 static void object_class_init(ObjectClass *klass, void *data)
 {
     object_class_property_add_str(klass, "type", qdev_get_type,
-                                  NULL, &error_abort);
+                                  NULL);
 }
=20
 static void register_types(void)
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 72cb9e32a9..54e14a3a14 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -82,10 +82,7 @@ Object *user_creatable_add_type(const char *type, const =
char *id,
=20
     if (id !=3D NULL) {
         object_property_add_child(object_get_objects_root(),
-                                  id, obj, &local_err);
-        if (local_err) {
-            goto out;
-        }
+                                  id, obj);
     }
=20
     user_creatable_complete(USER_CREATABLE(obj), &local_err);
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index ca27c93283..bf62cbec11 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -307,8 +307,7 @@ static void pr_manager_helper_class_init(ObjectClass *k=
lass,
     PRManagerClass *prmgr_klass =3D PR_MANAGER_CLASS(klass);
     UserCreatableClass *uc_klass =3D USER_CREATABLE_CLASS(klass);
=20
-    object_class_property_add_str(klass, "path", get_path, set_path,
-                                  &error_abort);
+    object_class_property_add_str(klass, "path", get_path, set_path);
     uc_klass->complete =3D pr_manager_helper_complete;
     prmgr_klass->run =3D pr_manager_helper_run;
     prmgr_klass->is_connected =3D pr_manager_helper_is_connected;
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 32c0047889..b8027c67b4 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2802,7 +2802,7 @@ static void create_default_memdev(MachineState *ms, c=
onst char *path)
     }
     object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
     object_property_add_child(object_get_objects_root(), mc->default_ram_i=
d,
-                              obj, &error_fatal);
+                              obj);
     /* Ensure backend's memory region name is equal to mc->default_ram_id =
*/
     object_property_set_bool(obj, false, "x-use-canonical-path-for-rambloc=
k-id",
                              &error_fatal);
@@ -3878,11 +3878,10 @@ void qemu_init(int argc, char **argv, char **envp)
         exit(0);
     }
     object_property_add_child(object_get_root(), "machine",
-                              OBJECT(current_machine), &error_abort);
+                              OBJECT(current_machine));
     object_property_add_child(container_get(OBJECT(current_machine),
                                             "/unattached"),
-                              "sysbus", OBJECT(sysbus_get_default()),
-                              NULL);
+                              "sysbus", OBJECT(sysbus_get_default()));
=20
     if (machine_class->minimum_page_bits) {
         if (!set_preferred_target_page_bits(machine_class->minimum_page_bi=
ts)) {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a79f233b17..19be48c2f9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1214,8 +1214,7 @@ void arm_cpu_post_init(Object *obj)
                                  TYPE_MEMORY_REGION,
                                  (Object **)&cpu->secure_memory,
                                  qdev_prop_allow_set_link_before_realize,
-                                 OBJ_PROP_LINK_STRONG,
-                                 &error_abort);
+                                 OBJ_PROP_LINK_STRONG);
     }
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
@@ -1225,8 +1224,7 @@ void arm_cpu_post_init(Object *obj)
=20
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu =3D true;
-        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu,
-                                 &error_abort);
+        object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }
=20
     /*
@@ -1266,8 +1264,7 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_M_SECURITY)) {
         object_property_add_link(obj, "idau", TYPE_IDAU_INTERFACE, &cpu->i=
dau,
                                  qdev_prop_allow_set_link_before_realize,
-                                 OBJ_PROP_LINK_STRONG,
-                                 &error_abort);
+                                 OBJ_PROP_LINK_STRONG);
         /*
          * M profile: initial value of the Secure VTOR. We can't just use
          * a simple DEFINE_PROP_UINT32 for this because we want to permit
@@ -1275,7 +1272,7 @@ void arm_cpu_post_init(Object *obj)
          */
         object_property_add_uint32_ptr(obj, "init-svtor",
                                        &cpu->init_svtor,
-                                       OBJ_PROP_FLAG_READWRITE, &error_abo=
rt);
+                                       OBJ_PROP_FLAG_READWRITE);
     }
=20
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e7a8df420c..1f24567aa3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -581,13 +581,13 @@ void aarch64_add_sve_properties(Object *obj)
     uint32_t vq;
=20
     object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
-                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
+                        cpu_arm_set_sve, NULL, NULL);
=20
     for (vq =3D 1; vq <=3D ARM_MAX_VQ; ++vq) {
         char name[8];
         sprintf(name, "sve%d", vq * 128);
         object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
-                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
+                            cpu_arm_set_sve_vq, NULL, NULL);
     }
 }
=20
@@ -734,7 +734,7 @@ static void aarch64_max_initfn(Object *obj)
=20
     aarch64_add_sve_properties(obj);
     object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_v=
q,
-                        cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
+                        cpu_max_set_sve_max_vq, NULL, NULL);
 }
=20
 struct ARMCPUInfo {
@@ -782,7 +782,7 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool v=
alue, Error **errp)
 static void aarch64_cpu_initfn(Object *obj)
 {
     object_property_add_bool(obj, "aarch64", aarch64_cpu_get_aarch64,
-                             aarch64_cpu_set_aarch64, NULL);
+                             aarch64_cpu_set_aarch64);
     object_property_set_description(obj, "aarch64",
                                     "Set on/off to enable/disable aarch64 =
"
                                     "execution state ");
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1ea2d047e3..4bdbe6dcac 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -200,7 +200,7 @@ void kvm_arm_add_vcpu_properties(Object *obj)
=20
     ARM_CPU(obj)->kvm_adjvtime =3D true;
     object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
-                             kvm_no_adjvtime_set, &error_abort);
+                             kvm_no_adjvtime_set);
     object_property_set_description(obj, "kvm-no-adjvtime",
                                     "Set on to disable the adjustment of "
                                     "the virtual counter. VM stopped time =
"
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 90ffc5f3b1..e819f3279f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6110,7 +6110,7 @@ static void x86_cpu_apic_create(X86CPU *cpu, Error **=
errp)
     cpu->apic_state =3D DEVICE(object_new_with_class(apic_class));
=20
     object_property_add_child(OBJECT(cpu), "lapic",
-                              OBJECT(cpu->apic_state), &error_abort);
+                              OBJECT(cpu->apic_state));
     object_unref(OBJECT(cpu->apic_state));
=20
     qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
@@ -6822,7 +6822,7 @@ static void x86_cpu_register_bit_prop(X86CPU *cpu,
         object_property_add(OBJECT(cpu), prop_name, "bool",
                             x86_cpu_get_bit_prop,
                             x86_cpu_set_bit_prop,
-                            x86_cpu_release_bit_prop, fp, &error_abort);
+                            x86_cpu_release_bit_prop, fp);
     }
 }
=20
@@ -6905,28 +6905,28 @@ static void x86_cpu_initfn(Object *obj)
=20
     object_property_add(obj, "family", "int",
                         x86_cpuid_version_get_family,
-                        x86_cpuid_version_set_family, NULL, NULL, NULL);
+                        x86_cpuid_version_set_family, NULL, NULL);
     object_property_add(obj, "model", "int",
                         x86_cpuid_version_get_model,
-                        x86_cpuid_version_set_model, NULL, NULL, NULL);
+                        x86_cpuid_version_set_model, NULL, NULL);
     object_property_add(obj, "stepping", "int",
                         x86_cpuid_version_get_stepping,
-                        x86_cpuid_version_set_stepping, NULL, NULL, NULL);
+                        x86_cpuid_version_set_stepping, NULL, NULL);
     object_property_add_str(obj, "vendor",
                             x86_cpuid_get_vendor,
-                            x86_cpuid_set_vendor, NULL);
+                            x86_cpuid_set_vendor);
     object_property_add_str(obj, "model-id",
                             x86_cpuid_get_model_id,
-                            x86_cpuid_set_model_id, NULL);
+                            x86_cpuid_set_model_id);
     object_property_add(obj, "tsc-frequency", "int",
                         x86_cpuid_get_tsc_freq,
-                        x86_cpuid_set_tsc_freq, NULL, NULL, NULL);
+                        x86_cpuid_set_tsc_freq, NULL, NULL);
     object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
-                        NULL, NULL, (void *)env->features, NULL);
+                        NULL, NULL, (void *)env->features);
     object_property_add(obj, "filtered-features", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
-                        NULL, NULL, (void *)cpu->filtered_features, NULL);
+                        NULL, NULL, (void *)cpu->filtered_features);
     /*
      * The "unavailable-features" property has the same semantics as
      * CpuDefinitionInfo.unavailable-features on the "query-cpu-definition=
s"
@@ -6935,10 +6935,10 @@ static void x86_cpu_initfn(Object *obj)
      */
     object_property_add(obj, "unavailable-features", "strList",
                         x86_cpu_get_unavailable_features,
-                        NULL, NULL, NULL, &error_abort);
+                        NULL, NULL, NULL);
=20
     object_property_add(obj, "crash-information", "GuestPanicInformation",
-                        x86_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL=
);
+                        x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
=20
     for (w =3D 0; w < FEATURE_WORDS; w++) {
         int bitnr;
@@ -6948,37 +6948,36 @@ static void x86_cpu_initfn(Object *obj)
         }
     }
=20
-    object_property_add_alias(obj, "sse3", obj, "pni", &error_abort);
-    object_property_add_alias(obj, "pclmuldq", obj, "pclmulqdq", &error_ab=
ort);
-    object_property_add_alias(obj, "sse4-1", obj, "sse4.1", &error_abort);
-    object_property_add_alias(obj, "sse4-2", obj, "sse4.2", &error_abort);
-    object_property_add_alias(obj, "xd", obj, "nx", &error_abort);
-    object_property_add_alias(obj, "ffxsr", obj, "fxsr-opt", &error_abort)=
;
-    object_property_add_alias(obj, "i64", obj, "lm", &error_abort);
+    object_property_add_alias(obj, "sse3", obj, "pni");
+    object_property_add_alias(obj, "pclmuldq", obj, "pclmulqdq");
+    object_property_add_alias(obj, "sse4-1", obj, "sse4.1");
+    object_property_add_alias(obj, "sse4-2", obj, "sse4.2");
+    object_property_add_alias(obj, "xd", obj, "nx");
+    object_property_add_alias(obj, "ffxsr", obj, "fxsr-opt");
+    object_property_add_alias(obj, "i64", obj, "lm");
=20
-    object_property_add_alias(obj, "ds_cpl", obj, "ds-cpl", &error_abort);
-    object_property_add_alias(obj, "tsc_adjust", obj, "tsc-adjust", &error=
_abort);
-    object_property_add_alias(obj, "fxsr_opt", obj, "fxsr-opt", &error_abo=
rt);
-    object_property_add_alias(obj, "lahf_lm", obj, "lahf-lm", &error_abort=
);
-    object_property_add_alias(obj, "cmp_legacy", obj, "cmp-legacy", &error=
_abort);
-    object_property_add_alias(obj, "nodeid_msr", obj, "nodeid-msr", &error=
_abort);
-    object_property_add_alias(obj, "perfctr_core", obj, "perfctr-core", &e=
rror_abort);
-    object_property_add_alias(obj, "perfctr_nb", obj, "perfctr-nb", &error=
_abort);
-    object_property_add_alias(obj, "kvm_nopiodelay", obj, "kvm-nopiodelay"=
, &error_abort);
-    object_property_add_alias(obj, "kvm_mmu", obj, "kvm-mmu", &error_abort=
);
-    object_property_add_alias(obj, "kvm_asyncpf", obj, "kvm-asyncpf", &err=
or_abort);
-    object_property_add_alias(obj, "kvm_steal_time", obj, "kvm-steal-time"=
, &error_abort);
-    object_property_add_alias(obj, "kvm_pv_eoi", obj, "kvm-pv-eoi", &error=
_abort);
-    object_property_add_alias(obj, "kvm_pv_unhalt", obj, "kvm-pv-unhalt", =
&error_abort);
-    object_property_add_alias(obj, "kvm_poll_control", obj, "kvm-poll-cont=
rol",
-                              &error_abort);
-    object_property_add_alias(obj, "svm_lock", obj, "svm-lock", &error_abo=
rt);
-    object_property_add_alias(obj, "nrip_save", obj, "nrip-save", &error_a=
bort);
-    object_property_add_alias(obj, "tsc_scale", obj, "tsc-scale", &error_a=
bort);
-    object_property_add_alias(obj, "vmcb_clean", obj, "vmcb-clean", &error=
_abort);
-    object_property_add_alias(obj, "pause_filter", obj, "pause-filter", &e=
rror_abort);
-    object_property_add_alias(obj, "sse4_1", obj, "sse4.1", &error_abort);
-    object_property_add_alias(obj, "sse4_2", obj, "sse4.2", &error_abort);
+    object_property_add_alias(obj, "ds_cpl", obj, "ds-cpl");
+    object_property_add_alias(obj, "tsc_adjust", obj, "tsc-adjust");
+    object_property_add_alias(obj, "fxsr_opt", obj, "fxsr-opt");
+    object_property_add_alias(obj, "lahf_lm", obj, "lahf-lm");
+    object_property_add_alias(obj, "cmp_legacy", obj, "cmp-legacy");
+    object_property_add_alias(obj, "nodeid_msr", obj, "nodeid-msr");
+    object_property_add_alias(obj, "perfctr_core", obj, "perfctr-core");
+    object_property_add_alias(obj, "perfctr_nb", obj, "perfctr-nb");
+    object_property_add_alias(obj, "kvm_nopiodelay", obj, "kvm-nopiodelay"=
);
+    object_property_add_alias(obj, "kvm_mmu", obj, "kvm-mmu");
+    object_property_add_alias(obj, "kvm_asyncpf", obj, "kvm-asyncpf");
+    object_property_add_alias(obj, "kvm_steal_time", obj, "kvm-steal-time"=
);
+    object_property_add_alias(obj, "kvm_pv_eoi", obj, "kvm-pv-eoi");
+    object_property_add_alias(obj, "kvm_pv_unhalt", obj, "kvm-pv-unhalt");
+    object_property_add_alias(obj, "kvm_poll_control", obj, "kvm-poll-cont=
rol");
+    object_property_add_alias(obj, "svm_lock", obj, "svm-lock");
+    object_property_add_alias(obj, "nrip_save", obj, "nrip-save");
+    object_property_add_alias(obj, "tsc_scale", obj, "tsc-scale");
+    object_property_add_alias(obj, "vmcb_clean", obj, "vmcb-clean");
+    object_property_add_alias(obj, "pause_filter", obj, "pause-filter");
+    object_property_add_alias(obj, "sse4_1", obj, "sse4.1");
+    object_property_add_alias(obj, "sse4_2", obj, "sse4.2");
=20
     if (xcc->model) {
         x86_cpu_load_model(cpu, xcc->model, &error_abort);
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 6842cfc26d..51cdbe5496 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -248,20 +248,17 @@ qsev_guest_class_init(ObjectClass *oc, void *data)
 {
     object_class_property_add_str(oc, "sev-device",
                                   qsev_guest_get_sev_device,
-                                  qsev_guest_set_sev_device,
-                                  NULL);
+                                  qsev_guest_set_sev_device);
     object_class_property_set_description(oc, "sev-device",
             "SEV device to use");
     object_class_property_add_str(oc, "dh-cert-file",
                                   qsev_guest_get_dh_cert_file,
-                                  qsev_guest_set_dh_cert_file,
-                                  NULL);
+                                  qsev_guest_set_dh_cert_file);
     object_class_property_set_description(oc, "dh-cert-file",
             "guest owners DH certificate (encoded with base64)");
     object_class_property_add_str(oc, "session-file",
                                   qsev_guest_get_session_file,
-                                  qsev_guest_set_session_file,
-                                  NULL);
+                                  qsev_guest_set_session_file);
     object_class_property_set_description(oc, "session-file",
             "guest owners session parameters (encoded with base64)");
 }
@@ -274,14 +271,14 @@ qsev_guest_init(Object *obj)
     sev->sev_device =3D g_strdup(DEFAULT_SEV_DEVICE);
     sev->policy =3D DEFAULT_GUEST_POLICY;
     object_property_add_uint32_ptr(obj, "policy", &sev->policy,
-                                   OBJ_PROP_FLAG_READWRITE, NULL);
+                                   OBJ_PROP_FLAG_READWRITE);
     object_property_add_uint32_ptr(obj, "handle", &sev->handle,
-                                   OBJ_PROP_FLAG_READWRITE, NULL);
+                                   OBJ_PROP_FLAG_READWRITE);
     object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
-                                   OBJ_PROP_FLAG_READWRITE, NULL);
+                                   OBJ_PROP_FLAG_READWRITE);
     object_property_add_uint32_ptr(obj, "reduced-phys-bits",
                                    &sev->reduced_phys_bits,
-                                   OBJ_PROP_FLAG_READWRITE, NULL);
+                                   OBJ_PROP_FLAG_READWRITE);
 }
=20
 /* sev guest info */
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 46ffb6da6d..7f144392f8 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -301,17 +301,13 @@ void ppc_compat_add_property(Object *obj, const char =
*name,
                              uint32_t *compat_pvr, const char *basedesc,
                              Error **errp)
 {
-    Error *local_err =3D NULL;
     gchar *namesv[ARRAY_SIZE(compat_table) + 1];
     gchar *names, *desc;
     int i;
=20
     object_property_add(obj, name, "string",
                         ppc_compat_prop_get, ppc_compat_prop_set, NULL,
-                        compat_pvr, &local_err);
-    if (local_err) {
-        goto out;
-    }
+                        compat_pvr);
=20
     for (i =3D 0; i < ARRAY_SIZE(compat_table); i++) {
         /*
@@ -328,7 +324,4 @@ void ppc_compat_add_property(Object *obj, const char *n=
ame,
=20
     g_free(names);
     g_free(desc);
-
-out:
-    error_propagate(errp, local_err);
 }
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 427a46e3e1..1a44550a07 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -287,7 +287,7 @@ static void s390_cpu_initfn(Object *obj)
     cs->halted =3D 1;
     cs->exception_index =3D EXCP_HLT;
     object_property_add(obj, "crash-information", "GuestPanicInformation",
-                        s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NUL=
L);
+                        s390_cpu_get_crash_info_qom, NULL, NULL, NULL);
     s390_cpu_model_register_props(obj);
 #if !defined(CONFIG_USER_ONLY)
     cpu->env.tod_timer =3D
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index aa7fc713ca..8efe6ed514 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -1106,13 +1106,13 @@ void s390_cpu_model_register_props(Object *obj)
     for (feat =3D 0; feat < S390_FEAT_MAX; feat++) {
         const S390FeatDef *def =3D s390_feat_def(feat);
         object_property_add(obj, def->name, "bool", get_feature,
-                            set_feature, NULL, (void *) feat, NULL);
+                            set_feature, NULL, (void *) feat);
         object_property_set_description(obj, def->name, def->desc);
     }
     for (group =3D 0; group < S390_FEAT_GROUP_MAX; group++) {
         const S390FeatGroupDef *def =3D s390_feat_group_def(group);
         object_property_add(obj, def->name, "bool", get_feature_group,
-                            set_feature_group, NULL, (void *) group, NULL)=
;
+                            set_feature_group, NULL, (void *) group);
         object_property_set_description(obj, def->name, def->desc);
     }
 }
@@ -1225,11 +1225,10 @@ static char *get_description(Object *obj, Error **e=
rrp)
 void s390_cpu_model_class_register_props(ObjectClass *oc)
 {
     object_class_property_add_bool(oc, "migration-safe", get_is_migration_=
safe,
-                                   NULL, NULL);
+                                   NULL);
     object_class_property_add_bool(oc, "static", get_is_static,
-                                   NULL, NULL);
-    object_class_property_add_str(oc, "description", get_description, NULL=
,
-                                  NULL);
+                                   NULL);
+    object_class_property_add_str(oc, "description", get_description, NULL=
);
 }
=20
 #ifdef CONFIG_KVM
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 140d56439a..84f48fe592 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -125,18 +125,9 @@ static char *dummy_get_sv(Object *obj,
=20
 static void dummy_init(Object *obj)
 {
-    Error *err =3D NULL;
-
     object_property_add_bool(obj, "bv",
                              dummy_get_bv,
-                             dummy_set_bv,
-                             NULL);
-    /* duplicate: */
-    object_property_add_str(obj, "sv",
-                            dummy_get_sv,
-                            dummy_set_sv,
-                            &err);
-    error_free_or_abort(&err);
+                             dummy_set_bv);
 }
=20
=20
@@ -144,14 +135,12 @@ static void dummy_class_init(ObjectClass *cls, void *=
data)
 {
     object_class_property_add_str(cls, "sv",
                                   dummy_get_sv,
-                                  dummy_set_sv,
-                                  NULL);
+                                  dummy_set_sv);
     object_class_property_add_enum(cls, "av",
                                    "DummyAnimal",
                                    &dummy_animal_map,
                                    dummy_get_av,
-                                   dummy_set_av,
-                                   NULL);
+                                   dummy_set_av);
 }
=20
=20
@@ -256,13 +245,13 @@ static void dummy_dev_init(Object *obj)
     DummyBus *bus =3D DUMMY_BUS(object_new(TYPE_DUMMY_BUS));
     DummyBackend *backend =3D DUMMY_BACKEND(object_new(TYPE_DUMMY_BACKEND)=
);
=20
-    object_property_add_child(obj, "bus", OBJECT(bus), NULL);
+    object_property_add_child(obj, "bus", OBJECT(bus));
     dev->bus =3D bus;
-    object_property_add_child(OBJECT(bus), "backend", OBJECT(backend), NUL=
L);
+    object_property_add_child(OBJECT(bus), "backend", OBJECT(backend));
     bus->backend =3D backend;
=20
     object_property_add_link(obj, "backend", TYPE_DUMMY_BACKEND,
-                             (Object **)&bus->backend, NULL, 0, NULL);
+                             (Object **)&bus->backend, NULL, 0);
 }
=20
 static void dummy_dev_unparent(Object *obj)
@@ -603,11 +592,11 @@ static void test_qom_partial_path(void)
      * /cont1/obj2 (obj2a)
      * /obj2 (obj2b)
      */
-    object_property_add_child(cont1, "obj1", obj1, &error_abort);
+    object_property_add_child(cont1, "obj1", obj1);
     object_unref(obj1);
-    object_property_add_child(cont1, "obj2", obj2a, &error_abort);
+    object_property_add_child(cont1, "obj2", obj2a);
     object_unref(obj2a);
-    object_property_add_child(root,  "obj2", obj2b, &error_abort);
+    object_property_add_child(root,  "obj2", obj2b);
     object_unref(obj2b);
=20
     ambiguous =3D false;
diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.=
c
index 270c690479..42d3dd7030 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -151,9 +151,9 @@ static void prop2_accessor(Object *obj, Visitor *v, con=
st char *name,
 static void dynamic_instance_init(Object *obj)
 {
     object_property_add(obj, "prop1", "uint32", prop1_accessor, prop1_acce=
ssor,
-                        NULL, NULL, NULL);
+                        NULL, NULL);
     object_property_add(obj, "prop2", "uint32", prop2_accessor, prop2_acce=
ssor,
-                        NULL, NULL, NULL);
+                        NULL, NULL);
 }
=20
 static void dynamic_class_init(ObjectClass *oc, void *data)
diff --git a/ui/console.c b/ui/console.c
index 184e173687..865fa32635 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1297,10 +1297,9 @@ static QemuConsole *new_console(DisplayState *ds, co=
nsole_type_t console_type,
     object_property_add_link(obj, "device", TYPE_DEVICE,
                              (Object **)&s->device,
                              object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG,
-                             &error_abort);
+                             OBJ_PROP_LINK_STRONG);
     object_property_add_uint32_ptr(obj, "head", &s->head,
-                                   OBJ_PROP_FLAG_READ, &error_abort);
+                                   OBJ_PROP_FLAG_READ);
=20
     if (!active_console || ((active_console->console_type !=3D GRAPHIC_CON=
SOLE) &&
         (console_type =3D=3D GRAPHIC_CONSOLE))) {
@@ -1868,7 +1867,7 @@ DisplayState *init_displaystate(void)
          * doesn't change any more */
         name =3D g_strdup_printf("console[%d]", con->index);
         object_property_add_child(container_get(object_get_root(), "/backe=
nd"),
-                                  name, OBJECT(con), &error_abort);
+                                  name, OBJECT(con));
         g_free(name);
     }
=20
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 527c75e130..1cdf0c5f82 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -700,25 +700,25 @@ static void input_barrier_instance_init(Object *obj)
=20
     object_property_add_str(obj, "name",
                             input_barrier_get_name,
-                            input_barrier_set_name, NULL);
+                            input_barrier_set_name);
     object_property_add_str(obj, "server",
                             input_barrier_get_server,
-                            input_barrier_set_server, NULL);
+                            input_barrier_set_server);
     object_property_add_str(obj, "port",
                             input_barrier_get_port,
-                            input_barrier_set_port, NULL);
+                            input_barrier_set_port);
     object_property_add_str(obj, "x-origin",
                             input_barrier_get_x_origin,
-                            input_barrier_set_x_origin, NULL);
+                            input_barrier_set_x_origin);
     object_property_add_str(obj, "y-origin",
                             input_barrier_get_y_origin,
-                            input_barrier_set_y_origin, NULL);
+                            input_barrier_set_y_origin);
     object_property_add_str(obj, "width",
                             input_barrier_get_width,
-                            input_barrier_set_width, NULL);
+                            input_barrier_set_width);
     object_property_add_str(obj, "height",
                             input_barrier_get_height,
-                            input_barrier_set_height, NULL);
+                            input_barrier_set_height);
 }
=20
 static void input_barrier_class_init(ObjectClass *oc, void *data)
diff --git a/ui/input-linux.c b/ui/input-linux.c
index ef37b14d6f..4925ce1af1 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -499,17 +499,17 @@ static void input_linux_instance_init(Object *obj)
 {
     object_property_add_str(obj, "evdev",
                             input_linux_get_evdev,
-                            input_linux_set_evdev, NULL);
+                            input_linux_set_evdev);
     object_property_add_bool(obj, "grab_all",
                              input_linux_get_grab_all,
-                             input_linux_set_grab_all, NULL);
+                             input_linux_set_grab_all);
     object_property_add_bool(obj, "repeat",
                              input_linux_get_repeat,
-                             input_linux_set_repeat, NULL);
+                             input_linux_set_repeat);
     object_property_add_enum(obj, "grab-toggle", "GrabToggleKeys",
                              &GrabToggleKeys_lookup,
                              input_linux_get_grab_toggle,
-                             input_linux_set_grab_toggle, NULL);
+                             input_linux_set_grab_toggle);
 }
=20
 static void input_linux_class_init(ObjectClass *oc, void *data)
--=20
2.21.1


