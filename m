Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAB3C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4758220705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPjmIh1t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4758220705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBpS-0004oC-HQ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ipBmf-0001Bp-Rz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ipBme-0002gF-QC
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:54:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ipBme-0002fh-ME
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578491643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H1BpjYKxdyjmi9UNsT7FFDo7zf3ijgwzXYue6hEE/z8=;
 b=SPjmIh1tWH7dddLntkehKoV7mgxo2rDOscwOYskOcxpj/Dph/EN4IHvN7hbEaxcc9PhsQM
 ya8UdOI8KDVP1ddE39ahOUgk2kAkYQyyrVIWqovMtYuJCImo9X7akuvaP1mRMFho5wn38g
 I0MEMF1pQeL3vLZ2x/iUlUEYxXgClpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-j2RF7CDpMVC9ECsWhQdggg-1; Wed, 08 Jan 2020 08:54:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5CA3800D50
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 13:54:01 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D72A310013A7;
 Wed,  8 Jan 2020 13:54:00 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, vkuznets@redhat.com, mst@redhat.com,
 jasowang@redhat.com
Subject: [PATCH 2/2] hyperv/synic: Allocate as ram_device
Date: Wed,  8 Jan 2020 13:53:53 +0000
Message-Id: <20200108135353.75471-3-dgilbert@redhat.com>
In-Reply-To: <20200108135353.75471-1-dgilbert@redhat.com>
References: <20200108135353.75471-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: j2RF7CDpMVC9ECsWhQdggg-1
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

Mark the synic pages as ram_device so that they won't be visible
to vhost.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/hyperv/hyperv.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index da8ce82725..4de3ec411d 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -95,12 +95,14 @@ static void synic_realize(DeviceState *dev, Error **err=
p)
     msgp_name =3D g_strdup_printf("synic-%u-msg-page", vp_index);
     eventp_name =3D g_strdup_printf("synic-%u-event-page", vp_index);
=20
-    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_name,
-                           sizeof(*synic->msg_page), &error_abort);
-    memory_region_init_ram(&synic->event_page_mr, obj, eventp_name,
-                           sizeof(*synic->event_page), &error_abort);
-    synic->msg_page =3D memory_region_get_ram_ptr(&synic->msg_page_mr);
-    synic->event_page =3D memory_region_get_ram_ptr(&synic->event_page_mr)=
;
+    synic->msg_page =3D qemu_memalign(qemu_real_host_page_size,
+                                    sizeof(*synic->msg_page));
+    synic->event_page =3D qemu_memalign(qemu_real_host_page_size,
+                                      sizeof(*synic->event_page));
+    memory_region_init_ram_device_ptr(&synic->msg_page_mr, obj, msgp_name,
+                           sizeof(*synic->msg_page), synic->msg_page);
+    memory_region_init_ram_device_ptr(&synic->event_page_mr, obj, eventp_n=
ame,
+                           sizeof(*synic->event_page), synic->event_page);
=20
     g_free(msgp_name);
     g_free(eventp_name);
--=20
2.24.1


