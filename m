Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE7C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB9ED20828
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 11:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9ED20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgSGJ-0001rR-0K
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 07:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hgS5x-0001yi-1Z
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hgS5u-0001fk-Cz
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:36 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53801 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hgS5t-0000fG-UI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id AC31A1A4598;
 Thu, 27 Jun 2019 12:56:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
 [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 6DAFA1A4567;
 Thu, 27 Jun 2019 12:56:29 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 12:56:15 +0200
Message-Id: <1561632985-24866-4-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v4 03/13] target/ppc: Optimize emulation of
 vgbbd instruction
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
Cc: stefan.brankovic@rt-rk.com, hsp.cat7@gmail.com,
 richard.henderson@linaro.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Optimize altivec instruction vgbbd (Vector Gather Bits by Bytes by Doubleword)
All ith bits (i in range 1 to 8) of each byte of doubleword element in
source register are concatenated and placed into ith byte of appropriate
doubleword element in destination register.

Following solution is done for both doubleword elements of source register
in parallel, in order to reduce the number of instructions needed(that's why
arrays are used):
First, both doubleword elements of source register vB are placed in
appropriate element of array avr. Bits are gathered in 2x8 iterations(2 for
loops). In first iteration bit 1 of byte 1, bit 2 of byte 2,... bit 8 of
byte 8 are in their final spots so avr[i], i={0,1} can be and-ed with
tcg_mask. For every following iteration, both avr[i] and tcg_mask variables
have to be shifted right for 7 and 8 places, respectively, in order to get
bit 1 of byte 2, bit 2 of byte 3.. bit 7 of byte 8 in their final spots so
shifted avr values(saved in tmp) can be and-ed with new value of tcg_mask...
After first 8 iteration(first loop), all the first bits are in their final
places, all second bits but second bit from eight byte are in their places...
only 1 eight bit from eight byte is in it's place). In second loop we do all
operations symmetrically, in order to get other half of bits in their final
spots. Results for first and second doubleword elements are saved in
result[0] and result[1] respectively. In the end those results are saved in
appropriate doubleword element of destination register vD.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |   1 -
 target/ppc/int_helper.c             | 276 ------------------------------------
 target/ppc/translate/vmx-impl.inc.c |  77 +++++++++-
 3 files changed, 76 insertions(+), 278 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 33dad6a..cf1af51 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -320,7 +320,6 @@ DEF_HELPER_1(vclzlsbb, tl, avr)
 DEF_HELPER_1(vctzlsbb, tl, avr)
 DEF_HELPER_3(vbpermd, void, avr, avr, avr)
 DEF_HELPER_3(vbpermq, void, avr, avr, avr)
