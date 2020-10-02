Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF16C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E882D206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxnB6YdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E882D206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMVO-0002wS-VC
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMIg-0002jW-N9
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMIc-0004gi-NY
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601649882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcXG6tG+BMhwFKN22AuHkWM33vsObebXB6LKcg/n7uk=;
 b=fxnB6YdIidFCvjORDdUtQceae3WvGkqm75N9utGIAKCD1MFbzQeAS89So6vLkl/wGvZ3DP
 MW56/HoXYy6mJVQG8UfL/FUPMqBR8CWTRD8UluZi6YXSJOxh9nuOJbwQTm+W/TLcueUuyv
 8Twj4Th8m4QHljmnvV2xxP8L2r4BRq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-wI9-OQW8McCpIqltxL9m5w-1; Fri, 02 Oct 2020 10:44:38 -0400
X-MC-Unique: wI9-OQW8McCpIqltxL9m5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE80F1006701;
 Fri,  2 Oct 2020 14:44:36 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-139.ams2.redhat.com
 [10.36.112.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 053085D9D3;
 Fri,  2 Oct 2020 14:44:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 32/37] iotests: Factor out qemu_tool_pipe_and_status()
Date: Fri,  2 Oct 2020 16:43:40 +0200
Message-Id: <20201002144345.253865-33-kwolf@redhat.com>
In-Reply-To: <20201002144345.253865-1-kwolf@redhat.com>
References: <20201002144345.253865-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have three almost identical functions that call an external process
and return its output and return code. Refactor them into small wrappers
around a common function.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200924152717.287415-29-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 49 ++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index f48460480a..f7ad0c1395 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -88,21 +88,30 @@ luks_default_secret_object = 'secret,id=keysec0,data=' + \
 luks_default_key_secret_opt = 'key-secret=keysec0'
 
 
-def qemu_img_pipe_and_status(*args: str) -> Tuple[str, int]:
+def qemu_tool_pipe_and_status(tool: str, args: Sequence[str],
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
+    return qemu_tool_pipe_and_status('qemu-img', full_args)
+
 def qemu_img(*args: str) -> int:
     '''Run qemu-img and return the exit code'''
     return qemu_img_pipe_and_status(*args)[1]
@@ -263,19 +272,13 @@ def qemu_nbd(*args):
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
+    output, returncode = qemu_tool_pipe_and_status('qemu-nbd', full_args,
+                                                   connect_stderr=False)
+    return returncode, output if returncode else ''
 
 @contextmanager
 def qemu_nbd_popen(*args):
@@ -1141,20 +1144,14 @@ def verify_working_luks():
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
+    output, _ = qemu_tool_pipe_and_status('qemu', full_args)
     return output
 
 def supported_formats(read_only=False):
-- 
2.25.4


