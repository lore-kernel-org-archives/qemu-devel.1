Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E160AC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 21:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93D32173E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 21:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEr8faMB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93D32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idLKA-0006zZ-Q0
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 16:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1idLFV-0003Z5-Tf
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1idLFS-0001k8-GE
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:34:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1idLFS-0001f3-4E
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 16:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575668084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0nU0GLDB1CzqLxIYN0MwWYmBawoC86YndCuM7qoWXvs=;
 b=TEr8faMB8qFhd9OQwWzLG1vJPcisGgf9OxNwGPZvO55puMnJSM7VZKSrEeXwYbyS+x7StS
 WCpBTCCtxmk5YFi5QODlX61vEJkZh97FZGzzQR3bi9UNdv6BstPa5xpVKP4hj8Qxhp3ev4
 3F+0tsO3FG+CmlRIYOltVpDTqQNmK2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-ZjuVcHCmNRObtM8mlpjVAA-1; Fri, 06 Dec 2019 16:34:43 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 899981005502;
 Fri,  6 Dec 2019 21:34:41 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C195D5C1D4;
 Fri,  6 Dec 2019 21:34:40 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] python/qemu: accel: Add list_accel() method
Date: Fri,  6 Dec 2019 16:34:31 -0500
Message-Id: <20191206213433.11305-3-wainersm@redhat.com>
In-Reply-To: <20191206213433.11305-1-wainersm@redhat.com>
References: <20191206213433.11305-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ZjuVcHCmNRObtM8mlpjVAA-1
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
Cc: fam@euphon.net, ehabkost@redhat.com, alex.bennee@linaro.org,
 philmd@redhat.com, crosa@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit cbe6d6365a48 the command `qemu -accel help` returns
the list of accelerators enabled in the QEMU binary. This adds
the list_accel() method which return that same list.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/accel.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index cbeac10dd1..746b7e68f5 100644
--- a/python/qemu/accel.py
+++ b/python/qemu/accel.py
@@ -14,7 +14,11 @@ accelerators.
 # the COPYING file in the top-level directory.
 #
=20
+import logging
 import os
+import subprocess
+
+LOG =3D logging.getLogger(__name__)
=20
 # Mapping host architecture to any additional architectures it can
 # support which often includes its 32 bit cousin.
@@ -23,6 +27,25 @@ ADDITIONAL_ARCHES =3D {
     "aarch64" : "armhf"
 }
=20
+def list_accel(qemu_bin):
+    """
+    List accelerators enabled in the QEMU binary.
+
+    @param qemu_bin (str): path to the QEMU binary.
+    @raise Exception: if failed to run `qemu -accel help`
+    @return a list of accelerator names.
+    """
+    if not qemu_bin:
+        return []
+    try:
+        out =3D subprocess.check_output("%s -accel help" % qemu_bin, shell=
=3DTrue)
+    except:
+        LOG.debug("Failed to get the list of accelerators in %s" % qemu_bi=
n)
+        raise
+    lines =3D out.decode().splitlines()
+    # Skip the first line which is the header.
+    return [l.strip() for l in lines[1:] if l]
+
 def kvm_available(target_arch=3DNone):
     host_arch =3D os.uname()[4]
     if target_arch and target_arch !=3D host_arch:
--=20
2.21.0


