Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD9C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:28:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46F02054F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT58RYbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46F02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWga6-0001r8-0f
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWgOh-0000qq-6c
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:17:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jWgOg-0005WV-Cb
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588857425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mpi92+9raoTumOXwOawLlzslHlS/jPYlqJNwqP3BnpI=;
 b=bT58RYbrmmbWLoQqGlofMor17CAwQeS9H1MFehB9EDxLsNHFAVsU9++ExucQN3LzXj3dWs
 Uez/1xfhThEzJXkoq2b45aWbtnxM1QLPZrMuQqvoHnT+19/lteUVnljTpyY1e6jmq+sslo
 2pUEAcl1E8F2WKw6Lcu85Ox5GzuNp6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-WAl_t3cKMTmYHadKbMYJqw-1; Thu, 07 May 2020 09:17:00 -0400
X-MC-Unique: WAl_t3cKMTmYHadKbMYJqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B0B91937FE3;
 Thu,  7 May 2020 13:16:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E74AC691F9;
 Thu,  7 May 2020 13:16:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E0AE79D56; Thu,  7 May 2020 15:16:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 15/15] floppy: make isa_fdc_get_drive_max_chs static
Date: Thu,  7 May 2020 15:16:40 +0200
Message-Id: <20200507131640.14041-16-kraxel@redhat.com>
In-Reply-To: <20200507131640.14041-1-kraxel@redhat.com>
References: <20200507131640.14041-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

acpi aml generator needs this, but it is in floppy code now
so we can make the function static.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/block/fdc.h | 2 --
 hw/block/fdc.c         | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/block/fdc.h b/include/hw/block/fdc.h
index c15ff4c62315..5d71cf972268 100644
--- a/include/hw/block/fdc.h
+++ b/include/hw/block/fdc.h
@@ -16,7 +16,5 @@ void sun4m_fdctrl_init(qemu_irq irq, hwaddr io_base,
                        DriveInfo **fds, qemu_irq *fdc_tc);
=20
 FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc, int i);
-void isa_fdc_get_drive_max_chs(FloppyDriveType type,
-                               uint8_t *maxc, uint8_t *maxh, uint8_t *maxs=
);
=20
 #endif
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 40faa088b5f7..499a580b993c 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2744,8 +2744,8 @@ FloppyDriveType isa_fdc_get_drive_type(ISADevice *fdc=
, int i)
     return isa->state.drives[i].drive;
 }
=20
-void isa_fdc_get_drive_max_chs(FloppyDriveType type,
-                               uint8_t *maxc, uint8_t *maxh, uint8_t *maxs=
)
+static void isa_fdc_get_drive_max_chs(FloppyDriveType type, uint8_t *maxc,
+                                      uint8_t *maxh, uint8_t *maxs)
 {
     const FDFormat *fdf;
=20
--=20
2.18.4


