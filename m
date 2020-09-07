Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BB3C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164CA2087D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiAy/Or1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164CA2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFM09-0000ym-3P
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLlR-0006Aa-60
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:21:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54394
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLlP-0004hr-1V
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599502870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeREhGKP4J/mxzvLAwobuXCNSXXlxfgXvwESJhQQF9k=;
 b=hiAy/Or1jKaAUSSQiX+MQ+1OqhephaqzYdJSzvq5Bw7uJQXKviKQspT5CjMtEjO+EjrFMc
 AbMTEo82LROnEZ4B4i+UZufwPfdi13jH5A22QRIl1VxrraZaKXQujzo7+1rgaN//F+Ys1N
 TLe+yzUSm7RG6oVGKB3kW6RQeHDV9ZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-C4llnZdEPoGfic6GN7Np6Q-1; Mon, 07 Sep 2020 14:21:05 -0400
X-MC-Unique: C4llnZdEPoGfic6GN7Np6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 650B3425CD;
 Mon,  7 Sep 2020 18:21:04 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AF1C60BF3;
 Mon,  7 Sep 2020 18:21:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 28/29] iotests: Factor out qemu_tool_pipe_and_status()
Date: Mon,  7 Sep 2020 20:20:10 +0200
Message-Id: <20200907182011.521007-29-kwolf@redhat.com>
In-Reply-To: <20200907182011.521007-1-kwolf@redhat.com>
References: <20200907182011.521007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have three almost identical functions that call an external process
and return its output and return code. Refactor them into small wrappers
around a common function.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 50 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 64ccaf9061..6fed77487e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -90,21 +90,30 @@ luks_default_secret_object = 'secret,id=keysec0,data=' + \
 luks_default_key_secret_opt = 'key-secret=keysec0'
 
 
-def qemu_img_pipe_and_status(*args: str) -> Tuple[str, int]:
+def qemu_tool_pipe_and_status(tool: str, *args: str,
+                              connect_stderr: bool = True) -> Tuple[str, int]:
     """
-    Run qemu-img and return both its output and its exit code
+    Run a tool and return both its output and its exit code
     """
-    subp = subprocess.Popen(qemu_img_args + list(args),
+    stderr = subprocess.STDOUT if connect_stderr else None
+    subp = subprocess.Popen(args,
                             stdout=subprocess.PIPE,
-                            stderr=subprocess.STDOUT,
+                            stderr=stderr,
                             universal_newlines=True)
     output = subp.communicate()[0]
     if subp.returncode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n'
-                         % (-subp.returncode,
+        sys.stderr.write('%s received signal %i: %s\n'
+                         % (tool, -subp.returncode,
                             ' '.join(qemu_img_args + list(args))))
     return (output, subp.returncode)
 
+def qemu_img_pipe_and_status(*args: str) -> Tuple[str, int]:
+    """
+    Run qemu-img and return both its output and its exit code
+    """
+    full_args = qemu_img_args + list(args)
+    return qemu_tool_pipe_and_status('qemu-img', *full_args)
+
 def qemu_img(*args: str) -> int:
     '''Run qemu-img and return the exit code'''
     return qemu_img_pipe_and_status(*args)[1]
@@ -265,19 +274,14 @@ def qemu_nbd(*args):
     '''Run qemu-nbd in daemon mode and return the parent's exit code'''
     return subprocess.call(qemu_nbd_args + ['--fork'] + list(args))
 
-def qemu_nbd_early_pipe(*args):
+def qemu_nbd_early_pipe(*args: str) -> Tuple[int, str]:
     '''Run qemu-nbd in daemon mode and return both the parent's exit code
        and its output in case of an error'''
-    subp = subprocess.Popen(qemu_nbd_args + ['--fork'] + list(args),
-                            stdout=subprocess.PIPE,
-                            universal_newlines=True)
-    output = subp.communicate()[0]
-    if subp.returncode < 0:
-        sys.stderr.write('qemu-nbd received signal %i: %s\n' %
-                         (-subp.returncode,
-                          ' '.join(qemu_nbd_args + ['--fork'] + list(args))))
-
-    return subp.returncode, output if subp.returncode else ''
+    full_args = qemu_nbd_args + ['--fork'] + list(args)
+    output, returncode = qemu_tool_pipe_and_status('qemu-nbd',
+                                                   connect_stderr=False,
+                                                   *full_args)
+    return returncode, output if returncode else ''
 
 @contextmanager
 def qemu_nbd_popen(*args):
@@ -1140,20 +1144,14 @@ def verify_working_luks():
     if not working:
         notrun(reason)
 
-def qemu_pipe(*args):
+def qemu_pipe(*args: str) -> str:
     """
     Run qemu with an option to print something and exit (e.g. a help option).
 
     :return: QEMU's stdout output.
     """
-    args = [qemu_prog] + qemu_opts + list(args)
-    subp = subprocess.Popen(args, stdout=subprocess.PIPE,
-                            stderr=subprocess.STDOUT,
-                            universal_newlines=True)
-    output = subp.communicate()[0]
-    if subp.returncode < 0:
-        sys.stderr.write('qemu received signal %i: %s\n' %
-                         (-subp.returncode, ' '.join(args)))
+    full_args = [qemu_prog] + qemu_opts + list(args)
+    output, _ = qemu_tool_pipe_and_status('qemu', *full_args)
     return output
 
 def supported_formats(read_only=False):
-- 
2.25.4


