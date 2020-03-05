Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E265C3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FD22072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xk5phjzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FD22072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9pz1-0001O0-I2
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:52:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9ptN-0007kf-HO
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9ptM-0001pR-DD
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51949
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9ptM-0001pC-9H
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583412380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PX36u3szPgZ2Q41knWXAoeXL+fhHmUrIIdFIn10MJtI=;
 b=Xk5phjzFY4/qeHNpugGsyn3awK2cUsg7BRv51zeAmrewZZbEXftUDw/MdC06f+yhlMAe+b
 baSEUUXlffXnL38uFSUNBmwnmnR6tRXq9RsOALHGaji1x1ELfgWuOnN8TW3VP+6hqSRKR1
 a7bWd3Gl/jKfv6QiGPa9O8i14+lXUDU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-JK7X30X1NeKRKAZ99QGIGA-1; Thu, 05 Mar 2020 07:46:18 -0500
X-MC-Unique: JK7X30X1NeKRKAZ99QGIGA-1
Received: by mail-ed1-f72.google.com with SMTP id d11so4280264eds.7
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 04:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AaV1ZZro3f+XiD92hHRr5sJi0Jy1dhCplYtiC3TxZ9Q=;
 b=NisteF513YSRStQ2ksNywRutmUAtbtLOpexNK6hOh2UE0HtYKi4nUoXOKXL3uzbSVd
 oE0YrV3Uch4rVYJ/9+j+n7bJ0s9xOE3G7mX32OctGLqrL60XDSsKZfp1gG9QVt62AfCi
 zfePykFpXv8g2sa7rEyaGTDujGXr+OzEk9t4SPXPmR1DBzLmzH4n+H1wg1UBlygulBVh
 9e6WWdrrVAneFdYkuRGEw6Hmh//SAPtpdu0Lxk1ZcFX7tNK5qsCGqESwqHdmWGTnsINn
 +sONUaPkkrGvcruiQ48sm5XZAjtxGMwcLkCQt1YYi9ptdpcN7QjchCSYOYrUxlcrUpS3
 vlww==
X-Gm-Message-State: ANhLgQ1STfqbFdxyQFYKsP8tNgqUuv3/e1buWJ32LYNp2UeefJ+KTvvd
 1mKXi7t6ZPB0aIB8QoQjcJhXGM6PymSkkNFNUxCi25hlQ4PAqjfXJoHPaiJjpQhyXCm6XRkyaSr
 GMAyIxiSDonF52gQ=
X-Received: by 2002:a17:907:20ae:: with SMTP id
 pw14mr5158861ejb.347.1583412376855; 
 Thu, 05 Mar 2020 04:46:16 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsXzhx6R4H7sx/neIO4/kU2XBgcI7lnVex83myb4LLHWpAvKquZR8H+zNUYUqKhe7Q024X6Zw==
X-Received: by 2002:a17:907:20ae:: with SMTP id
 pw14mr5158849ejb.347.1583412376669; 
 Thu, 05 Mar 2020 04:46:16 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q26sm1529544ejb.50.2020.03.05.04.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 04:46:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 9/9] virtfs-proxy-helper: Make the helper_opts[] array const
Date: Thu,  5 Mar 2020 13:45:25 +0100
Message-Id: <20200305124525.14555-10-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305124525.14555-1-philmd@redhat.com>
References: <20200305124525.14555-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reduce a bit the memory footprint by making the helper_opts[]
array const.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 fsdev/virtfs-proxy-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index aa1ab2590d..de061a8a0e 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -43,7 +43,7 @@
 #define BTRFS_SUPER_MAGIC 0x9123683E
 #endif
=20
-static struct option helper_opts[] =3D {
+static const struct option helper_opts[] =3D {
     {"fd", required_argument, NULL, 'f'},
     {"path", required_argument, NULL, 'p'},
     {"nodaemon", no_argument, NULL, 'n'},
--=20
2.21.1


