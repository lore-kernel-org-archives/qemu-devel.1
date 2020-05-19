Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AB3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AE0207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCq4U02t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AE0207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3iw-0001On-Cv
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ex-000122-EP
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:55:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52428
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ew-0003SQ-7N
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdEJOcUuEFaDh3ExuSna5m/KTh5+VqIGhh/AdokbZIU=;
 b=CCq4U02tfvHABX7rRnqr0tzCrCAcVcPSjJQrnRBM2CzShqFC4Lgmh6wW7U7cZAyisNmJP4
 SkiCjScPBiY9zgIYVvAVsJXoYOwkic8ckGKnAme1pj/cFn9+nt18d5NZMn54bQDMWnsJAD
 iGFfCw4LQGu2kkumtaa/NDSStDys9zE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-l_W_q77fP0en3Ti32who-Q-1; Tue, 19 May 2020 10:55:54 -0400
X-MC-Unique: l_W_q77fP0en3Ti32who-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66060107ACF4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:55:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 342FE3A2;
 Tue, 19 May 2020 14:55:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B568B11358BE; Tue, 19 May 2020 16:55:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/55] qdev: Drop redundant bus realization
Date: Tue, 19 May 2020 16:54:58 +0200
Message-Id: <20200519145551.22836-3-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 09:19:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Realizing a device automatically realizes its buses, in
device_set_realized().  Realizing them in realize methods is
redundant, unless the methods themselves require them to be realized
early.  None do.  Drop the redundant bus realiziations.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/pci-host/prep.c      | 1 -
 hw/pci-host/versatile.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 1a02e9a670..c821ef889d 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -268,7 +268,6 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     memory_region_add_subregion(address_space_mem, 0xbffffff0, &s->pci_intack);
 
     /* TODO Remove once realize propagates to child devices. */
-    object_property_set_bool(OBJECT(&s->pci_bus), true, "realized", errp);
     object_property_set_bool(OBJECT(&s->pci_dev), true, "realized", errp);
 }
 
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index cfb9a78ea6..28817dbeec 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -458,7 +458,6 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
     }
 
     /* TODO Remove once realize propagates to child devices. */
-    object_property_set_bool(OBJECT(&s->pci_bus), true, "realized", errp);
     object_property_set_bool(OBJECT(&s->pci_dev), true, "realized", errp);
 }
 
-- 
2.21.1


