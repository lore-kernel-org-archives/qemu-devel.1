Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3269BC47247
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 00:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D1320757
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 00:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D1320757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUJjk-0000oU-5o
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 20:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joseph_myers@mentor.com>) id 1jUJiH-0007vR-5O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 20:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <joseph_myers@mentor.com>) id 1jUJi4-0002nN-4g
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 20:39:30 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:16350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUJhy-0002ZF-9y
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 20:39:14 -0400
IronPort-SDR: I3s4GT+OXOvQyP+rpBnKUogBVvKEpMfFeNebTloeoSff6322evQCy3zVM/laQZOhlzhtIfiS5j
 O3pU8UvhC/kYASUDEA9JzTUF3NgA+uokkSDbvUhWHpcmbdodfG85oscZEX3HpFi/KiDagit0Jz
 0nRPjgZtg69tLLJji01F3Blnub9ud1ohXniu3mpXLw5Ca7wJnoKNzc4i9WpDJqV5VPV+esLERQ
 MS4xE5F7nbD1mfQRwYznEB82f/LXDiowaGh5f0G6bx3UNHlKK4qSZz3XgDPNNbDrQtelRuij9c
 qfs=
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; d="scan'208";a="48472378"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 30 Apr 2020 16:39:11 -0800
IronPort-SDR: 9Ej0Q8+6KqW3TX7j9U6hknY4l+jGuMk5PpDD/ASf8TZQJB2dg2ydrJrBBOUPX4z09psl8a/GxA
 ItJN/0DYFJfxOrwzMk5LFCNtgf0D1bvTEkUSIvmgjaGX61tShiagi6cH29+EAW6ULEJ8ZrayoG
 5J0hAq0tNBcyUrymwjvUJgnDhiZiewkVDGjkUiubDFm74vpqBpXmkGZCJNXJ96W1DbLYqoUL6i
 cUOpg/vIUwG4ZErU2DOMZRA5S1Eb3PUGwYo8FsWR0ZzbMEPDWteGFD6elbEksiCRbcSvMaivUq
 rO8=
Date: Fri, 1 May 2020 00:39:05 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>
Subject: [PATCH 3/4] softfloat: fix floatx80 pseudo-denormal comparisons
Message-ID: <alpine.DEB.2.21.2005010038260.30535@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.137.252;
 envelope-from=joseph_myers@mentor.com; helo=esa4.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 20:37:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 68.232.137.252
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The softfloat floatx80 comparisons fail to allow for pseudo-denormals,
which should compare equal to corresponding values with biased
exponent 1 rather than 0.  Add an adjustment for that case when
comparing numbers with the same sign.

Note that this fix only changes floatx80_compare_internal, not the
other more specific comparison operations.  That is the only
comparison function for floatx80 used in the i386 port, which is the
only supported port with these pseudo-denormal semantics.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 fpu/softfloat.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6094d267b5..8e9c714e6f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -7966,6 +7966,11 @@ static inline int floatx80_compare_internal(floatx80 a, floatx80 b,
             return 1 - (2 * aSign);
         }
     } else {
+        /* Normalize pseudo-denormals before comparison.  */
+        if ((a.high & 0x7fff) == 0 && a.low & UINT64_C(0x8000000000000000))
+            ++a.high;
+        if ((b.high & 0x7fff) == 0 && b.low & UINT64_C(0x8000000000000000))
+            ++b.high;
         if (a.low == b.low && a.high == b.high) {
             return float_relation_equal;
         } else {
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

