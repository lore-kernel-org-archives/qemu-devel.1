Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197ACC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7870820738
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 16:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQO2/jQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7870820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFg6D-0008FX-F8
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 12:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyb-0004tg-1W
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:56:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34876
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFfyZ-00042S-4V
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599580566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BaphSdiGhAZ4WeZEOB6GUUl46i+DVX/CX44TODloQyM=;
 b=OQO2/jQtnj06aWyy6m2mXgxw+CKr7RxR9RU3GEOx9Dux8xx81tNuzOZRIn8heQXveDso1/
 0mC1RL7K+JLk2p6+6GiwDKCycAf4ujvEj44fvRDWiSJpSvsVOYSEosYU0CD4PXN1UfsVch
 bksJ07MQTKgEtBItdQxIf4/5Q/tKKl0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-EoqpYTViO9ms0Wklr6Q-MQ-1; Tue, 08 Sep 2020 11:56:04 -0400
X-MC-Unique: EoqpYTViO9ms0Wklr6Q-MQ-1
Received: by mail-wr1-f69.google.com with SMTP id g6so7148267wrv.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 08:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BaphSdiGhAZ4WeZEOB6GUUl46i+DVX/CX44TODloQyM=;
 b=mT5sy/a+9bdNgumH1rmkPovIaCuO8boATOUaKdOVidHqlvgcupwHKgiFVdL4OYE3zr
 /jmEgtk331to834VdzvxNZcmbkYak8o1wNeTBZ5RKYmRm6Cw7Myl3sneRlGgpvuQAoM5
 fDUPIuawUmESzd8FdjCn+fJwCFgxt6I7olzVmWLEZrVbTAR3yshMhSsFdpw3Vhn7GN7Z
 WiAdlKntdG/cwhzy5Ak8GsLTjlBx4igcaUanm+a22MBcFSsflOHF0kAazXXLFKKpRM3p
 qTe6Hh7rJxojSDr/LEuHeX1gMXTgjb4Y1UvYH4NmGyu5DOorijDQSICvxM9LDm7Z0yYz
 mQGw==
X-Gm-Message-State: AOAM530XSN1npswDbmBiGDEw3fhMow/1uFSlAJjRPujPAWWnQwZsupLU
 s94BEXDyfibG3MCPSOZBQgRWpQFxuLXmkpfjsyBO0k+CnHX3riqEwzIkyF28VPHYvtUBPxjPHuq
 wOuX4trl3jsKBXOU=
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr162453wmi.135.1599580562476; 
 Tue, 08 Sep 2020 08:56:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyALjQfs+9IOfen4Ye454tvzuEGIBzUvWIDpuXevuX4q2Ul/ulBEnGqrdlon8zddGjC4+VrrA==
X-Received: by 2002:a7b:c40b:: with SMTP id k11mr162434wmi.135.1599580562312; 
 Tue, 08 Sep 2020 08:56:02 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d6sm34124785wrq.67.2020.09.08.08.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 08:56:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] typedefs: Restrict PCMachineState to 'hw/i386/pc.h'
Date: Tue,  8 Sep 2020 17:55:30 +0200
Message-Id: <20200908155530.249806-7-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908155530.249806-1-philmd@redhat.com>
References: <20200908155530.249806-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The PCMachineState type is only used under hw/i386/.
We don't need to forward-declare it for all architectures,
restrict it to the X86 one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/i386/pc.h    | 4 ++--
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index fe52e165b27..d4ebefcf2b4 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -19,7 +19,7 @@
  * @boot_cpus: number of present VCPUs
  * @smp_dies: number of dies per one package
  */
-struct PCMachineState {
+typedef struct PCMachineState {
     /*< private >*/
     X86MachineState parent_obj;
 
@@ -50,7 +50,7 @@ struct PCMachineState {
 
     /* ACPI Memory hotplug IO base address */
     hwaddr memhp_io_base;
-};
+} PCMachineState;
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
 #define PC_MACHINE_MAX_RAM_BELOW_4G "max-ram-below-4g"
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 427027a9707..6281eae3b55 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -90,7 +90,6 @@ typedef struct PCIExpressDevice PCIExpressDevice;
 typedef struct PCIExpressHost PCIExpressHost;
 typedef struct PCIHostDeviceAddress PCIHostDeviceAddress;
 typedef struct PCIHostState PCIHostState;
-typedef struct PCMachineState PCMachineState;
 typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
-- 
2.26.2


