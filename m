Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC6EC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899772068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZg+bMsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899772068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnRK-0007pc-SG
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMs-0007vU-Vm
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38835
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMr-0004N8-4m
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595319076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=tzrM6pnN/7PeCZJ74bnRF97Eq/He8Hc0iuUwDmInoQc=;
 b=iZg+bMsQy2eVSxD5vGPyaWl0jAUagvvBWhsFkqHPJj9F5sl/VZIJ5Xm2yVAJLo0lj84UDN
 QQsXDIu/fr5N96oHBwXEe2LyU4Qjw+a/AL/S4QBw5OqweyTC1hejNHgpGkWV1RRlPDhrBK
 DfnMfklsiA06ZVNWGcpZ3uLEkVagz+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-nCIEy559Nfq28o5WoIKdIQ-1; Tue, 21 Jul 2020 04:11:12 -0400
X-MC-Unique: nCIEy559Nfq28o5WoIKdIQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36DFC800468;
 Tue, 21 Jul 2020 08:11:11 +0000 (UTC)
Received: from thuth.com (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2ADE319C66;
 Tue, 21 Jul 2020 08:11:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 09/10] msf2: Unbreak device-list-properties for "msf-soc"
Date: Tue, 21 Jul 2020 10:10:54 +0200
Message-Id: <20200721081055.14073-10-thuth@redhat.com>
In-Reply-To: <20200721081055.14073-1-thuth@redhat.com>
References: <20200721081055.14073-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

Watch this:

    $ qemu-system-aarch64 -M ast2600-evb -S -display none -qmp stdio
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 5}, "package": "v5.0.0-2464-g3a9163af4e"}, "capabilities": ["oob"]}}
    {"execute": "qmp_capabilities"}
    {"return": {}}
    {"execute": "device-list-properties", "arguments": {"typename": "msf2-soc"}}
    Unsupported NIC model: ftgmac100
    armbru@dusky:~/work/images$ echo $?
    1

This is what breaks "make check SPEED=slow".

Root cause is m2sxxx_soc_initfn()'s messing with nd_table[] via
qemu_check_nic_model().  That's wrong.

We fixed the exact same bug for device "allwinner-a10" in commit
8aabc5437b "hw/arm/allwinner-a10: Do not use nd_table in instance_init
function".  Fix this instance the same way: move the offending code to
m2sxxx_soc_realize(), where it's less wrong, and add a FIXME comment.

Fixes: 05b7374a58 ("msf2: Add EMAC block to SmartFusion2 SoC")
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200715140440.3540942-2-armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/msf2-soc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 16bb7c9916..33ea7df342 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -82,10 +82,6 @@ static void m2sxxx_soc_initfn(Object *obj)
     }
 
     object_initialize_child(obj, "emac", &s->emac, TYPE_MSS_EMAC);
-    if (nd_table[0].used) {
-        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
-        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
-    }
 }
 
 static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -187,6 +183,11 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         g_free(bus_name);
     }
 
+    /* FIXME use qdev NIC properties instead of nd_table[] */
+    if (nd_table[0].used) {
+        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
+        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
+    }
     dev = DEVICE(&s->emac);
     object_property_set_link(OBJECT(&s->emac), "ahb-bus",
                              OBJECT(get_system_memory()), &error_abort);
-- 
2.18.1


