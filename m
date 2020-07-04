Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E541FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC01720826
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JM0Y81MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC01720826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkUR-0002Z8-V0
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkHc-0002uS-52
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:40:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31801
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkHW-0008Hy-Nh
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7tSIIx0YAEULmCHrXDbhmRzYLD86lXGUTjUWu9J2Gg=;
 b=JM0Y81MO/E20i410jwv5qEnZoOLTi1lSHO62V18tZWmXMiVALaKlYki6GWeXKi8fJtPWnd
 TJzMh8ciSY+tK4o1s/xvxMlm/SC/e5Pt0xPoWsYMequKi58KJbg2uqinw4xfvZDG2FU9ma
 uNhQ4PizzXapY9CKNCPE8uTiwQY7Ujs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-BwGon4i4OkGUnqpKiSTGrA-1; Sat, 04 Jul 2020 11:40:44 -0400
X-MC-Unique: BwGon4i4OkGUnqpKiSTGrA-1
Received: by mail-wm1-f71.google.com with SMTP id v11so21044036wmb.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R7tSIIx0YAEULmCHrXDbhmRzYLD86lXGUTjUWu9J2Gg=;
 b=sURCy+xwCQyEbcJu2F73d9nAYOUvm8YGokB4tNf21mDlWsTUPoiIeJhEi4iM7FZI4u
 rC2YJoD6oF3cPc349JjB92bnOEYi2w+eBMNNUgxsAh0iVqrTovBQ50fyy8tVxicX4Nwf
 /E6q/4iRy4fHVFcqXeBa6MPbjNAH6zm7QCA/QxCxMcngQhUWLu2vBYr2Lo0ZnZrk8om+
 J/JbXopQFdryAbEgtUcj3QYURrzxdAkNxV8gNWpCwVM1DbaNt5klDLkg9M+VDCXe5Roy
 yvMy7Jrhx/A0Dye2MugrsLkheHsBdCGot7g+kuFmmlJ+QLdyqDzrxsEOOnA749drCMBV
 LGEg==
X-Gm-Message-State: AOAM533gEDY6vkAodQ+b1axM/zvDGbfCE5kefROB5iUikEUKj+QJazTE
 TmJeB2xbUD8oyMexfq9FEXbjnWUCh1ai4SSle+AiStRJP7BnzAYfpzcre6m4VHdD5EFqMhnAfqe
 ZLqLjWjdE8Epa/ms=
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr40996400wrj.265.1593877243516; 
 Sat, 04 Jul 2020 08:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQIKLMWFxNGm+uuZl3W/8KNm9CfIgW+kgC0ZhT9nNbjtg+gssdP3TvkF5C2DIW+SRqj3+qeQ==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr40996372wrj.265.1593877243337; 
 Sat, 04 Jul 2020 08:40:43 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u8sm16661313wrt.28.2020.07.04.08.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:40:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 17/23] hw/nvram/eeprom93xx: Emit warning when old code
 is used
Date: Sat,  4 Jul 2020 17:39:02 +0200
Message-Id: <20200704153908.12118-18-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704153908.12118-1-philmd@redhat.com>
References: <20200704153908.12118-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/nvram/eeprom93xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index ca6f591c84..56603ea42b 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -39,6 +39,7 @@
 #include "hw/nvram/eeprom93xx.h"
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
+#include "hw/qdev-deprecated.h"
 
 /* Debug EEPROM emulation. */
 //~ #define DEBUG_EEPROM
@@ -300,6 +301,8 @@ eeprom_t *eeprom93xx_new(DeviceState *dev, uint16_t nwords)
     eeprom_t *eeprom;
     uint8_t addrbits;
 
+    qdev_warn_deprecated_function_used();
+
     switch (nwords) {
     case 16:
     case 64:
-- 
2.21.3


