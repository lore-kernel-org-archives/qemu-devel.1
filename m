Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C90C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42CF32067D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcg7wN/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42CF32067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBJd-0003gT-2J
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcB8F-0006d7-GM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kcB88-0000QA-6D
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604943536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UM4x0CQkP9ZWEjoleqaqp9HmuB5IYuiK5Bcb5B8NAA=;
 b=gcg7wN/zsFvjCUwDtTGEFJ7VFZ7kVW3+EMiET2RjeybHNgSnC5jLmdhOpjS/Bwk5Zqaj2E
 +ktV7jvCU6B8o8t8Chi8rRvMY94r4d3XMMX80JyDTIH3VnUkTtXm4qqUyN0ZsCNnsBmv9W
 EAvBMyk0tLaIvOKg7dsaMKHugzy/KCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-DDb3V0aEN-a1VCb2XGQmJg-1; Mon, 09 Nov 2020 12:38:52 -0500
X-MC-Unique: DDb3V0aEN-a1VCb2XGQmJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 275795F9CB;
 Mon,  9 Nov 2020 17:38:51 +0000 (UTC)
Received: from localhost (ovpn-113-179.ams2.redhat.com [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE96E1002391;
 Mon,  9 Nov 2020 17:38:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/15] hw/block/nvme: fix null ns in register namespace
Date: Mon,  9 Nov 2020 18:38:28 +0100
Message-Id: <20201109173839.2135984-5-mreitz@redhat.com>
In-Reply-To: <20201109173839.2135984-1-mreitz@redhat.com>
References: <20201109173839.2135984-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Klaus Jensen <k.jensen@samsung.com>

Fix dereference after NULL check.

Reported-by: Coverity (CID 1436128)
Fixes: b20804946bce ("hw/block/nvme: update nsid when registered")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Message-Id: <20201104102248.32168-2-its@irrelevant.dk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 hw/block/nvme.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index fa2cba744b..080d782f1c 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -2562,8 +2562,7 @@ int nvme_register_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error **errp)
 
     if (!nsid) {
         for (int i = 1; i <= n->num_namespaces; i++) {
-            NvmeNamespace *ns = nvme_ns(n, i);
-            if (!ns) {
+            if (!nvme_ns(n, i)) {
                 nsid = ns->params.nsid = i;
                 break;
             }
-- 
2.28.0


