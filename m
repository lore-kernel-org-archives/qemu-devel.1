Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BCEC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5210F20735
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtD3I0zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5210F20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWVB-0000yp-AG
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59626 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQWTV-0007Sw-J0
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:38 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jQWTT-0002uw-I4
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48424
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jQWTT-0002sA-5U
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 09:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587389314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMenhwkXU3W7qk+WShZLNVc7ADewiurDzFW6wwCy6vU=;
 b=VtD3I0zb6pdfVj6Cp5io0ejJvZ4zZSXX/usj7QBISWS+LscYA0eZPeuCyZpA6mJu6a12tJ
 XheCWtgeySCx/3ddFqy3AcOEQkUVAn0sIVyaphD2vHYvQWk0W2YH6AxScdw7rAm7DlwEby
 XsVQeu3wspa0u5210RyBcMb4WieWPZQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-hYc81HP3MCugVcw2KD_F5w-1; Mon, 20 Apr 2020 09:28:30 -0400
X-MC-Unique: hYc81HP3MCugVcw2KD_F5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 893CF802569;
 Mon, 20 Apr 2020 13:28:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48DE360C99;
 Mon, 20 Apr 2020 13:28:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 266EC11358C0; Mon, 20 Apr 2020 15:28:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] smbus: Fix spd_data_generate() for number of banks > 2
Date: Mon, 20 Apr 2020 15:28:26 +0200
Message-Id: <20200420132826.8879-5-armbru@redhat.com>
In-Reply-To: <20200420132826.8879-1-armbru@redhat.com>
References: <20200420132826.8879-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:32:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

spd_data_generate() splits @ram_size bytes into @nbanks RAM banks of
1 << sz_log2 MiB each, like this:

    size =3D ram_size >> 20; /* work in terms of megabytes */
    [...]
    nbanks =3D 1;
    while (sz_log2 > max_log2 && nbanks < 8) {
        sz_log2--;
        nbanks++;
    }

Each iteration halves the size of a bank, and increments the number of
banks.  Wrong: it should double the number of banks.

The bug goes back all the way to commit b296b664ab "smbus: Add a
helper to generate SPD EEPROM data".

It can't bite because spd_data_generate()'s current users pass only
@ram_size that result in *zero* iterations:

    machine     RAM size    #banks  type    bank size
    fulong2e     256 MiB         1   DDR      256 MiB
    sam460ex    2048 MiB         1   DDR2    2048 MiB
                1024 MiB         1   DDR2    1024 MiB
                 512 MiB         1   DDR2     512 MiB
                 256 MiB         1   DDR2     256 MiB
                 128 MiB         1   SDR      128 MiB
                  64 MiB         1   SDR       64 MiB
                  32 MiB         1   SDR       32 MiB

Apply the obvious, minimal fix.  I admit I'm tempted to rip out the
unused (and obviously untested) feature instead, because YAGNI.

Note that this is not the final result, as spd_data_generate() next
increases #banks from 1 to 2 if possible.  This is done "to avoid a
bug in MIPS Malta firmware".  We don't even use this function with
machine type malta.  *Shrug*

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i2c/smbus_eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 07fbbf87f1..e199fc8678 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -229,7 +229,7 @@ uint8_t *spd_data_generate(enum sdram_type type, ram_ad=
dr_t ram_size)
     nbanks =3D 1;
     while (sz_log2 > max_log2 && nbanks < 8) {
         sz_log2--;
-        nbanks++;
+        nbanks *=3D 2;
     }
=20
     assert(size =3D=3D (1ULL << sz_log2) * nbanks);
--=20
2.21.1


