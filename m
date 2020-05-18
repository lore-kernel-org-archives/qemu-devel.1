Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D829C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E4B20715
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 05:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsBMqItI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E4B20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaYCu-000841-85
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 01:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaYBs-0006E4-3a
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:19:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24638
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jaYBr-0007IZ-1y
 for qemu-devel@nongnu.org; Mon, 18 May 2020 01:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589779190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rW3lzp5teMyOOF8llXJU1AeolVT1AcaWTvY7gDedRfo=;
 b=PsBMqItIfJtKnIRtBCgnyL1bz89G83Nn9Q/6gXUTZgrEgq4TXOgw0HTMUMHaMcxXVqZJyd
 6NdSRydfMDdZ1qVUHsV2X7UkeIRg5G6eYHrE8Xf4X/hDEhB7VkJuZtIHn1HrN+JH1rFeHm
 lewvnEXYMc+ydnOSiRv97j5jJ2T6h1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-GvDnmRLzO6qwtllefLXyxA-1; Mon, 18 May 2020 01:19:48 -0400
X-MC-Unique: GvDnmRLzO6qwtllefLXyxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2873880058A
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 05:19:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB7C71A922;
 Mon, 18 May 2020 05:19:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 675C011358C0; Mon, 18 May 2020 07:19:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH not-for-merge 4/5] qdev: Instrument to detect missed QOM
 parenting
Date: Mon, 18 May 2020 07:19:44 +0200
Message-Id: <20200518051945.8621-5-armbru@redhat.com>
In-Reply-To: <20200518051945.8621-1-armbru@redhat.com>
References: <20200518051945.8621-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qdev-monitor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 07f78e9f5d..ec4e134ff7 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -801,6 +801,10 @@ static void qbus_print(Monitor *mon, BusState *bus, int indent)
         struct qbus_child *qc = children->data;
         DeviceState *dev = qc->dev;
         GSList *next = children->next;
+        if (!qc->qom_path) {
+            printf("### no qom path: %s, id \"%s\"\n",
+                   object_get_typename(OBJECT(dev)), dev->id ? dev->id : "");
+        }
         qdev_print(mon, dev, indent);
         g_free(qc->qom_path);
         g_free(qc);
-- 
2.21.1


