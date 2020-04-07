Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12026C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D96E620644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96E620644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmED-0001Yz-0z
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cfontana@suse.de>) id 1jLmDX-0000io-Up
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cfontana@suse.de>) id 1jLmDQ-0001J5-61
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:16:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:43916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cfontana@suse.de>) id 1jLmDQ-0001I3-0L
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:16:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B4B60AC62;
 Tue,  7 Apr 2020 11:16:20 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] configure: check for bison, flex before dtc submodule build
Date: Tue,  7 Apr 2020 13:16:18 +0200
Message-Id: <20200407111618.17241-1-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>, Claudio Fontana <cfontana@suse.de>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

if fdt is required, and the system DTC (libfdt) is not usable,
check for the dtc submodule requirements before trying to build it,
and error out with a helpful message in case the dependencies are not met.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 configure | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configure b/configure
index 22870f3867..68b95b8e94 100755
--- a/configure
+++ b/configure
@@ -4276,6 +4276,14 @@ EOF
           git_submodules="${git_submodules} dtc"
       fi
       if test -d "${source_path}/dtc/libfdt" || test -e "${source_path}/.git" ; then
+          for binary in ${BISON:-bison} ${LEX:-flex} ; do
+              if ! has $binary ; then
+                  error_exit "DTC (libfdt) version >= 1.4.2 not present on the system,\n" \
+                             "and using the dtc submodule replacement requires '${binary}'.\n" \
+                             "Please install the DTC (libfdt) devel package,\n" \
+                             "or the required binary '${binary}' to use the dtc submodule instead.\n"
+              fi
+          done
           fdt=git
           mkdir -p dtc
           if [ "$pwd_is_source_path" != "y" ] ; then
-- 
2.16.4


