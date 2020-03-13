Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1971C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4CE20749
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtLQ3b6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4CE20749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfqC-0005zi-IC
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jCfo6-0001xJ-ID
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jCfo5-00064Z-EC
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jCfo4-00062o-NV
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584088594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiEF0F2p122mi6EyxxzwncrqK2Zf5KaVIUcFNWt4j+0=;
 b=NtLQ3b6aCd/LEB+J8joRwaglCV4OoFGnrW64nOp9kmfgWPhH0rVbm3UNIQpItF8zjsGHTA
 jJnMgzK6fCiEEfYtH776UNQN77pJNzv9WQNFfLZhyM1U8JBqif7bc2zJ1nDQLAvvDZPH6G
 kNBn6pcEoN2s/C0KLKMKrHT7ufbFGqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-80shhg0eMzGFzlCAKbYOcQ-1; Fri, 13 Mar 2020 04:36:32 -0400
X-MC-Unique: 80shhg0eMzGFzlCAKbYOcQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4A3085EE6E;
 Fri, 13 Mar 2020 08:36:31 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68F9D96F81;
 Fri, 13 Mar 2020 08:36:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/3] python/qemu: Kill QEMU process if 'quit' doesn't work
Date: Fri, 13 Mar 2020 09:36:16 +0100
Message-Id: <20200313083617.8326-3-kwolf@redhat.com>
In-Reply-To: <20200313083617.8326-1-kwolf@redhat.com>
References: <20200313083617.8326-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With a QEMU bug, it can happen that the QEMU process doesn't react to a
'quit' QMP command. If we got an exception during previous QMP
communication (e.g. iotests Timeout expiring), we could also be in an
inconsistent state where after sending 'quit' we immediately read an old
response and close the socket even though the 'quit' command wasn't
processed yet. Both cases would lead to a hanging test.

Fix this by waiting for the QEMU process to exit after sending 'quit'
with a timeout, and if it doesn't happen within three seconds, send
SIGKILL.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 python/qemu/machine.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 183d8f3d38..c837ee8723 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -358,6 +358,7 @@ class QEMUMachine(object):
                     if not has_quit:
                         self._qmp.cmd('quit')
                     self._qmp.close()
+                    self._popen.wait(timeout=3D3)
                 except:
                     self._popen.kill()
             self._popen.wait()
--=20
2.20.1


