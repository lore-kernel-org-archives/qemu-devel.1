Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093CDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:11:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C6020739
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4/eKqHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C6020739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsO5X-0005SH-0l
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsNzf-0003Aa-QI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:04:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34000
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsNzb-00042W-NZ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vq6TsUIGnDXBhPCJ0YcNJc3kNtoo5pcVkJs1OhIv2GQ=;
 b=Z4/eKqHQOZe9Ac04ldSq5iiZlJTm2xfhATnfm/Ijpc7M+qse15iL81817jWP3fmxGYVOOY
 wcOaTd/84IbJg18UaPFdr8QB4Uc3aHF/QZv59a3/d94PetbjUAhmyAP6hiiMX2YfHejGRN
 qqDIFVaqGeH7VtKJqTv9FFci3498DxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-0wd9y_Z7NtmhKwYHI1besw-1; Mon, 06 Jul 2020 06:04:49 -0400
X-MC-Unique: 0wd9y_Z7NtmhKwYHI1besw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E791800D5C;
 Mon,  6 Jul 2020 10:04:48 +0000 (UTC)
Received: from localhost (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BD7210013D9;
 Mon,  6 Jul 2020 10:04:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/31] iotests.py: Add qemu_img_pipe_and_status()
Date: Mon,  6 Jul 2020 12:04:07 +0200
Message-Id: <20200706100432.2301919-7-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-1-mreitz@redhat.com>
References: <20200706100432.2301919-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function will be used by the next patch, which intends to check
both the exit code and qemu-img's output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200625125548.870061-5-mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
[mreitz: Rebased on 49438972b8c2e]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index ef739dd1e3..423974d3f6 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -29,7 +29,7 @@ import struct
 import subprocess
 import sys
 from typing import (Any, Callable, Dict, Iterable,
-                    List, Optional, Sequence, TypeVar)
+                    List, Optional, Sequence, Tuple, TypeVar)
 import unittest
 
 # pylint: disable=import-error, wrong-import-position
@@ -90,15 +90,24 @@ luks_default_secret_object = 'secret,id=keysec0,data=' + \
 luks_default_key_secret_opt = 'key-secret=keysec0'
 
 
-def qemu_img(*args):
-    '''Run qemu-img and return the exit code'''
-    devnull = open('/dev/null', 'r+')
-    exitcode = subprocess.call(qemu_img_args + list(args),
-                               stdin=devnull, stdout=devnull)
-    if exitcode < 0:
+def qemu_img_pipe_and_status(*args: str) -> Tuple[str, int]:
+    """
+    Run qemu-img and return both its output and its exit code
+    """
+    subp = subprocess.Popen(qemu_img_args + list(args),
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            universal_newlines=True)
+    output = subp.communicate()[0]
+    if subp.returncode < 0:
         sys.stderr.write('qemu-img received signal %i: %s\n'
-                         % (-exitcode, ' '.join(qemu_img_args + list(args))))
-    return exitcode
+                         % (-subp.returncode,
+                            ' '.join(qemu_img_args + list(args))))
+    return (output, subp.returncode)
+
+def qemu_img(*args: str) -> int:
+    '''Run qemu-img and return the exit code'''
+    return qemu_img_pipe_and_status(*args)[1]
 
 def ordered_qmp(qmsg, conv_keys=True):
     # Dictionaries are not ordered prior to 3.6, therefore:
@@ -140,18 +149,9 @@ def qemu_img_verbose(*args):
                          % (-exitcode, ' '.join(qemu_img_args + list(args))))
     return exitcode
 
-def qemu_img_pipe(*args):
+def qemu_img_pipe(*args: str) -> str:
     '''Run qemu-img and return its output'''
-    subp = subprocess.Popen(qemu_img_args + list(args),
-                            stdout=subprocess.PIPE,
-                            stderr=subprocess.STDOUT,
-                            universal_newlines=True)
-    output = subp.communicate()[0]
-    if subp.returncode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n'
-                         % (-subp.returncode,
-                            ' '.join(qemu_img_args + list(args))))
-    return output
+    return qemu_img_pipe_and_status(*args)[0]
 
 def qemu_img_log(*args):
     result = qemu_img_pipe(*args)
-- 
2.26.2


