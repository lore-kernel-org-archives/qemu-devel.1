Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207FFC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF297246AF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WamxfPHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF297246AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7epy-0002sj-SR
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7epM-00029S-3g
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7epK-00042n-Tf
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:33:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48855
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7epK-00042G-Qc
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582893190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vm+aNNOWd75exghh6UEIZXw8DMFqqm4EGT73R+r5OW0=;
 b=WamxfPHHvCuiE4yuNAualwQAzzyqm3kV79r9fAD9IazfiZKIavv2IbihBRmfUU9ZIawecT
 gqUBNv4PB3mQKPOFuv6DWCEy6jA6wvkw+q9Jc5MP7k/dtzNpu7R5IeTXruhZnkH+YKmzyS
 3vPdh4lG3QxY6fhAt2luJ5D7dJu4kP0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-XBZPDc4bMGKRMmCmqsQ-qA-1; Fri, 28 Feb 2020 07:33:08 -0500
X-MC-Unique: XBZPDc4bMGKRMmCmqsQ-qA-1
Received: by mail-wr1-f72.google.com with SMTP id o9so1268570wrw.14
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 04:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rhr6+r2tfY9AQJ5VKaVuxzDS32T1jjUavdB/SnDaCLY=;
 b=jpkRmzUNfeGdFrqdV0mLL2PO/Yo5MNktrUAFIOgCUkPDZGuun5R5ymWZzaV5W2MOVa
 Nu12bczHq5VD/0b742LRCOPiCuUskB2Xz8DsRd2VmsFX9hEozz9oecWquVZISWiK3lpi
 SI25U5urt8bG8B1XgZt1bUCAgB6ENY4FBQVvuhMsktBzfyJa4H9Tgcx7spoqTZr55ASf
 9F4oFwA5v8jBVw0UnmiRr6ON7RojeedXd00KrLblWukqBnEFI4MPQ47dwpjpkgZL5QCT
 8xjuhJFL+5ep6RaGuzSoEOIBuVPpoxCpYNxvhS54uiBrgl/AcSAYrOR2ak+zhfvBF5Tj
 pcBQ==
X-Gm-Message-State: APjAAAX7TDkdtFTZRWGVN6qK7aNfULseFUaFRcEHRA0hlZuhKedR7xme
 s+YE38bW1JUdi/Pp/bOgSiv0WI2USffAK08KqgZg9H8x9aSGOWgcXhHsa89y5tagZr4H80hlaa1
 czF9yE2iMtJ7k9J4=
X-Received: by 2002:a1c:9a13:: with SMTP id c19mr4584487wme.134.1582893186758; 
 Fri, 28 Feb 2020 04:33:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2Ef8TpQQT+Wdpy+qlrAYFnikp8Q+5VIeOArFBRmanDvK4L9Z6oFZXNDdcmwtW4ChwSCpy+w==
X-Received: by 2002:a1c:9a13:: with SMTP id c19mr4584460wme.134.1582893186460; 
 Fri, 28 Feb 2020 04:33:06 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id z16sm12054016wrp.33.2020.02.28.04.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 04:33:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/ppc/pnv: Fix typo in comment
Date: Fri, 28 Feb 2020 13:33:03 +0100
Message-Id: <20200228123303.14540-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/pnv_lpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index f150deca34..b5ffa48dac 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -829,7 +829,7 @@ ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool =
use_cpld, Error **errp)
     bool hostboot_mode =3D !!pnv->fw_load_addr;
=20
     /* let isa_bus_new() create its own bridge on SysBus otherwise
-     * devices speficied on the command line won't find the bus and
+     * devices specified on the command line won't find the bus and
      * will fail to create.
      */
     isa_bus =3D isa_bus_new(NULL, &lpc->isa_mem, &lpc->isa_io, &local_err)=
;
--=20
2.21.1


