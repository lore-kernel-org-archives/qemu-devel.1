Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11D0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEC020675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCjLtTjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEC020675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqQC-0005RC-HS
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7S-0002ko-3a
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq79-0006rq-I3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=neC/9LSKW89P1tH0g/MGfCjLd03e0uRftFtAXdOlVe4=;
 b=eCjLtTjNq1BEwE/iIzs86LwVtf9a/KuxgW53IYArYjgBM8+cyucVQpwNNUH0VWryHupOBU
 aYhozaDndY4RzpTlistWcxSRlAYZ8ElVzRSX8hdGlPy0LsAWG+8z7rNLAH1jqw6/Eno1Ra
 feF5Dfd4JoeG26uVZTu+jl/MfA8a9oM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-KMmNXjUDOXulG1Nq7n6zHA-1; Tue, 07 Jul 2020 12:06:32 -0400
X-MC-Unique: KMmNXjUDOXulG1Nq7n6zHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DE72461;
 Tue,  7 Jul 2020 16:06:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DC8C80887;
 Tue,  7 Jul 2020 16:06:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C66810F994D; Tue,  7 Jul 2020 18:06:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 34/45] error: Eliminate error_propagate() with Coccinelle,
 part 1
Date: Tue,  7 Jul 2020 18:06:02 +0200
Message-Id: <20200707160613.848843-35-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When all we do with an Error we receive into a local variable is
propagating to somewhere else, we can just as well receive it there
right away.  Convert

    if (!foo(..., &err)) {
        ...
        error_propagate(errp, err);
        ...
        return ...
    }

to

    if (!foo(..., errp)) {
        ...
        ...
        return ...
    }

where nothing else needs @err.  Coccinelle script:

    @rule1 forall@
    identifier fun, err, errp, lbl;
    expression list args, args2;
    binary operator op;
    constant c1, c2;
    symbol false;
    @@
         if (
    (
    -        fun(args, &err, args2)
    +        fun(args, errp, args2)
    |
    -        !fun(args, &err, args2)
    +        !fun(args, errp, args2)
    |
    -        fun(args, &err, args2) op c1
    +        fun(args, errp, args2) op c1
    )
            )
         {
             ... when != err
                 when != lbl:
                 when strict
    -        error_propagate(errp, err);
             ... when != err
    (
             return;
    |
             return c2;
    |
             return false;
    )
         }

    @rule2 forall@
    identifier fun, err, errp, lbl;
    expression list args, args2;
    expression var;
    binary operator op;
    constant c1, c2;
    symbol false;
    @@
    -    var = fun(args, &err, args2);
    +    var = fun(args, errp, args2);
         ... when != err
         if (
    (
             var
    |
             !var
    |
             var op c1
    )
            )
         {
             ... when != err
                 when != lbl:
                 when strict
    -        error_propagate(errp, err);
             ... when != err
    (
             return;
    |
             return c2;
    |
             return false;
    |
             return var;
    )
         }

    @depends on rule1 || rule2@
    identifier err;
    @@
    -    Error *err = NULL;
         ... when != err

Not exactly elegant, I'm afraid.

The "when != lbl:" is necessary to avoid transforming

         if (fun(args, &err)) {
             goto out
         }
         ...
     out:
         error_propagate(errp, err);

even though other paths to label out still need the error_propagate().
For an actual example, see sclp_realize().

Without the "when strict", Coccinelle transforms vfio_msix_setup(),
incorrectly.  I don't know what exactly "when strict" does, only that
it helps here.

The match of return is narrower than what I want, but I can't figure
out how to express "return where the operand doesn't use @err".  For
an example where it's too narrow, see vfio_intx_enable().

Silently fails to convert hw/arm/armsse.c, because Coccinelle gets
confused by ARMSSE being used both as typedef and function-like macro
there.  Converted manually.

Line breaks tidied up manually.  One nested declaration of @local_err
deleted manually.  Preexisting unwanted blank line dropped in
hw/riscv/sifive_e.c.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 accel/kvm/kvm-all.c              |   4 +-
 accel/tcg/tcg-all.c              |   4 +-
 backends/cryptodev-vhost-user.c  |   3 +-
 backends/cryptodev.c             |   4 +-
 backends/hostmem-file.c          |   4 +-
 backends/hostmem-memfd.c         |   4 +-
 backends/hostmem.c               |   8 +--
 backends/tpm/tpm_util.c          |   4 +-
 block.c                          |   3 +-
 block/curl.c                     |   4 +-
 block/file-posix.c               |   8 +--
 block/parallels.c                |   3 +-
 block/qcow.c                     |   3 +-
 block/qed.c                      |   3 +-
 block/throttle-groups.c          |   4 +-
 block/vhdx.c                     |   3 +-
 block/vmdk.c                     |   3 +-
 block/vpc.c                      |   3 +-
 blockdev.c                       |   6 +-
 hw/arm/allwinner-a10.c           |  16 ++---
 hw/arm/armsse.c                  | 114 +++++++++++--------------------
 hw/arm/armv7m.c                  |  24 +++----
 hw/arm/aspeed_ast2600.c          |  54 +++++----------
 hw/arm/aspeed_soc.c              |  48 +++++--------
 hw/arm/bcm2835_peripherals.c     |  48 +++++--------
 hw/arm/bcm2836.c                 |  16 ++---
 hw/arm/digic.c                   |  13 ++--
 hw/arm/fsl-imx25.c               |  33 +++------
 hw/arm/fsl-imx31.c               |  24 +++----
 hw/arm/fsl-imx6.c                |  36 ++++------
 hw/arm/msf2-soc.c                |  16 ++---
 hw/arm/nrf51_soc.c               |  24 +++----
 hw/arm/stm32f205_soc.c           |  22 ++----
 hw/arm/stm32f405_soc.c           |  27 +++-----
 hw/arm/xlnx-zynqmp.c             |  58 ++++++----------
 hw/block/fdc.c                   |   3 +-
 hw/block/xen-block.c             |   4 +-
 hw/char/serial-pci-multi.c       |   4 +-
 hw/char/serial-pci.c             |   4 +-
 hw/char/serial.c                 |   8 +--
 hw/core/machine.c                |   4 +-
 hw/core/qdev-properties-system.c |  16 ++---
 hw/core/qdev-properties.c        |  44 +++---------
 hw/cpu/a15mpcore.c               |   4 +-
 hw/cpu/a9mpcore.c                |  16 ++---
 hw/cpu/arm11mpcore.c             |  13 ++--
 hw/cpu/core.c                    |   8 +--
 hw/cpu/realview_mpcore.c         |   7 +-
 hw/display/virtio-gpu-pci.c      |   4 +-
 hw/display/virtio-vga.c          |   4 +-
 hw/gpio/aspeed_gpio.c            |   4 +-
 hw/i386/pc.c                     |   4 +-
 hw/intc/apic_common.c            |   4 +-
 hw/intc/armv7m_nvic.c            |   7 +-
 hw/intc/pnv_xive.c               |   6 +-
 hw/intc/realview_gic.c           |   4 +-
 hw/intc/spapr_xive.c             |   6 +-
 hw/intc/xics_kvm.c               |   4 +-
 hw/isa/piix4.c                   |   4 +-
 hw/mem/nvdimm.c                  |   4 +-
 hw/microblaze/xlnx-zynqmp-pmu.c  |   7 +-
 hw/mips/cps.c                    |  13 ++--
 hw/misc/aspeed_sdmc.c            |   4 +-
 hw/misc/macio/cuda.c             |   4 +-
 hw/misc/macio/macio.c            |  19 ++----
 hw/misc/macio/pmu.c              |   4 +-
 hw/misc/pca9552.c                |   4 +-
 hw/misc/tmp105.c                 |   4 +-
 hw/misc/tmp421.c                 |   4 +-
 hw/pci-host/pnv_phb3.c           |  10 +--
 hw/pci-host/pnv_phb4.c           |   4 +-
 hw/pci-host/pnv_phb4_pec.c       |   4 +-
 hw/ppc/e500.c                    |   4 +-
 hw/ppc/pnv.c                     |  40 ++++-------
 hw/ppc/pnv_core.c                |   3 +-
 hw/ppc/pnv_psi.c                 |  11 +--
 hw/ppc/spapr_caps.c              |  12 +---
 hw/ppc/spapr_drc.c               |   9 +--
 hw/ppc/spapr_irq.c               |   4 +-
 hw/riscv/opentitan.c             |   7 +-
 hw/riscv/sifive_e.c              |   5 +-
 hw/riscv/sifive_u.c              |   4 +-
 hw/s390x/css.c                   |   4 +-
 hw/s390x/event-facility.c        |   7 +-
 hw/s390x/virtio-ccw-crypto.c     |   4 +-
 hw/s390x/virtio-ccw-rng.c        |   4 +-
 hw/scsi/scsi-bus.c               |  10 +--
 hw/sd/aspeed_sdhci.c             |  10 +--
 hw/smbios/smbios.c               |  25 +++----
 hw/vfio/pci-quirks.c             |   4 +-
 hw/vfio/pci.c                    |   7 +-
 hw/virtio/virtio-balloon.c       |   4 +-
 hw/virtio/virtio-rng-pci.c       |   4 +-
 hw/virtio/virtio-rng.c           |   4 +-
 iothread.c                       |   7 +-
 net/colo-compare.c               |   8 +--
 net/dump.c                       |   4 +-
 net/filter-buffer.c              |   4 +-
 net/tap.c                        |   3 +-
 qapi/string-input-visitor.c      |   4 +-
 qdev-monitor.c                   |   8 +--
 qga/commands-win32.c             |   3 +-
 qom/object.c                     |  32 +++------
 softmmu/vl.c                     |   5 +-
 target/arm/cpu64.c               |  12 +---
 target/arm/monitor.c             |   3 +-
 target/i386/cpu.c                |  20 ++----
 target/ppc/compat.c              |   4 +-
 target/s390x/cpu_models.c        |  11 +--
 target/sparc/cpu.c               |   4 +-
 tpm.c                            |   4 +-
 util/main-loop.c                 |   4 +-
 util/qemu-config.c               |   7 +-
 util/qemu-option.c               |  24 ++-----
 114 files changed, 383 insertions(+), 896 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83f03b2018..c19035380a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3113,11 +3113,9 @@ static void kvm_set_kvm_shadow_mem(Object *obj, Visitor *v,
                                    Error **errp)
 {
     KVMState *s = KVM_STATE(obj);
-    Error *error = NULL;
     int64_t value;
 
-    if (!visit_type_int(v, name, &value, &error)) {
-        error_propagate(errp, error);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
 
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index d6b3d7fc07..eace2c113b 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -182,11 +182,9 @@ static void tcg_set_tb_size(Object *obj, Visitor *v,
                             Error **errp)
 {
     TCGState *s = TCG_STATE(obj);
-    Error *error = NULL;
     uint32_t value;
 
-    if (!visit_type_uint32(v, name, &value, &error)) {
-        error_propagate(errp, error);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
 
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 8b8cbc4223..dbe5a8aae6 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -209,8 +209,7 @@ static void cryptodev_vhost_user_init(
         backend->conf.peers.ccs[i] = cc;
 
         if (i == 0) {
-            if (!qemu_chr_fe_init(&s->chr, chr, &local_err)) {
-                error_propagate(errp, local_err);
+            if (!qemu_chr_fe_init(&s->chr, chr, errp)) {
                 return;
             }
         }
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 4de378532b..ada4ebe78b 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -154,11 +154,9 @@ cryptodev_backend_set_queues(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     CryptoDevBackend *backend = CRYPTODEV_BACKEND(obj);
-    Error *local_err = NULL;
     uint32_t value;
 
-    if (!visit_type_uint32(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index a44f5a61ac..5b819020b4 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -110,7 +110,6 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(o);
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
-    Error *local_err = NULL;
     uint64_t val;
 
     if (host_memory_backend_mr_inited(backend)) {
@@ -119,8 +118,7 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
         return;
     }
 
-    if (!visit_type_size(v, name, &val, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &val, errp)) {
         return;
     }
     fb->align = val;
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 1e74a2b92f..4c040a7541 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -77,7 +77,6 @@ memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(obj);
-    Error *local_err = NULL;
     uint64_t value;
 
     if (host_memory_backend_mr_inited(MEMORY_BACKEND(obj))) {
@@ -85,8 +84,7 @@ memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_size(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
     if (!value) {
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 5cc264b0db..c614f1bdc1 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -54,7 +54,6 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
-    Error *local_err = NULL;
     uint64_t value;
 
     if (host_memory_backend_mr_inited(backend)) {
@@ -63,8 +62,7 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_size(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
     if (!value) {
@@ -252,11 +250,9 @@ static void host_memory_backend_set_prealloc_threads(Object *obj, Visitor *v,
     const char *name, void *opaque, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
-    Error *local_err = NULL;
     uint32_t value;
 
-    if (!visit_type_uint32(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (value <= 0) {
diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index 971f3af047..b58d298c1a 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -48,7 +48,6 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
-    Error *local_err = NULL;
     Property *prop = opaque;
     TPMBackend *s, **be = qdev_get_prop_ptr(dev, prop);
     char *str;
@@ -58,8 +57,7 @@ static void set_tpm(Object *obj, Visitor *v, const char *name, void *opaque,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
diff --git a/block.c b/block.c
index b396f32a51..7f3091da63 100644
--- a/block.c
+++ b/block.c
@@ -5678,10 +5678,9 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
     if (bs->open_flags & BDRV_O_INACTIVE) {
         bs->open_flags &= ~BDRV_O_INACTIVE;
         bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-        ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &local_err);
+        ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, errp);
         if (ret < 0) {
             bs->open_flags |= BDRV_O_INACTIVE;
-            error_propagate(errp, local_err);
             return;
         }
         bdrv_set_perm(bs, perm, shared_perm);
diff --git a/block/curl.c b/block/curl.c
index d9552efe52..4f907c47be 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -669,7 +669,6 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVCURLState *s = bs->opaque;
     CURLState *state = NULL;
     QemuOpts *opts;
-    Error *local_err = NULL;
     const char *file;
     const char *cookie;
     const char *cookie_secret;
@@ -695,8 +694,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
 
     qemu_mutex_init(&s->mutex);
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         goto out_noclean;
     }
 
diff --git a/block/file-posix.c b/block/file-posix.c
index ca896d5b33..78f9dc8ab4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3334,7 +3334,6 @@ static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp)
 {
     BDRVRawState *s = bs->opaque;
-    Error *local_err = NULL;
     int ret;
 
 #if defined(__APPLE__) && defined(__MACH__)
@@ -3399,9 +3398,8 @@ hdev_open_Mac_error:
 
     s->type = FTYPE_FILE;
 
-    ret = raw_open_common(bs, options, flags, 0, true, &local_err);
+    ret = raw_open_common(bs, options, flags, 0, true, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
 #if defined(__APPLE__) && defined(__MACH__)
         if (*bsd_path) {
             filename = bsd_path;
@@ -3677,14 +3675,12 @@ static int cdrom_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
     BDRVRawState *s = bs->opaque;
-    Error *local_err = NULL;
     int ret;
 
     s->type = FTYPE_CD;
 
-    ret = raw_open_common(bs, options, flags, 0, true, &local_err);
+    ret = raw_open_common(bs, options, flags, 0, true, errp);
     if (ret) {
-        error_propagate(errp, local_err);
         return ret;
     }
 
diff --git a/block/parallels.c b/block/parallels.c
index 32d0ecd398..ff27a85c01 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -646,9 +646,8 @@ static int coroutine_fn parallels_co_create_opts(BlockDriver *drv,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto done;
     }
 
diff --git a/block/qcow.c b/block/qcow.c
index ee5d35fe20..dca2a1fe7d 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -973,9 +973,8 @@ static int coroutine_fn qcow_co_create_opts(BlockDriver *drv,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/qed.c b/block/qed.c
index c0c65015c7..e369fd360a 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -749,9 +749,8 @@ static int coroutine_fn bdrv_qed_co_create_opts(BlockDriver *drv,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 3d7e7cf990..03a53c89ea 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -811,7 +811,6 @@ static void throttle_group_set(Object *obj, Visitor *v, const char * name,
     ThrottleGroup *tg = THROTTLE_GROUP(obj);
     ThrottleConfig *cfg;
     ThrottleParamInfo *info = opaque;
-    Error *local_err = NULL;
     int64_t value;
 
     /* If we have finished initialization, don't accept individual property
@@ -823,8 +822,7 @@ static void throttle_group_set(Object *obj, Visitor *v, const char * name,
         return;
     }
 
-    if (!visit_type_int64(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int64(v, name, &value, errp)) {
         return;
     }
     if (value < 0) {
diff --git a/block/vhdx.c b/block/vhdx.c
index fa9e544a5e..ac5a9094c4 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2086,9 +2086,8 @@ static int coroutine_fn vhdx_co_create_opts(BlockDriver *drv,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/block/vmdk.c b/block/vmdk.c
index 62da465126..4d42d2fbe1 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2252,9 +2252,8 @@ static int vmdk_create_extent(const char *filename, int64_t filesize,
     BlockBackend *blk = NULL;
     Error *local_err = NULL;
 
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto exit;
     }
 
diff --git a/block/vpc.c b/block/vpc.c
index 64493f8434..a5bab92f64 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1114,9 +1114,8 @@ static int coroutine_fn vpc_co_create_opts(BlockDriver *drv,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_create_file(filename, opts, &local_err);
+    ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        error_propagate(errp, local_err);
         goto fail;
     }
 
diff --git a/blockdev.c b/blockdev.c
index 625c8ff3f2..705869d849 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -509,8 +509,7 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
         goto err_no_opts;
     }
 
-    if (!qemu_opts_absorb_qdict(opts, bs_opts, &error)) {
-        error_propagate(errp, error);
+    if (!qemu_opts_absorb_qdict(opts, bs_opts, errp)) {
         goto early_err;
     }
 
@@ -827,8 +826,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
 
     for (i = 0; i < ARRAY_SIZE(opt_renames); i++) {
         if (!qemu_opt_rename(all_opts, opt_renames[i].from,
-                             opt_renames[i].to, &local_err)) {
-            error_propagate(errp, local_err);
+                             opt_renames[i].to, errp)) {
             return NULL;
         }
     }
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index c5d604af68..e258463747 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -72,15 +72,12 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 {
     AwA10State *s = AW_A10(dev);
     SysBusDevice *sysbusdev;
-    Error *err = NULL;
 
-    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), errp)) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->intc);
@@ -91,8 +88,7 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
     qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), errp)) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->timer);
@@ -114,16 +110,14 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
         qemu_check_nic_model(&nd_table[0], TYPE_AW_EMAC);
         qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
     }
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), errp)) {
         return;
     }
     sysbusdev = SYS_BUS_DEVICE(&s->emac);
     sysbus_mmio_map(sysbusdev, 0, AW_A10_EMAC_BASE);
     sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(dev, 55));
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0, AW_A10_SATA_BASE);
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index c8604926a3..64fcab895f 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -535,20 +535,17 @@ static void armsse_realize(DeviceState *dev, Error **errp)
          */
         if (extract32(info->cpuwait_rst, i, 1)) {
             if (!object_property_set_bool(cpuobj, "start-powered-off", true,
-                                          &err)) {
-                error_propagate(errp, err);
+                                          errp)) {
                 return;
             }
         }
         if (!s->cpu_fpu[i]) {
-            if (!object_property_set_bool(cpuobj, "vfp", false, &err)) {
-                error_propagate(errp, err);
+            if (!object_property_set_bool(cpuobj, "vfp", false, errp)) {
                 return;
             }
         }
         if (!s->cpu_dsp[i]) {
-            if (!object_property_set_bool(cpuobj, "dsp", false, &err)) {
-                error_propagate(errp, err);
+            if (!object_property_set_bool(cpuobj, "dsp", false, errp)) {
                 return;
             }
         }
@@ -563,8 +560,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         object_property_set_link(cpuobj, "memory",
                                  OBJECT(&s->cpu_container[i]), &error_abort);
         object_property_set_link(cpuobj, "idau", OBJECT(s), &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(cpuobj), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(cpuobj), errp)) {
             return;
         }
         /*
@@ -573,8 +569,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
          * CPU must exist and have been parented into the cluster before
          * the cluster is realized.
          */
-        if (!qdev_realize(DEVICE(&s->cluster[i]), NULL, &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cluster[i]), NULL, errp)) {
             return;
         }
 
@@ -603,12 +598,10 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                 int cpunum;
 
                 if (!object_property_set_int(splitter, "num-lines",
-                                             info->num_cpus, &err)) {
-                    error_propagate(errp, err);
+                                             info->num_cpus, errp)) {
                     return;
                 }
-                if (!qdev_realize(DEVICE(splitter), NULL, &err)) {
-                    error_propagate(errp, err);
+                if (!qdev_realize(DEVICE(splitter), NULL, errp)) {
                     return;
                 }
                 for (cpunum = 0; cpunum < info->num_cpus; cpunum++) {
@@ -639,8 +632,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* Security controller */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->secctl), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->secctl), errp)) {
         return;
     }
     sbd_secctl = SYS_BUS_DEVICE(&s->secctl);
@@ -656,12 +648,10 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * that will be an output from the ARMSSE to the system.
      */
     if (!object_property_set_int(OBJECT(&s->sec_resp_splitter),
-                                 "num-lines", 3, &err)) {
-        error_propagate(errp, err);
+                                 "num-lines", 3, errp)) {
         return;
     }
-    if (!qdev_realize(DEVICE(&s->sec_resp_splitter), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->sec_resp_splitter), NULL, errp)) {
         return;
     }
     dev_splitter = DEVICE(&s->sec_resp_splitter);
@@ -683,8 +673,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         }
         object_property_set_link(OBJECT(&s->mpc[i]), "downstream",
                                  OBJECT(&s->sram[i]), &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mpc[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mpc[i]), errp)) {
             return;
         }
         /* Map the upstream end of the MPC into the right place... */
@@ -700,12 +689,10 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     /* We must OR together lines from the MPC splitters to go to the NVIC */
     if (!object_property_set_int(OBJECT(&s->mpc_irq_orgate), "num-lines",
                                  IOTS_NUM_EXP_MPC + info->sram_banks,
-                                 &err)) {
-        error_propagate(errp, err);
+                                 errp)) {
         return;
     }
-    if (!qdev_realize(DEVICE(&s->mpc_irq_orgate), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->mpc_irq_orgate), NULL, errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->mpc_irq_orgate), 0,
@@ -722,8 +709,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * map its upstream ends to the right place in the container.
      */
     qdev_prop_set_uint32(DEVICE(&s->timer0), "pclk-frq", s->mainclk_frq);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer0), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer0), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer0), 0,
@@ -733,8 +719,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                              &error_abort);
 
     qdev_prop_set_uint32(DEVICE(&s->timer1), "pclk-frq", s->mainclk_frq);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer1), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer1), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer1), 0,
@@ -744,8 +729,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                              &error_abort);
 
     qdev_prop_set_uint32(DEVICE(&s->dualtimer), "pclk-frq", s->mainclk_frq);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dualtimer), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dualtimer), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dualtimer), 0,
@@ -769,8 +753,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             int cpunum;
             SysBusDevice *mhu_sbd = SYS_BUS_DEVICE(&s->mhu[i]);
 
-            if (!sysbus_realize(SYS_BUS_DEVICE(&s->mhu[i]), &err)) {
-                error_propagate(errp, err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->mhu[i]), errp)) {
                 return;
             }
             port = g_strdup_printf("port[%d]", i + 3);
@@ -795,8 +778,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc0), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc0), errp)) {
         return;
     }
 
