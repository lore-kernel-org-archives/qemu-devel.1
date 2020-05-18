Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0238C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755F820787
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eog3r7Uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755F820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabJ8-0003fy-Lm
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jabH4-0008Vr-3R
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:37:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24799
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jabH3-0006Xu-9g
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589791043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BuyBU6F/qSQZGXhO3qzRRG/AxoXyHH0RYIfHDEQfOEg=;
 b=Eog3r7UojvFAu9mOpu5mktrmmla98mj7R6efWMTTR8XoC9hnJsD09KrToK24shwxDM4aM+
 Emq1izg84uk3P2OLDSuPa1LDZ6ve8ZqiUKAZySb0SOD1vpvSUsDWCJu84hwT9zUdjwrfCE
 la9dYG1BBm8rFGs8GUSo96NzWdysevw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-yr4LLo6TMU27JyD7S5qd_g-1; Mon, 18 May 2020 04:37:20 -0400
X-MC-Unique: yr4LLo6TMU27JyD7S5qd_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1A811B2C9AC;
 Mon, 18 May 2020 08:37:19 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-224.ams2.redhat.com [10.36.113.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E80F5C1D6;
 Mon, 18 May 2020 08:37:18 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/3] virtio-balloon: unref the iothread when unrealizing
Date: Mon, 18 May 2020 10:37:04 +0200
Message-Id: <20200518083704.52646-4-david@redhat.com>
In-Reply-To: <20200518083704.52646-1-david@redhat.com>
References: <20200518083704.52646-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We took a reference when realizing, so let's drop that reference when
unrealizing.

Fixes: c13c4153f76d ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-balloon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4fcf2d777..3f8fc50be0 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -820,6 +820,7 @@ static void virtio_balloon_device_unrealize(DeviceState *dev)
 
     if (s->free_page_bh) {
         qemu_bh_delete(s->free_page_bh);
+        object_unref(OBJECT(s->iothread));
         virtio_balloon_free_page_stop(s);
         precopy_remove_notifier(&s->free_page_report_notify);
     }
-- 
2.25.4


