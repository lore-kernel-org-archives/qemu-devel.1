Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD59BC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786E62076E
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 21:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwbMOs/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786E62076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEQ6-0001CO-J5
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 17:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDEPJ-0000eK-ID
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDEPG-0004tr-Oo
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:33:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28671
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDEPG-0004td-Kw
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584221598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GGjOTkUYf+GX1/cPgSF/r+83O02JxtmGeXpWGAW3xLo=;
 b=iwbMOs/QYyvmXLGUhGslzDlDK8wHP0asE64wfjXFttUzfR8IUOTjo2U+ozkoiHz76E7NVu
 kvOLadzFplbOonB0AzxRVJJTFAYYnwYdflw+aZ/lwIy4hgAS6lj72x85TWv00YPTvOicAg
 V2wN4WNqaMw88OTDAxh7NEigSUTzsPQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-c6-iFS6MOn2DKn0GkASjkQ-1; Sat, 14 Mar 2020 17:33:16 -0400
X-MC-Unique: c6-iFS6MOn2DKn0GkASjkQ-1
Received: by mail-wr1-f72.google.com with SMTP id 94so1774952wrr.3
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 14:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PHFbYPhoT67HpiSc4k10hKbBfy6Vxq0LfMGIlrYmsqo=;
 b=nMicbyoDO9zrN6QCbuMicZUoe8wUM69pUytLHv5u0+Z8E+M+dpahivzsf8RiqoiEiu
 1a9A/CRENHYoobqbcdGdE2zX0khYAWYVDuekBfAFK/TioJo4tPW6i5VWSqASMKtmAUWK
 N9w5lrAH4FbeQA99G315kdNm9ud74cpkqpLLW0WmwAN1if1qcen3k4YqJGxOPw2DvCsC
 MGL1OwCjnsgig1c/kssOzCxFFhisVLSNhI0DyJMsFnp1ol7Q5P1QEGbQKcNBYCrUwJmL
 quUjcIe6hQMdQXCLwCNs3Z82XGi9kQ7jVrwVPxuFS3+NQfUEvp8dnZY7H9ngD53k3vEC
 6MpQ==
X-Gm-Message-State: ANhLgQ2/08uMvShq8TJ/HDcBE8W9LkGhkvoEhjSFxUF8vUWXymEvMdJU
 uMQu7SKhGlCyVKG5YgGZyOlq1qglqpbOPADmKLW1ThiGcsW/mnyrXMjWhHlIkMgn309To4MP8Bs
 nkPHOvewb9Z4l2s8=
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr12478574wrw.182.1584221595238; 
 Sat, 14 Mar 2020 14:33:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsZPHmGD9eTQUPW4RVHTlTbkppxAIOfyFE9DO2zxMf/UC9XH54p3fwf8k3A+C6N02vFtxgZNQ==
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr12478553wrw.182.1584221594947; 
 Sat, 14 Mar 2020 14:33:14 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id i9sm23114290wmd.37.2020.03.14.14.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2020 14:33:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qemu-common.h: Update copyright string to include 2020
Date: Sat, 14 Mar 2020 22:33:12 +0100
Message-Id: <20200314213312.28282-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
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
Cc: qemu-trivial@nongnu.org, John Arbuckle <programmingkidx@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend the copyright range to include the current year.

Reported-by: John Arbuckle <programmingkidx@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/qemu-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index 082da59e85..d0142f29ac 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -13,7 +13,7 @@
 #define TFR(expr) do { if ((expr) !=3D -1) break; } while (errno =3D=3D EI=
NTR)
=20
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2019 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2020 " \
     "Fabrice Bellard and the QEMU Project developers"
=20
 /* Bug reporting information for --help arguments, About dialogs, etc */
--=20
2.21.1


