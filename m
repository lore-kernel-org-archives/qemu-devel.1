Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E2CCA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 11:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6632080F
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 11:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gqz+IilC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6632080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQrqI-0001ke-0J
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 07:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iQrpA-000117-FR
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 07:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iQrp7-0004Kl-A6
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 07:44:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54515
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iQrp6-0004I2-Vj
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 07:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572695044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+1THuLuSw0xjQPjCO5YWe8AoN+US1aCmSHR/MVwMob0=;
 b=Gqz+IilCzxY2d1aYIAkMeenQHrvCwLw/7YrPeg7dM3Dtxdf+UEkGlVtwzKkG7ObWnhRjIX
 /10LqpjXxQEgSSnCZfWPwZlLklcserX1KtXtDN8Q4VRB1Ih/NoUT32NQNKmW3DxAmWh12L
 caEf/EccpMD/EdoRxIHyVkZ56RpXelo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-JnDCX2CQOBaWxlZILnh34Q-1; Sat, 02 Nov 2019 07:44:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BB661800DFD;
 Sat,  2 Nov 2019 11:43:59 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-63.brq.redhat.com [10.40.204.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BBB35D9CD;
 Sat,  2 Nov 2019 11:43:49 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Sergio Lopez <slp@redhat.com>
Subject: [PATCH] Makefile: install bios-microvm like other binary blobs
Date: Sat,  2 Nov 2019 12:43:46 +0100
Message-Id: <20191102114346.6445-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: JnDCX2CQOBaWxlZILnh34Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-trivial@nongnu.org, Bruce Rogers <brogers@suse.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bruce Rogers <brogers@suse.com>

Commit 0d5fae3e52e introduced bios-microvm.bin but forgot to add
it to the list of blobs being installed.
Add it to the list of BLOBS that get installed.

Fixes: 0d5fae3e52e "roms: add microvm-bios (qboot) as binary"
Signed-off-by: Bruce Rogers <brogers@suse.com>
[PMD: Reworded description]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bd6376d295..755aa6c5f5 100644
--- a/Makefile
+++ b/Makefile
@@ -770,7 +770,7 @@ de-ch  es     fo  fr-ca  hu     ja  mk  pt  sl     tr \
 bepo    cz
=20
 ifdef INSTALL_BLOBS
-BLOBS=3Dbios.bin bios-256k.bin sgabios.bin vgabios.bin vgabios-cirrus.bin =
\
+BLOBS=3Dbios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin vg=
abios-cirrus.bin \
 vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
 vgabios-ramfb.bin vgabios-bochs-display.bin vgabios-ati.bin \
 ppc_rom.bin openbios-sparc32 openbios-sparc64 openbios-ppc QEMU,tcx.bin QE=
MU,cgthree.bin \
--=20
2.21.0


