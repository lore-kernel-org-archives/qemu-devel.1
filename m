Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F58C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9518206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcB78xx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9518206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtHcd-00011B-UR
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHb0-0007JM-HH
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:27:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49767
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHax-0001u0-Av
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tW4r/XexJa0nLgf7YKFyABfPWGMDF01myRjFL5Ri6I8=;
 b=JcB78xx4NqM4zsrQmrZuB6OPlgwQduhpAnlT+ef/k2LuKxH/tkKh4d5F2IlnpWDPrUcEDO
 qAcUIR2gr8nO1uQSIoTZ+VUsuWrRz77JSSIUtKU2kgDwmc3k1dbLOD+vJeDO0GL7YFXsRa
 OKdHfrS55QhlZRUQMb8eoEah/DFbbYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-kY6ysR53PyOHUA84g4ZjMQ-1; Tue, 07 Jul 2020 17:25:23 -0400
X-MC-Unique: kY6ysR53PyOHUA84g4ZjMQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7048580183C;
 Tue,  7 Jul 2020 21:25:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18F6F512FE;
 Tue,  7 Jul 2020 21:25:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D31F910C4AEF; Tue,  7 Jul 2020 23:25:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/53] fw_cfg: Use ERRP_GUARD()
Date: Tue,  7 Jul 2020 23:25:00 +0200
Message-Id: <20200707212503.1495927-51-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

If we want to check error after errp-function call, we need to
introduce local_err and then propagate it to errp. Instead, use
the ERRP_GUARD() macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_GUARD() leaves errp as is if it's not NULL or
   &error_fatal, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_GUARD() macro.
Otherwise, this info will not be added when errp == &error_fatal
(the program will exit prior to the error_append_hint() or
error_prepend() call).  No such cases are being fixed here.

This commit is generated by command

    sed -n '/^Firmware configuration (fw_cfg)$/,/^$/{s/^F: //p}' \
        MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/errp-guard.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200707165037.1026246-6-armbru@redhat.com>
[ERRP_AUTO_PROPAGATE() renamed to ERRP_GUARD(), and
auto-propagated-errp.cocci to errp-guard.cocci.  Commit message
tweaked again.]
---
 hw/nvram/fw_cfg.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 0408a31f8e..61b00d765a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1231,12 +1231,11 @@ static Property fw_cfg_io_properties[] = {
 
 static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     FWCfgIoState *s = FW_CFG_IO(dev);
-    Error *local_err = NULL;
 
-    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    fw_cfg_file_slots_allocate(FW_CFG(s), errp);
+    if (*errp) {
         return;
     }
 
@@ -1282,14 +1281,13 @@ static Property fw_cfg_mem_properties[] = {
 
 static void fw_cfg_mem_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_GUARD();
     FWCfgMemState *s = FW_CFG_MEM(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     const MemoryRegionOps *data_ops = &fw_cfg_data_mem_ops;
-    Error *local_err = NULL;
 
-    fw_cfg_file_slots_allocate(FW_CFG(s), &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    fw_cfg_file_slots_allocate(FW_CFG(s), errp);
+    if (*errp) {
         return;
     }
 
-- 
2.26.2


