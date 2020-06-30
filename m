Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4844CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D8AA206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUiqBnZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8AA206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBmD-0000UR-D6
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqBlY-0008Qs-Cn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:37:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30018
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqBlW-00073F-RR
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593506237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tg7h7WDK1MEJDD5VGfReg2iMfiyUh7gVUJacLcBD8Kc=;
 b=DUiqBnZ+Py7gXg/cOkKtwyM6XqxPAAajFXh1QECQMK3cYTXDPQVlYOQz7u4L3S7yN2xYAI
 aHleFQ7hy52N3aSdPW/I+X3dvt/WLZ1B+rmzFfWM8H8xpvCwZ4BXd+hbbdTR9OmrrWeESg
 4NKam5KRhRH2u3zTK7U+c9wvR9+dhPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-SvfWmOUPPVygd-dzxSjzVQ-1; Tue, 30 Jun 2020 04:37:14 -0400
X-MC-Unique: SvfWmOUPPVygd-dzxSjzVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BA3080183C;
 Tue, 30 Jun 2020 08:37:13 +0000 (UTC)
Received: from localhost (ovpn-113-102.ams2.redhat.com [10.36.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B72910013C0;
 Tue, 30 Jun 2020 08:37:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests.py: Do not wait() before communicate()
Date: Tue, 30 Jun 2020 10:37:11 +0200
Message-Id: <20200630083711.40567-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Waiting on a process for which we have a pipe will stall if the process
outputs more data than fits into the OS-provided buffer.  We must use
communicate() before wait(), and in fact, communicate() perfectly
replaces wait() already.

We have to drop the stderr=subprocess.STDOUT parameter from
subprocess.Popen() in qemu_nbd_early_pipe(), because stderr is passed on
to the child process, so if we do not drop this parameter, communicate()
will hang (because the pipe is not closed).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
I hit this at some point with some test when writing my dirty bitmap
migration mapping series, but I can't find the test I had problems with
any more (at least not on master).
Either way, I still think this is the right thing to do.
---
 tests/qemu-iotests/iotests.py | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 5ea4c4df8b..ef739dd1e3 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -146,11 +146,12 @@ def qemu_img_pipe(*args):
                             stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT,
                             universal_newlines=True)
-    exitcode = subp.wait()
-    if exitcode < 0:
+    output = subp.communicate()[0]
+    if subp.returncode < 0:
         sys.stderr.write('qemu-img received signal %i: %s\n'
-                         % (-exitcode, ' '.join(qemu_img_args + list(args))))
-    return subp.communicate()[0]
+                         % (-subp.returncode,
+                            ' '.join(qemu_img_args + list(args))))
+    return output
 
 def qemu_img_log(*args):
     result = qemu_img_pipe(*args)
@@ -177,11 +178,11 @@ def qemu_io(*args):
     subp = subprocess.Popen(args, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT,
                             universal_newlines=True)
-    exitcode = subp.wait()
-    if exitcode < 0:
+    output = subp.communicate()[0]
+    if subp.returncode < 0:
         sys.stderr.write('qemu-io received signal %i: %s\n'
-                         % (-exitcode, ' '.join(args)))
-    return subp.communicate()[0]
+                         % (-subp.returncode, ' '.join(args)))
+    return output
 
 def qemu_io_log(*args):
     result = qemu_io(*args)
@@ -257,15 +258,14 @@ def qemu_nbd_early_pipe(*args):
        and its output in case of an error'''
     subp = subprocess.Popen(qemu_nbd_args + ['--fork'] + list(args),
                             stdout=subprocess.PIPE,
-                            stderr=subprocess.STDOUT,
                             universal_newlines=True)
-    exitcode = subp.wait()
-    if exitcode < 0:
+    output = subp.communicate()[0]
+    if subp.returncode < 0:
         sys.stderr.write('qemu-nbd received signal %i: %s\n' %
-                         (-exitcode,
+                         (-subp.returncode,
                           ' '.join(qemu_nbd_args + ['--fork'] + list(args))))
 
-    return exitcode, subp.communicate()[0] if exitcode else ''
+    return subp.returncode, output if subp.returncode else ''
 
 def qemu_nbd_popen(*args):
     '''Run qemu-nbd in daemon mode and return the parent's exit code'''
@@ -1062,11 +1062,11 @@ def qemu_pipe(*args):
     subp = subprocess.Popen(args, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT,
                             universal_newlines=True)
-    exitcode = subp.wait()
-    if exitcode < 0:
+    output = subp.communicate()[0]
+    if subp.returncode < 0:
         sys.stderr.write('qemu received signal %i: %s\n' %
-                         (-exitcode, ' '.join(args)))
-    return subp.communicate()[0]
+                         (-subp.returncode, ' '.join(args)))
+    return output
 
 def supported_formats(read_only=False):
     '''Set 'read_only' to True to check ro-whitelist
-- 
2.26.2


