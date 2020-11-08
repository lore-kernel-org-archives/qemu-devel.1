Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5424C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295D2206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWbSGoTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295D2206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrmV-0000Zt-8C
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbd-0005E0-Gh
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbb-0000Yz-VI
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VembaEi0P815WTgBWwDrxMRk/B71iS1mYulR9D5rz1U=;
 b=iWbSGoTIffM/iJ2LReTcDwoJ3KfxlT+fk+ScW71IcYwmwZ2+zkkavwKZO1Zajg1eSOswoH
 ORWJFKb2oTJgT1Vb1+IVUfeX9yAlTst7DNVvpy57Tjn+kGCVX8C2dYnZXWBb5/W06rUYN8
 jEdYtIBUfdcYyMhxBw1bt4aUiIdjT2o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-ZBafgUPvO6OEJ8rhQDxNWg-1; Sun, 08 Nov 2020 15:48:05 -0500
X-MC-Unique: ZBafgUPvO6OEJ8rhQDxNWg-1
Received: by mail-wr1-f69.google.com with SMTP id h11so3363719wrq.20
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VembaEi0P815WTgBWwDrxMRk/B71iS1mYulR9D5rz1U=;
 b=D2Npt2mG1Tf2rQxn1AcZsH+VUU4WqXJjyLxVVPXIWE8X3kBVVSq9g2NW5jdXOjXGmj
 83u/7wM+GeIK9n/52DT/xvpIrVyFbe8WPPPkWHRAfeRfJ59Jak2kpzw+nc+Nh8sdcy4B
 6ZER+MdS9SobEL0AbHB3OtJ+54UT1Qs7i4WDGjgJg4ggxxc099dGGsxqDuyiEaebrHs0
 Qc6FWLXzr+0FoPw7UC/Ch6urgXvykaYhopRdapgK39VRYgU8qbZVrEcFKgwBm2axcMRm
 X5duJjHIjqxU+E5vr/yINkUkTHbk4Hm5OotLo0NHUW6nPqDkwRgfu3Jst1VSPN3xz7bs
 yH1g==
X-Gm-Message-State: AOAM532cQoB9E4ZkbN8icdbI96acQvV35+kNHtxMHM2loT0amRn6chz9
 daYGsmadj2NGtcFPnL0q3FzlaQmYY0yYnMWWVM7JXdXjRk2VQM5kyilitYmQfeizxKqXhfoihUq
 7aoq9ue7tVYofZdk=
X-Received: by 2002:a1c:4b0c:: with SMTP id y12mr11599733wma.91.1604868484032; 
 Sun, 08 Nov 2020 12:48:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDSfSSvk83ZmMrpSPvHG0hDYJnBhNv/LahK+I0uhMV4owX1XH7sr3ujor41PfntdoWIPhTjg==
X-Received: by 2002:a1c:4b0c:: with SMTP id y12mr11599707wma.91.1604868483850; 
 Sun, 08 Nov 2020 12:48:03 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id b73sm2144764wmb.0.2020.11.08.12.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:48:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 13/17] tests/docker: Install lttng-ust-devel
 package in Fedora image
Date: Sun,  8 Nov 2020 21:45:31 +0100
Message-Id: <20201108204535.2319870-14-philmd@redhat.com>
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
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Install the lttng-ust-devel package to be able to
build QEMU using the User-Space Tracer trace backend
(configure --enable-trace-backends=ust).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Daniel P . Berrange <berrange@redhat.com>
---
 tests/docker/dockerfiles/fedora.docker | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 0b5053f2d09..ac90f187882 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -44,6 +44,7 @@ ENV PACKAGES \
     libxml2-devel \
     libzstd-devel \
     llvm \
+    lttng-ust-devel \
     lzo-devel \
     make \
     mingw32-bzip2 \
-- 
2.26.2