@@ -838,12 +820,10 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * ORed together to give a single combined PPC interrupt to the NVIC.
      */
     if (!object_property_set_int(OBJECT(&s->ppc_irq_orgate),
-                                 "num-lines", NUM_PPCS, &err)) {
-        error_propagate(errp, err);
+                                 "num-lines", NUM_PPCS, errp)) {
         return;
     }
-    if (!qdev_realize(DEVICE(&s->ppc_irq_orgate), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->ppc_irq_orgate), NULL, errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->ppc_irq_orgate), 0,
@@ -864,8 +844,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_string(DEVICE(&s->cachectrl[i]), "name", name);
             g_free(name);
             qdev_prop_set_uint64(DEVICE(&s->cachectrl[i]), "size", 0x1000);
-            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cachectrl[i]), &err)) {
-                error_propagate(errp, err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cachectrl[i]), errp)) {
                 return;
             }
 
@@ -881,8 +860,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             qdev_prop_set_string(DEVICE(&s->cpusecctrl[i]), "name", name);
             g_free(name);
             qdev_prop_set_uint64(DEVICE(&s->cpusecctrl[i]), "size", 0x1000);
-            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpusecctrl[i]), &err)) {
-                error_propagate(errp, err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpusecctrl[i]), errp)) {
                 return;
             }
 
@@ -895,8 +873,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             MemoryRegion *mr;
 
             qdev_prop_set_uint32(DEVICE(&s->cpuid[i]), "CPUID", i);
-            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpuid[i]), &err)) {
-                error_propagate(errp, err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpuid[i]), errp)) {
                 return;
             }
 
@@ -910,8 +887,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      *   0x4002f000: S32K timer
      */
     qdev_prop_set_uint32(DEVICE(&s->s32ktimer), "pclk-frq", S32KCLK);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->s32ktimer), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->s32ktimer), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32ktimer), 0,
@@ -920,8 +896,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     object_property_set_link(OBJECT(&s->apb_ppc1), "port[0]", OBJECT(mr),
                              &error_abort);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc1), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc1), errp)) {
         return;
     }
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->apb_ppc1), 0);
@@ -945,17 +920,14 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                                                  "cfg_sec_resp", 0));
 
     if (!object_property_set_int(OBJECT(&s->sysinfo), "SYS_VERSION",
-                                 info->sys_version, &err)) {
-        error_propagate(errp, err);
+                                 info->sys_version, errp)) {
         return;
     }
     if (!object_property_set_int(OBJECT(&s->sysinfo), "SYS_CONFIG",
-                                 armsse_sys_config_value(s, info), &err)) {
-        error_propagate(errp, err);
+                                 armsse_sys_config_value(s, info), errp)) {
         return;
     }
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysinfo), errp)) {
         return;
     }
     /* System information registers */
@@ -969,8 +941,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                             s->init_svtor, &error_abort);
     object_property_set_int(OBJECT(&s->sysctl), "INITSVTOR1_RST",
                             s->init_svtor, &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctl), 0, 0x50021000);
@@ -999,20 +970,17 @@ static void armsse_realize(DeviceState *dev, Error **errp)
 
     /* This OR gate wires together outputs from the secure watchdogs to NMI */
     if (!object_property_set_int(OBJECT(&s->nmi_orgate), "num-lines", 2,
-                                 &err)) {
-        error_propagate(errp, err);
+                                 errp)) {
         return;
     }
-    if (!qdev_realize(DEVICE(&s->nmi_orgate), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->nmi_orgate), NULL, errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->nmi_orgate), 0,
                           qdev_get_gpio_in_named(DEVICE(&s->armv7m), "NMI", 0));
 
     qdev_prop_set_uint32(DEVICE(&s->s32kwatchdog), "wdogclk-frq", S32KCLK);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->s32kwatchdog), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->s32kwatchdog), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32kwatchdog), 0,
@@ -1022,8 +990,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     /* 0x40080000 .. 0x4008ffff : ARMSSE second Base peripheral region */
 
     qdev_prop_set_uint32(DEVICE(&s->nswatchdog), "wdogclk-frq", s->mainclk_frq);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nswatchdog), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nswatchdog), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->nswatchdog), 0,
@@ -1031,8 +998,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->nswatchdog), 0, 0x40081000);
 
     qdev_prop_set_uint32(DEVICE(&s->swatchdog), "wdogclk-frq", s->mainclk_frq);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->swatchdog), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->swatchdog), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->swatchdog), 0,
@@ -1042,12 +1008,10 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(s->ppc_irq_splitter); i++) {
         Object *splitter = OBJECT(&s->ppc_irq_splitter[i]);
 
-        if (!object_property_set_int(splitter, "num-lines", 2, &err)) {
-            error_propagate(errp, err);
+        if (!object_property_set_int(splitter, "num-lines", 2, errp)) {
             return;
         }
-        if (!qdev_realize(DEVICE(splitter), NULL, &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(splitter), NULL, errp)) {
             return;
         }
     }
@@ -1088,12 +1052,10 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         DeviceState *dev_splitter = DEVICE(splitter);
 
         if (!object_property_set_int(OBJECT(splitter), "num-lines", 2,
-                                     &err)) {
-            error_propagate(errp, err);
+                                     errp)) {
             return;
         }
