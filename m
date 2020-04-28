Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4685EC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE372085B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gT5VyyS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE372085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWx8-0003PT-4v
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWr8-0000Wq-Jr
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTWr8-00063K-2V
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTWr7-0005yN-GZ
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588105764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+XNg1Xg4+teq3LwNiBE9+0apmplXS9okGrsNbNOPayE=;
 b=gT5VyyS1+Yc3hH2UxCjL/abgWBOH0+kT+RKRp4fP+JaQ1UIJWBGp2UcirLyspRsFTQvJ5x
 gfg13j3HblU9w43hNloj6R03QHRIbr9iFwZptVcroNpSybwqZf8YVAkzlpGipv8LP/NlPn
 fu7bCJjp1PeccqlioQT0zyystocRJWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-qE-LnctuPp-RQqCNVdMWbw-1; Tue, 28 Apr 2020 16:29:22 -0400
X-MC-Unique: qE-LnctuPp-RQqCNVdMWbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC6A6800C78;
 Tue, 28 Apr 2020 20:29:21 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11C1A5C1D4;
 Tue, 28 Apr 2020 20:29:20 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/9] ssh: Support BDRV_REQ_ZERO_WRITE for truncate
Date: Tue, 28 Apr 2020 15:29:02 -0500
Message-Id: <20200428202905.770727-7-eblake@redhat.com>
In-Reply-To: <20200428202905.770727-1-eblake@redhat.com>
References: <20200428202905.770727-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our .bdrv_has_zero_init_truncate can detect when the remote side
always zero fills; we can reuse that same knowledge to implement
BDRV_REQ_ZERO_WRITE by ignoring it when the server gives it to us for
free.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/ssh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/ssh.c b/block/ssh.c
index 9eb33df8598c..f9e08a490069 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -883,6 +883,10 @@ static int ssh_file_open(BlockDriverState *bs, QDict *=
options, int bdrv_flags,
     /* Go non-blocking. */
     ssh_set_blocking(s->session, 0);

+    if (s->attrs->type =3D=3D SSH_FILEXFER_TYPE_REGULAR) {
+        bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
+    }
+
     qapi_free_BlockdevOptionsSsh(opts);

     return 0;
--=20
2.26.2


