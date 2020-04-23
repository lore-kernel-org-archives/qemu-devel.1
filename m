Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDE9C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B758D20736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmL89yyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B758D20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRal6-0006eW-Sz
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 08:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jRahO-00024u-I3
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jRahO-00086n-0l
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:11:22 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:38113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jRahN-00085Y-KW; Thu, 23 Apr 2020 08:11:21 -0400
Received: by mail-lf1-x143.google.com with SMTP id l11so4551603lfc.5;
 Thu, 23 Apr 2020 05:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZzALLD5JjgtTBfQ7kca+0KHNMa+Pi21VHypSM0MfNpQ=;
 b=pmL89yyfWHWglmE3kQKcGQ8tGr905N32Yd47/kpbYIy6W8zaGQXS5rnA7JAjukvLqI
 1dmOamjnoFfAAAU2lrmYNw9KUN3Gjjyrsu4edSAAgz/jsopzrdX31PUQIgPeECJlKRGd
 3GklfZyl7kk5bvbbi0kluRaaYMnwfXtYGAUFMQAWaSa0yqyNe70EKote4E3f+4e9TGX5
 aBOo8x4HARGo9btgFRptCSn5zYUN9KAru5CIp5F+NhUJ7AGs5KfXQ/ri/img+PGShWwp
 BAMAx/VaeZjvoEgl6QvxocLr+r4Q95VqWrAgp5sjVCKpk3SsWmE1uwhrHEVIG8mZ6Yrx
 H9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZzALLD5JjgtTBfQ7kca+0KHNMa+Pi21VHypSM0MfNpQ=;
 b=iKArPlPGbsX8/zbobyLWiAgEL7Y29+iLi2liEnwRym/3FQ+KUQiiEru8pNcAfLc6Kq
 kcSUGHxDvJy1SeB48V5PrVYGDhKmQVw0Ip2Fb+FltfSzej81lWHespfUjneycnoX3ztu
 ViogbvTUnfilvpJUW78RqIaAcfA2aqntG2Vc4eibUFk5v4X5x4YG5g/AD2Iqxy00yI/d
 3Au5Qr3xPhmGEnKHewFiRaKp6zeLvQFMn1lGOi85VRU6T322/EvPX1fsmzPqQz1Sh7zk
 nRQS8lnFyynM0TS15KFPnb32rFpapZlhuctzEpPUQe22XuBlvR1wh65pdJHk4CTWNxMT
 aatQ==
X-Gm-Message-State: AGi0PuZDuceEJWFVwrkbz2PzTYfi47WNaRdIE2AxGMhrFyen9dlahJLO
 31Ic0H+CMAEMhL7S3Oi4yF4nyoUhUvQ=
X-Google-Smtp-Source: APiQypIGPdKDAHnaDhGdqauQepbYbTlNoqh/i5cS37Yyi20b5AofVsz6fhTkQOzvFqzycjqRhqsmsQ==
X-Received: by 2002:a05:6512:52c:: with SMTP id
 o12mr2161976lfc.217.1587643879397; 
 Thu, 23 Apr 2020 05:11:19 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id c2sm1739088ljk.97.2020.04.23.05.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 05:11:18 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102
Date: Thu, 23 Apr 2020 14:11:13 +0200
Message-Id: <20200423121114.4274-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423121114.4274-1-edgar.iglesias@gmail.com>
References: <20200423121114.4274-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::143
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Move arm_boot_info into XlnxZCU102.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-zcu102.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index bd645ad818..4eb117c755 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -31,13 +31,14 @@ typedef struct XlnxZCU102 {
 
     bool secure;
     bool virt;
+
+    struct arm_boot_info binfo;
 } XlnxZCU102;
 
 #define TYPE_ZCU102_MACHINE   MACHINE_TYPE_NAME("xlnx-zcu102")
 #define ZCU102_MACHINE(obj) \
     OBJECT_CHECK(XlnxZCU102, (obj), TYPE_ZCU102_MACHINE)
 
-static struct arm_boot_info xlnx_zcu102_binfo;
 
 static bool zcu102_get_secure(Object *obj, Error **errp)
 {
@@ -166,9 +167,9 @@ static void xlnx_zcu102_init(MachineState *machine)
 
     /* TODO create and connect IDE devices for ide_drive_get() */
 
-    xlnx_zcu102_binfo.ram_size = ram_size;
-    xlnx_zcu102_binfo.loader_start = 0;
-    arm_load_kernel(s->soc.boot_cpu_ptr, machine, &xlnx_zcu102_binfo);
+    s->binfo.ram_size = ram_size;
+    s->binfo.loader_start = 0;
+    arm_load_kernel(s->soc.boot_cpu_ptr, machine, &s->binfo);
 }
 
 static void xlnx_zcu102_machine_instance_init(Object *obj)
-- 
2.20.1


