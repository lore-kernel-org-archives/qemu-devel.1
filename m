Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AC3C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43A720782
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZvyagjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43A720782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRBv2-0002zB-QE
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 06:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBb7-000858-FT
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBas-0002jF-CZ
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602323713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBzmz0aqo8Vt+TOJfwiqFROPuBw6QcH6Q/y3cW3oJ44=;
 b=HZvyagjQQQ2dpvI5mTFDPJK6p/bnxPzOZNUpDI5SNI+W/3RB1BwR8xaEGnguNngX6ce/8R
 tirbuPdI5ZSIsjIZ2ltOxdXAHu54VGJEunONHP7DKsC1oVvxCSMGWv2WBG/RNj6GjJeBHK
 LYRehJq/rN7nNp2evCOzSgEHb7QHTXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-lnmf_M48O92Qk_nWoY_PnA-1; Sat, 10 Oct 2020 05:55:11 -0400
X-MC-Unique: lnmf_M48O92Qk_nWoY_PnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0747051BA;
 Sat, 10 Oct 2020 09:55:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCE1D6EF58;
 Sat, 10 Oct 2020 09:55:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0116111275CA; Sat, 10 Oct 2020 11:55:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/34] qapi/gen.py: update write() to be more idiomatic
Date: Sat, 10 Oct 2020 11:54:58 +0200
Message-Id: <20201010095504.796182-29-armbru@redhat.com>
In-Reply-To: <20201010095504.796182-1-armbru@redhat.com>
References: <20201010095504.796182-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: peter.maydell@linaro.org, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Make the file handling here just a tiny bit more idiomatic.
(I realize this is heavily subjective.)

Use exist_ok=True for os.makedirs and remove the exception,
use fdopen() to wrap the file descriptor in a File-like object,
and use a context manager for managing the file pointer.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20201009161558.107041-31-jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/gen.py | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index 8b851c6262..670c21e210 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -12,7 +12,6 @@
 # See the COPYING file in the top-level directory.
 
 from contextlib import contextmanager
-import errno
 import os
 import re
 from typing import (
@@ -65,21 +64,19 @@ class QAPIGen:
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


