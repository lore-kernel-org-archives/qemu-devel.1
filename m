Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BBBC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC982176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4zQS3jA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC982176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z77-0007wT-Sk
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykd-0000lg-3W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkY-0006vc-SY
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:46 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:39093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkY-0006qJ-DU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:42 -0500
Received: by mail-wm1-x32c.google.com with SMTP id c84so2833211wme.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+mJK3OqxktkOAWxnxWkaALqDjs9dEYFvgQPqxO7ZMJk=;
 b=Z4zQS3jAv0bMtAO/gHwRsql1enZKoYoggDk80pJO3oQJ7sUCX1ZkqVhhB++UqYY+Mp
 UYyE4fDHjt9U8qQQCMMTCh6D9RmNLiYBvxs7C2FtMn2d26pzkE8mSNaf5cnqNjA/hrwQ
 YPKRqmZmO9K2m8BDifyZbwV4VEkQDRV8os+ddQAqxjU01zk8evTEubM91WMKau7JqrGA
 nBxQQLaCs92gEeAitdVonPOB1/1Dm7H6nOtB/+0t+tJ6hkau2gMQHLa/BQINbFlQW9FC
 ZAOztztOADVm2p+MarHQdClrXY3BtKFHoJdw17BwRIfkAqWutkLK0GWfE6ILIRhsUH6P
 ioEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+mJK3OqxktkOAWxnxWkaALqDjs9dEYFvgQPqxO7ZMJk=;
 b=oQvk6uDk6Jq0syssWLx5lmnEQzNzuGFkMOvZep7MHujxDTTcasW9hlwcDOSpwG4Br6
 odU84PNW9fMynSjeWdyUykAVoTCnECYcBxgjVHvD5f09omuoK0RdXiL1ZlGEhsySfPy2
 2pIU+oT4gRBSR/zWLEqQ0nY0a0JFrQbJg8Z29DWRLIOTvlHBshC4ncnpp8Qh/hqC2b/x
 GUgQJZ5y5SUjfEk9E4nYttWVQ3uJeWuYOLXp/WqJNBug8Fv33gVOdVgGopj6GxHda2mR
 JQHBHNzolFLNjW9nfZtKZ3jRjx6L0yQef5HmkNrBR8XOD4nTNi1vkuDmZR5rFMgBhUPu
 2+bg==
X-Gm-Message-State: APjAAAXPFM3FdzIY7EuozWSXOGWfyq7gV0DThnZUolLPpZ4ZZCMe8BQe
 p1m/r/r9q7CXCMmBxMxTCZAi1lZc
X-Google-Smtp-Source: APXvYqz+d8ro9113LDhzyT7DR2cIy9YqI2lgtW9tiQnxMuJZhlL5MAb1P3EfzA4yYCO/Ska/h8FgMA==
X-Received: by 2002:a1c:e488:: with SMTP id b130mr4772327wmh.108.1582631501237; 
 Tue, 25 Feb 2020 03:51:41 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 037/136] arm/xlnx-zcu102: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:27 +0100
Message-Id: <1582631466-13880-37-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-38-imammedo@redhat.com>
---
 hw/arm/xlnx-zcu102.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 53cfe7c..bd645ad 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -28,7 +28,6 @@ typedef struct XlnxZCU102 {
     MachineState parent_obj;
 
     XlnxZynqMPState soc;
-    MemoryRegion ddr_ram;
 
     bool secure;
     bool virt;
@@ -87,13 +86,10 @@ static void xlnx_zcu102_init(MachineState *machine)
                  ram_size);
     }
 
-    memory_region_allocate_system_memory(&s->ddr_ram, NULL, "ddr-ram",
-                                         ram_size);
-
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
                             TYPE_XLNX_ZYNQMP, &error_abort, NULL);
 
-    object_property_set_link(OBJECT(&s->soc), OBJECT(&s->ddr_ram),
+    object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
                          "ddr-ram", &error_abort);
     object_property_set_bool(OBJECT(&s->soc), s->secure, "secure",
                              &error_fatal);
@@ -211,6 +207,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
     mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
+    mc->default_ram_id = "ddr-ram";
 }
 
 static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
-- 
1.8.3.1



