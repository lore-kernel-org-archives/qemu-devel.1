Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004F8C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 22:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6DB20733
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 22:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WC+k7hT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6DB20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZNIL-0006Mt-Rd
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 17:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iZNEu-0003Qv-DS
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 17:53:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iZNEr-00036K-AT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 17:53:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34930
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iZNEo-00031N-7a
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 17:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574722425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQTnjlgt0BjVO69r26qEglw2c86b2cHL0VU5/2aWmoQ=;
 b=WC+k7hT8C5kFmvkBWqyIVIFzIpYKsJpUFoVW0QImY6mps1MTSsnx1PABpKSY145SPQEht/
 ZLtu6UgAUYj7fgUA1pMPa36qRdqcTxOJMQK5KToKHRnxfmelYXOYHIqfbKBO6kuYdOCHqL
 VnJ+ebOHDDNJZgM+Vxx54AnoYMf/RT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-Lj-Rs3k_NnCqfwJiZ88YyA-1; Mon, 25 Nov 2019 17:53:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96CFC1801BA9;
 Mon, 25 Nov 2019 22:53:39 +0000 (UTC)
Received: from localhost (ovpn-116-101.gru2.redhat.com [10.97.116.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD64F5C1D8;
 Mon, 25 Nov 2019 22:53:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/1] vmstate-static-checker: Fix for current python
Date: Mon, 25 Nov 2019 19:53:33 -0300
Message-Id: <20191125225333.322163-2-ehabkost@redhat.com>
In-Reply-To: <20191125225333.322163-1-ehabkost@redhat.com>
References: <20191125225333.322163-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Lj-Rs3k_NnCqfwJiZ88YyA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Python 3.7.5 on f31 doesn't seem to like the old type=3Dfile syntax
on argparse.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20191121185303.51685-1-dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/vmstate-static-checker.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-che=
cker.py
index d3467288dc..f8b7b8f772 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -375,9 +375,11 @@ def main():
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


