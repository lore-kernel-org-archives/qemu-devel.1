Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E28C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E07B217F5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vx+k2dBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E07B217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS17j-00045A-Gx
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iS10i-0005F1-93
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iS10g-00030G-6k
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45073)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iS10g-00030A-3v
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572968685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cydLyk85Sj0wvc752K2r6gUg4BKM93PS+YG8bQ6GRsw=;
 b=Vx+k2dBlQ3oV/pf6KJJC99IHbi5CP064hfAOj/ZyRiBxeOv0m6WwdIF5vUJCCKS1R/mn6y
 IUcLrEeIBLbHF90jAa2BKFoiYWulms69CSQR/ZirIoGo9nsaP1rJw7XJsWW9D42Zfyupkq
 Wq6nBaPZg+3ni0cSz6xDSTDrHoI0qHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-NQCZm5i7OUCbbnV_Gjb65g-1; Tue, 05 Nov 2019 10:44:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B96491005500;
 Tue,  5 Nov 2019 15:44:39 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A96F010018FF;
 Tue,  5 Nov 2019 15:44:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] image-fuzzer: Use bytes constant for field values
Date: Tue,  5 Nov 2019 16:43:28 +0100
Message-Id: <20191105154332.181417-8-stefanha@redhat.com>
In-Reply-To: <20191105154332.181417-1-stefanha@redhat.com>
References: <20191105154332.181417-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: NQCZm5i7OUCbbnV_Gjb65g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

Field values are supposed to be bytes objects, not unicode
strings.  Change two constants that were declared as strings.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20191016192430.25098-8-ehabkost@redhat.com
Message-Id: <20191016192430.25098-8-ehabkost@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/image-fuzzer/qcow2/layout.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/image-fuzzer/qcow2/layout.py b/tests/image-fuzzer/qcow2/=
layout.py
index 0adcbd448d..a0fd53c7ad 100644
--- a/tests/image-fuzzer/qcow2/layout.py
+++ b/tests/image-fuzzer/qcow2/layout.py
@@ -122,7 +122,7 @@ class Image(object):
     def create_header(self, cluster_bits, backing_file_name=3DNone):
         """Generate a random valid header."""
         meta_header =3D [
-            ['>4s', 0, "QFI\xfb", 'magic'],
+            ['>4s', 0, b"QFI\xfb", 'magic'],
             ['>I', 4, random.randint(2, 3), 'version'],
             ['>Q', 8, 0, 'backing_file_offset'],
             ['>I', 16, 0, 'backing_file_size'],
@@ -231,7 +231,7 @@ class Image(object):
             feature_tables =3D []
             feature_ids =3D []
             inner_offset =3D self.ext_offset + ext_header_len
-            feat_name =3D 'some cool feature'
+            feat_name =3D b'some cool feature'
             while len(feature_tables) < num_fnt_entries * 3:
                 feat_type, feat_bit =3D gen_feat_ids()
                 # Remove duplicates
--=20
2.23.0


