Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFB4C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D9D2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRhKHZtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D9D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafYH-0006Z2-4Y
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUE-0001Jd-Ky
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUA-0003R1-Sx
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yw2kauyKMh3FQod1x634Vpf4/YB25IOYhhK07dk3RPA=;
 b=gRhKHZtUveB2QYG4+jgEJ6Xuo5OcJV7JAWqMRiDWnvTaUbgd733EYHHHr2TeTzxdsRJTVO
 5Pha13UfdJ0GH3V4ulOnftkfe/p7+HU9V+mG538/D/3sLSwN6dwdo7DSao33/Q4qIww4ii
 rOaQdiEOCiT+EptgEpfwdf1+tCk6krk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-fn6n59uDNf62MqpSoJUAxg-1; Thu, 05 Nov 2020 08:39:26 -0500
X-MC-Unique: fn6n59uDNf62MqpSoJUAxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFEACE06A4;
 Thu,  5 Nov 2020 13:39:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C7E55C5DE;
 Thu,  5 Nov 2020 13:39:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BF5A99C90; Thu,  5 Nov 2020 14:39:23 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/12] microvm: drop microvm_gsi_handler()
Date: Thu,  5 Nov 2020 14:39:17 +0100
Message-Id: <20201105133923.23821-7-kraxel@redhat.com>
In-Reply-To: <20201105133923.23821-1-kraxel@redhat.com>
References: <20201105133923.23821-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the improved gsi_handler() we don't need
our private version any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/microvm.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 5e4182b47464..829b376a1278 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -96,13 +96,6 @@ static void microvm_set_rtc(MicrovmMachineState *mms, ISADevice *s)
     rtc_set_memory(s, 0x5d, val >> 16);
 }
 
-static void microvm_gsi_handler(void *opaque, int n, int level)
-{
-    GSIState *s = opaque;
-
-    qemu_set_irq(s->ioapic_irq[n], level);
-}
-
 static void create_gpex(MicrovmMachineState *mms)
 {
     X86MachineState *x86ms = X86_MACHINE(mms);
@@ -163,12 +156,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     /* Core components */
 
     gsi_state = g_malloc0(sizeof(*gsi_state));
-    if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
-        x86ms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS);
-    } else {
-        x86ms->gsi = qemu_allocate_irqs(microvm_gsi_handler,
-                                        gsi_state, GSI_NUM_PINS);
-    }
+    x86ms->gsi = qemu_allocate_irqs(gsi_handler, gsi_state, GSI_NUM_PINS);
 
     isa_bus = isa_bus_new(NULL, get_system_memory(), get_system_io(),
                           &error_abort);
-- 
2.27.0


