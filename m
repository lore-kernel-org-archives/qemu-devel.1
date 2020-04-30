Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DAAC47253
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:30:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9F22072A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2T/TZ3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9F22072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUACu-00016B-OV
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:30:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAAk-0007Mp-4s
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jUAAj-00022o-KA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58859
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jUAAj-0001yA-59
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588256896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ef1eEYo925KWV//BAerI3fsF2Er5PXfrJmQtLHKHKag=;
 b=a2T/TZ3ODL0AjOS2Rdfy01mR6zkdmf/8x7rIbhlZmSazePw0Se6cw7rnLzQ2MoxY3wPdns
 KjshTMQJr1lLeSoFfuNPHTcMScVkE+5Uo5MXXzlHMWtbSKWJVM9xwrstj9nUJRUTtNO3Cy
 zSKmxpfZFiOTWSJycFdVm8yXunYC7pY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-r3mErwBlPf2k-qSPKmQmNg-1; Thu, 30 Apr 2020 10:28:12 -0400
X-MC-Unique: r3mErwBlPf2k-qSPKmQmNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89051107ACCA;
 Thu, 30 Apr 2020 14:28:11 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16E216106A;
 Thu, 30 Apr 2020 14:28:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/4] backup: Improve error for bdrv_getlength() failure
Date: Thu, 30 Apr 2020 16:27:53 +0200
Message-Id: <20200430142755.315494-3-kwolf@redhat.com>
In-Reply-To: <20200430142755.315494-1-kwolf@redhat.com>
References: <20200430142755.315494-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_get_device_name() will be an empty string with modern management
tools that don't use -drive. Use bdrv_get_device_or_node_name() instead
so that the node name is used if the BlockBackend is anonymous.

While at it, start with upper case to make the message consistent with
the rest of the function.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/backup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index a7a7dcaf4c..c4c3b8cd46 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -400,8 +400,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDr=
iverState *bs,
=20
     len =3D bdrv_getlength(bs);
     if (len < 0) {
-        error_setg_errno(errp, -len, "unable to get length for '%s'",
-                         bdrv_get_device_name(bs));
+        error_setg_errno(errp, -len, "Unable to get length for '%s'",
+                         bdrv_get_device_or_node_name(bs));
         goto error;
     }
=20
--=20
2.25.3


