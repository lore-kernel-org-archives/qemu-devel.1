Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EBDC10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E2622525
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 19:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E2622525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNzq-0004O1-As
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 15:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNzC-0003fJ-OK
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNzB-0001bQ-PT
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:22:46 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:23268 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jBNzB-0001ay-Do
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 15:22:45 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id 6523A65B6;
 Mon,  9 Mar 2020 20:22:44 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37CEE5A050;
 Mon,  9 Mar 2020 20:22:44 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B9FB5A045;
 Mon,  9 Mar 2020 20:22:44 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS;
 Mon,  9 Mar 2020 20:22:44 +0100 (CET)
Received: from 669c1c222ef4 (static.187.0.0.81.ibercom.com [81.0.0.187])
 by smtp2 (Postfix) with ESMTPSA id DD1F05F6F;
 Mon,  9 Mar 2020 20:22:43 +0100 (CET)
Date: Mon, 9 Mar 2020 19:22:42 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 07/10] qemu-binfmt-conf.sh: honour QEMU_PATH and/or
 QEMU_SUFFIX
Message-ID: <20200309192242.GG65@669c1c222ef4>
References: <20200309191200.GA60@669c1c222ef4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309191200.GA60@669c1c222ef4>
X-Greylist: ACL 191 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Mon, 09 Mar 2020 20:22:44 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25280.002
X-TM-AS-Result: No-1.584-7.0-31-10
X-imss-scan-details: No-1.584-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25280.002
X-TMASE-Result: 10-1.583800-10.000000
X-TMASE-MatchedRID: SUQ+NPRnbh0NdWPTMyGlNi2416nc3bQlcZ9gNqdc/asHZBaLwEXlKGb6
 PphVtfZgqZ4KncYE2LPA1r83Ndy7E4G9V0kqQ2uQ2bpX2XJNwqFzHsCOuSqn1gMADm5EdqKWPBz
 wxTDfHyKE97yr4g+GPn8mA3sDDq0A5MIx11wv+COujVRFkkVsmyu9MWoaIV++oCrkB9D9Rc3SCY
 H0rJ+PYyaWRAPBnAfOQu5sCWJbCQGvuCSV9Tys1qlBSdyOhbC1Ru9sLwisTQje2feJC1tWylDwi
 PJ9vtHU1pHp569Iswjf5J+T5huzBH9c2E6+vBYDhCWCIvLE6iA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Mon, 09 Mar 2020 20:22:44 +0100 (CET)
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

Allow to set 'path' or 'suffix' through environment variables,
consistently with 'persistent' and 'credential'.

Signed-off-by: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 5cc6db6aed..b1a54aa470 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -181,7 +181,7 @@ Options and associated environment variables:
 Argument             Env-variable     Description
 -h|--help                             display this usage
 -Q|--path PATH       QEMU_PATH        set path to qemu interpreter(s)
--F|--suffix SUFFIX                    add a suffix to the default interpreter name
+-F|--suffix SUFFIX   QEMU_SUFFIX      add a suffix to the default interpreter name
 -p|--persistent      QEMU_PERSISTENT  (yes) load the interpreter and keep it in memory; all future
                                       uses are cloned from the open file.
 -c|--credential      QEMU_CREDENTIAL  (yes) credential and security tokens are calculated according
@@ -195,6 +195,7 @@ Argument             Env-variable     Description
 
 Defaults:
 QEMU_PATH=$QEMU_PATH
+QEMU_SUFFIX=$QEMU_SUFFIX
 QEMU_PERSISTENT=$QEMU_PERSISTENT
 QEMU_CREDENTIAL=$QEMU_CREDENTIAL
 
@@ -327,13 +328,11 @@ BINFMT_SET=qemu_register_interpreter
 SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"
 
-QEMU_PATH=/usr/local/bin
-
+QEMU_PATH="${QEMU_PATH:-/usr/local/bin}"
+QEMU_SUFFIX="${QEMU_SUFFIX:-}"
 QEMU_PERSISTENT="${QEMU_PERSISTENT:-no}"
 QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
 
-QEMU_SUFFIX=""
-
 options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"
 
-- 
2.25.1



