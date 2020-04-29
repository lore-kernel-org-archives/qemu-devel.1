Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7616C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A732082E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhUBFYgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A732082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnL1-0008SK-MO
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGc-0002GE-SG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTnGA-0003rt-Tu
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20564
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTnGA-0003q9-Al
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588168821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kIA+ZY/aP5q6VvWDCeDsaYYp8cEiw2KsP3HhLwBiwSw=;
 b=AhUBFYgXYdfxkgb01j7uyQ64XlEIQb2vhosKTflcWEYuzbSir2tW0mlJYpan+jBGzvg22U
 DfJ0djLEZbn70syVzg2n5zwhQ1QuLz/MPEIWvYrG50z4l2wuBT51g1itg0+1OWBZUSjhFL
 VzPRX7ctaDFXBv+XgNjj9KKT1VNnbiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-NoZAwNugMJWCa5KprF-WFg-1; Wed, 29 Apr 2020 10:00:17 -0400
X-MC-Unique: NoZAwNugMJWCa5KprF-WFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49112100A61F;
 Wed, 29 Apr 2020 14:00:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D7405C221;
 Wed, 29 Apr 2020 14:00:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 280F09D99; Wed, 29 Apr 2020 16:00:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/15] move 'typedef Aml' to qemu/types.h
Date: Wed, 29 Apr 2020 15:59:49 +0200
Message-Id: <20200429140003.7336-2-kraxel@redhat.com>
In-Reply-To: <20200429140003.7336-1-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/aml-build.h | 1 -
 include/qemu/typedefs.h     | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 0f4ed53d7fbf..1539fe066714 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -33,7 +33,6 @@ struct Aml {
     uint8_t op;
     AmlBlockFlags block_flags;
 };
-typedef struct Aml Aml;
=20
 typedef enum {
     AML_COMPATIBILITY =3D 0,
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 375770a80f06..ecf3cde26c3c 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -24,6 +24,7 @@
 typedef struct AdapterInfo AdapterInfo;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
+typedef struct Aml Aml;
 typedef struct AnnounceTimer AnnounceTimer;
 typedef struct BdrvDirtyBitmap BdrvDirtyBitmap;
 typedef struct BdrvDirtyBitmapIter BdrvDirtyBitmapIter;
--=20
2.18.2


