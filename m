Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B2FC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948F620578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNCPiUl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948F620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttBT-0007zz-Rh
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtt7Q-0008Mb-Gg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:31:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtt7O-0004vh-PD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594387868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8N8jixqL4QSHMjT/aTNnIeog9nVg4heujReAzPbEOE=;
 b=JNCPiUl4JTk3M+ZL3bLhR8KSGT1IxfO0VIPdB18eJaGQ/ZWU2ykOQUKWlcpitk+O3VaI83
 A5UKYVuq/6sIJTelQw8ljx/PZ5PgkqHb/YWXfuJ22LqPdwpw4yJ3UBLictLa3lL1JgUl8N
 LRhNOTX1iMRG0d63s/4UeS/ZQKAmNhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-PSl73_6iPbqdiJYoerrDVw-1; Fri, 10 Jul 2020 09:31:06 -0400
X-MC-Unique: PSl73_6iPbqdiJYoerrDVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72B0F88C79C;
 Fri, 10 Jul 2020 13:31:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F078B74F5B;
 Fri, 10 Jul 2020 13:31:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 80EAF11326E4; Fri, 10 Jul 2020 15:31:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 50/53] fw_cfg: Use ERRP_GUARD()
Date: Fri, 10 Jul 2020 15:31:03 +0200
Message-Id: <20200710133103.2153250-5-armbru@redhat.com>
In-Reply-To: <20200710133103.2153250-1-armbru@redhat.com>
References: <20200710133103.2153250-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
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
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
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
tweaked again.  Coccinelle script rerun for commit 3203148917
"hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR interface"]
---
 hw/nvram/fw_cfg.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 694722b212..3b1811d3bf 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1035,8 +1035,8 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
 void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
                                const char *gen_id, Error **errp)
 {
+    ERRP_GUARD();
     FWCfgDataGeneratorClass *klass;
-    Error *local_err = NULL;
     GByteArray *array;
     Object *obj;
     gsize size;
@@ -1052,9 +1052,8 @@ void fw_cfg_add_from_generator(FWCfgState *s, const char *filename,
         return;
     }
     klass = FW_CFG_DATA_GENERATOR_GET_CLASS(obj);
-    array = klass->get_data(obj, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    array = klass->get_data(obj, errp);
+    if (*errp) {
         return;
     }
     size = array->len;
@@ -1260,12 +1259,11 @@ static Property fw_cfg_io_properties[] = {
 
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
 
@@ -1311,14 +1309,13 @@ static Property fw_cfg_mem_properties[] = {
 
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


