Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEACAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:39:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EED2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuMfU9lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EED2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltoz-0005Ui-NM
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkB-0004Om-QM
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jltkA-0004mI-3v
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592483649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGm35NS9TNX7NuxVc5/FgVKm25dd/CU0oP9YFDrfAng=;
 b=SuMfU9lrBTBjHT28wHKPxuZLINzsCr+V5yYm6e1tF9J6zhgZgTH0j2kyNDkzSuf07CNQeF
 SyChXAUsBLPP7yNs/rchEUdzzXN9qHzZj7TY9hHAYg4Z/EKiZ/oMqA9jdzLZ1eZHYLqona
 rr5tEc/uRr94iZilG69ZSw6+CkwBegU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-gbxQFzL4PiGlBvycm5HSpA-1; Thu, 18 Jun 2020 08:34:05 -0400
X-MC-Unique: gbxQFzL4PiGlBvycm5HSpA-1
Received: by mail-wr1-f69.google.com with SMTP id w4so2750760wrl.13
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qGm35NS9TNX7NuxVc5/FgVKm25dd/CU0oP9YFDrfAng=;
 b=ozbRlJ1QF+2KI40h8/MuxBKP+Mmy2CEWTxn0F1Q6pT0ayuxUoUxd2rHYDTWyO7ioIO
 5SkCRw53GwiiC1vd4r4hxQMtQHK1cUAxoipTEcV+ciEBnF2Z2SzXz6Wqmk03DGwGmC3v
 03B9YlqT5xSwn1EXOryLT6Uig+vEvMGbrsPM0rGRYl2RsEA69Kx+W9KUmPJ3pE8gojGZ
 +DpGHm7TdiECZ4nRIfD74Ijlcli+UphmiwJfyo0qkp0om5UUA4BE497Wi+8puSsJJleK
 H9OMiNoyWcns2DqC/ZhgbAzUr+/tHH0FDS+ohRC+m2tmhFsIl2TWwoCnMRbRasw1vE6T
 zAjQ==
X-Gm-Message-State: AOAM530tJC09Nyq9uBZxFqvkBUN8RzT2j4pwv6iBq8C4kURqi+kRuTRP
 3hVZ1EQxJ+/ZB/fUXpw7EU4sAQcPnUIvFfWfUJYv3T48LCdnNOyByoqwt2zoz4dRak1/JPRDCzW
 Z+tlMHrZgJd5I+zc=
X-Received: by 2002:a05:6000:10cf:: with SMTP id
 b15mr4335089wrx.214.1592483643968; 
 Thu, 18 Jun 2020 05:34:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw71Y5QCb+2TRfiq3gVG0S5v4Pewe7HyoiaGE+3scgR8fl+iA9L6r+2Ovj/9LN8zdKl55a6/w==
X-Received: by 2002:a05:6000:10cf:: with SMTP id
 b15mr4335066wrx.214.1592483643748; 
 Thu, 18 Jun 2020 05:34:03 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j14sm3465557wrs.75.2020.06.18.05.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:34:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 04/10] configure: Generate rule to calculate the base
 architecture of a target
Date: Thu, 18 Jun 2020 14:33:36 +0200
Message-Id: <20200618123342.10693-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200618123342.10693-1-philmd@redhat.com>
References: <20200618123342.10693-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

As we encode the base architecture in configure.sh, we can emit
the base-arch() function into config-host.mak.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 configure | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/configure b/configure
index ba88fd1824..c0d7fbc30e 100755
--- a/configure
+++ b/configure
@@ -7927,6 +7927,8 @@ if test "$linux" = "yes" ; then
     fi
 fi
 
+target_to_base_map=""
+
 for target in $target_list; do
 target_dir="$target"
 config_target_mak=$target_dir/config-target.mak
@@ -8155,6 +8157,7 @@ target_arch_name="$(upper $TARGET_ARCH)"
 echo "TARGET_$target_arch_name=y" >> $config_target_mak
 echo "TARGET_NAME=$target_name" >> $config_target_mak
 echo "TARGET_BASE_ARCH=$TARGET_BASE_ARCH" >> $config_target_mak
+target_to_base_map="$target_dir,$TARGET_BASE_ARCH $target_to_base_map"
 if [ "$TARGET_ABI_DIR" = "" ]; then
   TARGET_ABI_DIR=$TARGET_ARCH
 fi
@@ -8370,6 +8373,22 @@ if test "$ccache_cpp2" = "yes"; then
   echo "export CCACHE_CPP2=y" >> $config_host_mak
 fi
 
+# Export a rule for calculating base arch from target_dir for use by
+# the Kconfig generator
+echo "# Usage: \$(call base-arch, target-dir)" >> $config_host_mak
+echo "# Return the base architecture for a target." >> $config_host_mak
+echo "# e.g \$(call base-arch, aarch64-linux-user) returns 'arm'" >> $config_host_mak
+echo "base-arch = \$(strip \\" >> $config_host_mak
+close_braces=""
+for pairs in $target_to_base_map
+do
+    dir="${pairs%%,*}"
+    base="${pairs#*,}"
+    echo "\$(if \$(findstring $dir,\$1),$base, \\" >> $config_host_mak
+    close_braces="$close_braces )"
+done
+echo "$close_braces )" >> $config_host_mak
+
 # If we're using a separate build tree, set it up now.
 # DIRS are directories which we simply mkdir in the build tree;
 # LINKS are things to symlink back into the source tree
-- 
2.21.3


