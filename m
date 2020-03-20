Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258F7C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF24620767
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 19:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Go4rHw3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF24620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFN0S-0000nt-07
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 15:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFMyW-00066y-5t
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFMyU-0000bN-6n
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48326)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFMyU-0000bF-2y
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 15:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584731189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWg8qEkdtHLS5RiJUs/y2SIc9XLbwUaK9DS/kS4AUxY=;
 b=Go4rHw3VTdlWUR9Q0SN0mNOloBEioJeNDQlzgmrVYMF5Vz2AHN6F9BlyVng5YSnG0gVk+A
 ZzFrTrHIDCYVv9KDUvzDPbVO92C4TD+BrKtYsS7B9U+Ia0SmDB3IkC+ml9sI75yOmDrP3Z
 DWZlUkDcjqmqUxuR1OihydotrYSL8wU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-lRIgRtlBO2uvFCOlq8YCKw-1; Fri, 20 Mar 2020 15:06:20 -0400
X-MC-Unique: lRIgRtlBO2uvFCOlq8YCKw-1
Received: by mail-wr1-f70.google.com with SMTP id e10so1293268wru.6
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 12:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FIrEvJM3MZZKAXLyDJ7b+Sj8plkho1NeMMKpejJfyeY=;
 b=V25Qlr2jdYSnjsv1M0oMnzKUVlzvTUGPWdO9Mu5ccQiieXpnPuWFv+G5tDPeh1Bfkl
 4RbJNffA3YPaklvEU71ynnHkckCTctAjKJbjQSdA5XWvJbfp+Z3ZCVkdISfRiQwPKLND
 7wOAHLBFZi92GRU4rgmwYZm6F2JLoV/FXLnCDkU1AshjYxdZb9YE0jeEEGaGGgg1AX7L
 RGW98hEBXMLFnz4amZf26YRvCHf4Rk+/wI4cG/vytbfrOt7tMUy/oDOTKyytS5SZPVSV
 DU4r2j7UaIUVec5LFgQRFKQTTPfPaAi105rYyMSt5Ub5doZP0KCkPLaxAIvA7QkOOEAJ
 Dgig==
X-Gm-Message-State: ANhLgQ2zUeDbtfVJQ5ejOsmaUNXc6r8lgXU0lQdjF7Ir0Drs/Jbh8LeD
 jV6adO1cNCqP2DbC+qf87cYhxVhWbVARPO+viXsjhgE2Y60fvGkep86UUO9B8gdZ7olttW8WoxO
 S0Pq564ibDs1cCwk=
X-Received: by 2002:adf:eb51:: with SMTP id u17mr13697116wrn.29.1584731178629; 
 Fri, 20 Mar 2020 12:06:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsQXkBknqiTwYgSwuANX3doJqPIYEDaFbdzU0KfppY0nqF4zu+I24VYV3AankdGUfqgLQ4gWg==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr13697082wrn.29.1584731178369; 
 Fri, 20 Mar 2020 12:06:18 -0700 (PDT)
Received: from localhost.localdomain (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id m12sm2764085wmi.3.2020.03.20.12.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 12:06:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] tests/docker: Add libepoxy and libudev packages to the
 Fedora image
Date: Fri, 20 Mar 2020 20:05:53 +0100
Message-Id: <20200320190553.9363-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320190553.9363-1-philmd@redhat.com>
References: <20200320190553.9363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install optional dependencies of QEMU to get better coverage.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfi=
les/fedora.docker
index 174979c7af..4bd2c953af 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -29,6 +29,7 @@ ENV PACKAGES \
     libblockdev-mpath-devel \
     libcap-ng-devel \
     libcurl-devel \
+    libepoxy-devel \
     libfdt-devel \
     libiscsi-devel \
     libjpeg-devel \
@@ -38,6 +39,7 @@ ENV PACKAGES \
     libseccomp-devel \
     libssh-devel \
     libubsan \
+    libudev-devel \
     libusbx-devel \
     libxml2-devel \
     libzstd-devel \
--=20
2.21.1


