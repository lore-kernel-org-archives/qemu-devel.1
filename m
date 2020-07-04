Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E504C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD3920720
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjWEb9ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD3920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmwM-0004cw-6j
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmvA-0002jG-Cs
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36346
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmuq-0001I2-8O
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kwK+YtoN3ISvSonZG8pWmnKbUjP97LUVMTrPci50qGM=;
 b=UjWEb9vekL43tkOZmb/O4s1CzGV4doJSeBzQnpx6XU1QOmq7p6AnWZ03K7xrelejj13gOb
 M/O7JD2ZzkV8xMz7c6MkbCy16BW2Bp17ImnPEbDlEkwtEsQ19oKWc1caPP2PCPRYYF6QLz
 q/7i/QyuIUcFvN0sXU9zBQe/Q7Fumx4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-iLM0IORvP-mCWBxMxLk9cA-1; Sat, 04 Jul 2020 14:29:29 -0400
X-MC-Unique: iLM0IORvP-mCWBxMxLk9cA-1
Received: by mail-wr1-f72.google.com with SMTP id d11so18926535wrw.12
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=kwK+YtoN3ISvSonZG8pWmnKbUjP97LUVMTrPci50qGM=;
 b=pNkas4nMATVznWYmyTy0jymvhU0BUnxIPjIo0xd3/EeUhJK3Zr51J9qPrHK/LLGMjw
 vAhPO6/k3AQ38M/Dz55cS820xwS/iV1fKz52h9W6GJHS0Usxxlkcrqkg6+2pSq8fkSE+
 764hNnSwMeN+9IlSC/HHaUHQrnzeL+H/nKSHJvzZlvhjB0FPJgQsEZ1yvhqX+HHYiT0W
 iJz7gpq3QOoWLDJ4RCP5SYaFgm7cJLyOESsEOmd65871YmUBD0nA8T7ZCisqmFUQbpSK
 m8H3Iq3L2eVMYPgH4dvRLE1rN0mQO0rhO8ESnh/5TIiXj5B5OTYVVUYE3h0G8cbMckJd
 xZdQ==
X-Gm-Message-State: AOAM530wMM8a4fHq6iuorhVvtIlJQCpo1U3YaI4G9QqQfKJaXlsu2jeO
 G7cRrL4Aw1+V/gXICyknRHzqjIaLNfMttiI0OFXk1mA+cNApkQsBB2SIC256mvPjbg0yifb6eL9
 SAK4vbv+MB7+VQ1o=
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr18599107wml.183.1593887367709; 
 Sat, 04 Jul 2020 11:29:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt0y7gHWJp9A2EIGhHYdo5s+mqBkChaOATIHmPLhIaZpHaTCjIzsPNPsHTRkp2srZxgMMPVg==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr18599085wml.183.1593887367342; 
 Sat, 04 Jul 2020 11:29:27 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 c11sm16764510wmb.45.2020.07.04.11.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:29:26 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:29:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/41] tests: disassemble-aml.sh: generate AML in readable
 format
Message-ID: <20200704182750.1088103-2-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On systems where the IASL tool exists, we can convert
extected ACPI tables to ASL format, which is useful
for debugging and documentation purposes.
This script does this for all ACPI tables under tests/data/acpi/.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/data/acpi/disassemle-aml.sh       | 52 +++++++++++++++++++++++++
 tests/data/acpi/rebuild-expected-aml.sh |  1 +
 2 files changed, 53 insertions(+)
 create mode 100755 tests/data/acpi/disassemle-aml.sh

diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
new file mode 100755
index 0000000000..1d8a4d0301
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
diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index 9cbaab1a4d..76cd797d1e 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -36,6 +36,7 @@ old_allowed_dif=`grep -v -e 'List of comma-separated changed AML files to ignore
 echo '/* List of comma-separated changed AML files to ignore */' > ${SRC_PATH}/tests/qtest/bios-tables-test-allowed-diff.h
 
 echo "The files were rebuilt and can be added to git."
+echo "You can use ${SRC_PATH}/tests/data/acpi/disassemle-aml.sh to disassemble them to ASL."
 
 if [ -z "$old_allowed_dif" ]; then
     echo "Note! Please do not commit expected files with source changes"
-- 
MST


