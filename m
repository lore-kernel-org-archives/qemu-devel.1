Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70CBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3EEF20679
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 16:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwZ/AO3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3EEF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcAkk-0005g9-Tg
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 12:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAgd-0006Rk-Oy
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33221
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcAgc-0002Rg-V9
 for qemu-devel@nongnu.org; Fri, 22 May 2020 12:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590165498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JofVph8hTCqe9tTdYnNgdFhC3wOmZ117kRTp2Ed4In0=;
 b=GwZ/AO3N9kY//JfxyjJN9qPcPT+xriOpoTG65u8zHdLcKF43TkRCkjz7IThu7L7rFePyPm
 a4arLB/WXyHGGAx71JjY4WaIt89z4MS150KTcisY2Jz461ZEDqQuZG/2TNQI1Zq2AUPZ5/
 MjvnfSF8pMNfkf9q4i+Bjgy+L1P9XVs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-R1vJMxPXO2OhEOhpx-mHzA-1; Fri, 22 May 2020 12:38:16 -0400
X-MC-Unique: R1vJMxPXO2OhEOhpx-mHzA-1
Received: by mail-wr1-f69.google.com with SMTP id z5so4564303wrt.17
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 09:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JofVph8hTCqe9tTdYnNgdFhC3wOmZ117kRTp2Ed4In0=;
 b=VjwLTUuCMA08LFwj9v13CiAaDlcXI5bDQ3f8/vzqcRgGqooqAHsmc4Qowoh6aiO11j
 dORmU00hA5tIbGSSbgvSliNDw4ly+1edlow1EfaVUCuYv2n7AI5Mj0KsI2UvSCZY295s
 XW30AMZogREhzgpLUyTwIVmdtuhDPuclQFo1fr3LsYUpZYoMKmG4dz9HfqCa5ve5xzDh
 H9liGuDE1bqwJA3YMwNsKl3trl+hVAUp3wXK1i85rvbRGWlwQpZoNdFBw3tdOMXKayP+
 BSY4lJmNilCEioLqCBjwlRhVs3n5qo/m57Bp2UZayZrctL08sHZM3C7882t/O/M/vKMX
 MoAw==
X-Gm-Message-State: AOAM532hHwvUjM4d6meZcfu2/sHYm8ho+UAt9GiO9qverhVNqoUjAVNm
 sOkdOHNDvo/qSVCeqUyLwOcVFCM7OQvkw7TpzqFq6FJ8sCcdex7MHV99AIHjd+En1Ll7AslfSQV
 IcDxge8blleLISb0=
X-Received: by 2002:a05:6000:1244:: with SMTP id
 j4mr4209036wrx.189.1590165495299; 
 Fri, 22 May 2020 09:38:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqk92PaN3Nz8ElNLAx5ty+YFAT6VwSO8inYhv/gXZS+BeglvRLxaabN9BNQKDLbiLdit4QVg==
X-Received: by 2002:a05:6000:1244:: with SMTP id
 j4mr4209030wrx.189.1590165495112; 
 Fri, 22 May 2020 09:38:15 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s67sm10156436wmf.3.2020.05.22.09.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 09:38:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/11] MAINTAINERS: Add an entry for the HAX accelerator
Date: Fri, 22 May 2020 18:37:51 +0200
Message-Id: <20200522163759.11480-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200522163759.11480-1-philmd@redhat.com>
References: <20200522163759.11480-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 11:11:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Vincent Palatin <vpalatin@chromium.org>, Hang Yuan <hang.yuan@intel.com>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 David Chou <david.j.chou@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Colin Xu <colin.xu@intel.com>,
 Yu Ning <yu.ning@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Tao Wu <lepton@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: Vincent Palatin <vpalatin@chromium.org>
Cc: Yu Ning <yu.ning@intel.com>
Cc: Tao Wu <lepton@google.com>
Cc: haxm-team@intel.com
Cc: Colin Xu <colin.xu@intel.com>
Cc: Hang Yuan <hang.yuan@intel.com>
Cc: David Chou <david.j.chou@intel.com>
Cc: Wenchao Wang <wenchao.wang@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7ee0c77f1..0377978201 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -426,6 +426,12 @@ F: accel/accel.c
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 
+HAX Accelerator
+S: Orphan
+F: accel/stubs/hax-stub.c
+F: target/i386/hax-all.c
+F: include/sysemu/hax.h
+
 X86 HVF CPUs
 M: Roman Bolshakov <r.bolshakov@yadro.com>
 S: Maintained
-- 
2.21.3


