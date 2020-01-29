Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F080C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C56020702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KF234yKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C56020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwut9-0004Vi-Ht
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwupJ-0005oU-R8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwupI-0000zX-Mq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21511
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwupI-0000yU-He
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/QoB+Io08NfOpDheh+GozLBIB+1HoMFpfftGG6ycXEM=;
 b=KF234yKm0VQVg1MpAvVFmvrzQGZBqaOn6M6G4WPNgrmrwWHaQ30ejzBr3aYtt4OwJ4egVB
 ubnJaMYtxsyhCdLCXeu6N3+Qp/LZ88/xpKa+g9z+iMbK68lzqQn6s+QGYPlYRVX1PKTn5H
 P/QJHqIDvr/2fBkeO9KRW654Zti91sI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-SH7pic85Pg6cVdzplIih-Q-1; Wed, 29 Jan 2020 16:24:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39968100550E;
 Wed, 29 Jan 2020 21:24:37 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 400AC60C05;
 Wed, 29 Jan 2020 21:24:35 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/29] python/qemu/accel: Use binutils::binary_get_accels()
Date: Wed, 29 Jan 2020 22:23:28 +0100
Message-Id: <20200129212345.20547-13-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: SH7pic85Pg6cVdzplIih-Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of parsing the process help output, use the
binary_get_accels() helper which queries the list of
accelerators over a QMP socket.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 python/qemu/accel.py | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index 0b38ddf0ab..cde51ae159 100644
--- a/python/qemu/accel.py
+++ b/python/qemu/accel.py
@@ -16,7 +16,8 @@ accelerators.
=20
 import logging
 import os
-import subprocess
+
+from .binutils import binary_get_accels
=20
 LOG =3D logging.getLogger(__name__)
=20
@@ -27,25 +28,6 @@ ADDITIONAL_ARCHES =3D {
     "aarch64" : "armhf"
 }
=20
-def list_accel(qemu_bin):
-    """
-    List accelerators enabled in the QEMU binary.
-
-    @param qemu_bin (str): path to the QEMU binary.
-    @raise Exception: if failed to run `qemu -accel help`
-    @return a list of accelerator names.
-    """
-    if not qemu_bin:
-        return []
-    try:
-        out =3D subprocess.check_output([qemu_bin, '-accel', 'help'],
-                                      universal_newlines=3DTrue)
-    except:
-        LOG.debug("Failed to get the list of accelerators in %s", qemu_bin=
)
-        raise
-    # Skip the first line which is the header.
-    return [acc.strip() for acc in out.splitlines()[1:]]
-
 def kvm_available(target_arch=3DNone, qemu_bin=3DNone):
     """
     Check if KVM is available using the following heuristic:
@@ -64,7 +46,7 @@ def kvm_available(target_arch=3DNone, qemu_bin=3DNone):
         if target_arch !=3D host_arch:
             if target_arch !=3D ADDITIONAL_ARCHES.get(host_arch):
                 return False
-    if qemu_bin and "kvm" not in list_accel(qemu_bin):
+    if qemu_bin and "kvm" not in binary_get_accels(qemu_bin):
         return False
     return True
=20
@@ -74,4 +56,4 @@ def tcg_available(qemu_bin):
=20
     @param qemu_bin (str): path to the QEMU binary
     """
-    return 'tcg' in list_accel(qemu_bin)
+    return 'tcg' in binary_get_accels(qemu_bin)
--=20
2.21.1


