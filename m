Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C599C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB0720775
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cw0YO1MA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB0720775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtarw-0005dw-91
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 14:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jtar0-0005DB-BJ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:01:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jtaqx-0001oq-D5
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594317656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rV+A+GC+sfbeBWbmGvpFyX4tjXUTjjrNmGDbFl8y/uQ=;
 b=cw0YO1MAke/Lng9//Ih+ZAsaBKknVz17JmmVx0R511X9+JHCESvcUl3+1CCHLoBOdQglif
 xweeZDTfxO/dP6CtOlzxK7xBN5P4KK90k7X1vCGQO7S/xJCIqLrEuvRRXq4oDfnTgmgbmy
 CS/tVwevok2fiMZn2lOjn6DCMsoTTow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-3fV6lE9pM0mz3J1hkx595A-1; Thu, 09 Jul 2020 14:00:54 -0400
X-MC-Unique: 3fV6lE9pM0mz3J1hkx595A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BC45102C7EE;
 Thu,  9 Jul 2020 18:00:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-100.phx2.redhat.com
 [10.3.112.100])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5BC7797FE;
 Thu,  9 Jul 2020 18:00:51 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: [PATCH] 9p: null terminate fs driver options list
Date: Thu,  9 Jul 2020 23:28:48 +0530
Message-Id: <20200709175848.650400-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:25:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

NULL terminate fs driver options' list, validate_opt() looks for
a null entry to terminate the loop.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 fsdev/qemu-fsdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fsdev/qemu-fsdev.c b/fsdev/qemu-fsdev.c
index a9e069c0c7..3da64e9f72 100644
--- a/fsdev/qemu-fsdev.c
+++ b/fsdev/qemu-fsdev.c
@@ -78,6 +78,7 @@ static FsDriverTable FsDrivers[] = {
             "throttling.iops-read-max-length",
             "throttling.iops-write-max-length",
             "throttling.iops-size",
+            NULL
         },
     },
     {
@@ -85,6 +86,7 @@ static FsDriverTable FsDrivers[] = {
         .ops = &synth_ops,
         .opts = (const char * []) {
             COMMON_FS_DRIVER_OPTIONS,
+            NULL
         },
     },
     {
@@ -95,6 +97,7 @@ static FsDriverTable FsDrivers[] = {
             "socket",
             "sock_fd",
             "writeout",
+            NULL
         },
     },
 };
-- 
2.26.2


