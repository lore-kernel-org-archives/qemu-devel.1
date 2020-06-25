Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669B0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F78C20672
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2UPwR0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F78C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRXD-0006Cx-CR
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joRQI-0002js-6k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:56:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joRQE-0003Fk-5u
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 08:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593089764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWtTyWpJgwjT//Lfo9OBEk7z8rIK5maX8s8CieLbWLA=;
 b=B2UPwR0+0Kco13tx2+w/+VZIL9hmfq/mwwh40sjaeMRaw2eYqcXC87NiePPNwEX2XmJF/r
 wBCfVUOwDqdypETzLjf5PhGI6GZHMUWx638opAcPdGoueuT+o6CmjqMaFfcfT1m5WoNXa2
 Uzk1ER5X+yBNhdoP2tSzFOBC1hSIfAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-WesZ0OHtPp-y7gD4PSS5YQ-1; Thu, 25 Jun 2020 08:56:00 -0400
X-MC-Unique: WesZ0OHtPp-y7gD4PSS5YQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EA2FEC1A0;
 Thu, 25 Jun 2020 12:55:59 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BB1061981;
 Thu, 25 Jun 2020 12:55:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 04/19] iotests.py: Add qemu_img_pipe_and_status()
Date: Thu, 25 Jun 2020 14:55:33 +0200
Message-Id: <20200625125548.870061-5-mreitz@redhat.com>
In-Reply-To: <20200625125548.870061-1-mreitz@redhat.com>
References: <20200625125548.870061-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This function will be used by the next patch, which intends to check
both the exit code and qemu-img's output.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 5ea4c4df8b..eee94e18cc 100644
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
@@ -90,15 +90,23 @@ luks_default_secret_object = 'secret,id=keysec0,data=' + \
 luks_default_key_secret_opt = 'key-secret=keysec0'
 
 
-def qemu_img(*args):
-    '''Run qemu-img and return the exit code'''
-    devnull = open('/dev/null', 'r+')
-    exitcode = subprocess.call(qemu_img_args + list(args),
-                               stdin=devnull, stdout=devnull)
+def qemu_img_pipe_and_status(*args: str) -> Tuple[str, int]:
+    """
+    Run qemu-img and return both its output and its exit code
+    """
+    subp = subprocess.Popen(qemu_img_args + list(args),
+                            stdout=subprocess.PIPE,
+                            stderr=subprocess.STDOUT,
+                            universal_newlines=True)
+    exitcode = subp.wait()
     if exitcode < 0:
         sys.stderr.write('qemu-img received signal %i: %s\n'
                          % (-exitcode, ' '.join(qemu_img_args + list(args))))
-    return exitcode
+    return (subp.communicate()[0], exitcode)
+
+def qemu_img(*args: str) -> int:
+    '''Run qemu-img and return the exit code'''
+    return qemu_img_pipe_and_status(*args)[1]
 
 def ordered_qmp(qmsg, conv_keys=True):
     # Dictionaries are not ordered prior to 3.6, therefore:
@@ -140,17 +148,9 @@ def qemu_img_verbose(*args):
                          % (-exitcode, ' '.join(qemu_img_args + list(args))))
     return exitcode
 
-def qemu_img_pipe(*args):
+def qemu_img_pipe(*args: str) -> str:
     '''Run qemu-img and return its output'''
-    subp = subprocess.Popen(qemu_img_args + list(args),
-                            stdout=subprocess.PIPE,
-                            stderr=subprocess.STDOUT,
-                            universal_newlines=True)
-    exitcode = subp.wait()
-    if exitcode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n'
-                         % (-exitcode, ' '.join(qemu_img_args + list(args))))
-    return subp.communicate()[0]
+    return qemu_img_pipe_and_status(*args)[0]
 
 def qemu_img_log(*args):
     result = qemu_img_pipe(*args)
-- 
2.26.2


