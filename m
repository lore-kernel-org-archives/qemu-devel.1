Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BFAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8A7206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvbSdRhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8A7206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrI2u-0007HJ-Ci
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrHtX-0002qx-KE
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:22:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jrHtU-0000yW-4u
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593768122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=worektGU7t2KWezXJC7Li6H7iMdOkxSQixsswdULoXw=;
 b=dvbSdRhcnwTwynaMjh/DOjO4BUQpXpl4dZ9hnft7KVFqU9+zkbuzAbncaCwMbskML3ETJN
 NlWLdYVryfIaKzGIklMl7/OJ5E3ucVccibhFK+Nhf64zRXAFquPSgJGYvH1qy7u2iVPbBE
 FqErUssLld0+kOsoCgmTRV+F71rrFqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-zGX2GSglPDiAOfoCvhnDDw-1; Fri, 03 Jul 2020 05:21:59 -0400
X-MC-Unique: zGX2GSglPDiAOfoCvhnDDw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8A7F8015F9;
 Fri,  3 Jul 2020 09:21:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-90.ams2.redhat.com [10.36.114.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7D797AC71;
 Fri,  3 Jul 2020 09:21:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 6/7] iotests.py: Do not wait() before communicate()
Date: Fri,  3 Jul 2020 11:21:42 +0200
Message-Id: <20200703092143.165594-7-kwolf@redhat.com>
In-Reply-To: <20200703092143.165594-1-kwolf@redhat.com>
References: <20200703092143.165594-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Waiting on a process for which we have a pipe will stall if the process
outputs more data than fits into the OS-provided buffer.  We must use
communicate() before wait(), and in fact, communicate() perfectly
replaces wait() already.

We have to drop the stderr=subprocess.STDOUT parameter from
subprocess.Popen() in qemu_nbd_early_pipe(), because stderr is passed on
to the child process, so if we do not drop this parameter, communicate()
will hang (because the pipe is not closed).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200630083711.40567-1-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.25.4