-        if (!qdev_realize(DEVICE(splitter), NULL, &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(splitter), NULL, errp)) {
             return;
         }
 
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 2e6dabbbaf..aa831d6653 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -175,27 +175,23 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     }
     if (object_property_find(OBJECT(s->cpu), "init-svtor", NULL)) {
         if (!object_property_set_uint(OBJECT(s->cpu), "init-svtor",
-                                      s->init_svtor, &err)) {
-            error_propagate(errp, err);
+                                      s->init_svtor, errp)) {
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "start-powered-off", NULL)) {
         if (!object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
-                                      s->start_powered_off, &err)) {
-            error_propagate(errp, err);
+                                      s->start_powered_off, errp)) {
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "vfp", NULL)) {
-        if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, &err)) {
-            error_propagate(errp, err);
+        if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, errp)) {
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "dsp", NULL)) {
-        if (!object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, &err)) {
-            error_propagate(errp, err);
+        if (!object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, errp)) {
             return;
         }
     }
@@ -207,14 +203,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     s->cpu->env.nvic = &s->nvic;
     s->nvic.cpu = s->cpu;
 
-    if (!qdev_realize(DEVICE(s->cpu), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(s->cpu), NULL, errp)) {
         return;
     }
 
     /* Note that we must realize the NVIC after the CPU */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nvic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nvic), errp)) {
         return;
     }
 
@@ -240,14 +234,12 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
 
             if (!object_property_set_int(obj, "base",
-                                         bitband_input_addr[i], &err)) {
-                error_propagate(errp, err);
+                                         bitband_input_addr[i], errp)) {
                 return;
             }
             object_property_set_link(obj, "source-memory",
                                      OBJECT(s->board_memory), &error_abort);
-            if (!sysbus_realize(SYS_BUS_DEVICE(obj), &err)) {
-                error_propagate(errp, err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(obj), errp)) {
                 return;
             }
 
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 22cbe68449..3767f7d8d0 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -258,8 +258,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
          * is needed when using -kernel
          */
 
-        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
             return;
         }
     }
@@ -299,15 +298,13 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_SRAM], &s->sram);
 
     /* SCU */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
 
     /* RTC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_RTC]);
@@ -317,8 +314,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
@@ -338,8 +334,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* I2C */
     object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_I2C]);
@@ -357,12 +352,10 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
                              &error_abort);
     if (!object_property_set_int(OBJECT(&s->fmc), "sdram-base",
-                                 sc->memmap[ASPEED_SDRAM], &err)) {
-        error_propagate(errp, err);
+                                 sc->memmap[ASPEED_SDRAM], errp)) {
         return;
     }
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_FMC]);
@@ -376,8 +369,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         object_property_set_link(OBJECT(&s->spi[i]), "dram",
                                  OBJECT(s->dram_mr), &error_abort);
         object_property_set_int(OBJECT(&s->spi[i]), "num-cs", 1, &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
@@ -388,8 +380,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
@@ -399,8 +390,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* SDMC - SDRAM Memory Controller */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_SDMC]);
@@ -411,8 +401,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
                                  &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
@@ -423,8 +412,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed", true,
                                  &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
@@ -434,8 +422,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->mii[i]), "nic",
                                  OBJECT(&s->ftgmac100[i]), &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mii[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->mii[i]), errp)) {
             return;
         }
 
@@ -444,8 +431,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* XDMA */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
@@ -454,16 +440,14 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
 
     /* GPIO */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_GPIO]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio_1_8v), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio_1_8v), 0,
@@ -472,8 +456,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_GPIO_1_8V));
 
     /* SDHCI */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
@@ -482,8 +465,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_SDHCI));
 
     /* eMMC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->emmc), 0, sc->memmap[ASPEED_EMMC]);
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index ff5f4d6a52..a1a8684216 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -230,8 +230,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     for (i = 0; i < sc->num_cpus; i++) {
-        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
             return;
         }
     }
@@ -247,15 +246,13 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_SRAM], &s->sram);
 
     /* SCU */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_SCU]);
 
     /* VIC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->vic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->vic), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->vic), 0, sc->memmap[ASPEED_VIC]);
@@ -265,8 +262,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
     /* RTC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, sc->memmap[ASPEED_RTC]);
@@ -276,8 +272,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* Timer */
     object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->timerctrl), 0,
@@ -297,8 +292,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* I2C */
     object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_I2C]);
@@ -309,12 +303,10 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
                              &error_abort);
     if (!object_property_set_int(OBJECT(&s->fmc), "sdram-base",
-                                 sc->memmap[ASPEED_SDRAM], &err)) {
-        error_propagate(errp, err);
+                                 sc->memmap[ASPEED_SDRAM], errp)) {
         return;
     }
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fmc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fmc), 0, sc->memmap[ASPEED_FMC]);
@@ -326,8 +318,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
         object_property_set_int(OBJECT(&s->spi[i]), "num-cs", 1, &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->spi[i]), 0,
@@ -338,8 +329,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
@@ -349,8 +339,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SDMC - SDRAM Memory Controller */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdmc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdmc), 0, sc->memmap[ASPEED_SDMC]);
@@ -361,8 +350,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
         object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
                                  &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
@@ -373,8 +361,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->macs_num; i++) {
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed", true,
                                  &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
@@ -384,8 +371,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* XDMA */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xdma), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
@@ -394,8 +380,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
 
     /* GPIO */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->memmap[ASPEED_GPIO]);
@@ -403,8 +388,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_GPIO));
 
     /* SDHCI */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index cb724c18e8..a9d7f53f6e 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -156,8 +156,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     /* Interrupt Controller */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ic), errp)) {
         return;
     }
 
@@ -166,8 +165,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     sysbus_pass_irq(SYS_BUS_DEVICE(s), SYS_BUS_DEVICE(&s->ic));
 
     /* Sys Timer */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->systmr), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->systmr), errp)) {
         return;
     }
     memory_region_add_subregion(&s->peri_mr, ST_OFFSET,
@@ -178,8 +176,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 
     /* UART0 */
     qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart0), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart0), errp)) {
         return;
     }
 
@@ -192,8 +189,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     /* AUX / UART1 */
     qdev_prop_set_chr(DEVICE(&s->aux), "chardev", serial_hd(1));
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->aux), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->aux), errp)) {
         return;
     }
 
@@ -204,8 +200,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_AUX));
 
     /* Mailboxes */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mboxes), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mboxes), errp)) {
         return;
     }
 
@@ -223,13 +218,11 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     if (!object_property_set_uint(OBJECT(&s->fb), "vcram-base",
-                                  ram_size - vcram_size, &err)) {
-        error_propagate(errp, err);
+                                  ram_size - vcram_size, errp)) {
         return;
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fb), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fb), errp)) {
         return;
     }
 
@@ -239,8 +232,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_FB));
 
     /* Property channel */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->property), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->property), errp)) {
         return;
     }
 
@@ -251,8 +243,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                       qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_PROPERTY));
 
     /* Random Number Generator */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng), errp)) {
         return;
     }
 
@@ -275,8 +266,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                              BCM2835_SDHC_CAPAREG, &error_abort);
     object_property_set_bool(OBJECT(&s->sdhci), "pending-insert-quirk", true,
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp)) {
         return;
     }
 
@@ -287,8 +277,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_ARASANSDIO));
 
     /* SDHOST */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhost), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhost), errp)) {
         return;
     }
 
@@ -299,8 +288,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_SDIO));
 
     /* DMA Channels */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dma), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp)) {
         return;
     }
 
@@ -317,16 +305,14 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     }
 
     /* THERMAL */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), errp)) {
         return;
     }
     memory_region_add_subregion(&s->peri_mr, THERMAL_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0));
 
     /* GPIO */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
 
@@ -336,8 +322,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
 
     /* Mphi */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mphi), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mphi), errp)) {
         return;
     }
 
@@ -348,8 +333,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_HOSTPORT));
 
     /* DWC2 */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dwc2), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dwc2), errp)) {
         return;
     }
 
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 0d373af1a1..f15cc3b405 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -72,7 +72,6 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     BCM283XClass *bc = BCM283X_GET_CLASS(dev);
     const BCM283XInfo *info = bc->info;
     Object *obj;
-    Error *err = NULL;
     int n;
 
     /* common peripherals from bcm2835 */
@@ -81,8 +80,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peripherals), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peripherals), errp)) {
         return;
     }
 
@@ -93,8 +91,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                             info->peri_base, 1);
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->control), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->control), errp)) {
         return;
     }
 
@@ -111,8 +108,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
         /* set periphbase/CBAR value for CPU-local registers */
         if (!object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
-                                     info->peri_base, &err)) {
-            error_propagate(errp, err);
+                                     info->peri_base, errp)) {
             return;
         }
 
@@ -120,13 +116,11 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         if (!object_property_set_bool(OBJECT(&s->cpu[n].core),
                                       "start-powered-off",
                                       n >= s->enabled_cpus,
-                                      &err)) {
-            error_propagate(errp, err);
+                                      errp)) {
             return;
         }
 
-        if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
             return;
         }
 
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 2306034840..614232165c 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -52,24 +52,20 @@ static void digic_init(Object *obj)
 static void digic_realize(DeviceState *dev, Error **errp)
 {
     DigicState *s = DIGIC(dev);
-    Error *err = NULL;
     SysBusDevice *sbd;
     int i;
 
     if (!object_property_set_bool(OBJECT(&s->cpu), "reset-hivecs", true,
-                                  &err)) {
-        error_propagate(errp, err);
+                                  errp)) {
         return;
     }
 
-    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
     }
 
     for (i = 0; i < DIGIC4_NB_TIMERS; i++) {
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
             return;
         }
 
@@ -78,8 +74,7 @@ static void digic_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
         return;
     }
 
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index ea72a02d06..b4ddceae45 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -85,13 +85,11 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     uint8_t i;
     Error *err = NULL;
 
-    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->avic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->avic), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->avic), 0, FSL_IMX25_AVIC_ADDR);
@@ -100,8 +98,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX25_CCM_ADDR);
@@ -121,8 +118,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
@@ -145,8 +141,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->gpt[i].ccm = IMX_CCM(&s->ccm);
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, gpt_table[i].addr);
@@ -167,8 +162,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->epit[i]), 0, epit_table[i].addr);
@@ -179,16 +173,14 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 
     qdev_set_nic_properties(DEVICE(&s->fec), &nd_table[0]);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fec), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->fec), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->fec), 0, FSL_IMX25_FEC_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->fec), 0,
                        qdev_get_gpio_in(DEVICE(&s->avic), FSL_IMX25_FEC_IRQ));
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rngc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rngc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rngc), 0, FSL_IMX25_RNGC_ADDR);
@@ -206,8 +198,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_I2C3_ADDR, FSL_IMX25_I2C3_IRQ }
         };
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
@@ -228,8 +219,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_GPIO4_ADDR, FSL_IMX25_GPIO4_IRQ }
         };
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
@@ -255,8 +245,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                  IMX25_ESDHC_CAPABILITIES, &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
                                  SDHCI_VENDOR_IMX, &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 23a5f50175..0983998bb4 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -66,13 +66,11 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     uint16_t i;
     Error *err = NULL;
 
-    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->avic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->avic), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->avic), 0, FSL_IMX31_AVIC_ADDR);
@@ -81,8 +79,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->avic), 1,
                        qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX31_CCM_ADDR);
@@ -99,8 +96,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
 
@@ -112,8 +108,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), errp)) {
         return;
     }
 
@@ -133,8 +128,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
         }
 
@@ -156,8 +150,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the I2C */
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
             return;
         }
         /* Map I2C memory */
@@ -181,8 +174,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 
         object_property_set_bool(OBJECT(&s->gpio[i]), "has-edge-sel", false,
                                  &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index e359ee579d..0bc9f0b60d 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -130,8 +130,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                      true, &error_abort);
         }
 
-        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
             return;
         }
     }
@@ -142,8 +141,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->a9mpcore), "num-irq",
                             FSL_IMX6_MAX_IRQ + GIC_INTERNAL, &error_abort);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, FSL_IMX6_A9MPCORE_ADDR);
@@ -155,14 +153,12 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccm), 0, FSL_IMX6_CCM_ADDR);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->src), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->src), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0, FSL_IMX6_SRC_ADDR);
@@ -182,8 +178,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
 
@@ -195,8 +190,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
     s->gpt.ccm = IMX_CCM(&s->ccm);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), errp)) {
         return;
     }
 
@@ -217,8 +211,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         s->epit[i].ccm = IMX_CCM(&s->ccm);
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->epit[i]), errp)) {
             return;
         }
 
@@ -239,8 +232,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_I2C3_ADDR, FSL_IMX6_I2C3_IRQ }
         };
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
             return;
         }
 
@@ -298,8 +290,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  &error_abort);
         object_property_set_bool(OBJECT(&s->gpio[i]), "has-upper-pin-irq",
                                  true, &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
             return;
         }
 
@@ -331,8 +322,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  IMX6_ESDHC_CAPABILITIES, &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
                                  SDHCI_VENDOR_IMX, &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->esdhc[i]), 0, esdhc_table[i].addr);
@@ -377,8 +367,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* Initialize the SPI */
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
 
@@ -389,8 +378,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->eth), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->eth), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->eth), 0, FSL_IMX6_ENET_ADDR);
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index e6e4bb3153..16bb7c9916 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -93,7 +93,6 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     MSF2State *s = MSF2_SOC(dev_soc);
     DeviceState *dev, *armv7m;
     SysBusDevice *busdev;
-    Error *err = NULL;
     int i;
 
     MemoryRegion *system_memory = get_system_memory();
@@ -125,8 +124,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), "memory",
                              OBJECT(get_system_memory()), &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
         return;
     }
 
@@ -152,8 +150,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->timer);
     /* APB0 clock is the timer input clock */
     qdev_prop_set_uint32(dev, "clock-frequency", s->m3clk / s->apb0div);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -166,8 +163,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->sysreg);
     qdev_prop_set_uint32(dev, "apb0divisor", s->apb0div);
     qdev_prop_set_uint32(dev, "apb1divisor", s->apb1div);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -176,8 +172,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < MSF2_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
 
@@ -195,8 +190,7 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     dev = DEVICE(&s->emac);
     object_property_set_link(OBJECT(&s->emac), "ahb-bus",
                              OBJECT(get_system_memory()), &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 7877d2bf60..45e6cc97d7 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -67,8 +67,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     object_property_set_link(OBJECT(&s->cpu), "memory", OBJECT(&s->container),
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu), errp)) {
         return;
     }
 
@@ -83,8 +82,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(&s->container, NRF51_SRAM_BASE, &s->sram);
 
     /* UART */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
         return;
     }
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
@@ -94,8 +92,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
                        BASE_TO_IRQ(NRF51_UART_BASE)));
 
     /* RNG */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng), errp)) {
         return;
     }
 
