Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53205C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1859120B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWuWbLdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1859120B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWVk-0001oV-5v
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59622 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQWTV-0007Sv-Hj
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:37 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQWTT-0002uS-Dk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43393
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQWTT-0002s6-14
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587389314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBvMs/dXtPNm3i2AJLw+p31L6gqvU7ODiUZUb2RuKsg=;
 b=iWuWbLdhf4uLHs+gDy/PxZTEdEFypsGPKTDilVx1pimQQRr3smUXPBuokxRl4zk/GGfIUm
 jSmUJo6NsFuxMdZSyx0wY5JkOUV14mSqUaVYCg9yp183kaKcnazKlEKaYw1bDtKhB07Ma8
 +dBovXMsmOCIqr1a5WjxgEHKbyxl+R8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-y_aUdheiPiOYg5H9NK48Aw-1; Mon, 20 Apr 2020 09:28:30 -0400
X-MC-Unique: y_aUdheiPiOYg5H9NK48Aw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89BE318B9FD8;
 Mon, 20 Apr 2020 13:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48E723A0;
 Mon, 20 Apr 2020 13:28:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 232B911358BF; Mon, 20 Apr 2020 15:28:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] bamboo,
 sam460ex: Tidy up error message for unsupported RAM size
Date: Mon, 20 Apr 2020 15:28:25 +0200
Message-Id: <20200420132826.8879-4-armbru@redhat.com>
In-Reply-To: <20200420132826.8879-1-armbru@redhat.com>
References: <20200420132826.8879-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 09:01:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve

    $ ppc-softmmu/qemu-system-ppc -M sam460ex -m 4096
    qemu-system-ppc: Max 1 banks of 2048 ,1024 ,512 ,256 ,128 ,64 ,32 MB DI=
MM/bank supported
    qemu-system-ppc: Possible valid RAM size: 2048

to

    qemu-system-ppc: Max 1 banks of 2048, 1024, 512, 256, 128, 64, 32 MB DI=
MM/bank supported
    Possible valid RAM size: 2048

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ppc/ppc4xx_devs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 3376c43ff5..dea39546ad 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -716,11 +716,11 @@ void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_ban=
ks,
         for (i =3D 0; sdram_bank_sizes[i]; i++) {
             g_string_append_printf(s, "%" PRIi64 "%s",
                                    sdram_bank_sizes[i] / MiB,
-                                   sdram_bank_sizes[i + 1] ? " ," : "");
+                                   sdram_bank_sizes[i + 1] ? ", " : "");
         }
         error_report("Max %d banks of %s MB DIMM/bank supported",
             nr_banks, s->str);
-        error_report("Possible valid RAM size: %" PRIi64,
+        error_printf("Possible valid RAM size: %" PRIi64 "\n",
             used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB);
=20
         g_string_free(s, true);
--=20
2.21.1


