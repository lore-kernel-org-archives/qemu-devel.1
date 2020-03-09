Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5A5C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74E920848
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74E920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNwx-00072O-36
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNw0-0005j2-Hl
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:19:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNvz-0007P2-5f
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:19:28 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:51905 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jBNvy-0007O2-TV
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:19:27 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id CDCF35F6F;
 Mon,  9 Mar 2020 20:19:25 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A734A5A04F;
 Mon,  9 Mar 2020 20:19:25 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BA365A045;
 Mon,  9 Mar 2020 20:19:25 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS;
 Mon,  9 Mar 2020 20:19:25 +0100 (CET)
Received: from 669c1c222ef4 (static.187.0.0.81.ibercom.com [81.0.0.187])
 by smtp2 (Postfix) with ESMTPSA id 588325F6F;
 Mon,  9 Mar 2020 20:19:25 +0100 (CET)
Date: Mon, 9 Mar 2020 19:19:24 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 02/10] qemu-binfmt-conf.sh: enforce safe tests
Message-ID: <20200309191924.GB65@669c1c222ef4>
References: <20200309191200.GA60@669c1c222ef4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309191200.GA60@669c1c222ef4>
X-Greylist: ACL 191 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Mon, 09 Mar 2020 20:19:25 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25280.002
X-TM-AS-Result: No-0.253-7.0-31-10
X-imss-scan-details: No-0.253-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25280.002
X-TMASE-Result: 10-0.252900-10.000000
X-TMASE-MatchedRID: SUQ+NPRnbh2U2+gk9zFq8Wj+pATS/uaDab+ZPXqZNQIRGC0rW8q1XUhq
 QpzXZe40YNA0HZI8EiGPQi9XuOWoOA719kpOO37PlchF+IvkllOZ2scyRQcer0p12IXZajx5l5E
 fwglrgibcDDiLNFW0338mA3sDDq0A5MIx11wv+COujVRFkkVsm0r0NWqXwFtCiB5O0Sfffperyi
 6SZSetV8cZ0J7yLqpqnjfVSwVbRsuIqhk2ZZ/hxF3P+KLVI//s3dLftEkjrnEl2KDtHVTYMlDwi
 PJ9vtHU1pHp569Iswjf5J+T5huzBH9c2E6+vBYDhCWCIvLE6iA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Mon, 09 Mar 2020 20:19:25 +0100 (CET)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 158.227.0.66
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All the tests are prefixed with 'x', in order to avoid risky comparisons
(i.e. a user deliberately trying to provoke a syntax error).

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index c728443ba2..98401f4e7c 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -259,10 +259,10 @@ qemu_check_systemd() {
 
 qemu_generate_register() {
     flags=""
-    if [ "$CREDENTIAL" = "yes" ]; then
+    if [ "x$CREDENTIAL" = "xyes" ]; then
         flags="OC"
     fi
-    if [ "$PERSISTENT" = "yes" ]; then
+    if [ "x$PERSISTENT" = "xyes" ]; then
         flags="${flags}F"
     fi
 
@@ -300,18 +300,18 @@ qemu_set_binfmts() {
         mask=$(eval echo \$${cpu}_mask)
         family=$(eval echo \$${cpu}_family)
 
-        if [ "$magic" = "" ] || [ "$mask" = "" ] || [ "$family" = "" ]; then
+        if [ "x$magic" = "x" ] || [ "x$mask" = "x" ] || [ "x$family" = "x" ]; then
             echo "INTERNAL ERROR: unknown cpu $cpu" 1>&2
             continue
         fi
 
         qemu="$QEMU_PATH/qemu-$cpu"
-        if [ "$cpu" = "i486" ]; then
+        if [ "x$cpu" = "xi486" ]; then
             qemu="$QEMU_PATH/qemu-i386"
         fi
 
         qemu="$qemu$QEMU_SUFFIX"
-        if [ "$host_family" != "$family" ]; then
+        if [ "x$host_family" != "x$family" ]; then
             $BINFMT_SET
         fi
     done
-- 
2.25.1



