Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FCAC3B186
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB57E20675
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 02:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB57E20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j24OY-00039l-13
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 21:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fangying1@huawei.com>) id 1j24M6-0007FY-8S
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fangying1@huawei.com>) id 1j24M4-0000bq-Gb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 21:35:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57584 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fangying1@huawei.com>)
 id 1j24M0-0000T4-7f; Wed, 12 Feb 2020 21:35:48 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 53FE1CF72C5DD6B4C053;
 Thu, 13 Feb 2020 10:35:46 +0800 (CST)
Received: from localhost (10.133.205.53) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 10:35:36 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH 3/4] arm: Add the cpufreq device model
Date: Thu, 13 Feb 2020 10:35:31 +0800
Message-ID: <20200213023532.902-4-fangying1@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200213023532.902-1-fangying1@huawei.com>
References: <20200213023532.902-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.53]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com, mst@redhat.com,
 i.mitsyanko@gmail.com, shannon.zhaosl@gmail.com, guoheyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ARM64 platform, CPU frequency is retrieved by ACPI CPPC,
so here we create the virtual cpufreq device to present
the CPPC registers and ACPI _CPC objects.

The default frequency is set host CPU nominal frequency, which
is obtained from the host CPPC sysfs. Other performance data
are set to the same value, since we don't support guest performance scali=
ng.

Performance counters are also not emulated and they simply return 1
if readed, and guest should fallback to use the desired performance
value as the current performance.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 hw/acpi/Makefile.objs |   1 +
 hw/acpi/cpufreq.c     | 247 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 248 insertions(+)
 create mode 100644 hw/acpi/cpufreq.c

diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 777da07f4d..61530675d4 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -16,6 +16,7 @@ common-obj-y +=3D bios-linker-loader.o
 common-obj-y +=3D aml-build.o utils.o
 common-obj-$(CONFIG_ACPI_PCI) +=3D pci.o
 common-obj-$(CONFIG_TPM) +=3D tpm.o
+common-obj-$(CONFIG_CPUFREQ) +=3D cpufreq.o
=20
 common-obj-$(CONFIG_IPMI) +=3D ipmi.o
 common-obj-$(call lnot,$(CONFIG_IPMI)) +=3D ipmi-stub.o
