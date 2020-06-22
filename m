Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53781C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1D520716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 11:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C80CJe17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1D520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnKtZ-0000ic-E0
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 07:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnKe1-0003HW-SS
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:29:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45698
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jnKdv-0008UL-6D
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 07:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592825377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=n9gEp/xzU4Jl1uFmXCKYIOaUv/dWWxCJ7gLxetTRaDc=;
 b=C80CJe172q3Uqvnsefho067o218SmXzMPExzelR3Anq+WAa9dXNPPgFEvQHVbHRj+1XoRT
 y6ukD8b4j+v0diZ0sTLEKUb/mK7+krk78ogEvr3R76oyLhPKSyDfQMZYiSZaVrshdBWF8F
 ygaxutd4RCh3YCfG0AbyOKjkcPRdGwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-baEOfVpxOYeeMpysdqNZfA-1; Mon, 22 Jun 2020 07:29:35 -0400
X-MC-Unique: baEOfVpxOYeeMpysdqNZfA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA30C19200C5;
 Mon, 22 Jun 2020 11:29:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FCE95C221;
 Mon, 22 Jun 2020 11:29:33 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C5BA39D02; Mon, 22 Jun 2020 13:29:14 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/19] audio: create pcspk device early, add audiodev alias.
Date: Mon, 22 Jun 2020 13:29:13 +0200
Message-Id: <20200622112914.30454-19-kraxel@redhat.com>
In-Reply-To: <20200622112914.30454-1-kraxel@redhat.com>
References: <20200622112914.30454-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Create the pcspk device early enough that we can create an audiodev
property alias for the machine type.

pcspk init works now with "-audiodev <backend>,id=<name> -M pc.pcspk-audiodev=<name>".

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc.c         | 5 ++++-
 softmmu/vl.c         | 4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 283754f42bd5..3290b0b93097 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -33,6 +33,7 @@ struct PCMachineState {
     PCIBus *bus;
     I2CBus *smbus;
     PFlashCFI01 *flash[2];
+    ISADevice *pcspk;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3f1d42b05102..bd393f82377f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1240,7 +1240,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
             /* connect PIT to output control line of the HPET */
             qdev_connect_gpio_out(hpet, 0, qdev_get_gpio_in(DEVICE(pit), 0));
         }
-        pcspk_init(isa_new(TYPE_PC_SPEAKER), isa_bus, pit);
+        pcspk_init(pcms->pcspk, isa_bus, pit);
     }
 
     i8257_dma_init(isa_bus, 0);
@@ -1912,6 +1912,9 @@ static void pc_machine_initfn(Object *obj)
     pcms->pit_enabled = true;
 
     pc_system_flash_create(pcms);
+    pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
+    object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
+                              OBJECT(pcms->pcspk), "audiodev");
 }
 
 static void pc_machine_reset(MachineState *machine)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index b8dc1f5a0e86..e8580ccaa2c6 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4287,6 +4287,8 @@ void qemu_init(int argc, char **argv, char **envp)
             exit (i == 1 ? 1 : 0);
     }
 
+    audio_init_audiodevs();
+
     /* This checkpoint is required by replay to separate prior clock
        reading from the other reads, because timer polling functions query
        clock values from the log. */
@@ -4344,8 +4346,6 @@ void qemu_init(int argc, char **argv, char **envp)
         create_default_memdev(current_machine, mem_path);
     }
 
-    audio_init_audiodevs();
-
     /* from here on runstate is RUN_STATE_PRELAUNCH */
     machine_run_board_init(current_machine);
 
-- 
2.18.4


