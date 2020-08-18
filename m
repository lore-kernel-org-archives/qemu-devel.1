Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F795C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09444206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mv89DSD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09444206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tOX-0000cg-As
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7P-0000kR-Am; Tue, 18 Aug 2020 00:21:03 -0400
Received: from ozlabs.org ([203.11.71.1]:60799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t7M-0006dM-RX; Tue, 18 Aug 2020 00:21:02 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNk1Clfz9sW9; Tue, 18 Aug 2020 14:19:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724374;
 bh=tbf7e1/8oTfJM2oleGmsFgOKdsRYrI6dXLzRHANsedE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mv89DSD38TtEn6mNGtTM+MtZq84NbMqrFRCpc6ERO1qyZ8Dc2xI/K6IUCfOoLz/ml
 Pur4HANIv++shCji25JGPygoRQLPX4t/4fYLS4SFMaB9/nYfoeqZ+SY6D6De1aa25W
 CKa9k2zfAyJZ/5DnA9VD+qEihAfVUpgv8w8dFrSY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 39/40] nvram: Exit QEMU if NVRAM cannot contain all -prom-env
 data
Date: Tue, 18 Aug 2020 14:19:21 +1000
Message-Id: <20200818041922.251708-40-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 00:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
support the -prom-env parameter"), pseries machines can pre-initialize
the "system" partition in the NVRAM with the data passed to all -prom-env
parameters on the QEMU command line.

In this case it is assumed that all the data fits in 64 KiB, but the user
can easily pass more and crash QEMU:

$ qemu-system-ppc64 -M pseries $(for ((x=0;x<128;x++)); do \
  echo -n " -prom-env " ; printf "%0.sx" {1..1024}; \
  done) # this requires ~128 Kib
malloc(): corrupted top size
Aborted (core dumped)

This happens because we don't check if all the prom-env data fits in
the NVRAM and chrp_nvram_set_var() happily memcpy() it passed the
buffer.

This crash affects basically all ppc/ppc64 machine types that use -prom-env:
- pseries (all versions)
- g3beige
- mac99

and also sparc/sparc64 machine types:
- LX
- SPARCClassic
- SPARCbook
- SS-10
- SS-20
- SS-4
- SS-5
- SS-600MP
- Voyager
- sun4u
- sun4v

Add a max_len argument to chrp_nvram_create_system_partition() so that
it can check the available size before writing to memory.

Since NVRAM is populated at machine init, it seems reasonable to consider
this error as fatal. So, instead of reporting an error when we detect that
the NVRAM is too small and adapt all machine types to handle it, we simply
exit QEMU in all cases. This is still better than crashing. If someone
wants another behavior, I guess this can be reworked later.

Tested with:

$ yes q | \
  (for arch in ppc ppc64 sparc sparc64; do \
       echo == $arch ==; \
       qemu=${arch}-softmmu/qemu-system-$arch; \
       for mach in $($qemu -M help | awk '! /^Supported/ { print $1 }'); do \
           echo $mach; \
           $qemu -M $mach -monitor stdio -nodefaults -nographic \
           $(for ((x=0;x<128;x++)); do \
                 echo -n " -prom-env " ; printf "%0.sx" {1..1024}; \
             done) >/dev/null; \
        done; echo; \
   done)

Without the patch, affected machine types cause QEMU to report some
memory corruption and crash:

malloc(): corrupted top size

free(): invalid size

*** stack smashing detected ***: terminated

With the patch, QEMU prints the following message and exits:

NVRAM is too small. Try to pass less data to -prom-env

It seems that the conditions for the crash have always existed, but it
affects pseries, the machine type I care for, since commit 61f20b9dc5b7
only.

Fixes: 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to support the -prom-env parameter")
RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1867739
Reported-by: John Snow <jsnow@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159736033937.350502.12402444542194031035.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/nvram/chrp_nvram.c         | 24 +++++++++++++++++++++---
 hw/nvram/mac_nvram.c          |  2 +-
 hw/nvram/spapr_nvram.c        |  3 ++-
 hw/sparc/sun4m.c              |  2 +-
 hw/sparc64/sun4u.c            |  2 +-
 include/hw/nvram/chrp_nvram.h |  3 ++-
 6 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/nvram/chrp_nvram.c b/hw/nvram/chrp_nvram.c
index d969f26704..d4d10a7c03 100644
--- a/hw/nvram/chrp_nvram.c
+++ b/hw/nvram/chrp_nvram.c
@@ -21,14 +21,21 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "hw/nvram/chrp_nvram.h"
 #include "sysemu/sysemu.h"
 
