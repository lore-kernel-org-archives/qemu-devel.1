Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BBBC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51033206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 10:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VG7M1zij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51033206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jChfo-0005jY-Ip
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 06:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jChag-0008PX-MA
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jChaf-000646-Jo
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39193
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jChaf-000628-Fo
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 06:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584095453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jg6I2rHJFJo3oQEwS/VJa7D6UAlAcUHnkuu+usViVfg=;
 b=VG7M1zijxfdd+Cyuosm7bip3exRV8xLkkVT+Ex6tdjkQzb3DQtTsjFXthc2y7ZcvCb2WST
 tSW8SEBaQNOIYCM814Do0X6XmJKytYXrifMj8li9I3oC88PrQOl4Wuwwl9/nmBO4dCb2of
 owhLkF8BE6qcyihNM5BWQ46s7A9eORM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-3kqMX2ixPRamFDGmFBTyEQ-1; Fri, 13 Mar 2020 06:30:51 -0400
X-MC-Unique: 3kqMX2ixPRamFDGmFBTyEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EA38DB20;
 Fri, 13 Mar 2020 10:30:50 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-92.ams2.redhat.com
 [10.36.117.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16FA28B773;
 Fri, 13 Mar 2020 10:30:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com,
 zhukeqian1@huawei.com, quintela@redhat.com
Subject: [PULL 5/5] migration: recognize COLO as part of activating process
Date: Fri, 13 Mar 2020 10:30:39 +0000
Message-Id: <20200313103039.150133-6-dgilbert@redhat.com>
In-Reply-To: <20200313103039.150133-1-dgilbert@redhat.com>
References: <20200313103039.150133-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

From: zhanghailiang <zhang.zhanghailiang@huawei.com>

We will migrate parts of dirty pages backgroud lively during the gap time
of two checkpoints, without this modification, it will not work
because ram_save_iterate() will check it before send RAM_SAVE_FLAG_EOS
at the end of it.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Message-Id: <20200224065414.36524-7-zhang.zhanghailiang@huawei.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index 59da5d0625..c1d88ace7f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -854,6 +854,7 @@ bool migration_is_setup_or_active(int state)
     case MIGRATION_STATUS_PRE_SWITCHOVER:
     case MIGRATION_STATUS_DEVICE:
     case MIGRATION_STATUS_WAIT_UNPLUG:
+    case MIGRATION_STATUS_COLO:
         return true;
=20
     default:
--=20
2.24.1


