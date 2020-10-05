Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD45C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2831620853
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnhApWT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2831620853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPWsH-00056j-6r
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPWXR-000163-1Z
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPWXP-0007D6-4y
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601927566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XT/BGeuOP1VrfZNMdbjpWJjMT/879qj9ZtBTiW2fJVs=;
 b=WnhApWT6+jjSbyvrLBrN1IdpNGSprCHH9iFEFm46qEdqJSnTszeBPOSp8PSXM9IddixBSq
 q+mWlFf7uTVV71qv4PLP3tPTNQJx6rV4k1n/+EnYBcoXREriswLsjW0ytmjwQxICmPyjCy
 jUmCKtihFC9djxdyiy9jLJnyyxDHILQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-fkGBrXIuNmaWwgKKcIL5_A-1; Mon, 05 Oct 2020 15:52:43 -0400
X-MC-Unique: fkGBrXIuNmaWwgKKcIL5_A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 981A91018F61
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2020 19:52:42 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7F905C1BD;
 Mon,  5 Oct 2020 19:52:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 30/36] qapi/gen.py: update write() to be more idiomatic
Date: Mon,  5 Oct 2020 15:51:52 -0400
Message-Id: <20201005195158.2348217-31-jsnow@redhat.com>
In-Reply-To: <20201005195158.2348217-1-jsnow@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the file handling here just a tiny bit more idiomatic.
(I realize this is heavily subjective.)

Use exist_ok=True for os.makedirs and remove the exception,
use fdopen() to wrap the file descriptor in a File-like object,
and use a context manager for managing the file pointer.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
---
 scripts/qapi/gen.py | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 3624162bb77..579ee283297 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -14,7 +14,6 @@
 # See the COPYING file in the top-level directory.
 
 from contextlib import contextmanager
-import errno
 import os
 import re
 from typing import (
@@ -67,21 +66,19 @@ def write(self, output_dir: str) -> None:
             return
         pathname = os.path.join(output_dir, self.fname)
         odir = os.path.dirname(pathname)
+
         if odir:
-            try:
-                os.makedirs(odir)
-            except os.error as e:
-                if e.errno != errno.EEXIST:
-                    raise
+            os.makedirs(odir, exist_ok=True)
+
+        # use os.open for O_CREAT to create and read a non-existant file
         fd = os.open(pathname, os.O_RDWR | os.O_CREAT, 0o666)
-        f = open(fd, 'r+', encoding='utf-8')
-        text = self.get_content()
-        oldtext = f.read(len(text) + 1)
-        if text != oldtext:
-            f.seek(0)
-            f.truncate(0)
-            f.write(text)
-        f.close()
+        with os.fdopen(fd, 'r+', encoding='utf-8') as fp:
+            text = self.get_content()
+            oldtext = fp.read(len(text) + 1)
+            if text != oldtext:
+                fp.seek(0)
+                fp.truncate(0)
+                fp.write(text)
 
 
 def _wrap_ifcond(ifcond: List[str], before: str, after: str) -> str:
-- 
2.26.2


