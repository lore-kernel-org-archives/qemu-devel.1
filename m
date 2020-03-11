Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F4C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D8B21D56
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiD4Ou8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D8B21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1t8-0001kX-0P
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1n1-0004B3-09
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1mz-0002cx-KB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55101
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1mz-0002bu-H8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+16saIOGAiKpnjUdMevgo7P8/ddL41+2kaIvsYz5qw=;
 b=EiD4Ou8JypCeNQKWlvEHnA1j+IAasdjgLOSAtM6G05wsxmbG2IbU1JBg2+BHCYhvfMFJjL
 5OfNTgzEI80aEmVJKCqXExDjesQ0oIyWuYcHhcIc6MfMB88F4rcug0TXvGFJNnlDuOieyb
 hGJToLpgDQG8L1dY1x6fXBLfXbmlU+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-tBtvgbpANuurfCcxXA3c1w-1; Wed, 11 Mar 2020 09:52:45 -0400
X-MC-Unique: tBtvgbpANuurfCcxXA3c1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8F0F8017CC;
 Wed, 11 Mar 2020 13:52:43 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F8BD5D9C5;
 Wed, 11 Mar 2020 13:52:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/19] qemu-img: free memory before re-assign
Date: Wed, 11 Mar 2020 14:52:03 +0100
Message-Id: <20200311135213.1242028-10-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

collect_image_check() is called twice in img_check(), the filename/format w=
ill be alloced without free the original memory.
It is not a big deal since the process will exit anyway, but seems like a c=
lean code and it will remove the warning spotted by asan.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200227012950.12256-3-pannengyuan@huawei.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 4bc40df6d2..7b7087dd60 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -817,6 +817,8 @@ static int img_check(int argc, char **argv)
                     check->corruptions_fixed);
         }
=20
+        qapi_free_ImageCheck(check);
+        check =3D g_new0(ImageCheck, 1);
         ret =3D collect_image_check(bs, check, filename, fmt, 0);
=20
         check->leaks_fixed          =3D leaks_fixed;
--=20
2.24.1


