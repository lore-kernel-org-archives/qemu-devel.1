Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C67C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDF82072B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 16:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVBdLy7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDF82072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isUyN-0001Ii-JK
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 11:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isUx0-0008Eq-0D
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isUww-0007F5-5c
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:58:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28684
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isUww-0007EL-2F
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 11:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579280301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HoBwyrBj1MLgahqtH2/VXG8dOlADdkk3kGx+vLp2cEk=;
 b=PVBdLy7f7vrD4noy03IYxYxrs5HmqZqjWiKw2qw6ck+a/RgACA8O0QgIIKgv9xM+yXsouH
 Eo2ZHzZwUNItdT31D67HtUduI8yZLYR0neuvwsRb/gbM746CsOWveAbLNxpSE2IdchkXI0
 E+nxFwcT3MbSWvm8VN/837+jrj+a964=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-NIuhZRgwOGuQYPKsNmTbDA-1; Fri, 17 Jan 2020 11:58:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D46C1DB61;
 Fri, 17 Jan 2020 16:58:16 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-206-6.brq.redhat.com [10.40.206.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6882A5D9CD;
 Fri, 17 Jan 2020 16:58:12 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Subject: [PATCH v3 0/2] hw/timer/m48t59: Convert to trace events
Date: Fri, 17 Jan 2020 17:58:07 +0100
Message-Id: <20200117165809.31067-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: NIuhZRgwOGuQYPKsNmTbDA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Another trivial cleanup series.

v2: Rebased on 4.2

Philippe Mathieu-Daud=C3=A9 (2):
  MAINTAINERS: Add missing m48t59 files to the PReP section
  hw/timer/m48t59: Convert debug printf()s to trace events

 hw/rtc/m48t59-internal.h |  5 -----
 hw/rtc/m48t59.c          | 11 +++++------
 MAINTAINERS              |  2 ++
 hw/rtc/trace-events      |  6 ++++++
 4 files changed, 13 insertions(+), 11 deletions(-)

--=20
2.21.1


