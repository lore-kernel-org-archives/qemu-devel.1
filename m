Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDA2C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FFF218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGetfByx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FFF218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z9T-00037X-Ni
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykd-0000md-Dl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkZ-00071S-Gq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:47 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:38654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkZ-0006ul-9Z
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:43 -0500
Received: by mail-wm1-x332.google.com with SMTP id a9so2847316wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EF1xxDl20iyMhk1ftjp9b02tb0F6Nx8GjS3T9tHjvyw=;
 b=vGetfByxwgBaTrHblfZFuUYcGpdoyOdJUFxe0n8C6IrgIDpXQr4NC3Eel9rrNzV5+Z
 qfiC56z8sAPhlHo3NhnadunEizOpseZeHoRoMgobimnPAUHZjtR1FR7epEIEjWU9Tr+u
 kw1TahW6BWo8l7X0yxaGq+Y2qy2LcxgUe5EhoGZ5mSIHimeTe3NmSRHsCqxZc/Z0W3vS
 32JnYZ7C9LpziwuUukohj0lsShYMtAb9c4VcYZhGnrJyx698VNTkyG6CLStBdABrHvLl
 rpN7E8JhVQ3Ub0zCnBGtooArLPwB4oKBDCzqz8IPS9BSj3BsmR9dnBbpUBwHWoKcU278
 27aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EF1xxDl20iyMhk1ftjp9b02tb0F6Nx8GjS3T9tHjvyw=;
 b=JnuEAqDoR1odG7FmjfVapNSOCHd3lgxigbJ2p4SojAKzD5Y6DJRzRP8KXczN8gpzhn
 qFPeCc8ikAMzZjv0dGAdvEyNZe4Zm6iJ4TtwtGPg2G2XJSpe5MI/2Nk78ggvvcj1fcAc
 LFvr0lHjLcEotqIZCN55Box9ECNrNvAtp6s9mUDvKSA1d4poY3iA6gMAzsk0B1KzJqtq
 Xl+k4r3ZnIGURL0ko5HDw7Th0vfDFSTkYNeUoszVcgS7fmiyQ9e7Id2MVa+4ns1EIDoy
 ZYtwkQbFV3DsK+iWhRPPs1YL0v6iLSnGkHmXCVi9Lprl56cQXIpaj1loxWI5G8cDmpVd
 UHGg==
X-Gm-Message-State: APjAAAWnbAbOk0k2KWz8NGDms0kvkucHEbB6IhHZMLFgCfYVvmyQqTBl
 5bb9/LlV5VI9HAe6usT8+PhpfEeO
X-Google-Smtp-Source: APXvYqyrz7+e11O0/5bVoICh0a/UKA9qof4SlHhGZUTkx761cDcK7TZfq1TxIMhZCCvkW3DNpRxWHA==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr4830674wmi.14.1582631502111;
 Tue, 25 Feb 2020 03:51:42 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 038/136] s390x/s390-virtio-ccw: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:28 +0100
Message-Id: <1582631466-13880-38-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Tested-by: Halil Pasic <pasic@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-39-imammedo@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e759eb5..a89cf4c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -154,14 +154,12 @@ static void virtio_ccw_register_hcalls(void)
                                    virtio_ccw_hcall_early_printk);
 }
 
-static void s390_memory_init(ram_addr_t mem_size)
+static void s390_memory_init(MemoryRegion *ram)
 {
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
     Error *local_err = NULL;
 
     /* allocate RAM for core */
-    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
     memory_region_add_subregion(sysmem, 0, ram);
 
     /*
@@ -245,7 +243,7 @@ static void ccw_init(MachineState *machine)
 
     s390_sclp_init();
     /* init memory + setup max page size. Required for the CPU model */
-    s390_memory_init(machine->ram_size);
+    s390_memory_init(machine->ram);
 
     /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
@@ -471,6 +469,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     hc->plug = s390_machine_device_plug;
     hc->unplug_request = s390_machine_device_unplug_request;
     nc->nmi_monitor_handler = s390_nmi;
+    mc->default_ram_id = "s390.ram";
 }
 
 static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)
-- 
1.8.3.1



