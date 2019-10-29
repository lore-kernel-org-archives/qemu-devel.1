Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE6CA9EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47B620874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihsHaC+v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47B620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPUun-0005iO-IJ
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 13:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iPUsb-0003mo-NS
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iPUsZ-0003Dw-1u
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:02:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35231
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iPUsU-0003At-3R
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572368507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0a4BH9gUbIav4fABnbdERR8dcHSdQmMzznyms1aQJ1w=;
 b=ihsHaC+v0jjVqfWNhcgy5qno6ExwxYpF23z7VT314hruL5IZ1vpJUpKmsuykfp3icMSJzw
 Iw2jOXngTsX5CIpAu0XfmRT+prxT5wMI22hwF0zY2gp7KkYBVlrA0Zf4iUaU2DtJQCj1+F
 w8cuyJIAzsbKLfLPnVd02Lvfl7SNAxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-HMdWRbxtN1uMdxTSjofTfw-1; Tue, 29 Oct 2019 13:01:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F35DF800C80
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 17:01:40 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-125.brq.redhat.com [10.40.204.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D932600F6;
 Tue, 29 Oct 2019 17:01:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 0/2] fw_cfg: Allow reboot-timeout=-1 again
Date: Tue, 29 Oct 2019 18:01:22 +0100
Message-Id: <20191029170124.27981-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HMdWRbxtN1uMdxTSjofTfw-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix the '-1' special value, and add a test.

Dr. David Alan Gilbert (1):
  fw_cfg: Allow reboot-timeout=3D-1 again

Philippe Mathieu-Daud=C3=A9 (1):
  tests/fw_cfg: Test 'reboot-timeout=3D-1' special value

 hw/nvram/fw_cfg.c   |  7 ++++---
 tests/fw_cfg-test.c | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

--=20
2.21.0


