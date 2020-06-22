Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756F4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45DFF20716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 10:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOIVicrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DFF20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnK8s-0005y0-FA
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 06:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnJuu-0007WW-TX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:43:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29028
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnJum-0005NO-MB
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 06:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592822580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yigXi+5jJxPcEfqszOa6dKjHvjPy5dq/aBEievotLbg=;
 b=cOIVicrvU90nSfM5hx6Yde6ev7ovh6pN3SY9j/EfjXhKnn7pOXHNz1eSCPuG5NVAM2RYHW
 EjYdhaMzyUTZWs0kAnGcXIAC4AW4CzVKaHAWFpfokwbSXU1btW4UERBgjfIYTuHOwVu3QY
 wKUuACo9YbiJoGDPtu1uuS6h/QsLOv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-I35GjO70ONmE6EuGJ-FYPw-1; Mon, 22 Jun 2020 06:42:58 -0400
X-MC-Unique: I35GjO70ONmE6EuGJ-FYPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5719A809880;
 Mon, 22 Jun 2020 10:42:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 558955BAEB;
 Mon, 22 Jun 2020 10:42:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1709A1138474; Mon, 22 Jun 2020 12:42:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/22] usb/dev-mtp: Fix Error double free after inotify failure
Date: Mon, 22 Jun 2020 12:42:34 +0200
Message-Id: <20200622104250.1404835-7-armbru@redhat.com>
In-Reply-To: <20200622104250.1404835-1-armbru@redhat.com>
References: <20200622104250.1404835-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

error_report_err() frees its first argument.  Freeing it again is
wrong.  Don't.

Fixes: 47287c27d0c367a89f7b2851e23a7f8b2d499dd6
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/usb/dev-mtp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 168428156b..15a2243101 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -634,7 +634,6 @@ static void usb_mtp_object_readdir(MTPState *s, MTPObject *o)
             error_reportf_err(err,
                               "usb-mtp: failed to add watch for %s: ",
                               o->path);
-            error_free(err);
         } else {
             trace_usb_mtp_file_monitor_event(s->dev.addr, o->path,
                                              "Watch Added");
@@ -1279,7 +1278,6 @@ static void usb_mtp_command(MTPState *s, MTPControl *c)
         if (err) {
             error_reportf_err(err,
                               "usb-mtp: file monitoring init failed: ");
-            error_free(err);
         } else {
             QTAILQ_INIT(&s->events);
         }
-- 
2.26.2


