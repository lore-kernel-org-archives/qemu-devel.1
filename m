Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2A2C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D415A20724
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7ZOScmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D415A20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ig421-0006GH-T1
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 04:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ig3zY-0004Xy-Ab
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ig3zX-0004Pz-Ar
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:45:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34531
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ig3zW-0004Nc-T2
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 04:45:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576316738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUapvLhtCW9yCcoxtOXVvyvcUvyz8RqxZFiSUUVE8Pk=;
 b=B7ZOScmK4QdTuZRVvHsYZ/PG2mYIiY7/IXfRPmvouQQeSwbBQhI0ixnON71ahwlKY5hDJB
 TI5HFTCj2QebqsIlsXZi2WJxfGsciet0xdB6XT87dk84b61rPW8e7wlVTElh78rbnTWoay
 yGKqTE3qzNLj7XpsasGa3/QXAwL1E04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-njYkWks1NhKysm8to5VQTA-1; Sat, 14 Dec 2019 04:45:36 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BBD61800D63;
 Sat, 14 Dec 2019 09:45:35 +0000 (UTC)
Received: from localhost (ovpn-116-90.ams2.redhat.com [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73C425C28C;
 Sat, 14 Dec 2019 09:45:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 01/16] vfio-ccw: Fix error message
Date: Sat, 14 Dec 2019 10:45:11 +0100
Message-Id: <20191214094526.8698-2-cohuck@redhat.com>
In-Reply-To: <20191214094526.8698-1-cohuck@redhat.com>
References: <20191214094526.8698-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: njYkWks1NhKysm8to5VQTA-1
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
Cc: Eric Farman <farman@linux.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Boris Fiuczynski <fiuczy@linux.ibm.com>

Signed-off-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20191128143015.5231-1-fiuczy@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/vfio/ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 6863f6c69fd9..3b5520ae75a1 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -102,7 +102,7 @@ again:
         if (errno =3D=3D EAGAIN) {
             goto again;
         }
-        error_report("vfio-ccw: wirte I/O region failed with errno=3D%d", =
errno);
+        error_report("vfio-ccw: write I/O region failed with errno=3D%d", =
errno);
         ret =3D -errno;
     } else {
         ret =3D region->ret_code;
--=20
2.21.0


