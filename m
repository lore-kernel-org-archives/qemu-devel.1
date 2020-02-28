Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCB6C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E627246A3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7NWWiU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E627246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fAU-0006VV-9A
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7f9T-0004x0-RH
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7f9S-0002ma-Qq
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:53:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7f9S-0002mS-Nn
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582894438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tQcQxO0mafeJcBrhpQ08m1da1xIhoRzWg6Hbi1jpjAM=;
 b=P7NWWiU58CdoJvYpUqfkl9OyBoL6t6aEL01kJrESA0osrqXjDM3VvThUvW7GDp1TNcrNlL
 FkLAc/NgF6kp9rwcgv8UUTrsKEi1BxyvaC/iL3hw8SjribcVmhqfRriJTJlYhER3HDcor6
 aRWriKbiAkJQMh6I1T7tsAL46YDDbAY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-JrFyg-o5OVSP98a87qbKnA-1; Fri, 28 Feb 2020 07:53:56 -0500
X-MC-Unique: JrFyg-o5OVSP98a87qbKnA-1
Received: by mail-wr1-f69.google.com with SMTP id m13so1295881wrw.3
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 04:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KG0eGk37oq+Ccl9b8PKNGyC9lzYSNCYQ0XyNSPhojuw=;
 b=ZabZCAroAHMX0EkTw6xfmy5odmBxrinocIA2EDbWLXzYVRDPMJupY1mu3VWsF4CmZx
 yS4/tyimK/GVSYzT4nCWNXcwSR41qh/iROJ5YIX/kDmGnFEVSHghwwz3YOoZ2uIZkBgC
 F5cVuKM49/4turBiRZgLsJmV5EiDe1vxKlo1mwpuQacVB9LKu2eOI4jlENOgClevJQSy
 AqIoaY3dWnxQSQGXjci0+CGiw+G6F4s9u5x1wQErhCdMc2iaAKJPTFc3a1mGKdZ6MX1F
 AQTNW8wo2cArfORKmhjOmVxIARXCdnA2s5LWVAO27V6GX3l7stdyBtR+IbOMfPJs9ER1
 m0+A==
X-Gm-Message-State: APjAAAVOJZjT2rd9zFz0bzK2gc71rjl3LSyxDT8KFeDiQYjJ3TJyEb5S
 CVt7NvTCgxmjAJeMafmMmGqYoHnB0SC75QM6dRmfwaY7zyA2l6qg0ZV6HngYgN7UsSGmQDW4xuF
 MAHAYJ/VDIO8vykI=
X-Received: by 2002:adf:e809:: with SMTP id o9mr4687880wrm.405.1582894435383; 
 Fri, 28 Feb 2020 04:53:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5DITn1g7ETuS6RPIJiR/0vw6ABchhfTUeYNbBQemZPsK+1ncz5p+Q30b8lea+2AQqakfg/A==
X-Received: by 2002:adf:e809:: with SMTP id o9mr4687864wrm.405.1582894435139; 
 Fri, 28 Feb 2020 04:53:55 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id d9sm12398979wrx.94.2020.02.28.04.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 04:53:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] hw/arm: Remove big-endian checks on machine code
Date: Fri, 28 Feb 2020 13:53:46 +0100
Message-Id: <20200228125351.29482-1-philmd@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only build the little-endian softmmu configurations.
Checking for big endian is pointless, remove the unused code.

Philippe Mathieu-Daud=C3=A9 (5):
  hw/arm/gumstix: Simplify since the machines are little-endian only
  hw/arm/mainstone: Simplify since the machines are little-endian only
  hw/arm/omap_sx1: Simplify since the machines are little-endian only
  hw/arm/z2: Simplify since the machines are little-endian only
  hw/arm/musicpal: Simplify since the machines are little-endian only

 hw/arm/gumstix.c   | 16 ++--------------
 hw/arm/mainstone.c |  8 +-------
 hw/arm/musicpal.c  | 10 ----------
 hw/arm/omap_sx1.c  | 11 ++---------
 hw/arm/z2.c        |  8 +-------
 5 files changed, 6 insertions(+), 47 deletions(-)

--=20
2.21.1


