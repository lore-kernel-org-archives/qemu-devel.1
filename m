Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7AFC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9AA20836
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qo1XQQfY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9AA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44439 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNj1-0002bp-6t
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaR-0006sw-Gs
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaQ-0007Ey-BW
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:16:47 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7351)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNaQ-000793-38; Mon, 09 Dec 2019 13:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915425; x=1607451425;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FEn9iowGIhh/4J3ieDV3VnOcaKziBmbfgw3ywvga+og=;
 b=qo1XQQfY5sYCO2HjpANtAaaP3BJMw0NjwVbf3X5Z5WZlGL7AwiS1wFVH
 +yAFoJO2q9sjpv1EqCkdXtsbNsZ7pnpeboZxqh8d2GsuZnr7GzvDDtaPC
 kpyDuEHzg2Y7yisd8Kip6GhAl4dl9XgC+ppc6fFitM9iwaLHG6mKxlqAg
 WZzoN1HXVuHon5DQDagsDCXxS8DfRF0nhuK4uAtQ8dSzEuzEc1poTlBXN
 wF1IEFhxxlEtiyLUys/3KYNaUWbp9VjEpKmXeSxrzqyV2YhhLoLkEk1Ak
 Yvmf7tLij+OAas6U+kZvjNfpxmLSCnzSqdY8kq/Tlo/qFssQ3sZb2r+03 w==;
IronPort-SDR: fEE5b2wtSB9W6n9k8p8mgBp++fjCmYSkotwIbGBSgH8hWeFngDTUtciFZsTcAlzhlI88LSjzzf
 EI6WU4qs5fdyH6J7E3jUApJICpi9ao6Jv/uNekUPK8mqdFSeLEkNebgmxz2qpPaJGFUNGLtlTK
 /VX3tpnYrA+yMnEvjNvCf+y2lNdrddOe+J27ywY5P6Y06KLyz7NyQtSRoA8O7uUgbmO/mW9OqK
 8Jc0UB6m67kKr9+8a/5fQiNUV25GRPyx1lpQaYn2QyZUR/HI8vCtcVKEA2GHcIRJVJrLb9u6cX
 GAM=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226411940"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:04 +0800
IronPort-SDR: I/E2bnUfZqlEEENB+CFwIzz9VdDa+6llq/muRARwaoPfrugHGkF8Vg9T3YS7d5SVVtH++T7Hll
 3fg7riK4mNCO+5JBhqfVfGb1A6HybkENvNHT0LqdkfqmpxQPasHa30WfJvs2MLj4Rt2U77rseh
 4zqQJ3xedoI1ncm885et2SiN9sg9Bi9sb8U7vfydKE0RXshGHPiAkE1zn+hWat/nB93hgk1KV4
 Gw7tt55G3TPO0RgopKAzS1b6feALrmPD1mC7F5AKirvrppZGZUo4Gh6Bam7bl44fGuk6QFh2UN
 4hraKcZVawGWljWkXO6gr+jd
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:02 -0800
IronPort-SDR: 2IJIx8AacBGV4Dyw909ZHGldOjiHpe38VPvOCZ0wsQJ0q3NSYuWFtu5JnztlskbwQgJVoxFCfj
 OekPcrfUvydO/gm3HIVFx0dmOT6NgThreQRjEPOBw2UxrvxsKL8lJHH4he1d8U2RA84Rn/u15W
 Z8y2OR6AaM7v1vUAmN6ZBFbWC9TAEpN1m20hCezt98CxhYiYnOaKNVQiphMkxBCA4JZcDIThy0
 hUDRD5D7zGfKWBDeA3e7L80XgQi0n9PASPFLzUrqbiZBM8YOmlNZSFbxE0VKdvpkzYgiMwmeQ5
 Jk0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:16:45 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 09/36] target/riscv: Fix CSR perm checking for HS mode
Date: Mon,  9 Dec 2019 10:11:04 -0800
Message-Id: <72b377cf058f6d159a40301b6880f017404ef9cd.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the CSR permission checking to work correctly when we are in
HS-mode.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 6a0a59edfd..eebfc1823d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -802,12 +802,22 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     /* check privileges and return -1 if check fails */
 #if !defined(CONFIG_USER_ONLY)
-    int csr_priv = get_field(csrno, 0x300);
+    int effective_priv = env->priv;
     int read_only = get_field(csrno, 0xC00) == 3;
-    if ((!env->debugger) && (env->priv < csr_priv)) {
-        return -1;
+
+    if (riscv_has_ext(env, RVH) &&
+        env->priv == PRV_S &&
+        !riscv_cpu_virt_enabled(env)) {
+        /*
+         * We are in S mode without virtualisation, therefore we are in HS Mode.
+         * Add 1 to the effective privledge level to allow us to access the
+         * Hypervisor CSRs.
+         */
+        effective_priv++;
     }
-    if (write_mask && read_only) {
+
+    if ((write_mask && read_only) ||
+        (!env->debugger && (effective_priv < get_field(csrno, 0x300)))) {
         return -1;
     }
 #endif
-- 
2.24.0