-DEF_HELPER_2(vgbbd, void, avr, avr)
 DEF_HELPER_3(vpmsumb, void, avr, avr, avr)
 DEF_HELPER_3(vpmsumh, void, avr, avr, avr)
 DEF_HELPER_3(vpmsumw, void, avr, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index a23853e..87e3062 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1185,282 +1185,6 @@ void helper_vbpermq(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 #undef VBPERMQ_INDEX
 #undef VBPERMQ_DW
 
-static const uint64_t VGBBD_MASKS[256] = {
-    0x0000000000000000ull, /* 00 */
-    0x0000000000000080ull, /* 01 */
-    0x0000000000008000ull, /* 02 */
-    0x0000000000008080ull, /* 03 */
-    0x0000000000800000ull, /* 04 */
-    0x0000000000800080ull, /* 05 */
-    0x0000000000808000ull, /* 06 */
-    0x0000000000808080ull, /* 07 */
-    0x0000000080000000ull, /* 08 */
-    0x0000000080000080ull, /* 09 */
-    0x0000000080008000ull, /* 0A */
-    0x0000000080008080ull, /* 0B */
-    0x0000000080800000ull, /* 0C */
-    0x0000000080800080ull, /* 0D */
-    0x0000000080808000ull, /* 0E */
-    0x0000000080808080ull, /* 0F */
-    0x0000008000000000ull, /* 10 */
-    0x0000008000000080ull, /* 11 */
-    0x0000008000008000ull, /* 12 */
-    0x0000008000008080ull, /* 13 */
-    0x0000008000800000ull, /* 14 */
-    0x0000008000800080ull, /* 15 */
-    0x0000008000808000ull, /* 16 */
-    0x0000008000808080ull, /* 17 */
-    0x0000008080000000ull, /* 18 */
-    0x0000008080000080ull, /* 19 */
-    0x0000008080008000ull, /* 1A */
-    0x0000008080008080ull, /* 1B */
-    0x0000008080800000ull, /* 1C */
-    0x0000008080800080ull, /* 1D */
-    0x0000008080808000ull, /* 1E */
-    0x0000008080808080ull, /* 1F */
-    0x0000800000000000ull, /* 20 */
-    0x0000800000000080ull, /* 21 */
-    0x0000800000008000ull, /* 22 */
-    0x0000800000008080ull, /* 23 */
-    0x0000800000800000ull, /* 24 */
-    0x0000800000800080ull, /* 25 */
-    0x0000800000808000ull, /* 26 */
-    0x0000800000808080ull, /* 27 */
-    0x0000800080000000ull, /* 28 */
-    0x0000800080000080ull, /* 29 */
-    0x0000800080008000ull, /* 2A */
-    0x0000800080008080ull, /* 2B */
-    0x0000800080800000ull, /* 2C */
-    0x0000800080800080ull, /* 2D */
-    0x0000800080808000ull, /* 2E */
-    0x0000800080808080ull, /* 2F */
-    0x0000808000000000ull, /* 30 */
-    0x0000808000000080ull, /* 31 */
-    0x0000808000008000ull, /* 32 */
-    0x0000808000008080ull, /* 33 */
-    0x0000808000800000ull, /* 34 */
-    0x0000808000800080ull, /* 35 */
-    0x0000808000808000ull, /* 36 */
-    0x0000808000808080ull, /* 37 */
-    0x0000808080000000ull, /* 38 */
-    0x0000808080000080ull, /* 39 */
-    0x0000808080008000ull, /* 3A */
-    0x0000808080008080ull, /* 3B */
-    0x0000808080800000ull, /* 3C */
-    0x0000808080800080ull, /* 3D */
-    0x0000808080808000ull, /* 3E */
-    0x0000808080808080ull, /* 3F */
-    0x0080000000000000ull, /* 40 */
-    0x0080000000000080ull, /* 41 */
-    0x0080000000008000ull, /* 42 */
-    0x0080000000008080ull, /* 43 */
-    0x0080000000800000ull, /* 44 */
-    0x0080000000800080ull, /* 45 */
-    0x0080000000808000ull, /* 46 */
-    0x0080000000808080ull, /* 47 */
-    0x0080000080000000ull, /* 48 */
-    0x0080000080000080ull, /* 49 */
-    0x0080000080008000ull, /* 4A */
-    0x0080000080008080ull, /* 4B */
-    0x0080000080800000ull, /* 4C */
-    0x0080000080800080ull, /* 4D */
-    0x0080000080808000ull, /* 4E */
-    0x0080000080808080ull, /* 4F */
-    0x0080008000000000ull, /* 50 */
-    0x0080008000000080ull, /* 51 */
-    0x0080008000008000ull, /* 52 */
-    0x0080008000008080ull, /* 53 */
-    0x0080008000800000ull, /* 54 */
-    0x0080008000800080ull, /* 55 */
-    0x0080008000808000ull, /* 56 */
-    0x0080008000808080ull, /* 57 */
-    0x0080008080000000ull, /* 58 */
-    0x0080008080000080ull, /* 59 */
-    0x0080008080008000ull, /* 5A */
-    0x0080008080008080ull, /* 5B */
-    0x0080008080800000ull, /* 5C */
-    0x0080008080800080ull, /* 5D */
-    0x0080008080808000ull, /* 5E */
-    0x0080008080808080ull, /* 5F */
-    0x0080800000000000ull, /* 60 */
-    0x0080800000000080ull, /* 61 */
-    0x0080800000008000ull, /* 62 */
-    0x0080800000008080ull, /* 63 */
-    0x0080800000800000ull, /* 64 */
-    0x0080800000800080ull, /* 65 */
-    0x0080800000808000ull, /* 66 */
-    0x0080800000808080ull, /* 67 */
-    0x0080800080000000ull, /* 68 */
-    0x0080800080000080ull, /* 69 */
-    0x0080800080008000ull, /* 6A */
-    0x0080800080008080ull, /* 6B */
-    0x0080800080800000ull, /* 6C */
-    0x0080800080800080ull, /* 6D */
-    0x0080800080808000ull, /* 6E */
-    0x0080800080808080ull, /* 6F */
-    0x0080808000000000ull, /* 70 */
-    0x0080808000000080ull, /* 71 */
-    0x0080808000008000ull, /* 72 */
-    0x0080808000008080ull, /* 73 */
-    0x0080808000800000ull, /* 74 */
-    0x0080808000800080ull, /* 75 */
-    0x0080808000808000ull, /* 76 */
-    0x0080808000808080ull, /* 77 */
-    0x0080808080000000ull, /* 78 */
-    0x0080808080000080ull, /* 79 */
-    0x0080808080008000ull, /* 7A */
-    0x0080808080008080ull, /* 7B */
-    0x0080808080800000ull, /* 7C */
-    0x0080808080800080ull, /* 7D */
-    0x0080808080808000ull, /* 7E */
-    0x0080808080808080ull, /* 7F */
-    0x8000000000000000ull, /* 80 */
-    0x8000000000000080ull, /* 81 */
-    0x8000000000008000ull, /* 82 */
-    0x8000000000008080ull, /* 83 */
-    0x8000000000800000ull, /* 84 */
-    0x8000000000800080ull, /* 85 */
-    0x8000000000808000ull, /* 86 */
-    0x8000000000808080ull, /* 87 */
-    0x8000000080000000ull, /* 88 */
-    0x8000000080000080ull, /* 89 */
-    0x8000000080008000ull, /* 8A */
-    0x8000000080008080ull, /* 8B */
-    0x8000000080800000ull, /* 8C */
-    0x8000000080800080ull, /* 8D */
-    0x8000000080808000ull, /* 8E */
-    0x8000000080808080ull, /* 8F */
-    0x8000008000000000ull, /* 90 */
-    0x8000008000000080ull, /* 91 */
-    0x8000008000008000ull, /* 92 */
-    0x8000008000008080ull, /* 93 */
-    0x8000008000800000ull, /* 94 */
-    0x8000008000800080ull, /* 95 */
-    0x8000008000808000ull, /* 96 */
-    0x8000008000808080ull, /* 97 */
-    0x8000008080000000ull, /* 98 */
-    0x8000008080000080ull, /* 99 */
-    0x8000008080008000ull, /* 9A */
-    0x8000008080008080ull, /* 9B */
-    0x8000008080800000ull, /* 9C */
-    0x8000008080800080ull, /* 9D */
-    0x8000008080808000ull, /* 9E */
-    0x8000008080808080ull, /* 9F */
-    0x8000800000000000ull, /* A0 */
-    0x8000800000000080ull, /* A1 */
-    0x8000800000008000ull, /* A2 */
-    0x8000800000008080ull, /* A3 */
-    0x8000800000800000ull, /* A4 */
-    0x8000800000800080ull, /* A5 */
-    0x8000800000808000ull, /* A6 */
-    0x8000800000808080ull, /* A7 */
-    0x8000800080000000ull, /* A8 */
-    0x8000800080000080ull, /* A9 */
-    0x8000800080008000ull, /* AA */
-    0x8000800080008080ull, /* AB */
-    0x8000800080800000ull, /* AC */
-    0x8000800080800080ull, /* AD */
-    0x8000800080808000ull, /* AE */
-    0x8000800080808080ull, /* AF */
-    0x8000808000000000ull, /* B0 */
-    0x8000808000000080ull, /* B1 */
-    0x8000808000008000ull, /* B2 */
-    0x8000808000008080ull, /* B3 */
-    0x8000808000800000ull, /* B4 */
-    0x8000808000800080ull, /* B5 */
-    0x8000808000808000ull, /* B6 */
-    0x8000808000808080ull, /* B7 */
-    0x8000808080000000ull, /* B8 */
-    0x8000808080000080ull, /* B9 */
-    0x8000808080008000ull, /* BA */
-    0x8000808080008080ull, /* BB */
-    0x8000808080800000ull, /* BC */
-    0x8000808080800080ull, /* BD */
-    0x8000808080808000ull, /* BE */
-    0x8000808080808080ull, /* BF */
-    0x8080000000000000ull, /* C0 */
-    0x8080000000000080ull, /* C1 */
-    0x8080000000008000ull, /* C2 */
-    0x8080000000008080ull, /* C3 */
-    0x8080000000800000ull, /* C4 */
-    0x8080000000800080ull, /* C5 */
-    0x8080000000808000ull, /* C6 */
-    0x8080000000808080ull, /* C7 */
-    0x8080000080000000ull, /* C8 */
-    0x8080000080000080ull, /* C9 */
-    0x8080000080008000ull, /* CA */
-    0x8080000080008080ull, /* CB */
-    0x8080000080800000ull, /* CC */
-    0x8080000080800080ull, /* CD */
-    0x8080000080808000ull, /* CE */
-    0x8080000080808080ull, /* CF */
-    0x8080008000000000ull, /* D0 */
-    0x8080008000000080ull, /* D1 */
-    0x8080008000008000ull, /* D2 */
-    0x8080008000008080ull, /* D3 */
-    0x8080008000800000ull, /* D4 */
-    0x8080008000800080ull, /* D5 */
-    0x8080008000808000ull, /* D6 */
-    0x8080008000808080ull, /* D7 */
-    0x8080008080000000ull, /* D8 */
-    0x8080008080000080ull, /* D9 */
-    0x8080008080008000ull, /* DA */
-    0x8080008080008080ull, /* DB */
-    0x8080008080800000ull, /* DC */
-    0x8080008080800080ull, /* DD */
-    0x8080008080808000ull, /* DE */
-    0x8080008080808080ull, /* DF */
-    0x8080800000000000ull, /* E0 */
-    0x8080800000000080ull, /* E1 */
-    0x8080800000008000ull, /* E2 */
-    0x8080800000008080ull, /* E3 */
-    0x8080800000800000ull, /* E4 */
-    0x8080800000800080ull, /* E5 */
-    0x8080800000808000ull, /* E6 */
-    0x8080800000808080ull, /* E7 */
-    0x8080800080000000ull, /* E8 */
-    0x8080800080000080ull, /* E9 */
-    0x8080800080008000ull, /* EA */
-    0x8080800080008080ull, /* EB */
-    0x8080800080800000ull, /* EC */
-    0x8080800080800080ull, /* ED */
-    0x8080800080808000ull, /* EE */
-    0x8080800080808080ull, /* EF */
-    0x8080808000000000ull, /* F0 */
-    0x8080808000000080ull, /* F1 */
-    0x8080808000008000ull, /* F2 */
-    0x8080808000008080ull, /* F3 */
-    0x8080808000800000ull, /* F4 */
-    0x8080808000800080ull, /* F5 */
-    0x8080808000808000ull, /* F6 */
-    0x8080808000808080ull, /* F7 */
-    0x8080808080000000ull, /* F8 */
-    0x8080808080000080ull, /* F9 */
-    0x8080808080008000ull, /* FA */
-    0x8080808080008080ull, /* FB */
-    0x8080808080800000ull, /* FC */
-    0x8080808080800080ull, /* FD */
-    0x8080808080808000ull, /* FE */
-    0x8080808080808080ull, /* FF */
-};
-
-void helper_vgbbd(ppc_avr_t *r, ppc_avr_t *b)
-{
-    int i;
-    uint64_t t[2] = { 0, 0 };
-
-    VECTOR_FOR_INORDER_I(i, u8) {
-#if defined(HOST_WORDS_BIGENDIAN)
-        t[i >> 3] |= VGBBD_MASKS[b->u8[i]] >> (i & 7);
-#else
-        t[i >> 3] |= VGBBD_MASKS[b->u8[i]] >> (7 - (i & 7));
-#endif
-    }
-
-    r->u64[0] = t[0];
-    r->u64[1] = t[1];
-}
-
 #define PMSUM(name, srcfld, trgfld, trgtyp)                   \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
 {                                                             \
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 62108ca..d9b346b 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -665,6 +665,81 @@ static void trans_vsr(DisasContext *ctx)
     tcg_temp_free_i64(tmp);
 }
 
+/*
+ * vgbbd VRT,VRB - Vector Gather Bits by Bytes by Doubleword
+ *
+ * All ith bits (i in range 1 to 8) of each byte of doubleword element in source
+ * register are concatenated and placed into ith byte of appropriate doubleword
+ * element in destination register.
+ *
+ * Following solution is done for both doubleword elements of source register
+ * in parallel, in order to reduce the number of instructions needed(that's why
+ * arrays are used):
+ * First, both doubleword elements of source register vB are placed in
+ * appropriate element of array avr. Bits are gathered in 2x8 iterations(2 for
+ * loops). In first iteration bit 1 of byte 1, bit 2 of byte 2,... bit 8 of
+ * byte 8 are in their final spots so avr[i], i={0,1} can be and-ed with
+ * tcg_mask. For every following iteration, both avr[i] and tcg_mask variables
+ * have to be shifted right for 7 and 8 places, respectively, in order to get
+ * bit 1 of byte 2, bit 2 of byte 3.. bit 7 of byte 8 in their final spots so
+ * shifted avr values(saved in tmp) can be and-ed with new value of tcg_mask...
+ * After first 8 iteration(first loop), all the first bits are in their final
+ * places, all second bits but second bit from eight byte are in their places...
+ * only 1 eight bit from eight byte is in it's place). In second loop we do all
+ * operations symmetrically, in order to get other half of bits in their final
+ * spots. Results for first and second doubleword elements are saved in
+ * result[0] and result[1] respectively. In the end those results are saved in
+ * appropriate doubleword element of destination register vD.
+ */
+static void trans_vgbbd(DisasContext *ctx)
+{
+    int VT = rD(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    uint64_t mask = 0x8040201008040201ULL;
+    int i, j;
+
+    TCGv_i64 result[2];
+    result[0] = tcg_temp_new_i64();
+    result[1] = tcg_temp_new_i64();
+    TCGv_i64 avr[2];
+    avr[0] = tcg_temp_new_i64();
+    avr[1] = tcg_temp_new_i64();
+    TCGv_i64 tcg_mask = tcg_temp_new_i64();
+
+    tcg_gen_movi_i64(tcg_mask, mask);
+    for (j = 0; j < 2; j++) {
+        get_avr64(avr[j], VB, j);
+        tcg_gen_and_i64(result[j], avr[j], tcg_mask);
+    }
+    for (i = 1; i < 8; i++) {
+        tcg_gen_movi_i64(tcg_mask, mask >> (i * 8));
+        for (j = 0; j < 2; j++) {
+            tcg_gen_shri_i64(tmp, avr[j], i * 7);
+            tcg_gen_and_i64(tmp, tmp, tcg_mask);
+            tcg_gen_or_i64(result[j], result[j], tmp);
+        }
+    }
+    for (i = 1; i < 8; i++) {
+        tcg_gen_movi_i64(tcg_mask, mask << (i * 8));
+        for (j = 0; j < 2; j++) {
+            tcg_gen_shli_i64(tmp, avr[j], i * 7);
+            tcg_gen_and_i64(tmp, tmp, tcg_mask);
+            tcg_gen_or_i64(result[j], result[j], tmp);
+        }
+    }
+    for (j = 0; j < 2; j++) {
+        set_avr64(VT, result[j], j);
+    }
+
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i64(tcg_mask);
+    tcg_temp_free_i64(result[0]);
+    tcg_temp_free_i64(result[1]);
+    tcg_temp_free_i64(avr[0]);
+    tcg_temp_free_i64(avr[1]);
+}
+
 GEN_VXFORM(vmuloub, 4, 0);
 GEN_VXFORM(vmulouh, 4, 1);
 GEN_VXFORM(vmulouw, 4, 2);
@@ -1209,7 +1284,7 @@ GEN_VXFORM_DUAL(vclzd, PPC_NONE, PPC2_ALTIVEC_207, \
                 vpopcntd, PPC_NONE, PPC2_ALTIVEC_207)
 GEN_VXFORM(vbpermd, 6, 23);
 GEN_VXFORM(vbpermq, 6, 21);
-GEN_VXFORM_NOA(vgbbd, 6, 20);
+GEN_VXFORM_TRANS(vgbbd, 6, 20);
 GEN_VXFORM(vpmsumb, 4, 16)
 GEN_VXFORM(vpmsumh, 4, 17)
 GEN_VXFORM(vpmsumw, 4, 18)
-- 
2.7.4


