Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B16C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6482068F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUsSq+Id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6482068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTMJ-0005Cv-U1
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJ5-0000Bk-5p
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:21:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJ3-0004VG-41
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lFvJAvABHJhn9aUbqkhpwxA2JbVZYnPkXyaT9KSO/8A=;
 b=OUsSq+Id9uj1AfGr+Cz2wqjD3DhH/91gRDpLm4AxMndgGMVwmdZq085QZ0v9BJ31Eu1TNe
 kUHa1RVNSXeqbaT2cIgqjG4p97TMJgivcT5F/zJMw8QYpdPteAofpnCEOkOk21PcdHJsAh
 Zb2J190AyZ2vXDllW7sNsbrvuXla9lw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-q_MIO3efN6mOND-FbL76Mw-1; Tue, 14 Jul 2020 18:21:41 -0400
X-MC-Unique: q_MIO3efN6mOND-FbL76Mw-1
Received: by mail-wm1-f70.google.com with SMTP id l5so90068wml.7
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lFvJAvABHJhn9aUbqkhpwxA2JbVZYnPkXyaT9KSO/8A=;
 b=aEfrwfyfMaMQUPauGZ5h8ZxtS5xifMXwkSyRC/VZNLSxgARDVa073C1juLImmKTJDo
 fbFHey9i5q36/pQufQz2g+1O+JR4QbFGtgq9QsyQOc3u98q2QgLvJKZcUtmaEoT3ZVFg
 OaTmrnTEluw5Lg/P5nrljOh0Bu31ybV1JMLe7777U849EjN1b1FnfhXOZMtLdrcwScu4
 pwiKxxYDelJwoBulNkB7cRaVzIVzMoz8gepbfEw5L3kcccAsm5oXGevv/ZujjdIgevcE
 a6vAght/cxIHjFfUw+Y2Rumo07NCBqzUL7QFmu5hQpkpI5xo1o5IMFpHj/hTfjS6a/J5
 F7nA==
X-Gm-Message-State: AOAM5312L/96iZtiiO6bRT1yk1R3V4aCD5Hd5ATABILNlEoUY9cEc/GT
 YOvdh1C1jfVC37i/Qlmr4aIJY137bcL/E0Ul2Z7MijgcY2SAAWNyM45Ot20XZxo9uXML/L6wo4V
 pfm12VRHH5BEBbTQ=
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr8036550wrr.196.1594765299326; 
 Tue, 14 Jul 2020 15:21:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf5GQIef7IlQoICvopUEpJloqBEI51Q+7z/cOPUBnJBo96Jsm9gt1x42ZLYOv1EnHqyav7bg==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr8036527wrr.196.1594765298999; 
 Tue, 14 Jul 2020 15:21:38 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id z6sm277928wmf.33.2020.07.14.15.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:21:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/19] scripts/performance: Add dissect.py script
Date: Wed, 15 Jul 2020 00:21:14 +0200
Message-Id: <20200714222132.10815-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>

Python script that dissects QEMU execution into three main phases:
code generation, JIT execution and helpers execution.

Syntax:
dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
                 <target executable> [<target executable options>]

[-h] - Print the script arguments help message.

Example of usage:
dissect.py -- qemu-arm coulomb_double-arm

Example output:
Total Instructions:        4,702,865,362

Code Generation:             115,819,309	 2.463%
JIT Execution:             1,081,980,528	23.007%
Helpers:                   3,505,065,525	74.530%

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200709052055.2650-2-ahmedkhaledkaraman@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 scripts/performance/dissect.py | 166 +++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100755 scripts/performance/dissect.py

