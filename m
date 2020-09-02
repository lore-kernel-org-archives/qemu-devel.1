Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6804FC433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F40B2072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSYrSyQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F40B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNrR-0002w6-Dh
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNpJ-0007KW-3J
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:09:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27103
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDNpH-0001pr-9p
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a7jMiaMP3JTj9ArNnNz3t5AwgDboPnJ3Xc9W3czcTi0=;
 b=gSYrSyQqFeKPNRUVg5xs9FTlYxgBJGnxpo+/lU6K8i5m0VwgPIon8qF0XBHbcmFO+d4W60
 tC18G0y9BC9u3r1m3yQ0Ots9POuhay6jUHgDaJjuhLbf8YbivOMY/FYLsSVAbj8j7wCwsC
 8Tr0xS/5htNwMqUPE920djacyz0NdH8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-tA9ROLyJNHesKY1F7FsvFA-1; Wed, 02 Sep 2020 04:08:21 -0400
X-MC-Unique: tA9ROLyJNHesKY1F7FsvFA-1
Received: by mail-wm1-f71.google.com with SMTP id x81so1528918wmg.8
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 01:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a7jMiaMP3JTj9ArNnNz3t5AwgDboPnJ3Xc9W3czcTi0=;
 b=iEFqq/1MhNld3WvZBIClqLJX1PwV5pNZYys6KCKoSOHxVEet03badQTbECsUDMvHvd
 hDxO51dhauVT61dsoftn54A5jy1PS8EK1Aj+2I4bhsCNqMaoFPjAibjIJ3K4rNIQzYDL
 f+VtubO0hvU1KJ7OLUdIQtMcWMgJaVXyZH4ua9hd37sjAcqQS25SjvRbpNCgaVAdvphh
 LkMRnTUPQbzDnt2r5Kz4ulR9JP4qA2JY3kSAtavCgryIP+WCZesdZ955FpmK+OBUw/h5
 T4BMkAyA0XEuqZrWitAkD5wlzP0DEUfsm2ry+8OErIo/ONMfICzzAtaMbRbWEFcY0z6F
 8Qog==
X-Gm-Message-State: AOAM533+8OVCWEQlT7QXwSHeZ1e0qqFXej2PLftIxPtxPx0tC8zkd3QY
 dpsIZWT5Z9v5CsfyVSpw1yqnZqLFz7B/OsibWhpomMPOEaYXwpoYH7Z4B4PiSWDXAOuNCOUSMjl
 ln2RcVYR7DO3n/j8=
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr5474572wru.33.1599034099693; 
 Wed, 02 Sep 2020 01:08:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFGqDIQtOUHFPGW0jIgS+ZVOQ2QN9WUI/lkiDw5q/wumx2PXzT/kP7sMdPSLVt6uHcfzlU6Q==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr5474545wru.33.1599034099473; 
 Wed, 02 Sep 2020 01:08:19 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 70sm5642929wme.15.2020.09.02.01.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 01:08:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/ppc/spapr: Do not declare local variable only used for
 assertion
Date: Wed,  2 Sep 2020 10:07:59 +0200
Message-Id: <20200902080801.160652-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902080801.160652-1-philmd@redhat.com>
References: <20200902080801.160652-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/ppc/spapr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index dd2fa4826b3..6447a5b3808 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -628,7 +628,6 @@ static int spapr_dt_dynamic_reconfiguration_memory(SpaprMachineState *spapr,
 static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
 {
     MachineState *machine = MACHINE(spapr);
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     hwaddr mem_start, node_size;
     int i, nb_nodes = machine->numa_state->num_nodes;
     NodeInfo *nodes = machine->numa_state->nodes;
@@ -670,7 +669,7 @@ static int spapr_dt_memory(SpaprMachineState *spapr, void *fdt)
     if (spapr_ovec_test(spapr->ov5_cas, OV5_DRCONF_MEMORY)) {
         int ret;
 
-        g_assert(smc->dr_lmb_enabled);
+        g_assert(SPAPR_MACHINE_GET_CLASS(spapr)->dr_lmb_enabled);
         ret = spapr_dt_dynamic_reconfiguration_memory(spapr, fdt);
         if (ret) {
             return ret;
-- 
2.26.2


