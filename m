Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDA2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5378207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDE8ot/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5378207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jidN0-00012O-6c
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jidIL-0003Og-99
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:23:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28552
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jidIG-0005Pw-OT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 08:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591705427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfCG/U6Fs8boUbgX3M42BSZudAfFQ+9Qi8hzPtIayDg=;
 b=fDE8ot/yV6DBFrZyIG8DKdWaTWDANmDwCBaTzP8KbcryQCF3zraY1S83AFrGrdL1xCR2mi
 YULivLoBH50pfOMRVRW6DiVGSzmX5zXGZXAKrPjGiQGyqHBtXOTGi5yOn3Lti+1iY9YuA2
 4v56eduV1cZMKPjgqMEVzN1Y4l4ybdc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-2SNYzUVdNFyXE4psangX0Q-1; Tue, 09 Jun 2020 08:23:45 -0400
X-MC-Unique: 2SNYzUVdNFyXE4psangX0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 022B2A0BD7;
 Tue,  9 Jun 2020 12:23:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0D3A2B4D7;
 Tue,  9 Jun 2020 12:23:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BC8F1138460; Tue,  9 Jun 2020 14:23:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 11/24] pnv/phb4: Delete unused "pnv-phb4-pec-stack" devices
Date: Tue,  9 Jun 2020 14:23:26 +0200
Message-Id: <20200609122339.937862-12-armbru@redhat.com>
In-Reply-To: <20200609122339.937862-1-armbru@redhat.com>
References: <20200609122339.937862-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001, URIBL_SBL=1.623,
 URIBL_SBL_A=0.1 autolearn=_AUTOLEARN
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
2.26.2


