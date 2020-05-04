Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ADCC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F111C2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDngqIPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F111C2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVewQ-0002Y9-2C
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVeq9-0002Ps-IF
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVeq8-0005OO-8N
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588613111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKFemNLKvLsfWugRqwCsKjdZxDFrpd75fXOIrjBACXk=;
 b=HDngqIPOcMQH23uaOzfjn7ru9Q2ujp6HJ2K1fMt3K7oQbWgwLnMVfpPRGrNi6HSKhrsR/y
 4SpGOiZK8Fp7svSlAEcMAeRNwbWkxPMb1ma30RaEb6k0cRT4VEOUfQeirsY7lF2bNRVIeE
 RcFoXe3m67heOV05iFetActK1lu1VQM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-KejHfgNvMOqFp-ex_LjPGA-1; Mon, 04 May 2020 13:25:09 -0400
X-MC-Unique: KejHfgNvMOqFp-ex_LjPGA-1
Received: by mail-wm1-f71.google.com with SMTP id h6so309347wmi.7
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6FZZJFR4wX+R6WdyE1qjITEUJ4N+wtsCncRkTmCNCbM=;
 b=Zh+j8ROmSkGDGEi/VFZZt61wGezK1JyusdBGspUrtXixaU5USyK3dbpkx7JJg0gCIK
 ZIghWJdPWg8Y9Bd/828mdTZM4aHXAhCKj86UiT7evOg42VjOAd8MUhEQDvEKhK5YOO5i
 sx4X85ZlXcZcqxidpciKg9pu/ghDC51TPGpwHJ9SIb1HDuPvXuVPfRyAELMBuGsePCyl
 lpIOTvEVMdNTm4ucf1MTsGGDq2BlYV2BCNTnzZYSThaeIrKE5MIvTqTwhKB1W1KE+mWa
 ugwCkm+JKYU1+dVwNO2zfx7m4ny46dqvH3qmV+7oMHcDZPGZA1JvVkDbK//xL5jToJUy
 UkyA==
X-Gm-Message-State: AGi0PuZzjAxUJxRyL6aOVOZhGwDqbeNBifXlriYv6jhTLLCJPC1eSvMp
 kkxf7gvRYsrbBoHZEsifixfOjvk8R3/tXQaEu3hFkqFSu5UwiGsn2CETn3umTx4A4T01OxK9cZh
 LmQ4AM4BIWfK8oIk=
X-Received: by 2002:a1c:dfc6:: with SMTP id
 w189mr16476866wmg.180.1588613108452; 
 Mon, 04 May 2020 10:25:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypLI1mPvZDPhY+ZKH4LyKu9+4Ct2WceO2vbk58+8cFyptnnTVQoShNUZ6mIi70U6BLHVVv2kBA==
X-Received: by 2002:a1c:dfc6:: with SMTP id
 w189mr16476851wmg.180.1588613108237; 
 Mon, 04 May 2020 10:25:08 -0700 (PDT)
Received: from x1w.redhat.com (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id n9sm19844703wrx.61.2020.05.04.10.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 10:25:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] target/arm/cpu: Restrict v8M IDAU interface to Aarch32
 CPUs
Date: Mon,  4 May 2020 19:24:47 +0200
Message-Id: <20200504172448.9402-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200504172448.9402-1-philmd@redhat.com>
References: <20200504172448.9402-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As IDAU is a v8M feature, restrict it to the Aarch32 CPUs.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b4d73dd47c..a10f8c4044 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2889,7 +2889,6 @@ static void arm_cpu_register_types(void)
     const size_t cpu_count =3D ARRAY_SIZE(arm_cpus);
=20
     type_register_static(&arm_cpu_type_info);
-    type_register_static(&idau_interface_type_info);
=20
 #ifdef CONFIG_KVM
     type_register_static(&host_arm_cpu_type_info);
@@ -2898,6 +2897,7 @@ static void arm_cpu_register_types(void)
     if (cpu_count) {
         size_t i;
=20
+        type_register_static(&idau_interface_type_info);
         for (i =3D 0; i < cpu_count; ++i) {
             arm_cpu_register(&arm_cpus[i]);
         }
--=20
2.21.3