@@ -107,13 +104,11 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* UICR, FICR, NVMC, FLASH */
     if (!object_property_set_uint(OBJECT(&s->nvm), "flash-size",
-                                  s->flash_size, &err)) {
-        error_propagate(errp, err);
+                                  s->flash_size, errp)) {
         return;
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nvm), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->nvm), errp)) {
         return;
     }
 
@@ -127,8 +122,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion_overlap(&s->container, NRF51_FLASH_BASE, mr, 0);
 
     /* GPIO */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
 
@@ -140,12 +134,10 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* TIMER */
     for (i = 0; i < NRF51_NUM_TIMERS; i++) {
-        if (!object_property_set_uint(OBJECT(&s->timer[i]), "id", i, &err)) {
-            error_propagate(errp, err);
+        if (!object_property_set_uint(OBJECT(&s->timer[i]), "id", i, errp)) {
             return;
         }
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
             return;
         }
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 9acf401fbf..a4f3344db2 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -81,7 +81,6 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     STM32F205State *s = STM32F205_SOC(dev_soc);
     DeviceState *dev, *armv7m;
     SysBusDevice *busdev;
-    Error *err = NULL;
     int i;
 
     MemoryRegion *system_memory = get_system_memory();
@@ -107,15 +106,13 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), "memory",
                              OBJECT(get_system_memory()), &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
         return;
     }
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -126,8 +123,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -139,8 +135,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -151,8 +146,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* ADC 1 to 3 */
     object_property_set_int(OBJECT(s->adc_irqs), "num-lines", STM_NUM_ADCS,
                             &error_abort);
-    if (!qdev_realize(DEVICE(s->adc_irqs), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(s->adc_irqs), NULL, errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(s->adc_irqs), 0,
@@ -160,8 +154,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -173,8 +166,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     /* SPI 1 and 2 */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index ddc680bfe0..cb04c11198 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -118,15 +118,13 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
     object_property_set_link(OBJECT(&s->armv7m), "memory",
                              OBJECT(system_memory), &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
         return;
     }
 
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
@@ -137,8 +135,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_USARTS; i++) {
         dev = DEVICE(&(s->usart[i]));
         qdev_prop_set_chr(dev, "chardev", serial_hd(i));
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -150,8 +147,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     for (i = 0; i < STM_NUM_TIMERS; i++) {
         dev = DEVICE(&(s->timer[i]));
         qdev_prop_set_uint64(dev, "clock-frequency", 1000000000);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -162,14 +158,12 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     /* ADC device, the IRQs are ORed together */
     if (!object_initialize_child_with_props(OBJECT(s), "adc-orirq",
                                             &s->adc_irqs, sizeof(s->adc_irqs),
-                                            TYPE_OR_IRQ, &err, NULL)) {
-        error_propagate(errp, err);
+                                            TYPE_OR_IRQ, errp, NULL)) {
         return;
     }
     object_property_set_int(OBJECT(&s->adc_irqs), "num-lines", STM_NUM_ADCS,
                             &error_abort);
-    if (!qdev_realize(DEVICE(&s->adc_irqs), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->adc_irqs), NULL, errp)) {
         return;
     }
     qdev_connect_gpio_out(DEVICE(&s->adc_irqs), 0,
@@ -177,8 +171,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adc[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -190,8 +183,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     /* SPI devices */
     for (i = 0; i < STM_NUM_SPIS; i++) {
         dev = DEVICE(&(s->spi[i]));
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
         busdev = SYS_BUS_DEVICE(dev);
@@ -201,8 +193,7 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* EXTI device */
     dev = DEVICE(&s->exti);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->exti), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(dev);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 055b778d11..772cfa3771 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -176,7 +176,6 @@ static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
 static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
                                    const char *boot_cpu, Error **errp)
 {
-    Error *err = NULL;
     int i;
     int num_rpus = MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
                        XLNX_ZYNQMP_NUM_RPU_CPUS);
@@ -209,8 +208,7 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
 
         object_property_set_bool(OBJECT(&s->rpu_cpu[i]), "reset-hivecs", true,
                                  &error_abort);
-        if (!qdev_realize(DEVICE(&s->rpu_cpu[i]), NULL, &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->rpu_cpu[i]), NULL, errp)) {
             return;
         }
     }
@@ -366,14 +364,12 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 GIC_BASE_ADDR, &error_abort);
         object_property_set_int(OBJECT(&s->apu_cpu[i]), "core-count",
                                 num_apus, &error_abort);
-        if (!qdev_realize(DEVICE(&s->apu_cpu[i]), NULL, &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->apu_cpu[i]), NULL, errp)) {
             return;
         }
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
 
@@ -467,8 +463,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                                 &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), "num-priority-queues", 2,
                                 &error_abort);
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
@@ -478,8 +473,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
         qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, uart_addr[i]);
@@ -489,8 +483,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     object_property_set_int(OBJECT(&s->sata), "num-ports", SATA_NUM_PORTS,
                             &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), errp)) {
         return;
     }
 
@@ -507,21 +500,17 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
          * - SDIO Specification Version 3.0
          * - eMMC Specification Version 4.51
          */
-        if (!object_property_set_uint(sdhci, "sd-spec-version", 3, &err)) {
-            error_propagate(errp, err);
+        if (!object_property_set_uint(sdhci, "sd-spec-version", 3, errp)) {
             return;
         }
         if (!object_property_set_uint(sdhci, "capareg", SDHCI_CAPABILITIES,
-                                      &err)) {
-            error_propagate(errp, err);
+                                      errp)) {
             return;
         }
-        if (!object_property_set_uint(sdhci, "uhs", UHS_I, &err)) {
-            error_propagate(errp, err);
+        if (!object_property_set_uint(sdhci, "uhs", UHS_I, errp)) {
             return;
         }
-        if (!sysbus_realize(SYS_BUS_DEVICE(sdhci), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(sdhci), errp)) {
             return;
         }
         sysbus_mmio_map(sbd, 0, sdhci_addr[i]);
@@ -536,8 +525,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < XLNX_ZYNQMP_NUM_SPIS; i++) {
         gchar *bus_name;
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
         }
 
@@ -552,8 +540,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(bus_name);
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->qspi), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->qspi), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->qspi), 0, QSPI_ADDR);
@@ -573,15 +560,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         g_free(target_bus);
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dp), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dp), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dp), 0, DP_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dp), 0, gic_spi[DP_IRQ]);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dpdma), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->dpdma), errp)) {
         return;
     }
     object_property_set_link(OBJECT(&s->dp), "dpdma", OBJECT(&s->dpdma),
@@ -589,15 +574,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ipi), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ipi), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ipi), 0, IPI_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ipi), 0, gic_spi[IPI_IRQ]);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rtc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, RTC_ADDR);
@@ -605,12 +588,10 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
         if (!object_property_set_uint(OBJECT(&s->gdma[i]), "bus-width", 128,
-                                      &err)) {
-            error_propagate(errp, err);
+                                      errp)) {
             return;
         }
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gdma[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gdma[i]), errp)) {
             return;
         }
 
@@ -620,8 +601,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_ADMA_CH; i++) {
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adma[i]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->adma[i]), errp)) {
             return;
         }
 
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 3be8c7be5b..f22f46c9c9 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2575,8 +2575,7 @@ static void fdctrl_connect_drives(FDCtrl *fdctrl, DeviceState *fdc_dev,
             return;
         }
 
-        if (!qdev_realize_and_unref(dev, &fdctrl->bus.bus, &local_err)) {
-            error_propagate(errp, local_err);
+        if (!qdev_realize_and_unref(dev, &fdctrl->bus.bus, errp)) {
             return;
         }
     }
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 89a4d02a1b..96c6c009c7 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -403,7 +403,6 @@ static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     XenBlockVdev *vdev = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     char *str, *p;
     const char *end;
 
@@ -412,8 +411,7 @@ static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 1328967461..2cf3e44177 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -95,7 +95,6 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
     PCIMultiSerialState *pci = DO_UPCAST(PCIMultiSerialState, dev, dev);
     SerialState *s;
-    Error *err = NULL;
     size_t i, nports = multi_serial_get_port_count(pc);
 
     pci->dev.config[PCI_CLASS_PROG] = pci->prog_if;
@@ -106,8 +105,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 
     for (i = 0; i < nports; i++) {
         s = pci->state + i;
-        if (!qdev_realize(DEVICE(s), NULL, &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(s), NULL, errp)) {
             multi_serial_pci_exit(dev);
             return;
         }
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index d22617426b..cd56924a43 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -47,10 +47,8 @@ static void serial_pci_realize(PCIDevice *dev, Error **errp)
 {
     PCISerialState *pci = DO_UPCAST(PCISerialState, dev, dev);
     SerialState *s = &pci->state;
-    Error *err = NULL;
 
-    if (!qdev_realize(DEVICE(s), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(s), NULL, errp)) {
         return;
     }
 
diff --git a/hw/char/serial.c b/hw/char/serial.c
index e69096eace..2386479492 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -989,10 +989,8 @@ static void serial_io_realize(DeviceState *dev, Error **errp)
 {
     SerialIO *sio = SERIAL_IO(dev);
     SerialState *s = &sio->serial;
-    Error *local_err = NULL;
 
-    if (!qdev_realize(DEVICE(s), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(s), NULL, errp)) {
         return;
     }
 
@@ -1095,10 +1093,8 @@ static void serial_mm_realize(DeviceState *dev, Error **errp)
 {
     SerialMM *smm = SERIAL_MM(dev);
     SerialState *s = &smm->serial;
-    Error *local_err = NULL;
 
-    if (!qdev_realize(DEVICE(s), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(s), NULL, errp)) {
         return;
     }
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7ff0af93ef..eb267b828d 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -290,11 +290,9 @@ static void machine_set_phandle_start(Object *obj, Visitor *v,
                                       Error **errp)
 {
     MachineState *ms = MACHINE(obj);
-    Error *error = NULL;
     int64_t value;
 
-    if (!visit_type_int(v, name, &value, &error)) {
-        error_propagate(errp, error);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 7d2387f22c..3e4f16fc21 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -80,7 +80,6 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    Error *local_err = NULL;
     void **ptr = qdev_get_prop_ptr(dev, prop);
     char *str;
     BlockBackend *blk;
@@ -92,8 +91,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
@@ -226,7 +224,6 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
                     Error **errp)
 {
     DeviceState *dev = DEVICE(obj);
-    Error *local_err = NULL;
     Property *prop = opaque;
     CharBackend *be = qdev_get_prop_ptr(dev, prop);
     Chardev *s;
@@ -237,8 +234,7 @@ static void set_chr(Object *obj, Visitor *v, const char *name, void *opaque,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
@@ -305,7 +301,6 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     NICPeers *peers_ptr = qdev_get_prop_ptr(dev, prop);
     NetClientState **ncs = peers_ptr->ncs;
     NetClientState *peers[MAX_QUEUE_NUM];
-    Error *local_err = NULL;
     int queues, err = 0, i = 0;
     char *str;
 
@@ -314,8 +309,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
@@ -386,7 +380,6 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
     Property *prop = opaque;
     QEMUSoundCard *card = qdev_get_prop_ptr(dev, prop);
     AudioState *state;
-    Error *local_err = NULL;
     int err = 0;
     char *str;
 
@@ -395,8 +388,7 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index be8d4eb9f6..2bec8a80b8 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -117,7 +117,6 @@ static void prop_set_bit(Object *obj, Visitor *v, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    Error *local_err = NULL;
     bool value;
 
     if (dev->realized) {
@@ -125,8 +124,7 @@ static void prop_set_bit(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_bool(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
     bit_prop_set(dev, prop, value);
@@ -180,7 +178,6 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
 {
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
-    Error *local_err = NULL;
     bool value;
 
     if (dev->realized) {
@@ -188,8 +185,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_bool(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
     bit64_prop_set(dev, prop, value);
@@ -476,7 +472,6 @@ static void set_string(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     char **ptr = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     char *str;
 
     if (dev->realized) {
@@ -484,8 +479,7 @@ static void set_string(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
     g_free(*ptr);
@@ -528,7 +522,6 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     MACAddr *mac = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     int i, pos;
     char *str, *p;
 
@@ -537,8 +530,7 @@ static void set_mac(Object *obj, Visitor *v, const char *name, void *opaque,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
@@ -832,15 +824,13 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
     Property *prop = opaque;
     uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
     uint64_t value;
-    Error *local_err = NULL;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
 
-    if (!visit_type_size(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
 
@@ -881,15 +871,13 @@ static void set_blocksize(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     uint32_t *ptr = qdev_get_prop_ptr(dev, prop);
     uint64_t value;
-    Error *local_err = NULL;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
 
-    if (!visit_type_size(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
     /* value of 0 means "unset" */
@@ -957,7 +945,6 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     PCIHostDeviceAddress *addr = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     char *str, *p;
     char *e;
     unsigned long val;
@@ -969,8 +956,7 @@ static void set_pci_host_devaddr(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
@@ -1060,7 +1046,6 @@ static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     QemuUUID *uuid = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     char *str;
 
     if (dev->realized) {
@@ -1068,8 +1053,7 @@ static void set_uuid(Object *obj, Visitor *v, const char *name, void *opaque,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
@@ -1135,7 +1119,6 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     uint32_t *alenptr = qdev_get_prop_ptr(dev, prop);
     void **arrayptr = (void *)dev + prop->arrayoffset;
-    Error *local_err = NULL;
     void *eltptr;
     const char *arrayname;
     int i;
@@ -1149,8 +1132,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
                    name);
         return;
     }
-    if (!visit_type_uint32(v, name, alenptr, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, alenptr, errp)) {
         return;
     }
     if (!*alenptr) {
@@ -1473,7 +1455,6 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
     int speed;
-    Error *local_err = NULL;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -1481,8 +1462,7 @@ static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
     }
 
     if (!visit_type_enum(v, prop->name, &speed, prop->info->enum_table,
-                         &local_err)) {
-        error_propagate(errp, local_err);
+                         errp)) {
         return;
     }
 
@@ -1561,7 +1541,6 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
     int width;
-    Error *local_err = NULL;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -1569,8 +1548,7 @@ static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
     }
 
     if (!visit_type_enum(v, prop->name, &width, prop->info->enum_table,
-                         &local_err)) {
-        error_propagate(errp, local_err);
+                         errp)) {
         return;
     }
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 358c6152c7..c377be398d 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -53,7 +53,6 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *gicdev;
     SysBusDevice *busdev;
     int i;
-    Error *err = NULL;
     bool has_el3;
     bool has_el2 = false;
     Object *cpuobj;
@@ -76,8 +75,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
         qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
     }
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(&s->gic);
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index fc35dcf179..351295e518 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -50,15 +50,13 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *scudev, *gicdev, *gtimerdev, *mptimerdev, *wdtdev;
     SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
                  *wdtbusdev;
-    Error *err = NULL;
     int i;
     bool has_el3;
     Object *cpuobj;
 
     scudev = DEVICE(&s->scu);
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
     scubusdev = SYS_BUS_DEVICE(&s->scu);
@@ -77,8 +75,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
         object_property_get_bool(cpuobj, "has_el3", &error_abort);
     qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
     gicbusdev = SYS_BUS_DEVICE(&s->gic);
@@ -91,24 +88,21 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     gtimerdev = DEVICE(&s->gtimer);
     qdev_prop_set_uint32(gtimerdev, "num-cpu", s->num_cpu);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gtimer), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gtimer), errp)) {
         return;
     }
     gtimerbusdev = SYS_BUS_DEVICE(&s->gtimer);
 
     mptimerdev = DEVICE(&s->mptimer);
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), errp)) {
         return;
     }
     mptimerbusdev = SYS_BUS_DEVICE(&s->mptimer);
 
     wdtdev = DEVICE(&s->wdt);
     qdev_prop_set_uint32(wdtdev, "num-cpu", s->num_cpu);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt), errp)) {
         return;
     }
     wdtbusdev = SYS_BUS_DEVICE(&s->wdt);
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index c5eef9514d..89c4e35143 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -76,11 +76,9 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     DeviceState *gicdev = DEVICE(&s->gic);
     DeviceState *mptimerdev = DEVICE(&s->mptimer);
     DeviceState *wdtimerdev = DEVICE(&s->wdtimer);
-    Error *err = NULL;
 
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
 
@@ -90,8 +88,7 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
                          ARM11MPCORE_NUM_GIC_PRIORITY_BITS);
 
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
 
@@ -102,14 +99,12 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, mpcore_priv_set_irq, s->num_irq - 32);
 
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), errp)) {
         return;
     }
 
     qdev_prop_set_uint32(wdtimerdev, "num-cpu", s->num_cpu);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdtimer), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdtimer), errp)) {
         return;
     }
 
diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index d9857031ca..3a659291ea 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -28,11 +28,9 @@ static void core_prop_set_core_id(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     CPUCore *core = CPU_CORE(obj);
-    Error *local_err = NULL;
     int64_t value;
 
-    if (!visit_type_int(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
 
@@ -57,11 +55,9 @@ static void core_prop_set_nr_threads(Object *obj, Visitor *v, const char *name,
                                      void *opaque, Error **errp)
 {
     CPUCore *core = CPU_CORE(obj);
-    Error *local_err = NULL;
     int64_t value;
 
-    if (!visit_type_int(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
 
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index bf3e48b48e..96f4d2517a 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -65,13 +65,11 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     DeviceState *priv = DEVICE(&s->priv);
     DeviceState *gic;
     SysBusDevice *gicbusdev;
-    Error *err = NULL;
     int n;
     int i;
 
     qdev_prop_set_uint32(priv, "num-cpu", s->num_cpu);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->priv), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->priv), errp)) {
         return;
     }
     sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->priv));
@@ -80,8 +78,7 @@ static void realview_mpcore_realize(DeviceState *dev, Error **errp)
     }
     /* ??? IRQ routing is hardcoded to "normal" mode.  */
     for (n = 0; n < 4; n++) {
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic[n]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic[n]), errp)) {
             return;
         }
         gic = DEVICE(&s->gic[n]);
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index d5b7d39bc4..34d8e93f28 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -31,11 +31,9 @@ static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOGPUBase *g = vgpu->vgpu;
     DeviceState *vdev = DEVICE(g);
     int i;
