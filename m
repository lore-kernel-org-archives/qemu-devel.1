Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F00C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E932176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ/QdHqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E932176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yow-0000iN-2d
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yk7-0000C2-BU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yk2-0005H6-Hg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:15 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:54490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yk2-0005E7-86
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:10 -0500
Received: by mail-wm1-x332.google.com with SMTP id z12so2661477wmi.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P4E/uPANWEGduczzyeMY1IJA5ZlMSCF4bQjKlNViLv0=;
 b=iJ/QdHqpOE5sSgNc21wj0B8DHwvHGlWGhoVvvawviJV51Kp48+Ddx4KVAPkHZhcGsh
 xZSFdfYHcBobfYcZVdoZbOo91BatSOhJFNHYBz84yH7gciAgffc6co/G3ZtzvHhKHOIA
 qZXACBZhLQJhVWeCdsWDKiNSdjm53vkZZt/oJ5lM6WR8hKMZE8L6rLR0TX+XpAg9uLZP
 r4k/RrM9UHww+4ffxppDYwZg9mtkLR31Aqk2XRYDZX1o7MbW3m/hVVcucg8KM4yfCz1J
 3w43wt7ejwb/gx2bYgtALqKKxCr7G9zT0J30v2Uk2zD4VgOlOpUCAA3fhu8X/m6smCaf
 0yLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=P4E/uPANWEGduczzyeMY1IJA5ZlMSCF4bQjKlNViLv0=;
 b=jZ8kbi1UhjOUX0Z7L6f+s4u9R3MHK5adis2tz16T/yu9KrfhXIkZvaVrdHd6UHspwo
 Cf9vrv29NTAy3OBy+WVZHcsHHOffp4HE4xzj9yLgYUShe+KGozyqhFqYR2NUZRjbrVs7
 FhOGzJSIBQLGEUzLEvMgPeQRyuf1C8FoGrIXjjWFmrcpoBnfP55n9VI+6TwSUS4MsS2a
 4YilJkuiFQJgP9OfmxIyjcQyUS1QECDDpMGQz9qD1jVCN+F/tO0zao3e6btB1hw2IdUq
 eSCSfOF6qeFkkQRcJBxTeW71tRTnqtw8E42p+QCLALOAHX+N6LNb0/g+BPyKqx9gb/k7
 y8Ew==
X-Gm-Message-State: APjAAAWaCySzhm5Zn2pHXXgmbiN/ik1ZTSkkd8U/qgbLRlVL5uehvE2K
 dqFO9MUc9aMVYUXknK1nFZeNi/vr
X-Google-Smtp-Source: APXvYqzDV4W+MhCis0wHuIJkFSuh1bUX8pj7ouAilAgIJCWv9hV+pGRS+tce35lHOJ/7jZv1tmJubQ==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr4769428wmh.108.1582631468638; 
 Tue, 25 Feb 2020 03:51:08 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 002/136] machine: introduce memory-backend property
Date: Tue, 25 Feb 2020 12:48:52 +0100
Message-Id: <1582631466-13880-2-git-send-email-pbonzini@redhat.com>
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

Property will contain link to memory backend that will be
used for backing initial RAM.
Follow up commit will alias -mem-path and -mem-prealloc
CLI options into memory backend options to make memory
handling consistent (using only hostmem backend family
for guest RAM allocation).

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200219160953.13771-3-imammedo@redhat.com>
---
 hw/core/machine.c   | 24 ++++++++++++++++++++++++
 include/hw/boards.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 84812a1..1a6e485 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -508,6 +508,22 @@ static void validate_sysbus_device(SysBusDevice *sbdev, void *opaque)
     }
 }
 
+static char *machine_get_memdev(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return g_strdup(ms->ram_memdev_id);
+}
+
+static void machine_set_memdev(Object *obj, const char *value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    g_free(ms->ram_memdev_id);
+    ms->ram_memdev_id = g_strdup(value);
+}
+
+
 static void machine_init_notify(Notifier *notifier, void *data)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
@@ -889,6 +905,14 @@ static void machine_initfn(Object *obj)
                                         "Table (HMAT)", NULL);
     }
 
+    object_property_add_str(obj, "memory-backend",
+                            machine_get_memdev, machine_set_memdev,
+                            &error_abort);
+    object_property_set_description(obj, "memory-backend",
+                                    "Set RAM backend"
+                                    "Valid value is ID of hostmem based backend",
+                                     &error_abort);
+
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify = machine_init_notify;
     qemu_add_machine_init_done_notifier(&ms->sysbus_notifier);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index fb1b43d..7b4b6b7 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -4,6 +4,7 @@
 #define HW_BOARDS_H
 
 #include "exec/memory.h"
+#include "sysemu/hostmem.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/accel.h"
 #include "qapi/qapi-types-machine.h"
@@ -285,6 +286,7 @@ struct MachineState {
     bool enforce_config_section;
     bool enable_graphics;
     char *memory_encryption;
+    char *ram_memdev_id;
     DeviceMemoryState *device_memory;
 
     ram_addr_t ram_size;
-- 
1.8.3.1



