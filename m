Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B31BC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5849020717
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsDeqaKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5849020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igvrK-0007s1-1r
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1igvpd-0006St-7p
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1igvpc-00085X-6S
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:15:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55944
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1igvpc-00085N-3I
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576523699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zbpEPorC+KdqjIx+JGbo9QFpBupxOt7Szs2Uciq2jOI=;
 b=OsDeqaKt3DqKNZmVTx+aLNH8eonOPqlkrZklSQUZ3fWsjQiXqgiW8sC2hq8nGexRitYyhN
 X7lIRgQKxuCtlYq+GdRGjUEQ9h7vzBRgiSuTJBd5B2XerXXIaGs8bXc3ixTu2YvsAbxM8I
 PP8sfdboAqSCnCI5koK/CkXWZAaMZgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-lkpVKUL8PSWs7X4gC3W7wQ-1; Mon, 16 Dec 2019 14:14:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 806F3800D41;
 Mon, 16 Dec 2019 19:14:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-67.gru2.redhat.com
 [10.97.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A43D5C1B5;
 Mon, 16 Dec 2019 19:14:51 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/5] python/qemu: accel: Strengthen kvm_available() checks
Date: Mon, 16 Dec 2019 16:14:36 -0300
Message-Id: <20191216191438.93418-4-wainersm@redhat.com>
In-Reply-To: <20191216191438.93418-1-wainersm@redhat.com>
References: <20191216191438.93418-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: lkpVKUL8PSWs7X4gC3W7wQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, ehabkost@redhat.com, philmd@redhat.com, jsnow@redhat.com,
 crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently kvm_available() checks for the presence of kvm module
and, if target and host arches don't mismatch. This patch adds
an 3rd checking: if QEMU binary was compiled with kvm
support.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 python/qemu/accel.py | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index 7395cee793..5fce3aa3dd 100644
--- a/python/qemu/accel.py
+++ b/python/qemu/accel.py
@@ -46,9 +46,24 @@ def list_accel(qemu_bin):
     # Skip the first line which is the header.
     return [acc.strip() for acc in out.splitlines()[1:]]
=20
-def kvm_available(target_arch=3DNone):
-    host_arch =3D os.uname()[4]
-    if target_arch and target_arch !=3D host_arch:
-        if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
-            return False
-    return os.access("/dev/kvm", os.R_OK | os.W_OK)
+def kvm_available(target_arch=3DNone, qemu_bin=3DNone):
+    """
+    Check if KVM is available using the following heuristic:
+      - Kernel module is present in the host;
+      - Target and host arches don't mismatch;
+      - KVM is enabled in the QEMU binary.
+
+    @param target_arch (str): target architecture
+    @param qemu_bin (str): path to the QEMU binary
+    @return True if kvm is available, otherwise False.
+    """
+    if not os.access("/dev/kvm", os.R_OK | os.W_OK):
+        return False
+    if target_arch:
+        host_arch =3D os.uname()[4]
+        if target_arch !=3D host_arch:
+            if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
+                return False
+    if qemu_bin and "kvm" not in list_accel(qemu_bin):
+        return False
+    return True
--=20
2.23.0


