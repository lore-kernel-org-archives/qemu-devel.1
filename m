Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1916C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0D620672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOt1gc1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0D620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXrah-0007LW-Nb
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iXrZr-0006fS-Sa
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iXrZo-0004vy-8w
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:53:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23732
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iXrZm-0004uf-Dz
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:53:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574362389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/ycIKR2Vr2dSVBvTi4QHjSqcY5kmM4PBXeNACmDo7NY=;
 b=FOt1gc1EoITPV4lfU4uy1maAnma9muLmMcoYR2sahuQZZySzhm+3heYrF99qLo4NnjKHq7
 vIX2SGRMu9aYu1/R3KjOpMPQkrrtlvCYCkjkBP3o0POrHKNP/y98/zv8i8/jlizH63AVk5
 OsKqvCtdSV31avCy6zuh2c0aT2gn/QU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-C38l0N8ROqC_LIopmQAmyQ-1; Thu, 21 Nov 2019 13:53:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B03FB800A02
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 18:53:06 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAA0444FA0;
 Thu, 21 Nov 2019 18:53:05 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, ehabkost@redhat.com,
 crosa@redhat.com
Subject: [PATCH] vmstate-static-checker: Fix for current python
Date: Thu, 21 Nov 2019 18:53:03 +0000
Message-Id: <20191121185303.51685-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: C38l0N8ROqC_LIopmQAmyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Python 3.7.5 on f31 doesn't seem to like the old type=3Dfile syntax
on argparse.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 scripts/vmstate-static-checker.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-che=
cker.py
index 21dbdccf3e..9f912dd870 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -379,9 +379,11 @@ def main():
     help_text =3D "Parse JSON-formatted vmstate dumps from QEMU in files S=
RC and DEST.  Checks whether migration from SRC to DEST QEMU versions would=
 break based on the VMSTATE information contained within the JSON outputs. =
 The JSON output is created from a QEMU invocation with the -dump-vmstate p=
arameter and a filename argument to it.  Other parameters to QEMU do not ma=
tter, except the -M (machine type) parameter."
=20
     parser =3D argparse.ArgumentParser(description=3Dhelp_text)
-    parser.add_argument('-s', '--src', type=3Dfile, required=3DTrue,
+    parser.add_argument('-s', '--src', type=3Dargparse.FileType('r'),
+                        required=3DTrue,
                         help=3D'json dump from src qemu')
-    parser.add_argument('-d', '--dest', type=3Dfile, required=3DTrue,
+    parser.add_argument('-d', '--dest', type=3Dargparse.FileType('r'),
+                        required=3DTrue,
                         help=3D'json dump from dest qemu')
     parser.add_argument('--reverse', required=3DFalse, default=3DFalse,
                         action=3D'store_true',
--=20
2.23.0


