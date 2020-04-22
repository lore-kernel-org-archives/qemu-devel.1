Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32B1C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:25:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA5920776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 17:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XU1h++jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA5920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJ7i-0008WN-FL
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 13:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6Q-0006up-Ch
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jRJ6P-0004L6-6E
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47639
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jRJ6O-0004JL-Mw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 13:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587576239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTbps+SS2Slp3h4Pf3Tt8s/+r7sD0evJW0cmToiLmrc=;
 b=XU1h++jn/AEDqXkIGA48sw6401ktBqO+gNBC3OBYvso64s8mWqgC4MVehEJSaLwziW/0zv
 uCpe/U1Vnu6tOv6ABQRexZSo8o4Al/9RYCTZ68r1PJz/+lu+xvg9fXuyCuVC1XTcn4oAb8
 B+tXB5iPUcCTZ8sR3FUwmfgqd6w/eNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-U4YNkAZNNlSee_fAC_GRcg-1; Wed, 22 Apr 2020 13:23:55 -0400
X-MC-Unique: U4YNkAZNNlSee_fAC_GRcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FFE4DB61;
 Wed, 22 Apr 2020 17:23:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC3D36084B;
 Wed, 22 Apr 2020 17:23:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] docker.py/build: support binary files in --extra-files
Date: Wed, 22 Apr 2020 13:23:45 -0400
Message-Id: <20200422172351.26583-3-pbonzini@redhat.com>
In-Reply-To: <20200422172351.26583-1-pbonzini@redhat.com>
References: <20200422172351.26583-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Read the --extra-files in binary mode to avoid encoding errors.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/docker.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index ad61747bae..85e1dda10f 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -56,15 +56,19 @@ class EngineEnum(enum.IntEnum):
=20
 USE_ENGINE =3D EngineEnum.AUTO
=20
+def _bytes_checksum(bytes):
+    """Calculate a digest string unique to the text content"""
+    return hashlib.sha1(bytes).hexdigest()
+
 def _text_checksum(text):
     """Calculate a digest string unique to the text content"""
-    return hashlib.sha1(text.encode('utf-8')).hexdigest()
+    return _bytes_checksum(text.encode('utf-8'))
=20
 def _read_dockerfile(path):
     return open(path, 'rt', encoding=3D'utf-8').read()
=20
 def _file_checksum(filename):
-    return _text_checksum(_read_dockerfile(filename))
+    return _bytes_checksum(open(filename, 'rb').read())
=20
=20
 def _guess_engine_command():
--=20
2.18.2



