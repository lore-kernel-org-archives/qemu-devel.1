Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF0AC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A4620720
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZICmHtVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A4620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2dO-0003fq-JK
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2Kh-0000Kk-8A
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52841
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2Kb-00008c-J5
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prSLUMQRDRgoKC7sDQ/elX7ogSIiZSGw4L7684zV2jc=;
 b=ZICmHtVKdbWfTeuV+olEbUox+juZvc4fEZiQpLYlp0zshGkxH2VnTeLaMGj6NOTzxRV/kY
 NAXO0rXhq8a1bqYRkDXdsZ97Rq34HvwQi9xK6oNvFr4CoeK5mDIgwOYapHaA7AYTiVZISI
 ExpFQFEQSDZz6O+cvR10f3/ZoVhW0iQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-CRSaoGbTPG-XSvltb3XyEA-1; Fri, 08 May 2020 08:42:18 -0400
X-MC-Unique: CRSaoGbTPG-XSvltb3XyEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AECAF1005510;
 Fri,  8 May 2020 12:42:17 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC7BD19167;
 Fri,  8 May 2020 12:42:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 27/30] ssh: Support BDRV_REQ_ZERO_WRITE for truncate
Date: Fri,  8 May 2020 14:41:32 +0200
Message-Id: <20200508124135.252565-28-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

Our .bdrv_has_zero_init_truncate can detect when the remote side
always zero fills; we can reuse that same knowledge to implement
BDRV_REQ_ZERO_WRITE by ignoring it when the server gives it to us for
free.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200428202905.770727-7-eblake@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/ssh.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/ssh.c b/block/ssh.c
index 9eb33df859..f9e08a4900 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -883,6 +883,10 @@ static int ssh_file_open(BlockDriverState *bs, QDict *=
options, int bdrv_flags,
     /* Go non-blocking. */
     ssh_set_blocking(s->session, 0);
=20
+    if (s->attrs->type =3D=3D SSH_FILEXFER_TYPE_REGULAR) {
+        bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
+    }
+
     qapi_free_BlockdevOptionsSsh(opts);
=20
     return 0;
--=20
2.25.3


