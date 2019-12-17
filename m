Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A8C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B708F2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ap0kJH+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B708F2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5u6-0003T1-Tm
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ih5Dx-0004T6-Rv
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ih5Dw-0004Cb-Mj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22553
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ih5Dw-0004CM-JD
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 00:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576559804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXeHrJD4tk/u30DpUF63Av8cKzHkbifYHGE/1Vt3IiI=;
 b=ap0kJH+vSWSOeR7p3ASRGdkyRmDPZ22IDUQW8UJ1Tm5D3uecNqA8oD3LISAJg/lmZUyWjG
 4ZoDS5kK9ynMz4njUjNoSV19WVrqEYoveTNIkdw45gn7XiBLfJ58IUJ+lceR7HHvN2sByU
 e4Q5qu+1lhB0N2mQXB5zys7L+eqzGYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-_9qxFTgyNR-dgwA-3j7mng-1; Tue, 17 Dec 2019 00:16:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D43A189CD00;
 Tue, 17 Dec 2019 05:16:41 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-6.gru2.redhat.com
 [10.97.116.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70F3919C4F;
 Tue, 17 Dec 2019 05:16:37 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/15] python/qemu: accel: Add list_accel() method
Date: Tue, 17 Dec 2019 00:15:18 -0500
Message-Id: <20191217051521.1239-13-crosa@redhat.com>
In-Reply-To: <20191217051521.1239-1-crosa@redhat.com>
References: <20191217051521.1239-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _9qxFTgyNR-dgwA-3j7mng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Fam Zheng <fam@euphon.net>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-ppc@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

Since commit cbe6d6365a48 the command `qemu -accel help` returns
the list of accelerators enabled in the QEMU binary. This adds
the list_accel() method which return that same list.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20191216191438.93418-3-wainersm@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 python/qemu/accel.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index cbeac10dd1..7395cee793 100644
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
+        out =3D subprocess.check_output([qemu_bin, '-accel', 'help'],
+                                      universal_newlines=3DTrue)
+    except:
+        LOG.debug("Failed to get the list of accelerators in %s", qemu_bin=
)
+        raise
+    # Skip the first line which is the header.
+    return [acc.strip() for acc in out.splitlines()[1:]]
+
 def kvm_available(target_arch=3DNone):
     host_arch =3D os.uname()[4]
     if target_arch and target_arch !=3D host_arch:
--=20
2.21.0


