Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01BBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6F521532
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGoWXYXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6F521532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jld1N-000251-Es
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwh-0003Yh-Sv
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:37:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwb-00088s-M4
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592419072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=55XnaJMZrBbinRSTa75FWtgEUUHQumqsDcF1mvx8mq8=;
 b=eGoWXYXCtgbYGW6dv17T1lcijgwh23Vrbk2+jJUH1z5zf+znOCITjkDVOB6nRp8+Wl044w
 a1yaTr36btK5vfRI6BPugPh6ZNIAAVWFb/3WZQSIkViVkU8ka1i6YFVD2u8eIFz5Sy2J6r
 8FM7nmKAuARoocga21nTg0SZ9Nx3QOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-RxTsZe1uOri5tfzHtuAiiQ-1; Wed, 17 Jun 2020 14:37:48 -0400
X-MC-Unique: RxTsZe1uOri5tfzHtuAiiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1C8218FE863;
 Wed, 17 Jun 2020 18:37:46 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-115-47.ams2.redhat.com
 [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A81F768B4;
 Wed, 17 Jun 2020 18:37:45 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, lvivier@redhat.com,
 maozhongyi@cmss.chinamobile.com, mreitz@redhat.com, pannengyuan@huawei.com
Subject: [PULL 02/12] qom-hmp-cmds: fix a memleak in hmp_qom_get
Date: Wed, 17 Jun 2020 19:37:23 +0100
Message-Id: <20200617183733.186168-3-dgilbert@redhat.com>
In-Reply-To: <20200617183733.186168-1-dgilbert@redhat.com>
References: <20200617183733.186168-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

'obj' forgot to free at the end of hmp_qom_get(). Fix that.

The leak stack:
Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f4e3a779ae8 in __interceptor_malloc (/lib64/libasan.so.5+0xefae8)
    #1 0x7f4e398f91d5 in g_malloc (/lib64/libglib-2.0.so.0+0x531d5)
    #2 0x55c9fd9a3999 in qstring_from_substr /build/qemu/src/qobject/qstring.c:45
    #3 0x55c9fd894bd3 in qobject_output_type_str /build/qemu/src/qapi/qobject-output-visitor.c:175
    #4 0x55c9fd894bd3 in qobject_output_type_str /build/qemu/src/qapi/qobject-output-visitor.c:168
    #5 0x55c9fd88b34d in visit_type_str /build/qemu/src/qapi/qapi-visit-core.c:308
    #6 0x55c9fd59aa6b in property_get_str /build/qemu/src/qom/object.c:2064
    #7 0x55c9fd5adb8a in object_property_get_qobject /build/qemu/src/qom/qom-qobject.c:38
    #8 0x55c9fd4a029d in hmp_qom_get /build/qemu/src/qom/qom-hmp-cmds.c:66

Fixes: 89cf4fe34f4
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200603070338.7922-1-pannengyuan@huawei.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Tested-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 qom/qom-hmp-cmds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index 99385b6ad2..158e2d7409 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -71,6 +71,7 @@ void hmp_qom_get(Monitor *mon, const QDict *qdict)
         qobject_unref(str);
     }
 
+    qobject_unref(obj);
     hmp_handle_error(mon, err);
 }
 
-- 
2.26.2


