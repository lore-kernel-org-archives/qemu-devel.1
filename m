Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1558FC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 07:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D141F2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 07:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igMgWWY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D141F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itRGv-0007gc-VM
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 02:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1itRG9-0007DP-EC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 02:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1itRG7-0000QJ-5L
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 02:14:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36130
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1itRG6-0000Pd-MA
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 02:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579504441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZEdzfbgoBSVAGmOfLN7NxhMnCshOiuHcK4zXq8eWo74=;
 b=igMgWWY72m0cCmKlioTk7rrxIgkUxyZCNOMhW+iQZ9ahjcZ2Vh/6xg0QoxA8twH+9u5i7h
 4n8nBumA5zNjpDJXRjHZAO6uVKusMisck+RezY1dhQithqRIvLqf/NraeDSP2lB4HxhVpT
 MbQSsuUUqfknhb4nLcbQjeelJXT6WGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-whDgAZhGN8idZl4fkXujNw-1; Mon, 20 Jan 2020 02:12:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78532107ACC5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 07:12:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-206-44.brq.redhat.com
 [10.40.206.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EDE584790;
 Mon, 20 Jan 2020 07:12:11 +0000 (UTC)
From: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] python: Treat None-return of greeting cmd
Date: Mon, 20 Jan 2020 08:12:02 +0100
Message-Id: <20200120071202.30646-1-ldoktor@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: whDgAZhGN8idZl4fkXujNw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case qemu process dies the "monitor.cmd" returns None which gets
passed to the "__negotiate_capabilities" and leads to unhandled
exception. Let's only check the resp in case it has a value.

Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
---
 python/qemu/qmp.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 5c8cf6a056..a3e5de718a 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -73,7 +73,7 @@ class QEMUMonitorProtocol(object):
             raise QMPConnectError
         # Greeting seems ok, negotiate capabilities
         resp =3D self.cmd('qmp_capabilities')
-        if "return" in resp:
+        if resp and "return" in resp:
             return greeting
         raise QMPCapabilitiesError
=20
--=20
2.21.0


