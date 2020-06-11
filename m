Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9857AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CF4206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avqk3z0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CF4206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQR0-00070I-Ka
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjQQI-0006YJ-PM
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:51:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22356
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjQQG-0004Yn-PY
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591894283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=aDcmqgYspKNhNgSfdZlkVo5/mNWYNEDAxUJl6L4TTlY=;
 b=avqk3z0L8Ii4p+O9ejF0vzPgAeXzitsI2owvLqRL+o9Un1Yd/xzvVYy2+MWJoic2lVhGBl
 sRwWe+I+1ew5pEXf5mjmd2nCPToqzi45DhlWY8JCGKfFAhMtjCMCsV2oAVHhJZDcdAw6o8
 TDRjdQ2BaLJshOJMbYvrWK6VDUi0dMA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-WzPCH9jnM7CXwpI5H40XOA-1; Thu, 11 Jun 2020 12:51:20 -0400
X-MC-Unique: WzPCH9jnM7CXwpI5H40XOA-1
Received: by mail-wr1-f69.google.com with SMTP id o1so2756836wrm.17
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=aDcmqgYspKNhNgSfdZlkVo5/mNWYNEDAxUJl6L4TTlY=;
 b=VlEF3HJEVrJ3eIS2B9+IxK3qQlLj4sgEI09iiSD2eQoW4MpIC61wITMdzJuuHp+9+G
 INgjJ1x7ehduLFmn14mkHy2IMxmnnHoHVNRqy43wMT8LGhsEecfrZP9tCtyfLjjmrdpz
 mgRlJJQyIzYuD8v0qjEMw4/iaww74/f8s2uARsyKRHeLkqpUxuhvbFpl3dfjDbcTmkil
 o+zZshlJ3px/tUho6Y85g+cXIXtObaAgZIWqDV+5VnIklnIFMtFEV8K2CEXChoU91eNY
 f7LomNGMUBCqPLfX3Y1rOtD1KrX9jOXT/tZwC7bAyyHcqToVqG/boBe4PjbKz62DS1PU
 l79w==
X-Gm-Message-State: AOAM5317tY5qKKwjDkIReTUxxWkQd3Af10qKO98WOPbnWJYYBZMgjlSE
 kOijM+sz/Qe3xTf+sNMb8PbFhQ0yQeZxAUYlrcg1O7Ky/iSV/JbDoSEwY9xAZzllpjGJflbHRUy
 kJqYtCmH82azyIB4=
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr10518819wrw.225.1591894278874; 
 Thu, 11 Jun 2020 09:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVhWIU1nKc18Y+50qTpBiVJEzm9UYVWU0fcQbaskPtfIrkuOWiQc4oMOuuZtIWzQQJJKITIg==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr10518806wrw.225.1591894278686; 
 Thu, 11 Jun 2020 09:51:18 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id u130sm5071472wmg.32.2020.06.11.09.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:51:17 -0700 (PDT)
Date: Thu, 11 Jun 2020 12:51:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: disassemble-asm.sh: generate AML in readable format
Message-ID: <20200611165112.30979-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On systems where the IASL tool exists, we can convert
extected ACPI tables to ASL format, which is useful
for debugging and documentation purposes.
This script does this for all ACPI tables under tests/data/acpi/.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/disassemle-aml.sh | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 tests/data/acpi/disassemle-aml.sh

diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
new file mode 100755
index 0000000000..42a1b51df0
--- /dev/null
+++ b/tests/data/acpi/disassemle-aml.sh
@@ -0,0 +1,52 @@
+#!/usr/bin/bash
+
+outdir=
+while getopts "o:" arg; do
+  case ${arg} in
+    o )
+        outdir=$OPTARG
+        ;;
+    \? )
+        echo "Usage: ./tests/data/acpi/disassemle-aml.sh [-o <output-directory>]"
+        exit 1
+        ;;
+    
+  esac
+done
+
+for machine in tests/data/acpi/*
+do
+    if [[ ! -d "$machine" ]];
+    then
+        continue
+    fi
+
+    if [[ "${outdir}" ]];
+    then
+        mkdir -p "${outdir}"/${machine} || exit $?
+    fi
+    for aml in $machine/*
+    do
+        if [[ "$aml" == $machine/*.dsl ]];
+        then
+            continue
+        fi
+        if [[ "$aml" == $machine/SSDT*.* ]];
+        then
+            dsdt=${aml/SSDT*./DSDT.}
+            extra="-e ${dsdt}"
+        elif [[ "$aml" == $machine/SSDT* ]];
+        then
+            dsdt=${aml/SSDT*/DSDT};
+            extra="-e ${dsdt}"
+        else
+            extra=""
+        fi
+        asl=${aml}.dsl
+        if [[ "${outdir}" ]];
+        then
+            asl="${outdir}"/${machine}/${asl}
+        fi
+        iasl -d -p ${asl} ${extra} ${aml} 
+    done
+done
-- 
MST