-    Error *local_error = NULL;
 
     virtio_pci_force_virtio_1(vpci_dev);
-    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), &local_error)) {
-        error_propagate(errp, local_error);
+    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
         return;
     }
 
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index d5cebf686f..f533d7d1b4 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -93,7 +93,6 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOVGABase *vvga = VIRTIO_VGA_BASE(vpci_dev);
     VirtIOGPUBase *g = vvga->vgpu;
     VGACommonState *vga = &vvga->vga;
-    Error *err = NULL;
     uint32_t offset;
     int i;
 
@@ -138,8 +137,7 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 
     /* init virtio bits */
     virtio_pci_force_virtio_1(vpci_dev);
-    if (!qdev_realize(DEVICE(g), BUS(&vpci_dev->bus), &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(g), BUS(&vpci_dev->bus), errp)) {
         return;
     }
 
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 3310fe62fe..985a259e05 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -755,15 +755,13 @@ static void aspeed_gpio_get_pin(Object *obj, Visitor *v, const char *name,
 static void aspeed_gpio_set_pin(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    Error *local_err = NULL;
     bool level;
     int pin = 0xfff;
     char group[4];
     AspeedGPIOState *s = ASPEED_GPIO(obj);
     int set_idx, group_idx = 0;
 
-    if (!visit_type_bool(v, name, &level, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &level, errp)) {
         return;
     }
     if (sscanf(name, "gpio%2[A-Z]%1d", group, &pin) != 2) {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 70771d6632..4c58b52b3d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1839,11 +1839,9 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
                                             Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-    Error *error = NULL;
     uint64_t value;
 
-    if (!visit_type_size(v, name, &value, &error)) {
-        error_propagate(errp, error);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
     if (value > 4 * GiB) {
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 76c3f78e11..dc070343c0 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -420,7 +420,6 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
 {
     APICCommonState *s = APIC_COMMON(obj);
     DeviceState *dev = DEVICE(obj);
-    Error *local_err = NULL;
     uint32_t value;
 
     if (dev->realized) {
@@ -428,8 +427,7 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_uint32(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
 
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 80a915e922..3c4b6e6d70 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2619,7 +2619,6 @@ static void nvic_systick_trigger(void *opaque, int n, int level)
 static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 {
     NVICState *s = NVIC(dev);
-    Error *err = NULL;
     int regionlen;
 
     /* The armv7m container object will have set our CPU pointer */
@@ -2640,8 +2639,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
 
     s->num_prio_bits = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 8 : 2;
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), errp)) {
         return;
     }
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->systick[M_REG_NS]), 0,
@@ -2656,8 +2654,7 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
         object_initialize_child(OBJECT(dev), "systick-reg-s",
                                 &s->systick[M_REG_S], TYPE_SYSTICK);
 
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_S]), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->systick[M_REG_S]), errp)) {
             return;
         }
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->systick[M_REG_S]), 0,
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index d6780061f4..5f69626b3a 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1832,8 +1832,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(xsrc), "nr-irqs", PNV_XIVE_NR_IRQS,
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), "xive", OBJECT(xive), &error_abort);
-    if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
 
@@ -1841,8 +1840,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(end_xsrc), "xive", OBJECT(xive),
                              &error_abort);
-    if (!qdev_realize(DEVICE(end_xsrc), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(end_xsrc), NULL, errp)) {
         return;
     }
 
diff --git a/hw/intc/realview_gic.c b/hw/intc/realview_gic.c
index aa0010e91f..9b12116b2a 100644
--- a/hw/intc/realview_gic.c
+++ b/hw/intc/realview_gic.c
@@ -26,7 +26,6 @@ static void realview_gic_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     RealViewGICState *s = REALVIEW_GIC(dev);
     SysBusDevice *busdev;
-    Error *err = NULL;
     /* The GICs on the RealView boards have a fixed nonconfigurable
      * number of interrupt lines, so we don't need to expose this as
      * a qdev property.
@@ -34,8 +33,7 @@ static void realview_gic_realize(DeviceState *dev, Error **errp)
     int numirq = 96;
 
     qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", numirq);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
     busdev = SYS_BUS_DEVICE(&s->gic);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 1f42bf4f43..89c8cd9667 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -311,8 +311,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(xsrc), "nr-irqs", xive->nr_irqs,
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), "xive", OBJECT(xive), &error_abort);
-    if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
     sysbus_init_mmio(SYS_BUS_DEVICE(xive), &xsrc->esb_mmio);
@@ -324,8 +323,7 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(end_xsrc), "xive", OBJECT(xive),
                              &error_abort);
-    if (!qdev_realize(DEVICE(end_xsrc), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(end_xsrc), NULL, errp)) {
         return;
     }
     sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 8d6156578f..68bb1914b9 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -309,16 +309,14 @@ int ics_set_kvm_state(ICSState *ics, Error **errp)
     }
 
     for (i = 0; i < ics->nr_irqs; i++) {
-        Error *local_err = NULL;
         int ret;
 
         if (ics_irq_free(ics, i)) {
             continue;
         }
 
-        ret = ics_set_kvm_state_one(ics, i, &local_err);
+        ret = ics_set_kvm_state_one(ics, i, errp);
         if (ret < 0) {
-            error_propagate(errp, local_err);
             return ret;
         }
     }
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 09d7daabed..ac044afa95 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -150,7 +150,6 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     PIIX4State *s = PIIX4_PCI_DEVICE(dev);
     ISABus *isa_bus;
     qemu_irq *i8259_out_irq;
-    Error *err = NULL;
 
     isa_bus = isa_bus_new(DEVICE(dev), pci_address_space(dev),
                           pci_address_space_io(dev), errp);
@@ -183,8 +182,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
 
     /* RTC */
     qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
-    if (!qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), errp)) {
         return;
     }
     isa_init_irq(ISA_DEVICE(&s->rtc), &s->rtc.irq, RTC_ISA_IRQ);
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 838ebcd227..d0d6e553cf 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -45,7 +45,6 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
     NVDIMMDevice *nvdimm = NVDIMM(obj);
-    Error *local_err = NULL;
     uint64_t value;
 
     if (nvdimm->nvdimm_mr) {
@@ -53,8 +52,7 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_size(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &value, errp)) {
         return;
     }
     if (value < MIN_NAMESPACE_LABEL_SIZE) {
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index d22d3e22d1..5f994547f7 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -76,7 +76,6 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
 static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
 {
     XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(dev);
-    Error *err = NULL;
 
     object_property_set_uint(OBJECT(&s->cpu), "base-vectors",
                              XLNX_ZYNQMP_PMU_ROM_ADDR, &error_abort);
@@ -96,8 +95,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_str(OBJECT(&s->cpu), "version", "8.40.b",
                             &error_abort);
     object_property_set_uint(OBJECT(&s->cpu), "pvr", 0, &error_abort);
-    if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
     }
 
@@ -107,8 +105,7 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_uint(OBJECT(&s->intc), "intc-positive", 0xffff,
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->intc), 0, XLNX_ZYNQMP_PMU_INTC_ADDR);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 83a073fba5..615e1a1ad2 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -71,7 +71,6 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     CPUMIPSState *env;
     MIPSCPU *cpu;
     int i;
-    Error *err = NULL;
     target_ulong gcr_base;
     bool itu_present = false;
     bool saar_present = false;
@@ -109,8 +108,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         if (saar_present) {
             s->itu.saar = &env->CP0_SAAR;
         }
-        if (!sysbus_realize(SYS_BUS_DEVICE(&s->itu), &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->itu), errp)) {
             return;
         }
 
@@ -124,8 +122,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             &error_abort);
     object_property_set_int(OBJECT(&s->cpc), "vp-start-running", 1,
                             &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), errp)) {
         return;
     }
 
@@ -138,8 +135,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                             &error_abort);
     object_property_set_int(OBJECT(&s->gic), "num-irq", 128,
                             &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
     }
 
@@ -160,8 +156,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
         return;
     }
 
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 40682af0b3..0737d8de81 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -223,12 +223,10 @@ static void aspeed_sdmc_set_ram_size(Object *obj, Visitor *v, const char *name,
     int i;
     char *sz;
     int64_t value;
-    Error *local_err = NULL;
     AspeedSDMCState *s = ASPEED_SDMC(obj);
     AspeedSDMCClass *asc = ASPEED_SDMC_GET_CLASS(s);
 
-    if (!visit_type_int(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
 
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index cc7c26d67c..286e7a55f4 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -521,13 +521,11 @@ static void cuda_reset(DeviceState *dev)
 static void cuda_realize(DeviceState *dev, Error **errp)
 {
     CUDAState *s = CUDA(dev);
-    Error *err = NULL;
     SysBusDevice *sbd;
     ADBBusState *adb_bus = &s->adb_bus;
     struct tm tm;
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_cuda), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_cuda), errp)) {
         return;
     }
 
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 9b6e3f120e..679722628e 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -98,10 +98,8 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
 {
     MacIOState *s = MACIO(d);
     SysBusDevice *sysbus_dev;
-    Error *err = NULL;
 
-    if (!qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->dbdma), BUS(&s->macio_bus), errp)) {
         return;
     }
     sysbus_dev = SYS_BUS_DEVICE(&s->dbdma);
@@ -115,8 +113,7 @@ static void macio_common_realize(PCIDevice *d, Error **errp)
     qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hd(1));
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
     qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
-    if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->escc), BUS(&s->macio_bus), errp)) {
         return;
     }
 
@@ -157,8 +154,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
 
     qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                          s->frequency);
-    if (!qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), errp)) {
         return;
     }
     sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
@@ -173,8 +169,7 @@ static void macio_oldworld_realize(PCIDevice *d, Error **errp)
     sysbus_connect_irq(sysbus_dev, 1, qdev_get_gpio_in(pic_dev,
                                                        OLDWORLD_ESCCA_IRQ));
 
-    if (!qdev_realize(DEVICE(&os->nvram), BUS(&s->macio_bus), &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(&os->nvram), BUS(&s->macio_bus), errp)) {
         return;
     }
     sysbus_dev = SYS_BUS_DEVICE(&os->nvram);
@@ -343,8 +338,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         object_property_set_link(OBJECT(&s->pmu), "gpio", OBJECT(sysbus_dev),
                                  &error_abort);
         qdev_prop_set_bit(DEVICE(&s->pmu), "has-adb", ns->has_adb);
-        if (!qdev_realize(DEVICE(&s->pmu), BUS(&s->macio_bus), &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->pmu), BUS(&s->macio_bus), errp)) {
             return;
         }
         sysbus_dev = SYS_BUS_DEVICE(&s->pmu);
@@ -360,8 +354,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         qdev_prop_set_uint64(DEVICE(&s->cuda), "timebase-frequency",
                              s->frequency);
 
