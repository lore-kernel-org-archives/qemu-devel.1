Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88302C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DEE820737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 17:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZPp7KJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEE820737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKQAn-0001nK-8b
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 13:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKQ8Z-0007xm-BB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKQ8Y-0006gw-5D
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKQ8X-0006g5-2k
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 13:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585934984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JvbaRt6FjvsveUuC+vOjrJEApSprL7Ma0wM7xUkHHic=;
 b=CZPp7KJDveVk7VRw+xe8rzF9DmHYHIyBaOZG/U7wpRAMdDcyKEkkvSC1sPqI8yb9M09LJS
 A8uMTJZFh5e1+5Mo9yKF1ZwDfaknq7awUi+Gew6Bsy/HREa49I4I63iDvGE/UFOI6GL2My
 r1WZB2B5lbU2nDDz4UutR2RkTjHOkSo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-AezuABXFMM2YZjyPcI39nw-1; Fri, 03 Apr 2020 13:29:37 -0400
X-MC-Unique: AezuABXFMM2YZjyPcI39nw-1
Received: by mail-wr1-f72.google.com with SMTP id m15so3466578wrb.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 10:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8eDnRTWyU3nAHcaQhD153aO8yrsrCY+01wCb/6HMgdw=;
 b=MCdmybrfpS9gqPbDt33JJOckj/RYu58/hGBPNPG/GCojtfApiNkf0X8jQHmWOthOLr
 lrGkQBOCgC5twUFzikL08hLafQ4W/1F9tkC0Wq/b7yV7gL9XV8G71BWZwuXbtLFtuzJe
 UvWWdls6vKg8YG+21kM+qqSJ6QiGSvP08+B9lbDdW75tXrIcF4BiUwTA3t9B8uDo7JRo
 08bQLVOutIng3TNi2HY4fc2xIL44d8zErY9irS05pWqzELhtKErI3I/CnC/VoXSqpk7N
 zYISz5SbkeYH7cjFwuxVnuTNw4Y075cbhhvvjglaSQoXQrldyT0CxCsQzWh3jbEbNsrf
 ekkQ==
X-Gm-Message-State: AGi0Pua2gCYNMu4fEIndsA1P0zWLt5RQ5NX8iVMz+TAe81tVLSeMtdEN
 5X1rw4GDh5unpovWes93phd8lpO24WhJQ+mHDqEwXoFvOihqNBdlw5XmqFiHIt0Vh/996euXPkJ
 +6Sdm5kd+sbXvF6A=
X-Received: by 2002:a1c:9c15:: with SMTP id f21mr9578871wme.18.1585934976279; 
 Fri, 03 Apr 2020 10:29:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypK6cb6A32vyZGGbW4SNRU1EvEyuqC9J2RuaNgog56NYhpeOvCEpLhlGWx0sY3Y3vMSulA/88Q==
X-Received: by 2002:a1c:9c15:: with SMTP id f21mr9578851wme.18.1585934976101; 
 Fri, 03 Apr 2020 10:29:36 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id r9sm12698522wma.47.2020.04.03.10.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 10:29:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 2/8] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org
 hostname
Date: Fri,  3 Apr 2020 19:29:13 +0200
Message-Id: <20200403172919.24621-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403172919.24621-1-philmd@redhat.com>
References: <20200403172919.24621-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use NetBSD content delivery network to get faster downloads.

Suggested-by: Kamil Rytarowski <kamil@netbsd.org>
Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20200211134504.9156-1-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/ppc_prep_40p.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep_4=
0p.py
index b27572f212..138064285a 100644
--- a/tests/acceptance/ppc_prep_40p.py
+++ b/tests/acceptance/ppc_prep_40p.py
@@ -34,7 +34,7 @@ def test_factory_firmware_and_netbsd(self):
                     '7020-40p/P12H0456.IMG')
         bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
         bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash)
-        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive/'
+        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-archive/'
                      'NetBSD-4.0/prep/installation/floppy/generic_com0.fs'=
)
         drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
         drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
)
@@ -66,7 +66,7 @@ def test_openbios_and_netbsd(self):
         :avocado: tags=3Darch:ppc
         :avocado: tags=3Dmachine:40p
         """
-        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/'
+        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/iso/7.1.2/'
                      'NetBSD-7.1.2-prep.iso')
         drive_hash =3D 'ac6fa2707d888b36d6fa64de6e7fe48e'
         drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_hash=
,
--=20
2.21.1


