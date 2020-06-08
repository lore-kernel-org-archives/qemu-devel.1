Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3128AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4AF2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNg3Vw1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4AF2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKLj-0008W1-3V
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDu-0006aL-L7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20326
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDs-0007nl-M0
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPFQ0bX3Ul9NeHHcjGis7Hob0YUuGxD/aHEXimgfPe0=;
 b=SNg3Vw1wOv3e531S7bQvEPa0ySxt/QmIxqGPmHm/U1zxU1WjNFWluxou2WsblLYn2lyaBM
 tWW3Vjg0Ms+1vtmiSD1HfOBfIBEXNjXKjrV04oUxlAqtQaMwUvew9W0ltKOY5mwQYPF0DX
 w8mMKJPlge1H2E7RMOkn/Rn4IoSse68=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-FyNBouKTN4mktMj7ZIca2Q-1; Mon, 08 Jun 2020 12:01:17 -0400
X-MC-Unique: FyNBouKTN4mktMj7ZIca2Q-1
Received: by mail-wr1-f69.google.com with SMTP id o1so7297819wrm.17
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JPFQ0bX3Ul9NeHHcjGis7Hob0YUuGxD/aHEXimgfPe0=;
 b=fixB7ber7WOIzoc9MzwgOactTNSuf6YCBb85gK2rb3YAylSOeGsWyteMxCmcJ7Zj6q
 YKyQGiI1Coxi+7h6Fveo3lKFsRrSUfQyzYaj4Z+xzmPyFK6sjlg9mSsWpUIO3UzFvK8a
 YLGZw6Yx24TqKlc5d5tmnzZC7pIZYXTKUNECHIIH5GczJWGkz/UiqD1i74F4Nj9NxjxK
 KHvIW0kpQnk81rwHNVlYwvQ+4ICBRc39hcQuStkO9BgMlPKEniBjFAChOWuChkPY4qNW
 DUginuguCyMB9O8h1qVmT3zWUnb8CfuV8kUm6sWOqAnf/KAq9GmmZ1HBhqxUsoV13ZeB
 mwjQ==
X-Gm-Message-State: AOAM532XDPVqey6mulS6c1AzeitvDes5LYxYE4M2H3ELo2UM5Q8/XBzH
 GjrphbKyJqD4W+8Rgp6926o50Lw1X3G6yhrSiKSGzLwc2gQogJz/9OVWQfVMoVV4sSh0sK5eBV5
 utmBuFa57U2ejjtw=
X-Received: by 2002:a1c:63c2:: with SMTP id x185mr71342wmb.68.1591632075685;
 Mon, 08 Jun 2020 09:01:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHSTbXCqkGc9kOsbxhlXHtghZhPx9xWZVb7ZeU/GWo7Q7cDZTZJUQ93U+AAUtsWNU3dUVBvg==
X-Received: by 2002:a1c:63c2:: with SMTP id x185mr71295wmb.68.1591632075484;
 Mon, 08 Jun 2020 09:01:15 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id h12sm145322wro.80.2020.06.08.09.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:01:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 05/35] hw/arm/nseries: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:14 +0200
Message-Id: <20200608160044.15531-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 11:58:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/nseries.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index eae800b5c1..bd0c3f39a9 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -44,6 +44,7 @@
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
+#include "hw/qdev-deprecated.h"
 
 /* Nokia N8x0 support */
 struct n800_s {
@@ -703,6 +704,7 @@ static void *mipid_init(void)
 {
     struct mipid_s *s = (struct mipid_s *) g_malloc0(sizeof(*s));
 
+    qdev_warn_deprecated_function_used();
     s->id = 0x838f03;
     mipid_reset(s);
 
-- 
2.21.3


