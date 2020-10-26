Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F5DC56201
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B14207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1650yNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B14207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzfK-0000LI-3v
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPH-0002lc-9Q
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPC-0006k2-DH
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=+nM0kYcQajA1fWMWAAseVtGUdQwwcwGeyDGj1H0tRms=;
 b=G1650yNwErlMwmZV4FWbPAOo6/uEJP5Vo6w+QgL2ko3mZrwxEvv8WxyfkMpAavXSLT8wME
 f8SNA2XacUKUwMjx1yhHW6AphwazCNXnWy2Z8JwnSU6E2CmqVlJ4u4fA2egkHzUpGryo1t
 Eoetr1SuhAHO95OrwSeRmv4FZrcKPTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-HH44Z7QFMj2iWGkANlxdnA-1; Mon, 26 Oct 2020 06:07:06 -0400
X-MC-Unique: HH44Z7QFMj2iWGkANlxdnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2324110E2184;
 Mon, 26 Oct 2020 10:07:05 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E9528B842;
 Mon, 26 Oct 2020 10:07:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/31] scripts/oss-fuzz: Add crash trace minimization script
Date: Mon, 26 Oct 2020 11:06:20 +0100
Message-Id: <20201026100632.212530-20-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

Once we find a crash, we can convert it into a QTest trace. Usually this
trace will contain many operations that are unneeded to reproduce the
crash. This script tries to minimize the crashing trace, by removing
operations and trimming QTest bufwrite(write addr len data...) commands.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-Id: <20201023150746.107063-12-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/oss-fuzz/minimize_qtest_trace.py | 157 +++++++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100755 scripts/oss-fuzz/minimize_qtest_trace.py

