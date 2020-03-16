Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9BDC2BB1D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231DE20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 10:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jMA9Nn2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231DE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDn83-0007K8-R1
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 06:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDmmp-000086-8v
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDmmk-0000o0-UD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:15:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28033
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDmmk-0000cX-OQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584353749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qPkXttmnLVUhaeL0m996xgDsH8uTC2wGhHHWk9ZUFIQ=;
 b=jMA9Nn2ROQ8zESGugkQKj8xJs1FSB2Mo1r3zHZNvbNe5rR9E1wX7S6TdTBCvn3WrLVoBSF
 ft/FXd6hM+LNPdG5kY29PKBuTKOa+xc93PE1aZiTA1EvmbF9a3Sc9JL4O8Tnqz0/FEQ8Ao
 XscItq3hB+PiXtI9x8utDuSoaJ1XvEk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-r4eosaLVOkyce3anBLsdTQ-1; Mon, 16 Mar 2020 06:15:48 -0400
X-MC-Unique: r4eosaLVOkyce3anBLsdTQ-1
Received: by mail-wr1-f71.google.com with SMTP id b12so8858141wro.4
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 03:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KU6QOX3JYccstszDRolan9OtS2SN+RYWmF0Jr4mTH0c=;
 b=rqyCk154o2RAXDipwtVASbna0NoXUzDiSHcFADuXfKDIN/7ESuD08GickDgYcofrKa
 nzd2sa5Ty+8CGHRmDDAquJNOLXsdcBy3notpwpOZI9s+zvKdmtZDVZBmjFWoi4lFfFAB
 e4woKjbpHm1giGVDg/r3xI5xbkl0sf+YBIr2UaqprCsne5gQpcp+kwMwBLePA/v3RvjL
 x37VpMpXsnuxev25hH2tuUIusYixfOLTkIMxY1/vyRa3r208xWa+D1GFZIOClBE0O53v
 E4dxVn8CYrSMvJL8edgrvmjFct2c8NwNR91fIuwnAmrReyoS0/GQysK2IxcZRhl617qK
 nd5A==
X-Gm-Message-State: ANhLgQ2FtJZQAe3B5DhA3o/zF0Kgk+0lkSB2l5TgdUABb+M5TwHTm9XC
 QcWqDKgHSDGH2CihKEeqzQdAYMEUwbCriuQW8J6HaRekWkB5E9kKLyOxmoee9YCSeRmhXsVpiDT
 3MdXiv9NWA1vSJys=
X-Received: by 2002:a1c:5452:: with SMTP id p18mr27932528wmi.102.1584353746750; 
 Mon, 16 Mar 2020 03:15:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vseyqLF14ewgpWgobssO2QruJGQELvCQOLV9YAeodZ1HdIyd8LZwLia8rvjwazEVXQ42XaoMg==
X-Received: by 2002:a1c:5452:: with SMTP id p18mr27932497wmi.102.1584353746507; 
 Mon, 16 Mar 2020 03:15:46 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id k3sm16738845wro.59.2020.03.16.03.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:15:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] travis.yml: Set G_MESSAGES_DEBUG do report GLib errors
Date: Mon, 16 Mar 2020 11:15:44 +0100
Message-Id: <20200316101544.22361-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit f5852efa293 we can display GLib errors with the QEMU
error reporting API. Set it to the 'error' level, as this helps
understanding failures from QEMU calls to GLib on Travis-CI.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .travis.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis.yml b/.travis.yml
index b92798ac3b..ccf68aa9ab 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -79,6 +79,7 @@ env:
     - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,mips64-softmmu,ppc64-softmmu=
,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
     - CCACHE_SLOPPINESS=3D"include_file_ctime,include_file_mtime"
     - CCACHE_MAXSIZE=3D1G
+    - G_MESSAGES_DEBUG=3Derror
=20
=20
 git:
--=20
2.21.1


