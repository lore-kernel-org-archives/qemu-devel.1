Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8635AC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49FB920714
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 10:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="F1+KtnhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FB920714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCK9l-0006vq-AW
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 06:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kCK7d-0005FM-Px
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:59:37 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kCK7c-00042O-C1
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 05:59:37 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mt12so1581367pjb.4
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=F1+KtnhPDwdoGYZKXd8Kr8f+KxY3gp63wSBxzAx9Prq4dvQZpxH0hmkQea4vz5tcRj
 EcpcPtqKW2kMK+nuAITVnNb97G/6//9nx0tUOXkDGjWhJAifA71sxLg5MwWa01uWgByM
 krDHIEnxp/mYwZlJz+5ZQD5+bN18QKeoqeYeCwdBp4vp+TfYFoHbaiT2f7/v8JvuoTl+
 BmtZCbDKR3jAEjJoijNhzZzBIC4OwfLvu2Bdlgt9Ch31C7rI2S+KdWVt6dzLjaYKNRyx
 RCpqYZoLSfWHXBdZdgkTmh/tz4AV5Py74uYzJEBa1jmeKVV+17L+F/iUAHhtnujGf7pt
 d6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HHdiOGLkXts4NNVu4SCMzFcJi56aYTGQpkW5PEoj6js=;
 b=ia4JC73AxexOz1hz9xmqzh0jX/WdlZXQS6Pysjss/ZhBvdIPD+kkrXufFR/LZaxl6J
 oRUYlegRKshNEbemBGEU9mkLmytjFsbrYIKlId2hqHjP2oW8eFdvHeqaaZcZXivvFl2T
 AIYBoGPuT1TMRNi1antCVcwe01B14VWHoXV8mX+KFh5wLUxyWSJ6TM8GYT5Xi3yL5r+H
 NAYIxsh9G2Yaecxh5sJo2HnsSJsi1F4qdf9N97zgS6BUbcjQP/Ic7CZ1GxT2+b+fTHVc
 z/W47hNI6yqbsDyHxKyvYsx5K5NgndmzLe+/lHwN6yVqjVxeozKo2PH1SfEaX0yjs7zR
 Kg8Q==
X-Gm-Message-State: AOAM532DbW6GrfFRxNgDJ5nfokE2MoPgILkdjUjFsJGY8N1yk9w+Ksok
 qKV+ckGGXegZ5R109pugTOtT3d+ZissKMw==
X-Google-Smtp-Source: ABdhPJwSRY796+I9Sb7ZzPuvoC93mbleRR/dVCukOARas+sVVO/r7zNNAR/+c9sZxoezv6m8A/i0VQ==
X-Received: by 2002:a17:902:d3cb:: with SMTP id
 w11mr5185977plb.24.1598781574412; 
 Sun, 30 Aug 2020 02:59:34 -0700 (PDT)
Received: from localhost.localdomain ([115.96.143.103])
 by smtp.googlemail.com with ESMTPSA id c143sm4773722pfb.84.2020.08.30.02.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2020 02:59:33 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] tests/acpi: document addition of table DSDT.roothp for
 unit testing root pci hotplug on/off
Date: Sun, 30 Aug 2020 15:29:12 +0530
Message-Id: <20200830095915.14402-2-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200830095915.14402-1-ani@anisinha.ca>
References: <20200830095915.14402-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::1041;
 envelope-from=ani@anisinha.ca; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A new binary acpi table tests/data/acpi/pc/DSDT.roothp is added in order to unit test
the feature flag that can disable/enable root pci bus hotplug on i440fx. This feature was
added with the commit:
3d7e78aa7777f0 ("Introduce a new flag for i440fx to disable PCI hotplug on the root bus")

This change documents the fact that this new file addition was made as a part of the
unit test change.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..ac864fc982 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/pc/DSDT.roothp",
-- 
2.17.1


