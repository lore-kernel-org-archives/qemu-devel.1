Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42018C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DA1206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1/zp4y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DA1206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPkvA-0003Nr-Hc
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPktZ-0001gM-CL
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPktX-0005JC-Cs
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 07:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601982754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHSMU3H8MAqIi6xWpwYEGX/4wsnCDrIc6FNRKW4vl4w=;
 b=X1/zp4y3z9qqCq9MqVy8BW1quzuihsENAySas69OaIaDYDPndx5PbCNT6bTSA93EEHd1kj
 NtsK9HGcAwN4pfssp/3ZN3QPq1MIm7s46AVwF9IgHTbfTqmC4hmIUUfawF+LOJm5mVkfvr
 PJnFZAKwNBfYcFPyfX5y+zi98XvDqwk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-EJRalVpgP_-AV8dzRrBVOA-1; Tue, 06 Oct 2020 07:12:33 -0400
X-MC-Unique: EJRalVpgP_-AV8dzRrBVOA-1
Received: by mail-wm1-f70.google.com with SMTP id p17so577437wmi.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 04:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XHSMU3H8MAqIi6xWpwYEGX/4wsnCDrIc6FNRKW4vl4w=;
 b=j+9RWLKaimh7rFn4pKswpo69WV1Q4YZFq0KycNbk8HNjzGjncFtDVmdP0L7rCjNIDO
 VRdzbdrUzqFMD0w1dwL8XBUGmd6yTyBiPp/CXohAJE+ms499+v63FPp5bYBCPOcGM82n
 4Ley3iUrJ14jXSZ+naey867lzwRoXmwojUnbGt7Mfc5NKbK084SLF5alE8Z2qofJpypc
 +wwU44kvceYohdOUU9Y1rgn+ykckjLTc9n+nTU8UJJNZPFlLgcNr5q3zEIUmQHBBvhds
 4XbOUvZ92eJBBSY9qOaXBcy9crPOUirO4RTfEmZuSjO/NtJpreER3FDex1uaxvcnLYMr
 OqPg==
X-Gm-Message-State: AOAM530w5rB7Xe1OnIKIQ2fmfveSUig3I1tmrfDooVxm1ZFcjapjmV4y
 MtBRWa2MRe/zN5ccATxTH86C+h0HvE5DFfKY96N6k9WTnFBKHcITwrRx471Ni+Kz42E+X9Sd/Qh
 0JBDK+WuTMNMv3lc=
X-Received: by 2002:a5d:4f82:: with SMTP id d2mr4242753wru.65.1601982751757;
 Tue, 06 Oct 2020 04:12:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztuI5MQgQsEFig4ahjsGUeWII8UCfOclJz6/4FmneUnD62NeONMVNzTjOwf7MmT8Zph3Ageg==
X-Received: by 2002:a5d:4f82:: with SMTP id d2mr4242730wru.65.1601982751552;
 Tue, 06 Oct 2020 04:12:31 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id g144sm1302861wmg.30.2020.10.06.04.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 04:12:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] meson.build: Add comments to clarify code organization
Date: Tue,  6 Oct 2020 13:12:11 +0200
Message-Id: <20201006111219.2300921-3-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index a02c743794..eaff16d482 100644
--- a/meson.build
+++ b/meson.build
@@ -1323,6 +1323,10 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 
+########################
+# Library dependencies #
+########################
+
 block_ss = block_ss.apply(config_host, strict: false)
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
@@ -1363,6 +1367,10 @@ common_all = static_library('common',
                             dependencies: common_all.dependencies(),
                             name_suffix: 'fa')
 
+###########
+# Targets #
+###########
+
 feature_to_c = find_program('scripts/feature_to_c.sh')
 
 emulators = {}
-- 
2.26.2


