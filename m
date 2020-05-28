Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B06C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4EB2088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 11:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bex/newZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4EB2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeGVJ-0001dG-DK
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 07:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLR-0005ug-T7
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:05:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39547
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jeGLF-0006kN-Sq
 for qemu-devel@nongnu.org; Thu, 28 May 2020 07:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590663893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+CXXh5pkicxbYmi19dREXQYrShpoktzDD+TxIdSpEA=;
 b=Bex/newZGBvAFyWYcJfOIF6v89cs394EjSEIOFWQ3Ohr9Objrl6gydcrwFSQA5Atu18VLL
 Q09NoGxYSF0v3cPMJxaaOjDZq4sNnl374jr+m7pqLIuuHGb5gGuLPWkKqvOJj9bDKyaWAU
 /T6bv+x9H3WhpW7PXDRlgCt00nonpfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-k269-Bk-NACYrCnRKoiH_A-1; Thu, 28 May 2020 07:04:49 -0400
X-MC-Unique: k269-Bk-NACYrCnRKoiH_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3824C835B44;
 Thu, 28 May 2020 11:04:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00F8F60C05;
 Thu, 28 May 2020 11:04:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6B0811358C2; Thu, 28 May 2020 13:04:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/24] macio: Delete unused "macio-gpio" devices
Date: Thu, 28 May 2020 13:04:30 +0200
Message-Id: <20200528110444.20456-11-armbru@redhat.com>
In-Reply-To: <20200528110444.20456-1-armbru@redhat.com>
References: <20200528110444.20456-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These devices go with the "via-pmu" device, which is controlled by
property "has-pmu".  macio_newworld_init() creates it unconditionally,
because the property has not been set then.  macio_newworld_realize()
realizes it only when the property is true.  Works, although it can
leave an unrealized device hanging around in the QOM composition tree.
Affects machine mac99 with via=cuda (default).

Delete the unused device by making macio_newworld_realize() unparent
it.  Visible in "info qom-tree":

     /machine (mac99-machine)
       [...]
       /unattached (container)
         /device[9] (macio-newworld)
           [...]
           /escc-legacy-port[8] (qemu:memory-region)
           /escc-legacy-port[9] (qemu:memory-region)
           /escc-legacy[0] (qemu:memory-region)
    -      /gpio (macio-gpio)
    -        /gpio[0] (qemu:memory-region)
           /ide[0] (macio-ide)
             /ide.0 (IDE)
             /pmac-ide[0] (qemu:memory-region)

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/misc/macio/macio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 3779865ab2..b3dddf8be7 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -368,6 +368,8 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
         memory_region_add_subregion(&s->bar, 0x16000,
                                     sysbus_mmio_get_region(sysbus_dev, 0));
     } else {
+        object_unparent(OBJECT(&ns->gpio));
+
         /* CUDA */
         object_initialize_child(OBJECT(s), "cuda", &s->cuda, sizeof(s->cuda),
                                 TYPE_CUDA, &error_abort, NULL);
-- 
2.21.3