-static int chrp_nvram_set_var(uint8_t *nvram, int addr, const char *str)
+static int chrp_nvram_set_var(uint8_t *nvram, int addr, const char *str,
+                              int max_len)
 {
     int len;
 
     len = strlen(str) + 1;
+
+    if (max_len < len) {
+        return -1;
+    }
+
     memcpy(&nvram[addr], str, len);
 
     return addr + len;
@@ -38,19 +45,26 @@ static int chrp_nvram_set_var(uint8_t *nvram, int addr, const char *str)
  * Create a "system partition", used for the Open Firmware
  * environment variables.
  */
-int chrp_nvram_create_system_partition(uint8_t *data, int min_len)
+int chrp_nvram_create_system_partition(uint8_t *data, int min_len, int max_len)
 {
     ChrpNvramPartHdr *part_header;
     unsigned int i;
     int end;
 
+    if (max_len < sizeof(*part_header)) {
+        goto fail;
+    }
+
     part_header = (ChrpNvramPartHdr *)data;
     part_header->signature = CHRP_NVPART_SYSTEM;
     pstrcpy(part_header->name, sizeof(part_header->name), "system");
 
     end = sizeof(ChrpNvramPartHdr);
     for (i = 0; i < nb_prom_envs; i++) {
-        end = chrp_nvram_set_var(data, end, prom_envs[i]);
+        end = chrp_nvram_set_var(data, end, prom_envs[i], max_len - end);
+        if (end == -1) {
+            goto fail;
+        }
     }
 
     /* End marker */
@@ -65,6 +79,10 @@ int chrp_nvram_create_system_partition(uint8_t *data, int min_len)
     chrp_nvram_finish_partition(part_header, end);
 
     return end;
+
+fail:
+    error_report("NVRAM is too small. Try to pass less data to -prom-env");
+    exit(EXIT_FAILURE);
 }
 
 /**
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index beec1c4e4d..11f2d31cdb 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -141,7 +141,7 @@ static void pmac_format_nvram_partition_of(MacIONVRAMState *nvr, int off,
 
     /* OpenBIOS nvram variables partition */
     sysp_end = chrp_nvram_create_system_partition(&nvr->data[off],
-                                                  DEF_SYSTEM_SIZE) + off;
+                                                  DEF_SYSTEM_SIZE, len) + off;
 
     /* Free space partition */
     chrp_nvram_create_free_partition(&nvr->data[sysp_end], len - sysp_end);
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 15d08281d4..386513499f 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -188,7 +188,8 @@ static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
         }
     } else if (nb_prom_envs > 0) {
         /* Create a system partition to pass the -prom-env variables */
-        chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZE / 4);
+        chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_SIZE / 4,
+                                           nvram->size);
         chrp_nvram_create_free_partition(&nvram->buf[MIN_NVRAM_SIZE / 4],
                                          nvram->size - MIN_NVRAM_SIZE / 4);
     }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 9be930415f..cf7dfa4af5 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -143,7 +143,7 @@ static void nvram_init(Nvram *nvram, uint8_t *macaddr,
     memset(image, '\0', sizeof(image));
 
     /* OpenBIOS nvram variables partition */
-    sysp_end = chrp_nvram_create_system_partition(image, 0);
+    sysp_end = chrp_nvram_create_system_partition(image, 0, 0x1fd0);
 
     /* Free space partition */
     chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 9e30203dcc..37310b73e6 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -136,7 +136,7 @@ static int sun4u_NVRAM_set_params(Nvram *nvram, uint16_t NVRAM_size,
     memset(image, '\0', sizeof(image));
 
     /* OpenBIOS nvram variables partition */
-    sysp_end = chrp_nvram_create_system_partition(image, 0);
+    sysp_end = chrp_nvram_create_system_partition(image, 0, 0x1fd0);
 
     /* Free space partition */
     chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end);
diff --git a/include/hw/nvram/chrp_nvram.h b/include/hw/nvram/chrp_nvram.h
index 09941a9be4..4a0f5c21b8 100644
--- a/include/hw/nvram/chrp_nvram.h
+++ b/include/hw/nvram/chrp_nvram.h
@@ -50,7 +50,8 @@ chrp_nvram_finish_partition(ChrpNvramPartHdr *header, uint32_t size)
     header->checksum = sum & 0xff;
 }
 
-int chrp_nvram_create_system_partition(uint8_t *data, int min_len);
+/* chrp_nvram_create_system_partition() failure is fatal */
+int chrp_nvram_create_system_partition(uint8_t *data, int min_len, int max_len);
 int chrp_nvram_create_free_partition(uint8_t *data, int len);
 
 #endif
-- 
2.26.2


