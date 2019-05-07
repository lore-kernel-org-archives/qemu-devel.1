Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0DEC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 22:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3818020825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 22:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fintelia.io header.i=@fintelia.io header.b="eQLZC3Eu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3818020825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fintelia.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55703 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO8mG-00032H-El
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 18:41:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54917)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
	id 1hO8im-0001FS-5I
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
	id 1hO8il-0005oh-8b
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:38:00 -0400
Received: from rs224.mailgun.us ([209.61.151.224]:19784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<bounce+cf442f.9b4e76-qemu-devel=nongnu.org@fintelia.io>)
	id 1hO8il-0005d9-0K
	for qemu-devel@nongnu.org; Tue, 07 May 2019 18:37:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=fintelia.io; q=dns/txt;
	s=pic; 
	t=1557268677; h=Content-Transfer-Encoding: MIME-Version: Message-Id:
	Date: Subject: Cc: To: From: Sender;
	bh=VdsjNYMT/y7obLcd7k81EK0CnfGh7dXjFP/umyMuyq4=;
	b=eQLZC3EuybrnX26jYM4+o76NYxPVI9a3n4VPIKGrxOBa4yZmEI0ynY4zBXNifTNW0PuP+zmJ
	zSn07sddqd4aOiMJ8eMH2qSKkEcXgnVpIQ9+m8oTnkE08ZksF/F5aNxjP5CVtS15Rc0bPJlk
	0jyA3R0ZWSQeJ9RMC9iA97yya5MzSSPc7wzftYOj+oGnAW/a/dta3wvmvtbj/86eGYt41yRJ
	v5E7iEklbZ849GzoFWJauwnGb2Lll5IIaIA1hl8rMVowaMPfaFDo8d6mCKLwzbsyrupu4Jny
	0b8MEHybZcjhzEan/HtCxjs1hQac6WIsr1wnxNEID5OxrjVHqkoR/g==
X-Mailgun-Sending-Ip: 209.61.151.224
X-Mailgun-Sid: WyJlMGM5NSIsICJxZW11LWRldmVsQG5vbmdudS5vcmciLCAiOWI0ZTc2Il0=
Received: from jonathan-ThinkPad-X1-Carbon.csail.mit.edu
	(30-9-187.wireless.csail.mit.edu [128.30.9.187])
	by mxa.mailgun.org with ESMTP id 5cd208c3.7f9160c9f530-smtp-out-n03;
	Tue, 07 May 2019 22:37:55 -0000 (UTC)
From: Jonathan Behrens <jonathan@fintelia.io>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 18:36:46 -0400
Message-Id: <20190507223646.18981-1-jonathan@fintelia.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.61.151.224
X-Mailman-Approved-At: Tue, 07 May 2019 18:40:28 -0400
Subject: [Qemu-devel] [PATCH] target/riscv: More accurate handling of `sip`
 CSR
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jonathan Behrens <jonathan@fintelia.io>, Palmer Dabbelt <palmer@sifive.com>,
	qemu-riscv@nongnu.org, Jonathan Behrens <fintelia@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the spec, "All bits besides SSIP, USIP, and UEIP in the sip
register are read-only." Further, if an interrupt is not delegated to mode x,
then "the corresponding bits in xip [...] should appear to be hardwired to
zero. This patch implements both of those requirements.

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
---
 target/riscv/csr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1ec1222da1..fff7d834e8 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -246,6 +246,7 @@ static const target_ulong sstatus_v1_9_mask = SSTATUS_SIE | SSTATUS_SPIE |
 static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
     SSTATUS_SUM | SSTATUS_MXR | SSTATUS_SD;
+static const target_ulong sip_writable_mask = SIP_SSIP | MIP_USIP | MIP_UEIP;
 
 #if defined(TARGET_RISCV32)
 static const char valid_vm_1_09[16] = {
@@ -694,8 +695,10 @@ static int write_sbadaddr(CPURISCVState *env, int csrno, target_ulong val)
 static int rmw_sip(CPURISCVState *env, int csrno, target_ulong *ret_value,
                    target_ulong new_value, target_ulong write_mask)
 {
-    return rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
-                   write_mask & env->mideleg);
+    int ret = rmw_mip(env, CSR_MSTATUS, ret_value, new_value,
+                      write_mask & env->mideleg & sip_writable_mask);
+    *ret_value &= env->mideleg;
+    return ret;
 }
 
 /* Supervisor Protection and Translation */
-- 
2.20.1

