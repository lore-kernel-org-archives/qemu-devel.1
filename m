Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B54C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C852A22242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLouK8qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C852A22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2zX-0002XU-Ql
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2ue-0005fc-0k
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27007)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uS-0001ko-S4
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPxUYhuZYPqdosbp81eGIkzc/DVkbIO6pNmxyDkdDWo=;
 b=YLouK8qmD88AS14OfD8clwX9iRYIMwsy2/EpQ5oxP0lI9xUozPm5S3efkfb0Zf6FSFiRPc
 /m9xMvpumBL2ofJIr8PQHXdSTwYSw4sTFwPS2XkhiuznA9B2RYCNN7dGgDyAmX3fMlg0FK
 crh7j4ydURhjKn2U5RfjStUJfHUHMCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-iAnwHxncMDeFYr6YUYFX5Q-1; Mon, 26 Oct 2020 09:51:35 -0400
X-MC-Unique: iAnwHxncMDeFYr6YUYFX5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4319807342;
 Mon, 26 Oct 2020 13:51:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25B756EF78;
 Mon, 26 Oct 2020 13:51:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/17] hw/core/qdev-clock: add a reference on aliased clocks
Date: Mon, 26 Oct 2020 09:51:18 -0400
Message-Id: <20201026135131.3006712-5-pbonzini@redhat.com>
In-Reply-To: <20201026135131.3006712-1-pbonzini@redhat.com>
References: <20201026135131.3006712-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Luc Michel <luc@lmichel.fr>

When aliasing a clock with the qdev_alias_clock() function, a new link
property is created on the device aliasing the clock. The link points
to the aliased clock and use the OBJ_PROP_LINK_STRONG flag. This
property is read only since it does not provide a check callback for
modifications.

The object_property_add_link() documentation stats that with
OBJ_PROP_LINK_STRONG properties, the linked object reference count get
decremented when the property is deleted. But it is _not_ incremented on
creation (object_property_add_link() does not actually know the link).

This commit increments the reference count on the aliased clock to
ensure the aliased clock stays alive during the property lifetime, and
to avoid a double-free memory error when the property gets deleted.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Message-Id: <20201020091024.320381-1-luc@lmichel.fr>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev-clock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 6a9a340d0f..eb05f2a13c 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -61,6 +61,14 @@ static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
                                  object_get_typename(OBJECT(clk)),
                                  (Object **) &ncl->clock,
                                  NULL, OBJ_PROP_LINK_STRONG);
+        /*
+         * Since the link property has the OBJ_PROP_LINK_STRONG flag, the clk
+         * object reference count gets decremented on property deletion.
+         * However object_property_add_link does not increment it since it
+         * doesn't know the linked object. Increment it here to ensure the
+         * aliased clock stays alive during this device life-time.
+         */
+        object_ref(OBJECT(clk));
     }
 
     ncl->clock = clk;
-- 
2.26.2



