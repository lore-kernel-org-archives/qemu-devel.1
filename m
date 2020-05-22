Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB45EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6D93206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 17:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIpMgH0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D93206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcBVv-0006Oh-RV
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 13:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQi-0005K2-IN
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcBQh-00026e-Hc
 for qemu-devel@nongnu.org; Fri, 22 May 2020 13:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590168354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XefzKKReH8eZhhydRDilC7RKuHWXd4LHlHsJ6jQQ1Og=;
 b=IIpMgH0ksux4x4rN55IpFH/RhOLaXvis7viGj2wluGQwIznPzrLuhKuVGqEjbe7V1drEAx
 gmoJ2/blXCJJp+/rdc/g5oq1zgGEHz59XViHtVGVBFxPRwGiMYUR4VyHpbCOTOJozmvDss
 LHf7bZ20NVkAh5/gneXVcYgiMjsFlk4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500--3oSRM-6N2W5_86N5A_JZA-1; Fri, 22 May 2020 13:25:53 -0400
X-MC-Unique: -3oSRM-6N2W5_86N5A_JZA-1
Received: by mail-wr1-f70.google.com with SMTP id q13so4669266wrn.14
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 10:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XefzKKReH8eZhhydRDilC7RKuHWXd4LHlHsJ6jQQ1Og=;
 b=H6VYZR28zv6M2iYSjnBzT6RPd3lzawLbjNLavFL9h4ghj31hvWME9uc3DDar8Plmon
 WrAjRNJsO3D9tmqoKEKrqpM6VY8DI0QNscJ0qPj74lEV9aNDl0wyfKRHT0KNh/ncioiH
 os6VjPViOHUfANV3xjZjoMoF1mxoX+BrUsw33htSBLCFyTMiC5+exhIG/TIqnME5e5/V
 4KXMnlWUnrqpmoS8i+nGlKBmDSxVM05Z4Jn2a1h96VMj6oK+ZIIHrKbBN9zKNpBYwx5l
 C7FAb45wwH0q//EHylFMaZ3v7LpQoFws7/Q86ahY6oyurHZxRBtccKPVROxxhjS4EZgM
 zbtg==
X-Gm-Message-State: AOAM533hD8TD20L0S/RcoxoNl5/2vcUDUJ57WXF6vkPTYDB4YgySI9Lw
 O61kxC8kBNg3Zc7Z5h2xGq/HnKBBF6UnizOiyn/PGPkSNs0SXvtTAkKXQC6kgEweNtFojmbt490
 mDA10j6lL/95nsRA=
X-Received: by 2002:a7b:c750:: with SMTP id w16mr15078734wmk.73.1590168352031; 
 Fri, 22 May 2020 10:25:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpgj1fIRtXMBFxyv6VxoiRKNc0LOatBF77ySHbAPhKzlIGe3APHYx941CDpkTjoxdNmx5JWg==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr15078719wmk.73.1590168351850; 
 Fri, 22 May 2020 10:25:51 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id z10sm10050615wmi.2.2020.05.22.10.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 10:25:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/13] exec: Assert CPU migration is not used on user-only
 build
Date: Fri, 22 May 2020 19:25:05 +0200
Message-Id: <20200522172510.25784-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522172510.25784-1-philmd@redhat.com>
References: <20200522172510.25784-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 10:36:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 exec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 5162f0d12f..6dfd314469 100644
--- a/exec.c
+++ b/exec.c
@@ -946,7 +946,9 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 
     qemu_plugin_vcpu_init_hook(cpu);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+    assert(cc->vmsd == NULL);
+#else /* !CONFIG_USER_ONLY */
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
     }
-- 
2.21.3