-        if (!qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), &err)) {
-            error_propagate(errp, err);
+        if (!qdev_realize(DEVICE(&s->cuda), BUS(&s->macio_bus), errp)) {
             return;
         }
         sysbus_dev = SYS_BUS_DEVICE(&s->cuda);
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 42ba963d8c..09022995ad 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -735,13 +735,11 @@ static void pmu_reset(DeviceState *dev)
 static void pmu_realize(DeviceState *dev, Error **errp)
 {
     PMUState *s = VIA_PMU(dev);
-    Error *err = NULL;
     SysBusDevice *sbd;
     ADBBusState *adb_bus = &s->adb_bus;
     struct tm tm;
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_pmu), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mos6522_pmu), errp)) {
         return;
     }
 
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index d2b99fc706..e4ccdeaf78 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -291,13 +291,11 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
 {
     PCA955xClass *k = PCA955X_GET_CLASS(obj);
     PCA955xState *s = PCA955X(obj);
-    Error *local_err = NULL;
     int led, rc, reg, val;
     uint8_t state;
     char *state_str;
 
-    if (!visit_type_str(v, name, &state_str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &state_str, errp)) {
         return;
     }
     rc = sscanf(name, "led%2d", &led);
diff --git a/hw/misc/tmp105.c b/hw/misc/tmp105.c
index 2ae0b899be..b47120492a 100644
--- a/hw/misc/tmp105.c
+++ b/hw/misc/tmp105.c
@@ -72,11 +72,9 @@ static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     TMP105State *s = TMP105(obj);
-    Error *local_err = NULL;
     int64_t temp;
 
-    if (!visit_type_int(v, name, &temp, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &temp, errp)) {
         return;
     }
     if (temp >= 128000 || temp < -128000) {
diff --git a/hw/misc/tmp421.c b/hw/misc/tmp421.c
index 9473382bd5..49abe2d246 100644
--- a/hw/misc/tmp421.c
+++ b/hw/misc/tmp421.c
@@ -141,14 +141,12 @@ static void tmp421_set_temperature(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     TMP421State *s = TMP421(obj);
-    Error *local_err = NULL;
     int64_t temp;
     bool ext_range = (s->config[0] & TMP421_CONFIG_RANGE);
     int offset = ext_range * 64 * 256;
     int tempid;
 
-    if (!visit_type_int(v, name, &temp, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &temp, errp)) {
         return;
     }
 
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 94cb989136..82132c12ca 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -990,7 +990,6 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
     PnvPHB3 *phb = PNV_PHB3(dev);
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
     PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
-    Error *local_err = NULL;
     int i;
 
     if (phb->phb_id >= PNV8_CHIP_PHB3_MAX) {
@@ -1003,8 +1002,7 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_int(OBJECT(&phb->lsis), "nr-irqs", PNV_PHB3_NUM_LSI,
                             &error_abort);
-    if (!qdev_realize(DEVICE(&phb->lsis), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&phb->lsis), NULL, errp)) {
         return;
     }
 
@@ -1021,16 +1019,14 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
                              &error_abort);
     object_property_set_int(OBJECT(&phb->msis), "nr-irqs", PHB3_MAX_MSI,
                             &error_abort);
-    if (!qdev_realize(DEVICE(&phb->msis), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&phb->msis), NULL, errp)) {
         return;
     }
 
     /* Power Bus Common Queue */
     object_property_set_link(OBJECT(&phb->pbcq), "phb", OBJECT(phb),
                              &error_abort);
-    if (!qdev_realize(DEVICE(&phb->pbcq), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&phb->pbcq), NULL, errp)) {
         return;
     }
 
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index a598c89eb0..75ad766fe0 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1169,7 +1169,6 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
     PnvPHB4 *phb = PNV_PHB4(dev);
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
     XiveSource *xsrc = &phb->xsrc;
-    Error *local_err = NULL;
     int nr_irqs;
     char name[32];
 
@@ -1218,8 +1217,7 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
     }
     object_property_set_int(OBJECT(xsrc), "nr-irqs", nr_irqs, &error_fatal);
     object_property_set_link(OBJECT(xsrc), "xive", OBJECT(phb), &error_fatal);
-    if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
 
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 088ab753aa..741ddc90ed 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -377,7 +377,6 @@ static void pnv_pec_instance_init(Object *obj)
 static void pnv_pec_realize(DeviceState *dev, Error **errp)
 {
     PnvPhb4PecState *pec = PNV_PHB4_PEC(dev);
-    Error *local_err = NULL;
     char name[64];
     int i;
 
@@ -390,8 +389,7 @@ static void pnv_pec_realize(DeviceState *dev, Error **errp)
 
         object_property_set_int(stk_obj, "stack-no", i, &error_abort);
         object_property_set_link(stk_obj, "pec", OBJECT(pec), &error_abort);
-        if (!qdev_realize(DEVICE(stk_obj), NULL, &local_err)) {
-            error_propagate(errp, local_err);
+        if (!qdev_realize(DEVICE(stk_obj), NULL, errp)) {
             return;
         }
     }
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 97fa970e72..5448d101d9 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -764,15 +764,13 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
 static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
                                           IrqLines *irqs, Error **errp)
 {
-    Error *err = NULL;
     DeviceState *dev;
     CPUState *cs;
 
     dev = qdev_new(TYPE_KVM_OPENPIC);
     qdev_prop_set_uint32(dev, "model", pmc->mpic_version);
 
-    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 194b457917..6670967e26 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1140,8 +1140,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
                             &error_fatal);
     object_property_set_link(OBJECT(&chip8->psi), ICS_PROP_XICS,
                              OBJECT(chip8->xics), &error_abort);
-    if (!qdev_realize(DEVICE(&chip8->psi), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip8->psi), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE,
@@ -1170,8 +1169,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     /* Create the simplified OCC model */
     object_property_set_link(OBJECT(&chip8->occ), "psi", OBJECT(&chip8->psi),
                              &error_abort);
-    if (!qdev_realize(DEVICE(&chip8->occ), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip8->occ), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_regs);
@@ -1183,8 +1181,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     /* HOMER */
     object_property_set_link(OBJECT(&chip8->homer), "chip", OBJECT(chip),
                              &error_abort);
-    if (!qdev_realize(DEVICE(&chip8->homer), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip8->homer), NULL, errp)) {
         return;
     }
     /* Homer Xscom region */
@@ -1202,8 +1199,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
         object_property_set_int(OBJECT(phb), "index", i, &error_fatal);
         object_property_set_int(OBJECT(phb), "chip-id", chip->chip_id,
                                 &error_fatal);
-        if (!sysbus_realize(SYS_BUS_DEVICE(phb), &local_err)) {
-            error_propagate(errp, local_err);
+        if (!sysbus_realize(SYS_BUS_DEVICE(phb), errp)) {
             return;
         }
 
@@ -1358,7 +1354,6 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
 static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
 {
     Pnv9Chip *chip9 = PNV9_CHIP(chip);
-    Error *local_err = NULL;
     int i, j;
     int phb_id = 0;
 
@@ -1380,8 +1375,7 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
                                 &error_fatal);
         object_property_set_link(OBJECT(pec), "system-memory",
                                  OBJECT(get_system_memory()), &error_abort);
-        if (!qdev_realize(DEVICE(pec), NULL, &local_err)) {
-            error_propagate(errp, local_err);
+        if (!qdev_realize(DEVICE(pec), NULL, errp)) {
             return;
         }
 
@@ -1405,8 +1399,7 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
                                     &error_fatal);
             object_property_set_link(obj, "stack", OBJECT(stack),
                                      &error_abort);
-            if (!sysbus_realize(SYS_BUS_DEVICE(obj), &local_err)) {
-                error_propagate(errp, local_err);
+            if (!sysbus_realize(SYS_BUS_DEVICE(obj), errp)) {
                 return;
             }
 
@@ -1464,8 +1457,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                             PNV9_XIVE_TM_BASE(chip), &error_fatal);
     object_property_set_link(OBJECT(&chip9->xive), "chip", OBJECT(chip),
                              &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&chip9->xive), &local_err)) {
-        error_propagate(errp, local_err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&chip9->xive), errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_XIVE_BASE,
@@ -1474,8 +1466,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip9->psi), "bar", PNV9_PSIHB_BASE(chip),
                             &error_fatal);
-    if (!qdev_realize(DEVICE(&chip9->psi), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip9->psi), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_PSIHB_BASE,
@@ -1484,8 +1475,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* LPC */
     object_property_set_link(OBJECT(&chip9->lpc), "psi", OBJECT(&chip9->psi),
                              &error_abort);
-    if (!qdev_realize(DEVICE(&chip9->lpc), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip9->lpc), NULL, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), PNV9_LPCM_BASE(chip),
@@ -1497,8 +1487,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* Create the simplified OCC model */
     object_property_set_link(OBJECT(&chip9->occ), "psi", OBJECT(&chip9->psi),
                              &error_abort);
-    if (!qdev_realize(DEVICE(&chip9->occ), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip9->occ), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom_regs);
@@ -1510,8 +1499,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* HOMER */
     object_property_set_link(OBJECT(&chip9->homer), "chip", OBJECT(chip),
                              &error_abort);
-    if (!qdev_realize(DEVICE(&chip9->homer), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip9->homer), NULL, errp)) {
         return;
     }
     /* Homer Xscom region */
@@ -1591,8 +1579,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip10->psi), "bar",
                             PNV10_PSIHB_BASE(chip), &error_fatal);
