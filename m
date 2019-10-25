Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8547CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617DC2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0McuKOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617DC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxO3-0005EV-4N
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNxLX-0001p8-5R
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNxLT-0001HM-8p
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:01:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27921
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNxLT-0001H1-4p
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572001286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rvofbdMsFiHSbSYh1z33bgI9FevJ8vBhIJ+juY/w+lM=;
 b=F0McuKOH7n2cWwRyty4Pk8tjn+QB0zlwrorCToZEaw/L/8JNKui/mbyM6jYF4RWLv3RvPs
 fjuVg5vbvEzRoVkjFCHnVXfnw1s1g522ptmgJ4UIDo9zp5pzSDS3T0O2hw6o6ngsK2WMMN
 D6bvvaujHdJKIPPU0925Jwni8Q4cOe8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-O7acdi-6N66U8aNpq7JQ3w-1; Fri, 25 Oct 2019 07:01:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F0FD801E70;
 Fri, 25 Oct 2019 11:01:21 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ACE65D9CA;
 Fri, 25 Oct 2019 11:01:16 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org,
 KONRAD Frederic <frederic.konrad@adacore.com>
Subject: [PATCH 0/2] hw/sparc/leon3: Fixes for the AHB/APB bridge
Date: Fri, 25 Oct 2019 13:01:12 +0200
Message-Id: <20191025110114.27091-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: O7acdi-6N66U8aNpq7JQ3w-1
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jiri Gaisler <jiri@gaisler.se>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two trivial fixes after reading Jiri comment:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg654994.html

  "The plug&play area must support byte accesses,
  which is used by the RTEMS grlib scanning functions..."

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (2):
  hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP registers
  hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses

 hw/misc/grlib_ahb_apb_pnp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--=20
2.21.0


