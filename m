Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80258C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 04:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40856206F0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 04:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="d/T0X+ZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40856206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipPCw-0006tY-4w
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 23:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <masahiroy@kernel.org>) id 1ipPCF-0006Lf-8U
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:13:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <masahiroy@kernel.org>) id 1ipPCD-0002Ze-TL
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:13:23 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:62838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <masahiroy@kernel.org>)
 id 1ipPC8-0002Hs-Fh; Wed, 08 Jan 2020 23:13:17 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 0094CUwT026552;
 Thu, 9 Jan 2020 13:12:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 0094CUwT026552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1578543151;
 bh=BGrV9MYFYy/4lN3+lwdtOSdl3h0m0Dt37S+FF37WHQc=;
 h=From:To:Cc:Subject:Date:From;
 b=d/T0X+ZAfspEWoIVTg6beDtFsXcpo+8TfB2VkYDfVX2fDsjd0JLe106hkZ5zWkD+w
 IbMy5mC2H5icC68IkVKkkOYtG5BHN0x4RDr04zeM4cRbM4x3exNGenvNHRp/0/Hedo
 OamRG1eZ5De043p7uTnTt3/Hau25+r4DykuhViQV1UCWDrX/WhV1oO0v+6Lwc8fa09
 DaT+Weq8Rj5RIQU9LWuytgEkytPOorJlh38SaODizyH/IBRioIwa+Jd5Np1BGLLDIj
 rAgRCfNbx/Vlx6lZKsGw+sLx5zzyVel2vrIMHbdr8oU/DPKp61s5y2OZSflbl+EQE9
 swYZzQpIuDNig==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <masahiroy@kernel.org>
To: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] target/arm/arm-semi: fix SYS_OPEN to return nonzero filehandle
Date: Thu,  9 Jan 2020 13:12:28 +0900
Message-Id: <20200109041228.10131-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 210.131.2.75
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
Cc: Masahiro Yamada <masahiroy@kernel.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the specification "Semihosting for AArch32 and Aarch64",
the SYS_OPEN operation should return:

 - A nonzero handle if the call is successful
 - -1 if the call is not successful

So, it should never return 0.

Prior to commit 35e9a0a8ce4b ("target/arm/arm-semi: Make semihosting
code hand out its own file descriptors"), the guest fd matched to the
host fd. It returned a nonzero handle on success since the fd 0 is
already used for stdin.

Now that the guest fd is the index of guestfd_array, it starts from 0.

I noticed this issue particularly because Trusted Firmware-A built with
PLAT=qemu is no longer working. Its io_semihosting driver only handles
a positive return value as a valid filehandle.

Basically, there are two ways to fix this:

  - Use (guestfd - 1) as the index of guestfs_arrary. We need to insert
    increment/decrement to convert the guestfd and the array index back
    and forth.

  - Keep using guestfd as the index of guestfs_array. The first entry
    of guestfs_array is left unused.

I thought the latter is simpler. We end up with wasting a small piece
of memory for the unused first entry of guestfd_array, but this is
probably not a big deal.

Fixes: 35e9a0a8ce4b ("target/arm/arm-semi: Make semihosting code hand out its own file descriptors")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 target/arm/arm-semi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 6f7b6d801bf9..4275dfc34591 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -144,7 +144,8 @@ static int alloc_guestfd(void)
         guestfd_array = g_array_new(FALSE, TRUE, sizeof(GuestFD));
     }
 
-    for (i = 0; i < guestfd_array->len; i++) {
+    /* SYS_OPEN should return nonzero handle on success. Start guestfd from 1 */
+    for (i = 1; i < guestfd_array->len; i++) {
         GuestFD *gf = &g_array_index(guestfd_array, GuestFD, i);
 
         if (gf->type == GuestFDUnused) {
@@ -168,7 +169,7 @@ static GuestFD *do_get_guestfd(int guestfd)
         return NULL;
     }
 
-    if (guestfd < 0 || guestfd >= guestfd_array->len) {
+    if (guestfd <= 0 || guestfd >= guestfd_array->len) {
         return NULL;
     }
 
-- 
2.17.1


