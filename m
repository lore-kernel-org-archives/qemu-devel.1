Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F4AC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6A8B2072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivv4vi0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A8B2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9ulM-0000if-0i
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9uk4-00079x-NK
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9uk3-0002hI-Is
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51440
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9uk3-0002gs-Ft
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 12:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583431023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CS6YPb3Ihef4vMzBH/zBkjylrRdhrNd8BsGM+mGSMes=;
 b=ivv4vi0vf4qc93h8r5KEyIZAYl/Hwf5siqawO9MkegtvvzMAvBBAnnIpdKk1jrZGqrALY6
 uFFpgoHrcWYl8+srvuL8Ojyv5lXBeEMCnzFXRPJSfI5L52sOCINxpfhP2HLoLMPAosc3GL
 wZx3+1erwt9pDHmGvrLYzcLJvOlGFzk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-LpT-CZ8dNiCx6aLBtvX6gA-1; Thu, 05 Mar 2020 12:56:59 -0500
X-MC-Unique: LpT-CZ8dNiCx6aLBtvX6gA-1
Received: by mail-wm1-f69.google.com with SMTP id t2so1876387wmj.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 09:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6JrFb878lHzGwYsPjMk4F0hM2hVACJ2Pnf75ZdCaRHg=;
 b=aGe5zXssWmspgjWRWemrPBIqnQXFgmnVn8oiY+UkkREAkjEZvxRUs5cVFh5ATN/Nap
 clXfbERcFK/sSyU/OmwRfKLB5RmACofa0jRflTVzzhrBjJz6RLcb4aCiY6bMXDaPBMpD
 dRb/E+KJrMTw/AtS7EY3TEnHlbOOfdMFdPesET6C1Vh12ajEvC37uErXb0g5SQ4DoWNk
 5zXv4+LQDcR7zse6wCbMngBXv1E3PGakKu1GGH2lNDKfI/C9oKGKXVJktsh1IcKWEHXM
 5T0st/pP5fc51MX+/2EXd00kT9IbT1/E+qFGUzD+vTx4ELdjljLjyTbOnb+QKVmBjW5b
 tzyA==
X-Gm-Message-State: ANhLgQ1toor/zS7nEPjUKuDlGq8dWi9AcJtccxYU0pH5jEDCtJeoEyTd
 dSRBdPEdse2HyWtQm7jgFpC3USqD3YcQQH5oJuJ1oaufjuRTTd4LwZxdeVOZvgJTH350tHF+a3w
 lRB4p5+wHI+a5GTc=
X-Received: by 2002:a5d:4885:: with SMTP id g5mr97807wrq.93.1583431018457;
 Thu, 05 Mar 2020 09:56:58 -0800 (PST)
X-Google-Smtp-Source: ADFU+vskaAkFKgbEQH+pNIGFb8Sr3L1S1HvDcf8VKDBvX02lrY1dc2utRLDl7z40uKKyLXE/PBLOtw==
X-Received: by 2002:a5d:4885:: with SMTP id g5mr97785wrq.93.1583431018221;
 Thu, 05 Mar 2020 09:56:58 -0800 (PST)
Received: from x1w.redhat.com (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f3sm15240718wrs.26.2020.03.05.09.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 09:56:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] hw/net/e1000e_core: Let e1000e_can_receive() return a
 boolean
Date: Thu,  5 Mar 2020 18:56:45 +0100
Message-Id: <20200305175651.4563-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305175651.4563-1-philmd@redhat.com>
References: <20200305175651.4563-1-philmd@redhat.com>
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
Cc: qemu-ppc@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Joel Stanley <joel@jms.id.au>, Beniamino Galvani <b.galvani@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The e1000e_can_receive() function simply returns a boolean value.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/e1000e_core.h | 2 +-
 hw/net/e1000e_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 49abb136dd..aee32f7e48 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -143,7 +143,7 @@ e1000e_core_set_link_status(E1000ECore *core);
 void
 e1000e_core_pci_uninit(E1000ECore *core);
=20
-int
+bool
 e1000e_can_receive(E1000ECore *core);
=20
 ssize_t
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 94ea34dca5..e0bafe975b 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -967,7 +967,7 @@ e1000e_start_recv(E1000ECore *core)
     }
 }
=20
-int
+bool
 e1000e_can_receive(E1000ECore *core)
 {
     int i;
--=20
2.21.1


