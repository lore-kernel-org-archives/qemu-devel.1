Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0BC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17790208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 16:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IROZEM5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17790208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGJb-0001Qn-8Y
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 11:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jAGIQ-0000U4-7I
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jAGIP-0003Gf-3w
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:57:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jAGIP-0003EZ-08
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 11:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583513876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JbZPd/wLu/MyMkULqdcDuthR6H2vGP8ZBti5hBogKwE=;
 b=IROZEM5nfpQfQija7YYNyxNStirrO+OQvzPJBnI4siL10E/FE3LQ26TBldgdFnxdzvepH/
 nKI4ijZ76l2Q2AyKjlVtqGIlch7/QhXvkS3GUtegUqorCPU7VtCeLY+IbB8fNMJPDOTbSP
 JHKeFhg0oV3bZhvTV0bsOn9uUdqN94E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-UYHodpYFPBS0NWHfi8aEtw-1; Fri, 06 Mar 2020 11:57:55 -0500
X-MC-Unique: UYHodpYFPBS0NWHfi8aEtw-1
Received: by mail-wm1-f72.google.com with SMTP id k65so909035wmf.7
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 08:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F7l/j/GIgvrAnGNmwDhjdQAQtKm/wVAbt56hHo9kdzs=;
 b=QPIvHnt9F5Fyck+X7nfezRgN5RusRaDDDE+mAH31UumBmzSftZ0Xp9LzI0BT/84eB+
 OEIeXmvzrykv5NkG3mK46d0BQq1StB3uXz6pL7wl0MRH1SUxZZZUfdIqr1DeHVkUgoXH
 X5RV7cVX4tVkT8PYVmZC6lXkLG5T1ZnMPohJok248STG51YSvGM+hNwTUanyGecOuDP1
 mqX3fAzV1BJHP/QtvsiysZSC7YXkGJdcmltQXKusYX4gXLxXZSUh2mjlg9JP7urft6ZY
 nKeplQxqj6fSE33dUVNC3OGckAz0WAzDcBZ8UGNDPqLihj8lIwM6rugMjOPzpisjnqg7
 0apw==
X-Gm-Message-State: ANhLgQ1ZMeKRprXWCOWVtsdkMNIKUgG7v6Q9ZqTrue0Mh13qsgUxZ82n
 b3MBZyhviljMhdXcFie147INsDsd1R0SfMofn6RmvHsMDyfxOFECfxRTYUaaWmK91EEyzQDbEVk
 WdeSDk3ecUuJE++w=
X-Received: by 2002:a1c:35c6:: with SMTP id c189mr4696237wma.108.1583513873576; 
 Fri, 06 Mar 2020 08:57:53 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtbpBPWvC5539slMSpRFgjb23xZMihyVbGAnueCyZrDt4qDbsdvADaxjoC6HLWmoM/0V6loJQ==
X-Received: by 2002:a1c:35c6:: with SMTP id c189mr4696220wma.108.1583513873276; 
 Fri, 06 Mar 2020 08:57:53 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q16sm34511293wrj.73.2020.03.06.08.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 08:57:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/qemu-iotests: Fix socket_scm_helper build path
Date: Fri,  6 Mar 2020 17:57:51 +0100
Message-Id: <20200306165751.18986-1-philmd@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The socket_scm_helper path got corrupted during the mechanical
refactor moving the qtests files into their own sub-directory.

Fixes: 1e8a1fae7 ("test: Move qtests to a separate directory")
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/Makefile.include       | 1 +
 tests/qtest/Makefile.include | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index edcbd475aa..67e8fcddda 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -589,6 +589,7 @@ include $(SRC_PATH)/tests/qtest/Makefile.include
 tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
 tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
 tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o $(test-util-ob=
j-y) libvhost-user.a
+tests/qemu-iotests/socket_scm_helper$(EXESUF): tests/qemu-iotests/socket_s=
cm_helper.o
=20
 SPEED =3D quick
=20
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index 383b0ab217..76672990a7 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -287,7 +287,6 @@ tests/qtest/usb-hcd-ehci-test$(EXESUF): tests/qtest/usb=
-hcd-ehci-test.o $(libqos
 tests/qtest/usb-hcd-xhci-test$(EXESUF): tests/qtest/usb-hcd-xhci-test.o $(=
libqos-usb-obj-y)
 tests/qtest/cpu-plug-test$(EXESUF): tests/qtest/cpu-plug-test.o
 tests/qtest/migration-test$(EXESUF): tests/qtest/migration-test.o tests/qt=
est/migration-helpers.o
-tests/qtest/qemu-iotests/qtest/socket_scm_helper$(EXESUF): tests/qtest/qem=
u-iotests/qtest/socket_scm_helper.o
 tests/qtest/test-netfilter$(EXESUF): tests/qtest/test-netfilter.o $(qtest-=
obj-y)
 tests/qtest/test-filter-mirror$(EXESUF): tests/qtest/test-filter-mirror.o =
$(qtest-obj-y)
 tests/qtest/test-filter-redirector$(EXESUF): tests/qtest/test-filter-redir=
ector.o $(qtest-obj-y)
--=20
2.21.1


