Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7D4C11D24
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE692071E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ELr4mgli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE692071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zJW-00050s-Vm
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z88-0002Vo-Hs
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z86-0000Gu-7G
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:32 -0500
Received: from ozlabs.org ([203.11.71.1]:47725)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z85-0008GS-R3; Thu, 20 Feb 2020 22:37:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwJ64hWz9sSk; Fri, 21 Feb 2020 14:37:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256224;
 bh=b+pSqFeNJtq8tlWR3yUuCcaRuH5bSZGMiVbJiMXOhxQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ELr4mgliBpz+okMAuvTucjZFjdS5VQvkAVd1aRzqfXGw0q6DZxrjEbcCIhg/n0diJ
 zcfGbkVbEgSHie/b5CJDY04RcHDr2iv2bf3DGNGaFasm47NRurncd/9eK2D7vQV7dS
 ruyQkDvWdeywaxhLpvdzynJapEw3Z91iDIU3WgAI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 17/20] ppc: free 'fdt' after reset the machine
Date: Fri, 21 Feb 2020 14:36:47 +1100
Message-Id: <20200221033650.444386-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Euler Robot <euler.robot@huawei.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

'fdt' forgot to clean both e500 and pnv when we call 'system_reset' on pp=
c,
this patch fix it. The leak stacks are as follow:

Direct leak of 4194304 byte(s) in 4 object(s) allocated from:
    #0 0x7fafe37dd970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
    #1 0x7fafe2e3149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x561876f7f80d in create_device_tree /mnt/sdb/qemu-new/qemu/device=
_tree.c:40
    #3 0x561876b7ac29 in ppce500_load_device_tree /mnt/sdb/qemu-new/qemu/=
hw/ppc/e500.c:364
    #4 0x561876b7f437 in ppce500_reset_device_tree /mnt/sdb/qemu-new/qemu=
/hw/ppc/e500.c:617
    #5 0x56187718b1ae in qemu_devices_reset /mnt/sdb/qemu-new/qemu/hw/cor=
e/reset.c:69
    #6 0x561876f6938d in qemu_system_reset /mnt/sdb/qemu-new/qemu/vl.c:14=
12
    #7 0x561876f6a25b in main_loop_should_exit /mnt/sdb/qemu-new/qemu/vl.=
c:1645
    #8 0x561876f6a398 in main_loop /mnt/sdb/qemu-new/qemu/vl.c:1679
    #9 0x561876f7da8e in main /mnt/sdb/qemu-new/qemu/vl.c:4438
    #10 0x7fafde16b812 in __libc_start_main ../csu/libc-start.c:308
    #11 0x5618765c055d in _start (/mnt/sdb/qemu-new/qemu/build/ppc64-soft=
mmu/qemu-system-ppc64+0x2b1555d)

Direct leak of 1048576 byte(s) in 1 object(s) allocated from:
    #0 0x7fc0a6f1b970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
    #1 0x7fc0a656f49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55eb05acd2ca in pnv_dt_create /mnt/sdb/qemu-new/qemu/hw/ppc/pnv.=
c:507
    #3 0x55eb05ace5bf in pnv_reset /mnt/sdb/qemu-new/qemu/hw/ppc/pnv.c:57=
8
    #4 0x55eb05f2f395 in qemu_system_reset /mnt/sdb/qemu-new/qemu/vl.c:14=
10
    #5 0x55eb05f43850 in main /mnt/sdb/qemu-new/qemu/vl.c:4403
    #6 0x7fc0a18a9812 in __libc_start_main ../csu/libc-start.c:308
    #7 0x55eb0558655d in _start (/mnt/sdb/qemu-new/qemu/build/ppc64-softm=
mu/qemu-system-ppc64+0x2b1555d)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200214033206.4395-1-pannengyuan@huawei.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c | 1 +
 hw/ppc/pnv.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 886442e54f..af537bba2b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -594,6 +594,7 @@ done:
         cpu_physical_memory_write(addr, fdt, fdt_size);
     }
     ret =3D fdt_size;
+    g_free(fdt);
=20
 out:
     g_free(pci_map);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 139c857b1e..e98038b809 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -582,6 +582,8 @@ static void pnv_reset(MachineState *machine)
=20
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
+
+    g_free(fdt);
 }
=20
 static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
--=20
2.24.1


