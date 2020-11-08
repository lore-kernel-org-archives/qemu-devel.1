Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52484C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C09206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6LtN4pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C09206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrlb-0007aP-SM
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:58:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbt-0005oW-Si
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbs-0000a5-2c
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzWt1qDKwVED4KYkWX6MIPCKsj2TKTK/b4JiHS7BZWA=;
 b=h6LtN4plwCs5djLtC7bRwksW1xla147Sf6A25IHd8UH0PIGLvjjyhdmvayxM07nkrGDPkn
 RIn6bGvc1eyt0CLaWTppsbUs8dyo1ohbCFgRtCgeHrLQFmvUfJhpIMhF6tiQdxjqmk8qOs
 Obmrr6ukLn84FAW+Ro7rU0SkEHVlrTY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-fIuPPh0NPKmwRnid4xiLng-1; Sun, 08 Nov 2020 15:48:21 -0500
X-MC-Unique: fIuPPh0NPKmwRnid4xiLng-1
Received: by mail-wr1-f72.google.com with SMTP id q1so3386332wrn.5
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:48:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fzWt1qDKwVED4KYkWX6MIPCKsj2TKTK/b4JiHS7BZWA=;
 b=gcEUcJunWoMBGW1tvz3zi/BtVJjV9Wrqcpm52sl8yEBtIZ+ZsCHZ9HK3+Yf4pyVNHH
 qzpWwxpaSxtmBFQgasgj5hV/128wJT83alvyRr9qvvZMTUXNXqj2CvKeXARFuegzbzyK
 X8Bv+K6VDEHmGlDMQpin9pJp6GPTZ19wiK6mc2iXUAsRVkuQKqEhWXVoGz4ImSPULhdV
 JgDU/ezHF0j1msnQvWh4lN4uk2jh5BYZ+9fT0WdVJ+OdyWCQwRJvs6zIjM5s1TImOAym
 e9CeevsPu3nVCaeG6Qt/831GUhFQcvy3NlOU/g2tevdTVVVppc/vyY5B1NBzBVvrcbAo
 Vi5w==
X-Gm-Message-State: AOAM531aH0UvJWTBx3cpnrc9lsvUmR5XhTkoZz4y53QzyQ5EEs/R4e9w
 GmGRpuS721QTueFQmrsAIenOGjD5biKpeKA0Be4GUtvHYGTdX9d+NlK7thK1cFiDFQCtXssPPIF
 +GOY9iq/TRPFYo+Y=
X-Received: by 2002:adf:e992:: with SMTP id h18mr4849150wrm.356.1604868500416; 
 Sun, 08 Nov 2020 12:48:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEzpwNGG+JyEheuQemZNlT+vAgGFs5jDmM/lFwMY+renp/vqGB6xnp24O+P9nfpsofOCes8w==
X-Received: by 2002:adf:e992:: with SMTP id h18mr4849129wrm.356.1604868500284; 
 Sun, 08 Nov 2020 12:48:20 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id s9sm12227336wrf.90.2020.11.08.12.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:48:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 16/17] gitlab-ci: Make some ARM 32-bit jobs optional
Date: Sun,  8 Nov 2020 21:45:34 +0100
Message-Id: <20201108204535.2319870-17-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:03:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The armel/armhf targets have a lot in common. Instead of
testing both user/system emulation on each target, test
each one once. Mark the other combination optional, so
user can still run the tests manually.

We now test system-mode emulation on armel target, and
user-mode emulation to armhf target:

- armel-system          Yes
- armel-user            Optional
- armhf-system          Optional
- armhf-user            Yes

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: qemu-arm@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
---
 .gitlab-ci.d/crossbuilds.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 03ebfabb3fa..e4526e98232 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -32,11 +32,17 @@ cross-armel-user:
   <<: *cross_user_build_job_definition
   variables:
     IMAGE: debian-armel-cross
+  rules:
+    - when: manual
+      allow_failure: true
 
 cross-armhf-system:
   <<: *cross_system_build_job_definition
   variables:
     IMAGE: debian-armhf-cross
+  rules:
+    - when: manual
+      allow_failure: true
 
 cross-armhf-user:
   <<: *cross_user_build_job_definition
-- 
2.26.2


