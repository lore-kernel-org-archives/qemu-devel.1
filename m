Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86C4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B3C206DB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aaEgdNxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B3C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhDz1-0007Cp-Mw
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhDlx-00046n-J0
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:56:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39114
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jhDls-0007Va-AA
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 10:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591368995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K2CFRVVlqihOWpqw3mNZDeRHnB4M1D5JStIrtvhT4Rk=;
 b=aaEgdNxPLGAFDG8ZWQah9vqFTfg3WVWv/z998P2tqASFUfmUEd7TO8Y9rCITRRVWrGZEJv
 3ZiuhRqqRz6QerxJuCv4WdXp0L4UBdsgiO5zSoCoHMTXQlC6/EuB4fSOluF5Xw91vHQZAU
 yPotVzcPmrR+UOTNR6fa5U6Foy1la1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-7lDd6SazPVWYg6Tnc5ARUA-1; Fri, 05 Jun 2020 10:56:31 -0400
X-MC-Unique: 7lDd6SazPVWYg6Tnc5ARUA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E70D107ACF7;
 Fri,  5 Jun 2020 14:56:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EDE41973B;
 Fri,  5 Jun 2020 14:56:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E0B461138467; Fri,  5 Jun 2020 16:56:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/16] sd/milkymist-memcard: Fix error API violation
Date: Fri,  5 Jun 2020 16:56:25 +0200
Message-Id: <20200605145625.2920920-17-armbru@redhat.com>
In-Reply-To: <20200605145625.2920920-1-armbru@redhat.com>
References: <20200605145625.2920920-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:27:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, Michael Walle <michael@walle.cc>,
 pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

milkymist_memcard_realize() is wrong that way: it passes &err to
qdev_prop_set_drive_err() and qdev_realize_and_unref().  Currently
harmless, because the latter uses it only as first argument of
error_propagate().

Making qdev_prop_set_drive_err() fail involves abuse of -global.
Leave handling that to qdev_prop_set_drive(), like we do elsewhere.

Cc: Michael Walle <michael@walle.cc>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/sd/milkymist-memcard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 1c23310715..482e97191e 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -279,7 +279,7 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     dinfo = drive_get_next(IF_SD);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     carddev = qdev_new(TYPE_SD_CARD);
-    qdev_prop_set_drive_err(carddev, "drive", blk, &err);
+    qdev_prop_set_drive(carddev, "drive", blk);
     qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err);
     if (err) {
         error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
-- 
2.26.2


