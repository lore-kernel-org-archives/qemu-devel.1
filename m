Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CDFC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9109F206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqAcK/5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9109F206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkv9-0003LN-GB
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:14:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPktX-0001fm-E4
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPktT-0005Hd-Do
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etfUyWzqCzlIALaB60Jij2GH0zWb1XjkmDYm3zzjL14=;
 b=CqAcK/5uiOeCyPJd6+IiUxG0ylZuN0NlgDVUnBLhAymltRHI/3l6Axr3RsgR+Cz6qVgNlB
 AJtjzEdNwQk01KOY6caWLuyrTh/Q960diFScY/bloKXCBkx+ekLvsCa6P2VIYuyFSqOhdy
 9JIR1WATU7/uif01InMhr83dmSYT+bk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-yp8fEjaFMa6YOErA2WBvLQ-1; Tue, 06 Oct 2020 07:12:28 -0400
X-MC-Unique: yp8fEjaFMa6YOErA2WBvLQ-1
Received: by mail-wm1-f72.google.com with SMTP id p17so577374wmi.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=etfUyWzqCzlIALaB60Jij2GH0zWb1XjkmDYm3zzjL14=;
 b=JPuZ9yrLBzxgOBkIiqsTmq1wLxntZH31KuLUzPQSdB3ApZTw+OQGwSlzEiiY2JP6jH
 6Y0+05+uA4cOpHS1JxExPJ2xrZrbMRFkU7CBCGR4uQujkjmIJ1Gqp1ihwTkzK7wxZRJi
 HIGJqkZLIOeSrEPaQjqag3Lu5s7rehRXP/mLZVbPCORBnfzDKZZ6qmEX7QaxNGP5/PSU
 ARzTNvdte0MuRbQ1ANLYvbgzzDl1z+FrbCU0rUU8DiA8chpxjVvq6zzDg9xudFulX8Y8
 Gh8zgJzMHftM9PQ9AscxzeqT3/EOjUfoEZ+Ts0+vq4lyICKU7Kjllr4xALLbYxZeGe7N
 D6iA==
X-Gm-Message-State: AOAM532jTTBaUKIXFUe1pqNmAjlqh2XNDDye4xHS/6BP1inEu7Ef0Kol
 HdXflVaulCsLyPtoQscDHv1frqFkbJC0R5cq7bl2Lr0Pqgq2+XGOknqVz1SG6aDTTzjdMDY/zwu
 Ru8uyxLxWCeIXH24=
X-Received: by 2002:adf:ffca:: with SMTP id x10mr4700567wrs.342.1601982746874; 
 Tue, 06 Oct 2020 04:12:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVaUhGKN/eK/MxaPd8ALcO7Brhfsz0vexxt3GbwQETMLKBc63ZGYVD7tchiwRYMEg/0K5QMg==
X-Received: by 2002:adf:ffca:: with SMTP id x10mr4700548wrs.342.1601982746714; 
 Tue, 06 Oct 2020 04:12:26 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o16sm3805655wrp.52.2020.10.06.04.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:12:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 01/10] migration: Only add migration files to the Meson
 sourceset
Date: Tue,  6 Oct 2020 13:12:10 +0200
Message-Id: <20201006111219.2300921-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006111219.2300921-1-philmd@redhat.com>
References: <20201006111219.2300921-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm not sure how that works, but keep the use of Meson
sourcesets consistent, only add source files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 migration/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/meson.build b/migration/meson.build
index b5b71c8060..55c9e1329f 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -14,7 +14,7 @@ libmigration = static_library('migration', sources: migration_files + genh,
                               build_by_default: false)
 migration = declare_dependency(link_with: libmigration,
                                dependencies: [zlib, qom, io])
-softmmu_ss.add(migration)
+softmmu_ss.add(migration_files)
 
 softmmu_ss.add(files(
   'block-dirty-bitmap.c',
-- 
2.26.2