diff --git a/scripts/oss-fuzz/minimize_qtest_trace.py b/scripts/oss-fuzz/minimize_qtest_trace.py
new file mode 100755
index 0000000000..5e405a0d5f
--- /dev/null
+++ b/scripts/oss-fuzz/minimize_qtest_trace.py
@@ -0,0 +1,157 @@
+#!/usr/bin/env python3
+# -*- coding: utf-8 -*-
+
+"""
+This takes a crashing qtest trace and tries to remove superflous operations
+"""
+
+import sys
+import os
+import subprocess
+import time
+import struct
+
+QEMU_ARGS = None
+QEMU_PATH = None
+TIMEOUT = 5
+CRASH_TOKEN = None
+
+write_suffix_lookup = {"b": (1, "B"),
+                       "w": (2, "H"),
+                       "l": (4, "L"),
+                       "q": (8, "Q")}
+
+def usage():
+    sys.exit("""\
+Usage: QEMU_PATH="/path/to/qemu" QEMU_ARGS="args" {} input_trace output_trace
+By default, will try to use the second-to-last line in the output to identify
+whether the crash occred. Optionally, manually set a string that idenitifes the
+crash by setting CRASH_TOKEN=
+""".format((sys.argv[0])))
+
+def check_if_trace_crashes(trace, path):
+    global CRASH_TOKEN
+    with open(path, "w") as tracefile:
+        tracefile.write("".join(trace))
+
+    rc = subprocess.Popen("timeout -s 9 {timeout}s {qemu_path} {qemu_args} 2>&1\
+    < {trace_path}".format(timeout=TIMEOUT,
+                           qemu_path=QEMU_PATH,
+                           qemu_args=QEMU_ARGS,
+                           trace_path=path),
+                          shell=True,
+                          stdin=subprocess.PIPE,
+                          stdout=subprocess.PIPE)
+    stdo = rc.communicate()[0]
+    output = stdo.decode('unicode_escape')
+    if rc.returncode == 137:    # Timed Out
+        return False
+    if len(output.splitlines()) < 2:
+        return False
+
+    if CRASH_TOKEN is None:
+        CRASH_TOKEN = output.splitlines()[-2]
+
+    return CRASH_TOKEN in output
+
+
+def minimize_trace(inpath, outpath):
+    global TIMEOUT
+    with open(inpath) as f:
+        trace = f.readlines()
+    start = time.time()
+    if not check_if_trace_crashes(trace, outpath):
+        sys.exit("The input qtest trace didn't cause a crash...")
+    end = time.time()
+    print("Crashed in {} seconds".format(end-start))
+    TIMEOUT = (end-start)*5
+    print("Setting the timeout for {} seconds".format(TIMEOUT))
+    print("Identifying Crashes by this string: {}".format(CRASH_TOKEN))
+
+    i = 0
+    newtrace = trace[:]
+    # For each line
+    while i < len(newtrace):
+        # 1.) Try to remove it completely and reproduce the crash. If it works,
+        # we're done.
+        prior = newtrace[i]
+        print("Trying to remove {}".format(newtrace[i]))
+        # Try to remove the line completely
+        newtrace[i] = ""
+        if check_if_trace_crashes(newtrace, outpath):
+            i += 1
+            continue
+        newtrace[i] = prior
+
+        # 2.) Try to replace write{bwlq} commands with a write addr, len
+        # command. Since this can require swapping endianness, try both LE and
+        # BE options. We do this, so we can "trim" the writes in (3)
+        if (newtrace[i].startswith("write") and not
+            newtrace[i].startswith("write ")):
+            suffix = newtrace[i].split()[0][-1]
+            assert(suffix in write_suffix_lookup)
+            addr = int(newtrace[i].split()[1], 16)
+            value = int(newtrace[i].split()[2], 16)
+            for endianness in ['<', '>']:
+                data = struct.pack("{end}{size}".format(end=endianness,
+                                   size=write_suffix_lookup[suffix][1]),
+                                   value)
+                newtrace[i] = "write {addr} {size} 0x{data}\n".format(
+                    addr=hex(addr),
+                    size=hex(write_suffix_lookup[suffix][0]),
+                    data=data.hex())
+                if(check_if_trace_crashes(newtrace, outpath)):
+                    break
+            else:
+                newtrace[i] = prior
+
+        # 3.) If it is a qtest write command: write addr len data, try to split
+        # it into two separate write commands. If splitting the write down the
+        # middle does not work, try to move the pivot "left" and retry, until
+        # there is no space left. The idea is to prune unneccessary bytes from
+        # long writes, while accommodating arbitrary MemoryRegion access sizes
+        # and alignments.
+        if newtrace[i].startswith("write "):
+            addr = int(newtrace[i].split()[1], 16)
+            length = int(newtrace[i].split()[2], 16)
+            data = newtrace[i].split()[3][2:]
+            if length > 1:
+                leftlength = int(length/2)
+                rightlength = length - leftlength
+                newtrace.insert(i+1, "")
+                while leftlength > 0:
+                    newtrace[i] = "write {addr} {size} 0x{data}\n".format(
+                            addr=hex(addr),
+                            size=hex(leftlength),
+                            data=data[:leftlength*2])
+                    newtrace[i+1] = "write {addr} {size} 0x{data}\n".format(
+                            addr=hex(addr+leftlength),
+                            size=hex(rightlength),
+                            data=data[leftlength*2:])
+                    if check_if_trace_crashes(newtrace, outpath):
+                        break
+                    else:
+                        leftlength -= 1
+                        rightlength += 1
+                if check_if_trace_crashes(newtrace, outpath):
+                    i -= 1
+                else:
+                    newtrace[i] = prior
+                    del newtrace[i+1]
+        i += 1
+    check_if_trace_crashes(newtrace, outpath)
+
+
+if __name__ == '__main__':
+    if len(sys.argv) < 3:
+        usage()
+
+    QEMU_PATH = os.getenv("QEMU_PATH")
+    QEMU_ARGS = os.getenv("QEMU_ARGS")
+    if QEMU_PATH is None or QEMU_ARGS is None:
+        usage()
+    # if "accel" not in QEMU_ARGS:
+    #     QEMU_ARGS += " -accel qtest"
+    CRASH_TOKEN = os.getenv("CRASH_TOKEN")
+    QEMU_ARGS += " -qtest stdio -monitor none -serial none "
+    minimize_trace(sys.argv[1], sys.argv[2])
-- 
2.18.2


