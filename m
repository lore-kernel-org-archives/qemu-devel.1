Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A2CC4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 00:42:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C862C20757
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 00:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C862C20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUJl5-0001sN-Vd
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 20:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joseph_myers@mentor.com>) id 1jUJj7-0000TD-Ad
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 20:40:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <joseph_myers@mentor.com>) id 1jUJij-0004BV-8G
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 20:40:22 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:64093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joseph_myers@mentor.com>)
 id 1jUJie-0003sN-JL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 20:39:57 -0400
IronPort-SDR: M5EV7SYg60fP9Ef37em9bQLxf97grpwBTJ1Lmjhw5/yxOd+1G5hLOR/GnWrip0o2c1HsHvOgoU
 bqLAp7vUFRUcVx1ouK1q3//6THtq+Vjl4ATV9jsHPeLvBacnlN2I0YcXvW0T91Xi4bK7zO4z+c
 se/104EqNjq60H6FzpB1wFWSoDYGBJAMub/fp0jTirfPBCPeeMhKKBNJivSW/SSDUenu/rbggB
 ba3hO4s1VyA73r6Kxq9RYoDVS39lNlSk9yhkq4MC0hEBmm4nFdaNi4acZukseRpgluJCDFsWbn
 yJw=
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; d="scan'208";a="50425318"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa1.mentor.iphmx.com with ESMTP; 30 Apr 2020 16:39:53 -0800
IronPort-SDR: SdFsOwrAIhY1otDszQsp5ZO2F12gB4UdYlCvQ9IWKrsptf7AihP2wRaSo/K+2xSU75jrZMmjDE
 5ApwaGRAo3DaLIuHfmYPjWkXf2MI066qXPd17nZVo8JyYnbUnP46x8tItjejPkGfzmFMfXJFBv
 q9+T3UYpOKbZaNARYyV5CYOwo86BAhkWwPN4mHR+bUFE54AnigkdVlLUCZC9bnfk8rMJgSWFRa
 yqaef+AwhsNrPUPge45wpUa+lVolFnmjLVCulLrfZWkaa1msDFBkApY7Jpz2QLrCDaiztQq8r4
 +TE=
Date: Fri, 1 May 2020 00:39:47 +0000
From: Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To: <qemu-devel@nongnu.org>
Subject: [PATCH 4/4] softfloat: fix floatx80 pseudo-denormal round to integer
Message-ID: <alpine.DEB.2.21.2005010039120.30535@digraph.polyomino.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Received-SPF: pass client-ip=68.232.129.153;
 envelope-from=joseph_myers@mentor.com; helo=esa1.mentor.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 20:38:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 68.232.129.153
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

The softfloat function floatx80_round_to_int incorrectly handles the
case of a pseudo-denormal where only the high bit of the significand
is set, ignoring that bit (treating the number as an exact zero)
rather than treating the number as an alternative representation of
+/- 2^-16382 (which may round to +/- 1 depending on the rounding mode)
as hardware does.  Fix this check (simplifying the code in the
process).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8e9c714e6f..e29b07542a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -5741,7 +5741,7 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
     }
     if ( aExp < 0x3FFF ) {
         if (    ( aExp == 0 )
-             && ( (uint64_t) ( extractFloatx80Frac( a )<<1 ) == 0 ) ) {
+             && ( (uint64_t) ( extractFloatx80Frac( a ) ) == 0 ) ) {
             return a;
         }
         status->float_exception_flags |= float_flag_inexact;
-- 
2.17.1


-- 
Joseph S. Myers
joseph@codesourcery.com

