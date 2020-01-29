Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E14C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E1120702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 21:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtuZDsPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E1120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwupe-00063X-39
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 16:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwuof-0004L8-Jq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwuoe-0008MW-Mg
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwuoe-0008MK-Jp
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 16:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580333044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVzEAsn5ssLnp1bZkPwIO2os/2HRiZ8j0UbJwHtxps0=;
 b=gtuZDsPltoVdEHKPoHsjjjl8QRvu7TFiWzby7fTwxEGrCcjz5TBMg6ZsKMUiQSh4NTF0D2
 i5/1wG6vu6yStWHyIMFAJ7vkR0DT0K2fPzLecNy6jZxM+XI0p51NcyflmuZsVbIHx0fTq8
 hBq5txsI4KpwV2S/stqTECeBoPfCjv8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-6fm1zb9YMDaXT7OZ-Z1kTw-1; Wed, 29 Jan 2020 16:24:00 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDBDB107ACC9;
 Wed, 29 Jan 2020 21:23:59 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-184.brq.redhat.com [10.40.205.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF1560BF3;
 Wed, 29 Jan 2020 21:23:57 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/29] accel/accel: Make TYPE_ACCEL abstract
Date: Wed, 29 Jan 2020 22:23:18 +0100
Message-Id: <20200129212345.20547-3-philmd@redhat.com>
In-Reply-To: <20200129212345.20547-1-philmd@redhat.com>
References: <20200129212345.20547-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 6fm1zb9YMDaXT7OZ-Z1kTw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no generic acceleration, we have to use specific
implementations. Make the base class abstract.

Fixes: b14a0b7469f
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 accel/accel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/accel.c b/accel/accel.c
index cb555e3b06..a0169b4e69 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -33,6 +33,7 @@
 static const TypeInfo accel_type =3D {
     .name =3D TYPE_ACCEL,
     .parent =3D TYPE_OBJECT,
+    .abstract =3D true,
     .class_size =3D sizeof(AccelClass),
     .instance_size =3D sizeof(AccelState),
 };
--=20
2.21.1


