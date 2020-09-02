Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE2DC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 552FD2084C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5LTwisP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552FD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNpi-0007hi-Et
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNom-0005xr-Ov
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNol-0001l3-3W
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqoGra6YF9Ce6QcGdVGR0NnxjhhD6ItqfGW+etggexM=;
 b=N5LTwisP9LCXsDsNkLQCHrgdCP4Tohjy9cxMSIcNqGm+36cHvMxiS+puy+3P+gETckyqqC
 gbW81UIAsfFvh0fv2EAi/KeDPx2EmWIiHpnSeAxjMQI3kGB10JDwXvVtOdhM/PyOhGYOYP
 9sQK81eezzovrBTSFZQUdgBcSWBnAVg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-TrFtfc9MPWWqAD9TJT36EQ-1; Wed, 02 Sep 2020 04:08:26 -0400
X-MC-Unique: TrFtfc9MPWWqAD9TJT36EQ-1
Received: by mail-wm1-f72.google.com with SMTP id k12so1108419wmj.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qqoGra6YF9Ce6QcGdVGR0NnxjhhD6ItqfGW+etggexM=;
 b=rVrEvgn2OVv82Tm0Y0G9hYsn7gKha5q0TdMsIJjLGp7bos8WZFpyR23X2eDDj1pbXA
 PRxjopIoHv/7MR5rOXMmo3hiH5Og6+cxcgdH9Bav8fLVPtBaDmZ1U226IyoHpc2vGV+8
 Fhj6B8LdPPm3U23eJooROz9+JHFx8gjRLDAMP5yrfuGs0yH567ZIAz6jrENLwI3i7JPG
 sfg7MEN3EOXdHvTQPz5E2/IL2Zf1/tvC1r8QRSO/65xn/dILQMSRVssvg/LLDYX/ElA8
 qbbY/3amLIzfXT8qTN0spLjVN0++3d9IFnqazieZh6PATXO3HICLthZ3LrvBqbM0FmuR
 mgLg==
X-Gm-Message-State: AOAM530uGS2a0iEYLeGHK3TQgCZdim2rBzW/vu9iZeH9xgV/nxZBhJ/4
 LjHO0wKS359zHHI3vM9uh8Nao3pR2oJvn1kZBUXi+jmk/uOmvV06h008U4xDiAicv0jAOTF5gAn
 radP5t1kHKZiceYk=
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr5304996wmr.76.1599034105338;
 Wed, 02 Sep 2020 01:08:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhMl1QiX60uBZI3rBLSdHTG2Ml6h8GrTYZUS2VqvWLkBp44hIuMHZxZN5lK/+XKS+Vhksetw==
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr5304974wmr.76.1599034105170;
 Wed, 02 Sep 2020 01:08:25 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id b194sm82986wmd.42.2020.09.02.01.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 01:08:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] tcg/tcg: Do not declare local variable only used for
 assertion
Date: Wed,  2 Sep 2020 10:08:00 +0200
Message-Id: <20200902080801.160652-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902080801.160652-1-philmd@redhat.com>
References: <20200902080801.160652-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This variable is used once in an assertion. Remove single
declaration and access directly in the assert().

See in "qemu/osdep.h":

 *                                  [...] disable assertion is not
 * supported upstream so the risk is all yours.  Meanwhile, please
 * submit patches to remove any side-effects inside an assertion, or
 * fixing error handling that should use Error instead of assert.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tcg/tcg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 62f299e36e5..0bff49e544a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -777,7 +777,6 @@ void tcg_register_thread(void)
 #else
 void tcg_register_thread(void)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     TCGContext *s = g_malloc(sizeof(*s));
     unsigned int i, n;
     bool err;
@@ -795,7 +794,7 @@ void tcg_register_thread(void)
 
     /* Claim an entry in tcg_ctxs */
     n = atomic_fetch_inc(&n_tcg_ctxs);
-    g_assert(n < ms->smp.max_cpus);
+    g_assert(n < MACHINE(qdev_get_machine())->smp.max_cpus);
     atomic_set(&tcg_ctxs[n], s);
 
     if (n > 0) {
-- 
2.26.2


