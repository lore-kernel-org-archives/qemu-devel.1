Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A20C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF53206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTHTSQ7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF53206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcMi-0001TS-Lp
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6w-0006pb-Iq
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6v-0006mw-Ki
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAfJ5/3TbHF/8WjmWYvb2QAzYmCal5x9QNrXZKyAwD8=;
 b=FTHTSQ7LRw3LKCJwFfBDgf+2uaTpe//f/4dqJf1sZ1aCEAdWPDx8SvSnau74sKEUHhIvVL
 OboO1VLNyIYmuTotpvxCjQVdYLzGKShagdpJIYR1chV+KNfMQRuqGY6ZhtDDFwNy66qBCI
 5O9G9Hfa+3559ZM9GahxI+v+8cdWY5U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-5krrOh1WMzmg3LZC7fOK0g-1; Mon, 04 May 2020 10:30:18 -0400
X-MC-Unique: 5krrOh1WMzmg3LZC7fOK0g-1
Received: by mail-wm1-f69.google.com with SMTP id h22so4991223wml.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9VtA+lfLhyvx9BGaosLru1/AAtx+gXAahmsNpkaZs5I=;
 b=TuBiMuRPw4K7GYMTSCndf84Ko+wZuS23GJSm1mJKrng0LkkMz4GN5v6plOBy1NSeuy
 28Bm4poV9kUUrObQ3MZ9LLeJr78tG8MbnrtQs1X0NOygzVBXR2G1ZdLhkHWdrk0+MldZ
 5TWOXrcR2M2bO6BbwOE7sUbZt15O9KbaEg7EuLdpwlY6sxUSh4E4gYw73pSIei4eKu4E
 C5720ECEe2w0mfuEzSqfJW5F3vAB7RTi+FTiq4cX+5CM+SYZWnmsEZPL/Iyz/6Zu6I5r
 H0ZRmu1RbBnsG++vNMzeU3e7lqJL9vJFGb/LNlbnhcebbd1wcxcSPxmqxyYweGYc/eLy
 +06g==
X-Gm-Message-State: AGi0PuZIC+kScUmzf/bCQ0V+FjkDudpKyAFB898oXK1FWVmUaku1mDu8
 /swE2FZdN6bzOLxUaJd5FRiQQVUAZov5js8tjmWgMYhWuMDT6aS5c30NHMMDjIXQ27+3t7vA5VY
 d2zlx9XIOicNi+yM=
X-Received: by 2002:adf:e582:: with SMTP id l2mr5949048wrm.392.1588602617587; 
 Mon, 04 May 2020 07:30:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypJt819Ha7ezsa30jzyl8gPBeY6EarOlgRO9Y52hho646cF735I+z+caggyygowvOgKUDGaLiQ==
X-Received: by 2002:adf:e582:: with SMTP id l2mr5949032wrm.392.1588602617435; 
 Mon, 04 May 2020 07:30:17 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 w12sm18914535wrk.56.2020.05.04.07.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:30:17 -0700 (PDT)
Date: Mon, 4 May 2020 10:30:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/29] hw/i386/pc: Create 'vmport' device in place
Message-ID: <20200504142814.157589-27-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20200504083342.24273-2-f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h | 6 ------
 hw/i386/pc.c         | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6ab6eda046..26e2a3d92b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -132,12 +132,6 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enab=
led);
 /* vmport.c */
 #define TYPE_VMPORT "vmport"
 typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
-
-static inline void vmport_init(ISABus *bus)
-{
-    isa_create_simple(bus, TYPE_VMPORT);
-}
-
 void vmport_register(unsigned char command, VMPortReadFunc *func, void *op=
aque);
 void vmmouse_get_data(uint32_t *data);
 void vmmouse_set_data(const uint32_t *data);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5143c51653..84669ddc84 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1152,7 +1152,7 @@ static void pc_superio_init(ISABus *isa_bus, bool cre=
ate_fdctrl, bool no_vmport)
=20
     i8042 =3D isa_create_simple(isa_bus, "i8042");
     if (!no_vmport) {
-        vmport_init(isa_bus);
+        isa_create_simple(isa_bus, TYPE_VMPORT);
         vmmouse =3D isa_try_create(isa_bus, "vmmouse");
     } else {
         vmmouse =3D NULL;
--=20
MST


