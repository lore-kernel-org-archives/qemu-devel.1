Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4096C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C882073A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dC5tWEIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C882073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFl8-0001tg-1w
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRFjn-0000De-La
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jRFji-00088f-D1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:48:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jRFjh-00084F-Tt
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587563300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMenhwkXU3W7qk+WShZLNVc7ADewiurDzFW6wwCy6vU=;
 b=dC5tWEIgHCO7YZ602Yzgo8/7W+Q3BYdbaGrbZc89Yvsln9yTmH57KNG5vVUcU3AwtxgeYd
 ehascRJc8xj/OFHL+7AWjIWxpkehHDXdmPshxEtq0tx8VOZrRq07XCVtn5TLwx+amwcyyI
 dPIDuuoKktQyQMv0NS8Wk5QGGJcjOro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Ozl7pB1pNPSY3WNVJhrVYw-1; Wed, 22 Apr 2020 09:48:19 -0400
X-MC-Unique: Ozl7pB1pNPSY3WNVJhrVYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D606D81CBE1;
 Wed, 22 Apr 2020 13:48:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69AC16084A;
 Wed, 22 Apr 2020 13:48:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E0A8D11358C0; Wed, 22 Apr 2020 15:48:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] smbus: Fix spd_data_generate() for number of banks > 2
Date: Wed, 22 Apr 2020 15:48:15 +0200
Message-Id: <20200422134815.1584-5-armbru@redhat.com>
In-Reply-To: <20200422134815.1584-1-armbru@redhat.com>
References: <20200422134815.1584-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:12:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org
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


