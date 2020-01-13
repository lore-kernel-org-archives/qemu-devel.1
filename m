Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E92C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89FD8207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AM+K9xFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FD8207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3fb-0008Ub-6U
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ir3eA-0006ah-S1
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ir3e9-00026M-TS
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:37:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24704
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ir3e9-00025p-QA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578937021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97O01buc7glABGMtRrqiEagdNJtM8sbG5AB6H/GxU3s=;
 b=AM+K9xFUcz9dDpbarJ2rurAqnA6UglP1H2hUiJ4cRMVRMV8g0wXXavHcWPOlsnECTIxqyh
 x/zzOctWhY7/c0guqxShY7V75O0U3hHszqJcGG4E/OxBA6OMRA/NEG4jte6Pos0vgLGqUl
 HlrcxiwMS9qIMquXtimdc7uL+5UZSJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-SpHKGEKVOluJW7gPNqhoUQ-1; Mon, 13 Jan 2020 12:36:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5067210054E3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 17:36:57 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 282515C1B0;
 Mon, 13 Jan 2020 17:36:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com,
 jasowang@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 3/3] hyperv/synic: Mark regions as no vhost
Date: Mon, 13 Jan 2020 17:36:47 +0000
Message-Id: <20200113173647.84842-4-dgilbert@redhat.com>
In-Reply-To: <20200113173647.84842-1-dgilbert@redhat.com>
References: <20200113173647.84842-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: SpHKGEKVOluJW7gPNqhoUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Mark synic regions as novhost; they are splitting huge page memory
and breaking vhost region joining.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/hyperv/hyperv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index da8ce82725..5dbbb14fdd 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -99,6 +99,14 @@ static void synic_realize(DeviceState *dev, Error **errp=
)
                            sizeof(*synic->msg_page), &error_abort);
     memory_region_init_ram(&synic->event_page_mr, obj, eventp_name,
                            sizeof(*synic->event_page), &error_abort);
+    /*
+     * The guest can put the synic pages anywhere, including
+     * fragmenting something the host might want to keep as a huge
+     * page.
+     */
+    memory_region_set_no_vhost(&synic->msg_page_mr, true);
+    memory_region_set_no_vhost(&synic->event_page_mr, true);
+
     synic->msg_page =3D memory_region_get_ram_ptr(&synic->msg_page_mr);
     synic->event_page =3D memory_region_get_ram_ptr(&synic->event_page_mr)=
;
=20
--=20
2.24.1


