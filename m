Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3F1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 466C42088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBlndOJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466C42088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGQb-0000LL-En
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:10:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLH-0005kE-71
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:04:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35817
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLE-0006eu-8L
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590663891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=791xB3bIhnmA94pE0vzJpWoq5hrHM3MtEJgzlo62QlI=;
 b=bBlndOJoUmNHCCyi6qmfb65fcvb00SD5pKdrFC3Il7TRxz0ZxPM4+FkwgFyyvbWJ2jKJsH
 Gw48h8Ac6opU10U+90vN1QGjXlmRpN/etCQmVpq4isLP3jhfxGxaXpM9TD6qpo9bqUvg9K
 APb85zqTwdaN6O/WETdDPb3yYs4rxBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-ramdDYJwNvuPkzhJOfuYMg-1; Thu, 28 May 2020 07:04:49 -0400
X-MC-Unique: ramdDYJwNvuPkzhJOfuYMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6011E1855A0E;
 Thu, 28 May 2020 11:04:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C546768D0;
 Thu, 28 May 2020 11:04:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E052811358C3; Thu, 28 May 2020 13:04:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/24] pnv/phb4: Delete unused "pnv-phb4-pec-stack" devices
Date: Thu, 28 May 2020 13:04:31 +0200
Message-Id: <20200528110444.20456-12-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-1-armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: berrange@redhat.com, ehabkost@redhat.com, Greg Kurz <groug@kaod.org>,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The number of stacks is controlled by property "num-stacks".
pnv_pec_instance_init() creates the maximum supported number, because
the property has not been set then.  pnv_pec_realize() realizes only
the wanted number.  Works, although it can leave unrealized devices
hanging around in the QOM composition tree.  Affects machine powernv9.

Delete the unused devices by making pnv_pec_realize() unparent them.
Visible in "info qom-tree":

     /machine (powernv9-machine)
       /chip[0] (power9_v2.0-pnv-chip)
         [...]
         /pec[0] (pnv-phb4-pec)
           /stack[0] (pnv-phb4-pec-stack)
             [...]
    -      /stack[1] (pnv-phb4-pec-stack)
    -        /phb (pnv-phb4)
    -          /pcie-mmcfg-mmio[0] (qemu:memory-region)
    -          /root (pnv-phb4-root-port)
    -          /source (xive-source)
    -      /stack[2] (pnv-phb4-pec-stack)
    -        /phb (pnv-phb4)
    -          /pcie-mmcfg-mmio[0] (qemu:memory-region)
    -          /root (pnv-phb4-root-port)
    -          /source (xive-source)
           /xscom-pec-0.0-nest[0] (qemu:memory-region)
           /xscom-pec-0.0-pci[0] (qemu:memory-region)
         /pec[1] (pnv-phb4-pec)
           /stack[0] (pnv-phb4-pec-stack)
             [...]
           /stack[1] (pnv-phb4-pec-stack)
             [...]
    -      /stack[2] (pnv-phb4-pec-stack)
    -        /phb (pnv-phb4)
    -          /pcie-mmcfg-mmio[0] (qemu:memory-region)
    -          /root (pnv-phb4-root-port)
    -          /source (xive-source)
           /xscom-pec-0.1-nest[0] (qemu:memory-region)
           /xscom-pec-0.1-pci[0] (qemu:memory-region)
         /pec[2] (pnv-phb4-pec)
           /stack[0] (pnv-phb4-pec-stack)
             [...]
           /stack[1] (pnv-phb4-pec-stack)
             [...]
           /stack[2] (pnv-phb4-pec-stack)
             [...]

Cc: Cédric Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/pci-host/pnv_phb4_pec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 911d147ffd..565345a018 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -397,6 +397,9 @@ static void pnv_pec_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    for (; i < PHB4_PEC_MAX_STACKS; i++) {
+        object_unparent(OBJECT(&pec->stacks[i]));
+    }
 
     /* Initialize the XSCOM regions for the PEC registers */
     snprintf(name, sizeof(name), "xscom-pec-%d.%d-nest", pec->chip_id,
-- 
2.21.3


