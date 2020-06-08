Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D7AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEEEA206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fefb/B0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEEA206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKZT-0002zR-Ug
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKEL-0006w1-A3
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36927
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKE5-0007qh-T6
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOyQYXnEE/P1L9M062K4OG7LDuRa+UfsKXeI8IczatQ=;
 b=fefb/B0sEevutDY78MH/2UWOO1i+K3MTugRIojbNgaC0LB3ka6Od5kXlv2cFhVWzBordYC
 eAm5dOgPRh237pcCnOZMDQeM0dkczuLjQDMKXws10lrLJp31LXmSOhbVNmZM8LSWXBZy7Q
 ShFTX6ewNBX5+gNJpFhxAGvcnhBJ+Ho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-CcIC-PgXP22I27Rq6q2scA-1; Mon, 08 Jun 2020 12:02:13 -0400
X-MC-Unique: CcIC-PgXP22I27Rq6q2scA-1
Received: by mail-wr1-f71.google.com with SMTP id s7so7360307wrm.16
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jOyQYXnEE/P1L9M062K4OG7LDuRa+UfsKXeI8IczatQ=;
 b=pf2LwqBEndtHQoM9qUNIURk8XwYU8Or9FkAeR0a5WzV+1llADlFXdM3cgrzY6xecIN
 clWEZcu0/Z2pyBeDQ3iwlM5pXgaUdjR0f+bOYdwREpaBrNzsdbXwzonoKFOpLbWDFFdc
 XMDxZSvEmERYvANUf71E29vlMKU4L6/pL2SGEoothWCZJ2Evh3G2crLGHO3zMI5A3aIH
 qMfFcwvF1XxLRE55+EhDNO05GLZ7sbi/5Re8Sijn5/l20WtyLiAHGuuDtX9uG8K8VLa/
 MWb95aveXRj4C6l795eiHhZ7Arw8aZ5SbGEZ7LHNXsmyOR7JNZh+dPu8F2j62s+nuWdr
 6XUg==
X-Gm-Message-State: AOAM531+L+PrsRiStmL8dq3F6QRB5jRfz0J77TJQDHLS01bdLyHAHjuJ
 P9mmXAb0f7PhGTii2voSGTtU8aM6wMsQ4AZUz7jgtSX/q4MEoaP+n55he4LWLlwcwGpgQcE0zgs
 aS/QYiBi1VrLPHkw=
X-Received: by 2002:a05:600c:2256:: with SMTP id
 a22mr82490wmm.18.1591632132283; 
 Mon, 08 Jun 2020 09:02:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvLE6gRX7XM83bmbZu8lLW6Zr2jKGWG6aII1A2AXMFr5e4D5cYkpsPFEEPHv3ro5n12uF+eA==
X-Received: by 2002:a05:600c:2256:: with SMTP id
 a22mr82438wmm.18.1591632132052; 
 Mon, 08 Jun 2020 09:02:12 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z25sm31297wmf.10.2020.06.08.09.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:02:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 15/35] hw/i386/xen/xen-hvm: Emit warning when old code is
 used
Date: Mon,  8 Jun 2020 18:00:24 +0200
Message-Id: <20200608160044.15531-16-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 hw/i386/xen/xen-hvm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 82ece6b9e7..a1163b1529 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -31,7 +31,7 @@
 #include "sysemu/xen-mapcache.h"
 #include "trace.h"
 #include "exec/address-spaces.h"
-
+#include "hw/qdev-deprecated.h"
 #include <xen/hvm/ioreq.h>
 #include <xen/hvm/e820.h>
 
@@ -1401,6 +1401,8 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     xen_pfn_t ioreq_pfn;
     XenIOState *state;
 
+    qdev_warn_deprecated_function_used();
+
     state = g_malloc0(sizeof (XenIOState));
 
     state->xce_handle = xenevtchn_open(NULL, 0);
-- 
2.21.3


