Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140C0C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE91720774
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gh+8NbYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE91720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRFYL-0003u3-T9
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFUK-0006PX-1Q
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRFU9-0002Yt-5v
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58174
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRFU8-0002Xa-J9
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587562335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbhb8PXc0mO/1TMkYieEGxWYqNfWPp+iXA4REG7HVoQ=;
 b=gh+8NbYlc9eHBd7RJZ9Dx92Ag8S3ABMscec3U5blNaSfsQxNuY9Yi8tZQYpmDRF1Z1H2a4
 x+1xVOaobvKmnEdRXuhV1OwsHSAzPoKjyKEKGAMZPeCen0Jc52YGIAMa1rmQNdZlxu7i1e
 FzQI//01omKK69C2LcQ/s0JbwFUpTYw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-ISF335z7O3uN0zz-qqAcMw-1; Wed, 22 Apr 2020 09:32:11 -0400
X-MC-Unique: ISF335z7O3uN0zz-qqAcMw-1
Received: by mail-wr1-f71.google.com with SMTP id p16so1035845wro.16
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 06:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bCsuLg6l9rCOFqdEp8PJclmAT0RCbEg/PEbjffqRb9A=;
 b=sudFHL3p3iCDEiPB3J5i8UM5CslFVw5/84rSy0Qa4N1fD/WUNuwpJhk9V0H8JH4KpG
 MEm1Gjl+ip24T+uN9RfZ61B9NU8UqgmO9ThAjh2wq3835C7BEeNyW4a0NaAoPmUsVuMX
 qohOUkEfha+JXCA6G3FSv0qDBcsEAPYoI4lzRR5JdEMcnD0CA0eu1uPPNCu1jzEjwGuv
 C/MIDqRjzHl+BmcDy+JOIWGr4raiHPh0DjtlHNyknSn+M8kL4w5zwM4YRfOIG0ojthYm
 60HJFsfoAHZAkW52as/PLx+rgMF5wvKTNf2RS/GpGr4cmnAkidphywCWSno6XYd3hCTk
 fuEQ==
X-Gm-Message-State: AGi0PuahiQvosuswdS9zWZNAoNpndU20sWHiTsDQtpXPP+xUSLtrLc7Z
 bB1vL6i/6dGipsf6S5nfb3gpjcomjqgaT1dsSubSraKDleevoghFfh8WX0idIj6gvoGHcYSqLAA
 02q+3tLlKEQtQG6k=
X-Received: by 2002:a7b:c755:: with SMTP id w21mr10387295wmk.120.1587562330240; 
 Wed, 22 Apr 2020 06:32:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypLYA9+ugGytKHJcVjgqQyyLgri/XnZFg00t/v4mlEVQj2OqPIgxDxR5iT3qfGmXy8rHuq1B6w==
X-Received: by 2002:a7b:c755:: with SMTP id w21mr10387279wmk.120.1587562330041; 
 Wed, 22 Apr 2020 06:32:10 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u127sm8228653wme.8.2020.04.22.06.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 06:32:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/9] hw/i2c/pm_smbus: Remove dead assignment
Date: Wed, 22 Apr 2020 15:31:46 +0200
Message-Id: <20200422133152.16770-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200422133152.16770-1-philmd@redhat.com>
References: <20200422133152.16770-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix warning reported by Clang static code analyzer:

    CC      hw/i2c/pm_smbus.o
  hw/i2c/pm_smbus.c:187:17: warning: Value stored to 'ret' is never read
                  ret =3D 0;
                  ^     ~

Reported-by: Clang Static Analyzer
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i2c/pm_smbus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 36994ff585..4728540c37 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -184,7 +184,6 @@ static void smb_transaction(PMSMBus *s)
                 s->smb_stat |=3D STS_HOST_BUSY | STS_BYTE_DONE;
                 s->smb_data[0] =3D s->smb_blkdata;
                 s->smb_index =3D 0;
-                ret =3D 0;
             }
             goto out;
         }
--=20
2.21.1


