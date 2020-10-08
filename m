Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1846FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:29:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D2D22227
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyFdy8wU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D2D22227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQcXF-0004Rr-B5
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 16:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQcVd-0003BU-N8
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:27:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQcVc-0005uT-5A
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602188847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yj12oITVEgWM3MNWR3Hu+YVNSz6iK8jlQxvhaPR1rew=;
 b=iyFdy8wUe04hBo/1jn6N+op9U+BKI1x9AtzlrnF93ur+hiJl0chJuHlK6FV6S+8QjjL6eM
 34cuSUsRiqXrBuqRGYoCSoWwXYDusH8GONTm6sHEEoEV2vteDuwXkn2XSIgSI2EpuY/LvZ
 0GZAJCtxfwseATiwa5l0NhP0WPx6gMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-MT3ppzEyN0qpShjqqiKMRQ-1; Thu, 08 Oct 2020 16:27:23 -0400
X-MC-Unique: MT3ppzEyN0qpShjqqiKMRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C5731019626;
 Thu,  8 Oct 2020 20:27:22 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 84516702E7;
 Thu,  8 Oct 2020 20:27:19 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] authz-list-file: Fix crash when filename is not set
Date: Thu,  8 Oct 2020 16:27:11 -0400
Message-Id: <20201008202713.1416823-2-ehabkost@redhat.com>
In-Reply-To: <20201008202713.1416823-1-ehabkost@redhat.com>
References: <20201008202713.1416823-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the following crash:

  $ qemu-system-x86_64 -object authz-list-file,id=obj0
  qemu-system-x86_64: -object authz-list-file,id=obj0: GLib: g_file_get_contents: assertion 'filename != NULL' failed
  Segmentation fault (core dumped)

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
---
 authz/listfile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/authz/listfile.c b/authz/listfile.c
index cd6163aa40..aaf930453d 100644
--- a/authz/listfile.c
+++ b/authz/listfile.c
@@ -122,6 +122,11 @@ qauthz_list_file_complete(UserCreatable *uc, Error **errp)
     QAuthZListFile *fauthz = QAUTHZ_LIST_FILE(uc);
     gchar *dir = NULL, *file = NULL;
 
+    if (!fauthz->filename) {
+        error_setg(errp, "filename not provided");
+        return;
+    }
+
     fauthz->list = qauthz_list_file_load(fauthz, errp);
 
     if (!fauthz->refresh) {
-- 
2.26.2