-    if (!qdev_realize(DEVICE(&chip10->psi), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip10->psi), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV10_XSCOM_PSIHB_BASE,
@@ -1601,8 +1588,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     /* LPC */
     object_property_set_link(OBJECT(&chip10->lpc), "psi",
                              OBJECT(&chip10->psi), &error_abort);
-    if (!qdev_realize(DEVICE(&chip10->lpc), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(&chip10->lpc), NULL, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), PNV10_LPCM_BASE(chip),
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index d699f077ad..4724ddf96c 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -173,8 +173,7 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
     Error *local_err = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(pc->chip);
 
-    if (!qdev_realize(DEVICE(cpu), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
         return;
     }
 
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 604788a8eb..5bdeec700e 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -501,17 +501,14 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
 {
     PnvPsi *psi = PNV_PSI(dev);
     ICSState *ics = &PNV8_PSI(psi)->ics;
-    Error *err = NULL;
     unsigned int i;
 
     /* Create PSI interrupt control source */
     if (!object_property_set_int(OBJECT(ics), "nr-irqs", PSI_NUM_INTERRUPTS,
-                                 &err)) {
-        error_propagate(errp, err);
+                                 errp)) {
         return;
     }
-    if (!qdev_realize(DEVICE(ics), NULL, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(DEVICE(ics), NULL, errp)) {
         return;
     }
 
@@ -841,7 +838,6 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvPsi *psi = PNV_PSI(dev);
     XiveSource *xsrc = &PNV9_PSI(psi)->source;
-    Error *local_err = NULL;
     int i;
 
     /* This is the only device with 4k ESB pages */
@@ -849,8 +845,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(xsrc), "nr-irqs", PSIHB9_NUM_IRQS,
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), "xive", OBJECT(psi), &error_abort);
-    if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 52be86e49c..3225fc5a2e 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -86,10 +86,8 @@ static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
     SpaprCapabilityInfo *cap = opaque;
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
     bool value;
-    Error *local_err = NULL;
 
-    if (!visit_type_bool(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
 
@@ -122,12 +120,10 @@ static void spapr_cap_set_string(Object *obj, Visitor *v, const char *name,
 {
     SpaprCapabilityInfo *cap = opaque;
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
-    Error *local_err = NULL;
     uint8_t i;
     char *val;
 
-    if (!visit_type_str(v, name, &val, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &val, errp)) {
         return;
     }
 
@@ -167,10 +163,8 @@ static void spapr_cap_set_pagesize(Object *obj, Visitor *v, const char *name,
     SpaprMachineState *spapr = SPAPR_MACHINE(obj);
     uint64_t pagesize;
     uint8_t val;
-    Error *local_err = NULL;
 
-    if (!visit_type_size(v, name, &pagesize, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_size(v, name, &pagesize, errp)) {
         return;
     }
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1f18b79348..43d12bc33a 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -327,8 +327,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
         case FDT_BEGIN_NODE:
             fdt_depth++;
             name = fdt_get_name(fdt, fdt_offset, &name_len);
-            if (!visit_start_struct(v, name, NULL, 0, &err)) {
-                error_propagate(errp, err);
+            if (!visit_start_struct(v, name, NULL, 0, errp)) {
                 return;
             }
             break;
@@ -347,14 +346,12 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
             int i;
             prop = fdt_get_property_by_offset(fdt, fdt_offset, &prop_len);
             name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
-            if (!visit_start_list(v, name, NULL, 0, &err)) {
-                error_propagate(errp, err);
+            if (!visit_start_list(v, name, NULL, 0, errp)) {
                 return;
             }
             for (i = 0; i < prop_len; i++) {
                 if (!visit_type_uint8(v, NULL, (uint8_t *)&prop->data[i],
-                                      &err)) {
-                    error_propagate(errp, err);
+                                      errp)) {
                     return;
                 }
             }
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index eb55171d70..2f8f7d62f8 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -302,7 +302,6 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
     spapr_irq_msi_init(spapr);
 
     if (spapr->irq->xics) {
-        Error *local_err = NULL;
         Object *obj;
 
         obj = object_new(TYPE_ICS_SPAPR);
@@ -311,8 +310,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         object_property_set_link(obj, ICS_PROP_XICS, OBJECT(spapr),
                                  &error_abort);
         object_property_set_int(obj, "nr-irqs", smc->nr_xirqs, &error_abort);
-        if (!qdev_realize(DEVICE(obj), NULL, &local_err)) {
-            error_propagate(errp, local_err);
+        if (!qdev_realize(DEVICE(obj), NULL, errp)) {
             return;
         }
 
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 7003b1f62d..a8f0039e51 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -106,7 +106,6 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     LowRISCIbexSoCState *s = RISCV_IBEX_SOC(dev_soc);
     MemoryRegion *sys_mem = get_system_memory();
-    Error *err = NULL;
 
     object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
                             &error_abort);
@@ -127,16 +126,14 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
                                 &s->flash_mem);
 
     /* PLIC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->plic), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->plic), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->plic), 0, memmap[IBEX_PLIC].base);
 
     /* UART */
     qdev_prop_set_chr(DEVICE(&(s->uart)), "chardev", serial_hd(0));
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart), 0, memmap[IBEX_UART].base);
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index f2df06cc43..7bb97b463d 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -185,8 +185,6 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     const struct MemmapEntry *memmap = sifive_e_memmap;
-    Error *err = NULL;
-
     SiFiveESoCState *s = RISCV_E_SOC(dev);
     MemoryRegion *sys_mem = get_system_memory();
 
@@ -221,8 +219,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     /* GPIO */
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
     }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e70253d58f..7851326988 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -608,7 +608,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
-    Error *err = NULL;
     NICInfo *nd = &nd_table[0];
 
     sysbus_realize(SYS_BUS_DEVICE(&s->e_cpus), &error_abort);
@@ -710,8 +709,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
     object_property_set_int(OBJECT(&s->gem), "revision", GEM_REVISION,
                             &error_abort);
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem), &err)) {
-        error_propagate(errp, err);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index ab28b2fb30..519dc91316 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2377,7 +2377,6 @@ static void set_css_devid(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     CssDevId *dev_id = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
     char *str;
     int num, n1, n2;
     unsigned int cssid, ssid, devid;
@@ -2387,8 +2386,7 @@ static void set_css_devid(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_str(v, name, &str, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index cee2908ae9..645b4080c5 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -442,16 +442,13 @@ static void init_event_facility(Object *obj)
 static void realize_event_facility(DeviceState *dev, Error **errp)
 {
     SCLPEventFacility *event_facility = EVENT_FACILITY(dev);
-    Error *local_err = NULL;
 
     if (!qdev_realize(DEVICE(&event_facility->quiesce),
-                      BUS(&event_facility->sbus), &local_err)) {
-        error_propagate(errp, local_err);
+                      BUS(&event_facility->sbus), errp)) {
         return;
     }
     if (!qdev_realize(DEVICE(&event_facility->cpu_hotplug),
-                      BUS(&event_facility->sbus), &local_err)) {
-        error_propagate(errp, local_err);
+                      BUS(&event_facility->sbus), errp)) {
         qdev_unrealize(DEVICE(&event_facility->quiesce));
         return;
     }
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index 5720e84fc9..570c0333fc 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -19,10 +19,8 @@ static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIOCryptoCcw *dev = VIRTIO_CRYPTO_CCW(ccw_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
-    Error *err = NULL;
 
-    if (!qdev_realize(vdev, BUS(&ccw_dev->bus), &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(vdev, BUS(&ccw_dev->bus), errp)) {
         return;
     }
 
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index 8cf01ce76c..4bb8c16d79 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -20,10 +20,8 @@ static void virtio_ccw_rng_realize(VirtioCcwDevice *ccw_dev, Error **errp)
 {
     VirtIORNGCcw *dev = VIRTIO_RNG_CCW(ccw_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
-    Error *err = NULL;
 
-    if (!qdev_realize(vdev, BUS(&ccw_dev->bus), &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(vdev, BUS(&ccw_dev->bus), errp)) {
         return;
     }
 
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 38b66a2f45..df65cc2223 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -248,7 +248,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     const char *driver;
     char *name;
     DeviceState *dev;
-    Error *err = NULL;
     DriveInfo *dinfo;
 
     if (blk_is_sg(blk)) {
@@ -277,13 +276,11 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     if (serial && object_property_find(OBJECT(dev), "serial", NULL)) {
         qdev_prop_set_string(dev, "serial", serial);
     }
-    if (!qdev_prop_set_drive_err(dev, "drive", blk, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_prop_set_drive_err(dev, "drive", blk, errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
-    if (!object_property_set_bool(OBJECT(dev), "share-rw", share_rw, &err)) {
-        error_propagate(errp, err);
+    if (!object_property_set_bool(OBJECT(dev), "share-rw", share_rw, errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
@@ -291,8 +288,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
     qdev_prop_set_enum(dev, "rerror", rerror);
     qdev_prop_set_enum(dev, "werror", werror);
 
-    if (!qdev_realize_and_unref(dev, &bus->qbus, &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize_and_unref(dev, &bus->qbus, errp)) {
         object_unparent(OBJECT(dev));
         return NULL;
     }
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 687b300773..22cafce0fb 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -115,7 +115,6 @@ static void aspeed_sdhci_set_irq(void *opaque, int n, int level)
 
 static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
 {
-    Error *err = NULL;
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     AspeedSDHCIState *sdhci = ASPEED_SDHCI(dev);
 
@@ -132,19 +131,16 @@ static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
         Object *sdhci_slot = OBJECT(&sdhci->slots[i]);
         SysBusDevice *sbd_slot = SYS_BUS_DEVICE(&sdhci->slots[i]);
 
-        if (!object_property_set_int(sdhci_slot, "sd-spec-version", 2, &err)) {
-            error_propagate(errp, err);
+        if (!object_property_set_int(sdhci_slot, "sd-spec-version", 2, errp)) {
             return;
         }
 
         if (!object_property_set_uint(sdhci_slot, "capareg",
-                                      ASPEED_SDHCI_CAPABILITIES, &err)) {
-            error_propagate(errp, err);
+                                      ASPEED_SDHCI_CAPABILITIES, errp)) {
             return;
         }
 
-        if (!sysbus_realize(sbd_slot, &err)) {
-            error_propagate(errp, err);
+        if (!sysbus_realize(sbd_slot, errp)) {
             return;
         }
 
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 87afcf9142..f560826904 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -953,7 +953,6 @@ static void save_opt_list(size_t *ndest, const char ***dest,
 
 void smbios_entry_add(QemuOpts *opts, Error **errp)
 {
-    Error *err = NULL;
     const char *val;
 
     assert(!smbios_immutable);
@@ -964,8 +963,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
         int size;
         struct smbios_table *table; /* legacy mode only */
 
-        if (!qemu_opts_validate(opts, qemu_smbios_file_opts, &err)) {
-            error_propagate(errp, err);
+        if (!qemu_opts_validate(opts, qemu_smbios_file_opts, errp)) {
             return;
         }
 
@@ -1050,8 +1048,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
 
         switch (type) {
         case 0:
-            if (!qemu_opts_validate(opts, qemu_smbios_type0_opts, &err)) {
-                error_propagate(errp, err);
+            if (!qemu_opts_validate(opts, qemu_smbios_type0_opts, errp)) {
                 return;
             }
             save_opt(&type0.vendor, opts, "vendor");
@@ -1069,8 +1066,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             }
             return;
         case 1:
-            if (!qemu_opts_validate(opts, qemu_smbios_type1_opts, &err)) {
-                error_propagate(errp, err);
+            if (!qemu_opts_validate(opts, qemu_smbios_type1_opts, errp)) {
                 return;
             }
             save_opt(&type1.manufacturer, opts, "manufacturer");
@@ -1090,8 +1086,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             }
             return;
         case 2:
-            if (!qemu_opts_validate(opts, qemu_smbios_type2_opts, &err)) {
-                error_propagate(errp, err);
+            if (!qemu_opts_validate(opts, qemu_smbios_type2_opts, errp)) {
                 return;
             }
             save_opt(&type2.manufacturer, opts, "manufacturer");
@@ -1102,8 +1097,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&type2.location, opts, "location");
             return;
         case 3:
-            if (!qemu_opts_validate(opts, qemu_smbios_type3_opts, &err)) {
-                error_propagate(errp, err);
+            if (!qemu_opts_validate(opts, qemu_smbios_type3_opts, errp)) {
                 return;
             }
             save_opt(&type3.manufacturer, opts, "manufacturer");
@@ -1113,8 +1107,7 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&type3.sku, opts, "sku");
             return;
         case 4:
-            if (!qemu_opts_validate(opts, qemu_smbios_type4_opts, &err)) {
-                error_propagate(errp, err);
+            if (!qemu_opts_validate(opts, qemu_smbios_type4_opts, errp)) {
                 return;
             }
             save_opt(&type4.sock_pfx, opts, "sock_pfx");
@@ -1125,15 +1118,13 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&type4.part, opts, "part");
             return;
         case 11:
-            if (!qemu_opts_validate(opts, qemu_smbios_type11_opts, &err)) {
-                error_propagate(errp, err);
+            if (!qemu_opts_validate(opts, qemu_smbios_type11_opts, errp)) {
                 return;
             }
             save_opt_list(&type11.nvalues, &type11.values, opts, "value");
             return;
         case 17:
-            if (!qemu_opts_validate(opts, qemu_smbios_type17_opts, &err)) {
-                error_propagate(errp, err);
+            if (!qemu_opts_validate(opts, qemu_smbios_type17_opts, errp)) {
                 return;
             }
             save_opt(&type17.loc_pfx, opts, "loc_pfx");
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 1467b8034e..3a14b7c303 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1502,15 +1502,13 @@ static void set_nv_gpudirect_clique_id(Object *obj, Visitor *v,
     DeviceState *dev = DEVICE(obj);
     Property *prop = opaque;
     uint8_t value, *ptr = qdev_get_prop_ptr(dev, prop);
-    Error *local_err = NULL;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
         return;
     }
 
-    if (!visit_type_uint8(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint8(v, name, &value, errp)) {
         return;
     }
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6838bcc4b3..c1802441d9 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -116,7 +116,6 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
 #ifdef CONFIG_KVM
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
-    Error *err = NULL;
 
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
@@ -147,8 +146,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                VFIO_IRQ_SET_ACTION_UNMASK,
                                event_notifier_get_fd(&vdev->intx.unmask),
-                               &err)) {
-        error_propagate(errp, err);
+                               errp)) {
         goto fail_vfio;
     }
 
@@ -2741,9 +2739,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (!pdev->failover_pair_id) {
         error_setg(&vdev->migration_blocker,
                 "VFIO device doesn't support migration");
-        ret = migrate_add_blocker(vdev->migration_blocker, &err);
+        ret = migrate_add_blocker(vdev->migration_blocker, errp);
         if (ret) {
-            error_propagate(errp, err);
             error_free(vdev->migration_blocker);
             vdev->migration_blocker = NULL;
             return;
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 62676412f9..8eb652a348 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -274,11 +274,9 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
                                             Error **errp)
 {
     VirtIOBalloon *s = opaque;
-    Error *local_err = NULL;
     int64_t value;
 
-    if (!visit_type_int(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
 
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
index 8b11c4b425..2f0b529b62 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -34,10 +34,8 @@ static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIORngPCI *vrng = VIRTIO_RNG_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&vrng->vdev);
-    Error *err = NULL;
 
-    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), &err)) {
-        error_propagate(errp, err);
+    if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
         return;
     }
 
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 8d052fbeed..2886c0ce2a 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -176,7 +176,6 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIORNG *vrng = VIRTIO_RNG(dev);
-    Error *local_err = NULL;
 
     if (vrng->conf.period_ms <= 0) {
         error_setg(errp, "'period' parameter expects a positive integer");
@@ -195,8 +194,7 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
         Object *default_backend = object_new(TYPE_RNG_BUILTIN);
 
         if (!user_creatable_complete(USER_CREATABLE(default_backend),
-                                     &local_err)) {
-            error_propagate(errp, local_err);
+                                     errp)) {
             object_unref(default_backend);
             return;
         }
diff --git a/iothread.c b/iothread.c
index aa8830fed2..0598a6d20d 100644
--- a/iothread.c
+++ b/iothread.c
@@ -169,9 +169,8 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
 
     iothread->stopping = false;
     iothread->running = true;
-    iothread->ctx = aio_context_new(&local_error);
+    iothread->ctx = aio_context_new(errp);
     if (!iothread->ctx) {
-        error_propagate(errp, local_error);
         return;
     }
 
@@ -240,11 +239,9 @@ static void iothread_set_poll_param(Object *obj, Visitor *v,
     IOThread *iothread = IOTHREAD(obj);
     PollParamInfo *info = opaque;
     int64_t *field = (void *)iothread + info->offset;
-    Error *local_err = NULL;
     int64_t value;
 
-    if (!visit_type_int64(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int64(v, name, &value, errp)) {
         return;
     }
 
diff --git a/net/colo-compare.c b/net/colo-compare.c
index d75169e28f..398b7546ff 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1093,11 +1093,9 @@ static void compare_set_timeout(Object *obj, Visitor *v,
                                 Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
-    Error *local_err = NULL;
     uint32_t value;
 
-    if (!visit_type_uint32(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {
@@ -1123,11 +1121,9 @@ static void compare_set_expired_scan_cycle(Object *obj, Visitor *v,
                                            Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
-    Error *local_err = NULL;
     uint32_t value;
 
-    if (!visit_type_uint32(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {
diff --git a/net/dump.c b/net/dump.c
index f7a302f56c..11a737a4bc 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -192,11 +192,9 @@ static void filter_dump_set_maxlen(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     NetFilterDumpState *nfds = FILTER_DUMP(obj);
-    Error *local_err = NULL;
     uint32_t value;
 
-    if (!visit_type_uint32(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (value == 0) {
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 143627fcaf..dfa211794b 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -170,11 +170,9 @@ static void filter_buffer_set_interval(Object *obj, Visitor *v,
                                        Error **errp)
 {
     FilterBufferState *s = FILTER_BUFFER(obj);
-    Error *local_err = NULL;
     uint32_t value;
 
-    if (!visit_type_uint32(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {
diff --git a/net/tap.c b/net/tap.c
index ca48f2a285..2d8d83a30b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -790,9 +790,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        fd = monitor_fd_param(cur_mon, tap->fd, &err);
+        fd = monitor_fd_param(cur_mon, tap->fd, errp);
         if (fd == -1) {
-            error_propagate(errp, err);
             return -1;
         }
 
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index d0ca10aefa..6e53396ea3 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -315,12 +315,10 @@ static bool parse_type_size(Visitor *v, const char *name, uint64_t *obj,
                             Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
-    Error *err = NULL;
     uint64_t val;
 
     assert(siv->lm == LM_NONE);
-    if (!parse_option_size(name, siv->string, &val, &err)) {
-        error_propagate(errp, err);
+    if (!parse_option_size(name, siv->string, &val, errp)) {
         return false;
     }
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index cd46157bcf..4139dd2fe3 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -176,15 +176,13 @@ static int set_property(void *opaque, const char *name, const char *value,
                         Error **errp)
 {
     Object *obj = opaque;
-    Error *err = NULL;
 
     if (strcmp(name, "driver") == 0)
         return 0;
     if (strcmp(name, "bus") == 0)
         return 0;
 
-    if (!object_property_parse(obj, name, value, &err)) {
-        error_propagate(errp, err);
+    if (!object_property_parse(obj, name, value, errp)) {
         return -1;
     }
     return 0;
@@ -794,7 +792,6 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
 
 void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
 {
-    Error *local_err = NULL;
     QemuOpts *opts;
     DeviceState *dev;
 
@@ -806,9 +803,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         qemu_opts_del(opts);
         return;
     }
-    dev = qdev_device_add(opts, &local_err);
+    dev = qdev_device_add(opts, errp);
     if (!dev) {
-        error_propagate(errp, local_err);
         qemu_opts_del(opts);
         return;
     }
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 0f4911082f..aaa71f147b 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2195,9 +2195,8 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
     }
 
     server = os_version.wProductType != VER_NT_WORKSTATION;
-    product_name = ga_get_win_product_name(&local_err);
+    product_name = ga_get_win_product_name(errp);
     if (product_name == NULL) {
-        error_propagate(errp, local_err);
         return NULL;
     }
 
diff --git a/qom/object.c b/qom/object.c
index 97c4e0af07..84b7b52dda 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -800,15 +800,13 @@ bool object_set_propv(Object *obj,
                      va_list vargs)
 {
     const char *propname;
-    Error *local_err = NULL;
 
     propname = va_arg(vargs, char *);
     while (propname != NULL) {
         const char *value = va_arg(vargs, char *);
 
         g_assert(value != NULL);
-        if (!object_property_parse(obj, propname, value, &local_err)) {
-            error_propagate(errp, local_err);
+        if (!object_property_parse(obj, propname, value, errp)) {
             return false;
         }
         propname = va_arg(vargs, char *);
@@ -2101,10 +2099,8 @@ static void property_set_str(Object *obj, Visitor *v, const char *name,
 {
     StringProperty *prop = opaque;
     char *value;
-    Error *local_err = NULL;
 
-    if (!visit_type_str(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &value, errp)) {
         return;
     }
 
@@ -2181,10 +2177,8 @@ static void property_set_bool(Object *obj, Visitor *v, const char *name,
 {
     BoolProperty *prop = opaque;
     bool value;
-    Error *local_err = NULL;
 
-    if (!visit_type_bool(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
 
@@ -2253,10 +2247,8 @@ static void property_set_enum(Object *obj, Visitor *v, const char *name,
 {
     EnumProperty *prop = opaque;
     int value;
-    Error *err = NULL;
 
-    if (!visit_type_enum(v, name, &value, prop->lookup, &err)) {
-        error_propagate(errp, err);
+    if (!visit_type_enum(v, name, &value, prop->lookup, errp)) {
         return;
     }
     prop->set(obj, value, errp);
@@ -2405,10 +2397,8 @@ static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
 {
     uint8_t *field = opaque;
     uint8_t value;
-    Error *local_err = NULL;
 
-    if (!visit_type_uint8(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint8(v, name, &value, errp)) {
         return;
     }
 
@@ -2427,10 +2417,8 @@ static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
 {
     uint16_t *field = opaque;
     uint16_t value;
-    Error *local_err = NULL;
 
-    if (!visit_type_uint16(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint16(v, name, &value, errp)) {
         return;
     }
 
@@ -2449,10 +2437,8 @@ static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
 {
     uint32_t *field = opaque;
     uint32_t value;
-    Error *local_err = NULL;
 
-    if (!visit_type_uint32(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
 
@@ -2471,10 +2457,8 @@ static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
 {
     uint64_t *field = opaque;
     uint64_t value;
-    Error *local_err = NULL;
 
-    if (!visit_type_uint64(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_uint64(v, name, &value, errp)) {
         return;
     }
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index aa79d3e79f..df0b895ea7 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2444,14 +2444,11 @@ static int object_parse_property_opt(Object *obj,
                                      const char *name, const char *value,
                                      const char *skip, Error **errp)
 {
-    Error *local_err = NULL;
-
     if (g_str_equal(name, skip)) {
         return 0;
     }
 
-    if (!object_property_parse(obj, name, value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!object_property_parse(obj, name, value, errp)) {
         return -1;
     }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 343c227c09..15494002d2 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -464,11 +464,9 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    Error *err = NULL;
     uint32_t max_vq;
 
-    if (!visit_type_uint32(v, name, &max_vq, &err)) {
-        error_propagate(errp, err);
+    if (!visit_type_uint32(v, name, &max_vq, errp)) {
         return;
     }
 
@@ -509,11 +507,9 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
 {
     ARMCPU *cpu = ARM_CPU(obj);
     uint32_t vq = atoi(&name[3]) / 128;
-    Error *err = NULL;
     bool value;
 
-    if (!visit_type_bool(v, name, &value, &err)) {
-        error_propagate(errp, err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
 
@@ -544,12 +540,10 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-    Error *err = NULL;
     bool value;
     uint64_t t;
 
-    if (!visit_type_bool(v, name, &value, &err)) {
-        error_propagate(errp, err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
 
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index c162c5fb68..ba6e01abd0 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -174,10 +174,9 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         Error *err = NULL;
 
         visitor = qobject_input_visitor_new(model->props);
-        if (!visit_start_struct(visitor, NULL, NULL, 0, &err)) {
+        if (!visit_start_struct(visitor, NULL, NULL, 0, errp)) {
             visit_free(visitor);
             object_unref(obj);
-            error_propagate(errp, err);
             return NULL;
         }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2b60b61ced..6f27f12ec7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4417,11 +4417,9 @@ static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     const int64_t min = 0;
     const int64_t max = 0xff + 0xf;
-    Error *local_err = NULL;
     int64_t value;
 
-    if (!visit_type_int(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -4459,11 +4457,9 @@ static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     const int64_t min = 0;
     const int64_t max = 0xff;
-    Error *local_err = NULL;
     int64_t value;
 
-    if (!visit_type_int(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -4496,11 +4492,9 @@ static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
     CPUX86State *env = &cpu->env;
     const int64_t min = 0;
     const int64_t max = 0xf;
-    Error *local_err = NULL;
     int64_t value;
 
-    if (!visit_type_int(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -4600,11 +4594,9 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
     X86CPU *cpu = X86_CPU(obj);
     const int64_t min = 0;
     const int64_t max = INT64_MAX;
-    Error *local_err = NULL;
     int64_t value;
 
-    if (!visit_type_int(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
     if (value < min || value > max) {
@@ -6798,7 +6790,6 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
     DeviceState *dev = DEVICE(obj);
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
-    Error *local_err = NULL;
     bool value;
 
     if (dev->realized) {
@@ -6806,8 +6797,7 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_bool(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
 
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 42f87a4bfe..08aede88dc 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -260,12 +260,10 @@ static void ppc_compat_prop_get(Object *obj, Visitor *v, const char *name,
 static void ppc_compat_prop_set(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
-    Error *local_err = NULL;
     char *value;
     uint32_t compat_pvr;
 
-    if (!visit_type_str(v, name, &value, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!visit_type_str(v, name, &value, errp)) {
         return;
     }
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index f3ba30e93e..c2af226174 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -510,8 +510,7 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
 
     if (qdict) {
         visitor = qobject_input_visitor_new(info->props);
-        if (!visit_start_struct(visitor, NULL, NULL, 0, &err)) {
-            error_propagate(errp, err);
+        if (!visit_start_struct(visitor, NULL, NULL, 0, errp)) {
             visit_free(visitor);
             object_unref(obj);
             return;
@@ -999,7 +998,6 @@ static void get_feature(Object *obj, Visitor *v, const char *name,
 static void set_feature(Object *obj, Visitor *v, const char *name,
                         void *opaque, Error **errp)
 {
-    Error *err = NULL;
     S390Feat feat = (S390Feat) opaque;
     DeviceState *dev = DEVICE(obj);
     S390CPU *cpu = S390_CPU(obj);
@@ -1015,8 +1013,7 @@ static void set_feature(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_bool(v, name, &value, &err)) {
-        error_propagate(errp, err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
     if (value) {
@@ -1056,7 +1053,6 @@ static void get_feature_group(Object *obj, Visitor *v, const char *name,
 static void set_feature_group(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
-    Error *err = NULL;
     S390FeatGroup group = (S390FeatGroup) opaque;
     const S390FeatGroupDef *def = s390_feat_group_def(group);
     DeviceState *dev = DEVICE(obj);
@@ -1073,8 +1069,7 @@ static void set_feature_group(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (!visit_type_bool(v, name, &value, &err)) {
-        error_propagate(errp, err);
+    if (!visit_type_bool(v, name, &value, errp)) {
         return;
     }
     if (value) {
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 4a9257005d..cf21efd85f 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -801,11 +801,9 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
     const int64_t min = MIN_NWINDOWS;
     const int64_t max = MAX_NWINDOWS;
     SPARCCPU *cpu = SPARC_CPU(obj);
-    Error *err = NULL;
     int64_t value;
 
-    if (!visit_type_int(v, name, &value, &err)) {
-        error_propagate(errp, err);
+    if (!visit_type_int(v, name, &value, errp)) {
         return;
     }
 
diff --git a/tpm.c b/tpm.c
index 75bc937812..fe03b24858 100644
--- a/tpm.c
+++ b/tpm.c
@@ -85,7 +85,6 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     const char *id;
     const TPMBackendClass *be;
     TPMBackend *drv;
-    Error *local_err = NULL;
     int i;
 
     if (!QLIST_EMPTY(&tpm_backends)) {
@@ -116,8 +115,7 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
     }
 
     /* validate backend specific opts */
-    if (!qemu_opts_validate(opts, be->opts, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_validate(opts, be->opts, errp)) {
         return 1;
     }
 
diff --git a/util/main-loop.c b/util/main-loop.c
index eda63fe4e0..f69f055013 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -148,7 +148,6 @@ int qemu_init_main_loop(Error **errp)
 {
     int ret;
     GSource *src;
-    Error *local_error = NULL;
 
     init_clocks(qemu_timer_notify_cb);
 
@@ -157,9 +156,8 @@ int qemu_init_main_loop(Error **errp)
         return ret;
     }
 
-    qemu_aio_context = aio_context_new(&local_error);
+    qemu_aio_context = aio_context_new(errp);
     if (!qemu_aio_context) {
-        error_propagate(errp, local_error);
         return -EMFILE;
     }
     qemu_notify_bh = qemu_bh_new(notify_event_cb, NULL);
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 7229c79cc7..660f47b005 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -479,7 +479,6 @@ static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
     QemuOpts *subopts;
     QDict *subqdict;
     QList *list = NULL;
-    Error *local_err = NULL;
     size_t orig_size, enum_size;
     char *prefix;
 
@@ -496,8 +495,7 @@ static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
         goto out;
     }
 
-    if (!qemu_opts_absorb_qdict(subopts, subqdict, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opts_absorb_qdict(subopts, subqdict, errp)) {
         goto out;
     }
 
@@ -540,8 +538,7 @@ static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
                 goto out;
             }
 
-            if (!qemu_opts_absorb_qdict(subopts, section, &local_err)) {
-                error_propagate(errp, local_err);
+            if (!qemu_opts_absorb_qdict(subopts, section, errp)) {
                 qemu_opts_del(subopts);
                 goto out;
             }
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 1dd14a0634..b9f93a7f8b 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -524,7 +524,6 @@ static bool opt_validate(QemuOpt *opt, bool *help_wanted,
                          Error **errp)
 {
     const QemuOptDesc *desc;
-    Error *local_err = NULL;
 
     desc = find_desc_by_name(opt->opts->list->desc, opt->name);
     if (!desc && !opts_accepts_any(opt->opts)) {
@@ -536,8 +535,7 @@ static bool opt_validate(QemuOpt *opt, bool *help_wanted,
     }
 
     opt->desc = desc;
-    if (!qemu_opt_parse(opt, &local_err)) {
-        error_propagate(errp, local_err);
+    if (!qemu_opt_parse(opt, errp)) {
         return false;
     }
 
@@ -908,7 +906,6 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
     const char *firstname;
     char *id = opts_parse_id(params);
     QemuOpts *opts;
-    Error *local_err = NULL;
 
     assert(!permit_abbrev || list->implied_opt_name);
     firstname = permit_abbrev ? list->implied_opt_name : NULL;
@@ -921,16 +918,14 @@ static QemuOpts *opts_parse(QemuOptsList *list, const char *params,
      * (if unlikely) future misuse:
      */
     assert(!defaults || list->merge_lists);
-    opts = qemu_opts_create(list, id, !defaults, &local_err);
+    opts = qemu_opts_create(list, id, !defaults, errp);
     g_free(id);
     if (opts == NULL) {
-        error_propagate(errp, local_err);
         return NULL;
     }
 
     if (!opts_do_parse(opts, params, firstname, defaults, help_wanted,
-                       &local_err)) {
-        error_propagate(errp, local_err);
+                       errp)) {
         qemu_opts_del(opts);
         return NULL;
     }
@@ -1030,7 +1025,6 @@ static bool qemu_opts_from_qdict_entry(QemuOpts *opts,
 QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
                                Error **errp)
 {
-    Error *local_err = NULL;
     QemuOpts *opts;
     const QDictEntry *entry;
 
@@ -1044,8 +1038,7 @@ QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
     for (entry = qdict_first(qdict);
          entry;
          entry = qdict_next(qdict, entry)) {
-        if (!qemu_opts_from_qdict_entry(opts, entry, &local_err)) {
-            error_propagate(errp, local_err);
+        if (!qemu_opts_from_qdict_entry(opts, entry, errp)) {
             qemu_opts_del(opts);
             return NULL;
         }
@@ -1066,13 +1059,10 @@ bool qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qdict, Error **errp)
     entry = qdict_first(qdict);
 
     while (entry != NULL) {
-        Error *local_err = NULL;
-
         next = qdict_next(qdict, entry);
 
         if (find_desc_by_name(opts->list->desc, entry->key)) {
-            if (!qemu_opts_from_qdict_entry(opts, entry, &local_err)) {
-                error_propagate(errp, local_err);
+            if (!qemu_opts_from_qdict_entry(opts, entry, errp)) {
                 return false;
             }
             qdict_del(qdict, entry->key);
@@ -1144,7 +1134,6 @@ QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
 bool qemu_opts_validate(QemuOpts *opts, const QemuOptDesc *desc, Error **errp)
 {
     QemuOpt *opt;
-    Error *local_err = NULL;
 
     assert(opts_accepts_any(opts));
 
@@ -1155,8 +1144,7 @@ bool qemu_opts_validate(QemuOpts *opts, const QemuOptDesc *desc, Error **errp)
             return false;
         }
 
-        if (!qemu_opt_parse(opt, &local_err)) {
-            error_propagate(errp, local_err);
+        if (!qemu_opt_parse(opt, errp)) {
             return false;
         }
     }
-- 
2.26.2