diff --git a/scripts/performance/dissect.py b/scripts/performance/dissect.py
new file mode 100755
index 0000000000..bf24f50922
--- /dev/null
+++ b/scripts/performance/dissect.py
@@ -0,0 +1,166 @@
+#!/usr/bin/env python3
+
+#  Print the percentage of instructions spent in each phase of QEMU
+#  execution.
+#
+#  Syntax:
+#  dissect.py [-h] -- <qemu executable> [<qemu executable options>] \
+#                   <target executable> [<target executable options>]
+#
+#  [-h] - Print the script arguments help message.
+#
+#  Example of usage:
+#  dissect.py -- qemu-arm coulomb_double-arm
+#
+#  This file is a part of the project "TCG Continuous Benchmarking".
+#
+#  Copyright (C) 2020  Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+#  Copyright (C) 2020  Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
+#
+#  This program is free software: you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation, either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program. If not, see <https://www.gnu.org/licenses/>.
+
+import argparse
+import os
+import subprocess
+import sys
+import tempfile
+
+
+def get_JIT_line(callgrind_data):
+    """
+    Search for the first instance of the JIT call in
+    the callgrind_annotate output when ran using --tree=caller
+    This is equivalent to the self number of instructions of JIT.
+
+    Parameters:
+    callgrind_data (list): callgrind_annotate output
+
+    Returns:
+    (int): Line number
+    """
+    line = -1
+    for i in range(len(callgrind_data)):
+        if callgrind_data[i].strip('\n') and \
+                callgrind_data[i].split()[-1] == "[???]":
+            line = i
+            break
+    if line == -1:
+        sys.exit("Couldn't locate the JIT call ... Exiting.")
+    return line
+
+
+def main():
+    # Parse the command line arguments
+    parser = argparse.ArgumentParser(
+        usage='dissect.py [-h] -- '
+        '<qemu executable> [<qemu executable options>] '
+        '<target executable> [<target executable options>]')
+
+    parser.add_argument('command', type=str, nargs='+', help=argparse.SUPPRESS)
+
+    args = parser.parse_args()
+
+    # Extract the needed variables from the args
+    command = args.command
+
+    # Insure that valgrind is installed
+    check_valgrind = subprocess.run(
+        ["which", "valgrind"], stdout=subprocess.DEVNULL)
+    if check_valgrind.returncode:
+        sys.exit("Please install valgrind before running the script.")
+
+    # Save all intermediate files in a temporary directory
+    with tempfile.TemporaryDirectory() as tmpdirname:
+        # callgrind output file path
+        data_path = os.path.join(tmpdirname, "callgrind.data")
+        # callgrind_annotate output file path
+        annotate_out_path = os.path.join(tmpdirname, "callgrind_annotate.out")
+
+        # Run callgrind
+        callgrind = subprocess.run((["valgrind",
+                                     "--tool=callgrind",
+                                     "--callgrind-out-file=" + data_path]
+                                    + command),
+                                   stdout=subprocess.DEVNULL,
+                                   stderr=subprocess.PIPE)
+        if callgrind.returncode:
+            sys.exit(callgrind.stderr.decode("utf-8"))
+
+        # Save callgrind_annotate output
+        with open(annotate_out_path, "w") as output:
+            callgrind_annotate = subprocess.run(
+                ["callgrind_annotate", data_path, "--tree=caller"],
+                stdout=output,
+                stderr=subprocess.PIPE)
+            if callgrind_annotate.returncode:
+                sys.exit(callgrind_annotate.stderr.decode("utf-8"))
+
+        # Read the callgrind_annotate output to callgrind_data[]
+        callgrind_data = []
+        with open(annotate_out_path, 'r') as data:
+            callgrind_data = data.readlines()
+
+        # Line number with the total number of instructions
+        total_instructions_line_number = 20
+        # Get the total number of instructions
+        total_instructions_line_data = \
+            callgrind_data[total_instructions_line_number]
+        total_instructions = total_instructions_line_data.split()[0]
+        total_instructions = int(total_instructions.replace(',', ''))
+
+        # Line number with the JIT self number of instructions
+        JIT_self_instructions_line_number = get_JIT_line(callgrind_data)
+        # Get the JIT self number of instructions
+        JIT_self_instructions_line_data = \
+            callgrind_data[JIT_self_instructions_line_number]
+        JIT_self_instructions = JIT_self_instructions_line_data.split()[0]
+        JIT_self_instructions = int(JIT_self_instructions.replace(',', ''))
+
+        # Line number with the JIT self + inclusive number of instructions
+        # It's the line above the first JIT call when running with --tree=caller
+        JIT_total_instructions_line_number = JIT_self_instructions_line_number-1
+        # Get the JIT self + inclusive number of instructions
+        JIT_total_instructions_line_data = \
+            callgrind_data[JIT_total_instructions_line_number]
+        JIT_total_instructions = JIT_total_instructions_line_data.split()[0]
+        JIT_total_instructions = int(JIT_total_instructions.replace(',', ''))
+
+        # Calculate number of instructions in helpers and code generation
+        helpers_instructions = JIT_total_instructions-JIT_self_instructions
+        code_generation_instructions = total_instructions-JIT_total_instructions
+
+        # Print results (Insert commas in large numbers)
+        # Print total number of instructions
+        print('{:<20}{:>20}\n'.
+              format("Total Instructions:",
+                     format(total_instructions, ',')))
+        # Print code generation instructions and percentage
+        print('{:<20}{:>20}\t{:>6.3f}%'.
+              format("Code Generation:",
+                     format(code_generation_instructions, ","),
+                     (code_generation_instructions / total_instructions) * 100))
+        # Print JIT instructions and percentage
+        print('{:<20}{:>20}\t{:>6.3f}%'.
+              format("JIT Execution:",
+                     format(JIT_self_instructions, ","),
+                     (JIT_self_instructions / total_instructions) * 100))
+        # Print helpers instructions and percentage
+        print('{:<20}{:>20}\t{:>6.3f}%'.
+              format("Helpers:",
+                     format(helpers_instructions, ","),
+                     (helpers_instructions/total_instructions)*100))
+
+
+if __name__ == "__main__":
+    main()
-- 
2.21.3


