Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1751BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E6F206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hst0ip2J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E6F206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKro-0000Xj-2B
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnT-0002j8-PC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKnS-0005vC-Qt
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591634330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvhtS3OSMs98c1SpJ0qbWUOWyVxnfYR2isIDLvoIiso=;
 b=Hst0ip2JHR8pDJcOg0h30Tfc4T15serMuyWvdnR2YGXLAS3RMkX2XBl9Yyn1tD+kOzIhMu
 G5/MoE/QUy66FEODJHF0xCNS305WM1FfeTDRkYDc/8Imf7HF2PDATjOH225/HnmaLLD7QI
 Gf9QzUvLQFiBkx9hCoSPfD30AIhWa4E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-9qoWQVf5PFe3dqOwUJSkgg-1; Mon, 08 Jun 2020 12:38:46 -0400
X-MC-Unique: 9qoWQVf5PFe3dqOwUJSkgg-1
Received: by mail-wr1-f70.google.com with SMTP id o1so7339496wrm.17
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SvhtS3OSMs98c1SpJ0qbWUOWyVxnfYR2isIDLvoIiso=;
 b=SKv9T8xVV0hmMTXSwWOR/GYgI8XJzSy1s64R1tb0uF93bXj6Q2hF7/KCMQ+ttIbUu1
 ToZnqGlUJySDAOpfURlb5tTE1fM8ptjsXojRIuXFWPzHm3iItZe/bYCbjFxfIaMFTSx7
 NjVerCuPxZxQ1vwd2pGkJhGo4+N9AiEtNCFD6RO4RbNpk+Z2iXq1/1OInB0cDa3IK8Ww
 ucf4APHUQrFhOGa9yREOowDj1YkJy/5aP/G9kBUSn94GVWVRqTcGIFypa76OVVHI0Fvk
 tjaBadwqwCRHBvIPa8XdkJ0EccnXIIlwE4vyPXCtLZNdVvhiX+hddlYapwkVCsWEFd7V
 dFrw==
X-Gm-Message-State: AOAM532TgoNEYVGS+4sy/aTKSLfSc/lJjGGtQXdUbHjE+k1KzYGQEtAu
 quqjvmlAF3To+UNkQZAN1lLDOYE36bGArqTyjuzIF5ywQIxqAAmCjUmpN+UMtRHixJkzns+Tk0+
 uuD0f4GxMjtgFMVw=
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr26120371wrt.220.1591634325075; 
 Mon, 08 Jun 2020 09:38:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylCw9/DaZErOBfQWhGiUWoiZNiMfIBcTAFLa0MnjrUMU0d4T8aYmnNHsossKVFfTSii/OvVA==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr26120354wrt.220.1591634324858; 
 Mon, 08 Jun 2020 09:38:44 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m129sm138261wmf.2.2020.06.08.09.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:38:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 04/10] configure: Generate rule to calculate the base
 architecture of a target
Date: Mon,  8 Jun 2020 18:38:17 +0200
Message-Id: <20200608163823.8890-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608163823.8890-1-philmd@redhat.com>
References: <20200608163823.8890-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
index 597e909b53..b48eb893f8 100755
--- a/configure
+++ b/configure
@@ -7756,6 +7756,8 @@ if test "$linux" = "yes" ; then
     fi
 fi
 
+target_to_base_map=""
+
 for target in $target_list; do
 target_dir="$target"
 config_target_mak=$target_dir/config-target.mak
@@ -7984,6 +7986,7 @@ target_arch_name="$(upper $TARGET_ARCH)"
 echo "TARGET_$target_arch_name=y" >> $config_target_mak
 echo "TARGET_NAME=$target_name" >> $config_target_mak
 echo "TARGET_BASE_ARCH=$TARGET_BASE_ARCH" >> $config_target_mak
+target_to_base_map="$target_dir,$TARGET_BASE_ARCH $target_to_base_map"
 if [ "$TARGET_ABI_DIR" = "" ]; then
   TARGET_ABI_DIR=$TARGET_ARCH
 fi
@@ -8199,6 +8202,22 @@ if test "$ccache_cpp2" = "yes"; then
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