diff --git a/hw/acpi/cpufreq.c b/hw/acpi/cpufreq.c
new file mode 100644
index 0000000000..f38087884a
--- /dev/null
+++ b/hw/acpi/cpufreq.c
@@ -0,0 +1,247 @@
+/*
+ * ACPI CPPC register device
+ *
+ * Support for showing CPU frequency in guest OS.
+ *
+ * Copyright (c) 2019 HUAWEI TECHNOLOGIES CO.,LTD.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License alo=
ng
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "chardev/char.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "qemu/option.h"
+#include "sysemu/sysemu.h"
+#include "hw/acpi/acpi-defs.h"
+#include "qemu/cutils.h"
+#include "qemu/error-report.h"
+#include "hw/boards.h"
+
+#define TYPE_CPUFREQ "cpufreq"
+#define CPUFREQ(obj) OBJECT_CHECK(CpufreqState, (obj), TYPE_CPUFREQ)
+#define NOMINAL_FREQ_FILE "/sys/devices/system/cpu/cpu0/acpi_cppc/nomina=
l_freq"
+#define CPU_MAX_FREQ_FILE "/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_=
max_freq"
+#define HZ_MAX_LENGTH 1024
+#define MAX_SUPPORT_SPACE 0x10000
+
+typedef struct CpufreqState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t HighestPerformance;
+    uint32_t NominalPerformance;
+    uint32_t LowestNonlinearPerformance;
+    uint32_t LowestPerformance;
+    uint32_t GuaranteedPerformance;
+    uint32_t DesiredPerformance;
+    uint64_t ReferencePerformanceCounter;
+    uint64_t DeliveredPerformanceCounter;
+    uint32_t PerformanceLimited;
+    uint32_t LowestFreq;
+    uint32_t NominalFreq;
+    uint32_t reg_size;
+} CpufreqState;
+
+
+static uint64_t cpufreq_read(void *opaque, hwaddr offset,
+                           unsigned size)
+{
+    CpufreqState *s =3D (CpufreqState *)opaque;
+    uint64_t r;
+    uint64_t n;
+
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    unsigned int smp_cpus =3D ms->smp.cpus;
+
+    if (offset >=3D smp_cpus * CPPC_REG_PER_CPU_STRIDE) {
+        warn_report("cpufreq_read: offset 0x%lx out of range", offset);
+        return 0;
+    }
+
+    n =3D offset % CPPC_REG_PER_CPU_STRIDE;
+    switch (n) {
+    case 0:
+        r =3D s->HighestPerformance;
+        break;
+    case 4:
+        r =3D s->NominalPerformance;
+        break;
+    case 8:
+        r =3D s->LowestNonlinearPerformance;
+        break;
+    case 12:
+        r =3D s->LowestPerformance;
+        break;
+    case 16:
+        r =3D s->GuaranteedPerformance;
+        break;
+    case 20:
+        r =3D s->DesiredPerformance;
+        break;
+    /*
+     * We don't have real counters and it is hard to emulate, so always =
set the
+     * counter value to 1 to rely on Linux to use the DesiredPerformance=
 value
+     * directly.
+     */
+    case 24:
+        r =3D s->ReferencePerformanceCounter;
+        break;
+    /*
+     * Guest may still access the register by 32bit; add the process to
+     * eliminate unnecessary warnings
+     */
+    case 28:
+        r =3D s->ReferencePerformanceCounter >> 32;
+        break;
+    case 32:
+        r =3D s->DeliveredPerformanceCounter;
+        break;
+    case 36:
+        r =3D s->DeliveredPerformanceCounter >> 32;
+        break;
+
+    case 40:
+        r =3D s->PerformanceLimited;
+        break;
+    case 44:
+        r =3D s->LowestFreq;
+        break;
+    case 48:
+        r =3D s->NominalFreq;
+        break;
+    default:
+        error_printf("cpufreq_read: Bad offset 0x%lx\n", offset);
+        r =3D 0;
+        break;
+    }
+    return r;
+}
+
+static void cpufreq_write(void *opaque, hwaddr offset,
+                           uint64_t value, unsigned size)
+{
+    uint64_t n;
+
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    unsigned int smp_cpus =3D ms->smp.cpus;
+
+    if (offset >=3D smp_cpus * CPPC_REG_PER_CPU_STRIDE) {
+        error_printf("cpufreq_write: offset 0x%lx out of range", offset)=
;
+        return;
+    }
+
+    n =3D offset % CPPC_REG_PER_CPU_STRIDE;
+
+    switch (n) {
+    case 20:
+        break;
+    default:
+        error_printf("cpufreq_write: Bad offset 0x%lx\n", offset);
+    }
+}
+
+static uint32_t CPPC_Read(const char *hostpath)
+{
+    int fd;
+    char buffer[HZ_MAX_LENGTH] =3D { 0 };
+    uint64_t hz;
+    int len;
+    const char *endptr =3D NULL;
+    int ret;
+
+    fd =3D qemu_open(hostpath, O_RDONLY);
+    if (fd < 0) {
+        return 0;
+    }
+
+    len =3D read(fd, buffer, HZ_MAX_LENGTH);
+    qemu_close(fd);
+    if (len <=3D 0) {
+        return 0;
+    }
+    ret =3D qemu_strtoul(buffer, &endptr, 0, &hz);
+    if (ret < 0) {
+        return 0;
+    }
+    return (uint32_t)hz;
+}
+
+static const MemoryRegionOps cpufreq_ops =3D {
+    .read =3D cpufreq_read,
+    .write =3D cpufreq_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static void hz_init(CpufreqState *s)
+{
+    uint32_t hz;
+
+    hz =3D CPPC_Read(NOMINAL_FREQ_FILE);
+    if (hz =3D=3D 0) {
+        hz =3D CPPC_Read(CPU_MAX_FREQ_FILE);
+        /* Value in CpuMaxFrequency is in KHz unit; convert to MHz */
+        hz =3D hz / 1000;
+    }
+
+    s->HighestPerformance =3D hz;
+    s->NominalPerformance =3D hz;
+    s->LowestNonlinearPerformance =3D hz;
+    s->LowestPerformance =3D hz;
+    s->GuaranteedPerformance =3D hz;
+    s->DesiredPerformance =3D hz;
+    s->ReferencePerformanceCounter =3D 1;
+    s->DeliveredPerformanceCounter =3D 1;
+    s->PerformanceLimited =3D 0;
+    s->LowestFreq =3D hz;
+    s->NominalFreq =3D hz;
+}
+
+static void cpufreq_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    CpufreqState *s =3D CPUFREQ(obj);
+
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    unsigned int smp_cpus =3D ms->smp.cpus;
+
+    s->reg_size =3D smp_cpus * CPPC_REG_PER_CPU_STRIDE;
+    if (s->reg_size > MAX_SUPPORT_SPACE) {
+        error_report("Required space 0x%x excesses the maximun size 0x%x=
",
+                 s->reg_size, MAX_SUPPORT_SPACE);
+        abort();
+    }
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &cpufreq_ops, s, "cpufre=
q",
+                          s->reg_size);
+    sysbus_init_mmio(sbd, &s->iomem);
+    hz_init(s);
+    return;
+}
+
+static const TypeInfo cpufreq_info =3D {
+    .name          =3D TYPE_CPUFREQ,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(CpufreqState),
+    .instance_init =3D cpufreq_init,
+};
+
+static void cpufreq_register_types(void)
+{
+    type_register_static(&cpufreq_info);
+}
+
+type_init(cpufreq_register_types)
--=20
2.19.1



