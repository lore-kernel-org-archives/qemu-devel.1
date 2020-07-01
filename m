Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943E6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFF520760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mj3bwoDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFF520760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqbea-00072n-Kw
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqbdl-0006WS-Px
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:15:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqbdi-00067z-QN
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593605697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=rCeLkVXuGN8EJqQ+gwY5J+yWh9OPz0BgJSsPx1vNxrQ=;
 b=Mj3bwoDkYO7lFF/5aACzLMgZdmW6KaFY1IZcD9cP9nW/TsfKxj/eUJSYg04kdd0ueKVAWx
 LrCYM9mtWriIXf0QImOikTjGm3WVrr2a1ZmAQssPMYrskCgqLgULVdLkflvdvPerei2JBG
 zd6Bolvfj+66fynKSxJq2xnoL01TW7g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-He5k2Zs8Nqu3FgJJe-EGJQ-1; Wed, 01 Jul 2020 08:14:54 -0400
X-MC-Unique: He5k2Zs8Nqu3FgJJe-EGJQ-1
Received: by mail-wm1-f70.google.com with SMTP id g6so17165522wmk.4
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=rCeLkVXuGN8EJqQ+gwY5J+yWh9OPz0BgJSsPx1vNxrQ=;
 b=KDIikhKwyCV/IuKDhqdnUOoqK8stnKIRi9IKsup/pZYXaLfTUc94f62wk4t7Ds2YzA
 uZxqXPhoylqOanNUnBxTwhEYP7ID3gTa3jiDcFhEKNa+ud8kwMj4h7HpWyp27fucRccM
 dmFO0/t8dAbL2QJqJxODNqPtWoR/PzzI4eMe/oXoc5C91nKGwlvxTJVqPLLW/T5xYSfF
 v/PCuwUWvuOXpOpl5m+tXZp4mBFWfDQtRLqfwuZXi/Q6keBszZeN+pYC2AKbNP1ZeMbK
 zrxWhbwrB3SP9DciVDAVvk6euaPqVKTu9anHXLrvL3Kkkz+xQpP2VllDCEcij5YIP+VQ
 vuGA==
X-Gm-Message-State: AOAM532vtejA98tsZtZnweWWUrestZqfTmNW4UeMLlu1uvWxzz2R0eUe
 fbaQTr/ndXEYrwzJ96vJjRTkeWoTH1a+X1Zreu49r9ePbs+/1VjKQfzdDGyuzx5hbZDUs50gVwe
 nrIntKJEnSmC6zmc=
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr26932734wro.317.1593605692521; 
 Wed, 01 Jul 2020 05:14:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5dta08u/ewz1ZVYxSFDREEnW+mgKKtB92k89Ht1RjXfBjyxoOHPvLbl6GQm8TsQmgqKk+Fg==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr26932714wro.317.1593605692308; 
 Wed, 01 Jul 2020 05:14:52 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 c11sm6857787wmb.45.2020.07.01.05.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 05:14:51 -0700 (PDT)
Date: Wed, 1 Jul 2020 08:14:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] tests: disassemble-aml.sh: generate AML in readable format
Message-ID: <20200701121349.50523-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
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

changes from v1:
    - suggest the script from rebuild-expected-aml.sh
    - fix subject typo

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


