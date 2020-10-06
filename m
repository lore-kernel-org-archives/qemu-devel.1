Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C86BC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E250E20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 13:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+Qub80d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E250E20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmh7-0006gb-Si
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 09:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmVy-0002rl-7r
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmVw-0001t0-Cf
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601988979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VHqbyXPiJRDV4C8FnQjUpTXWXPI5vIxp7C25lKKq3Fo=;
 b=T+Qub80d9oSouka5gX6nk9r2rgzTBPDfgKb5ouOXbidd9aYWJMeo+kBoencC5KwJi3nAjJ
 gchZSkfJHmrm70Tb9PpubDP4rpo2vwHXZlfWLx9vzHMnieZS6w0MGQEXkzD8lwtyUtzyDh
 EPR26L66TYdWzyI2CAoXblMjxd2jiZg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-0b98J307OFint8Mr_-sreQ-1; Tue, 06 Oct 2020 08:56:16 -0400
X-MC-Unique: 0b98J307OFint8Mr_-sreQ-1
Received: by mail-wr1-f71.google.com with SMTP id y3so5312094wrl.21
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VHqbyXPiJRDV4C8FnQjUpTXWXPI5vIxp7C25lKKq3Fo=;
 b=HCBHBmqDVysfAel1KNsLi5pZLq7JTNdsOtPViLPMMjRmF7HeNoyBJkRoB/CyVFn+qd
 BEhUJeak/qDLYH5kLtWiF1zMaefBGQSKQ4CWRE3A6uOMgXegp82En7OcbIqUty/TAoNZ
 JdrGDXEXN4n7422w+Rqj8KksjNZJ4//9y00YpgB/efGzj8M9eRHbLI1CgF6tLQrMIFIz
 M6TTpS+mha+sMdLS8MdNaZMEu1BrqJoeQrenmF2xh5PxiC5Q5mC9JiLZf1JszfYMdFHw
 qeo5U0DigM6yiA8frsxRT3VyTtuxIw0xOiZmKJGAwx1vpSr2yDfip5sk4PBab5/Lktkw
 575A==
X-Gm-Message-State: AOAM530UWLbSaz+iRu1M2RQmSSm6TepwEMLB19MaCiTVwcPn/93E/Pma
 E1RWR2N8kJaNtAibFXhISlTwRajyfcAnTEaJCjS4S5CA8iSn73QCZL/OujU/yq9xfbsE+z7HECy
 cqG3EvpxCF8kZ/ss=
X-Received: by 2002:a5d:6a85:: with SMTP id s5mr2832708wru.90.1601988975096;
 Tue, 06 Oct 2020 05:56:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeqrQWQCRK1EX2S+oD40CiZSTZfJhoZAZ8DHL2+3uZ/MK8Gtyhjz0sp06K+9lSMCE2NytQGg==
X-Received: by 2002:a5d:6a85:: with SMTP id s5mr2832685wru.90.1601988974951;
 Tue, 06 Oct 2020 05:56:14 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f14sm4761594wrv.72.2020.10.06.05.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:56:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] meson.build: Sort sourcesets alphabetically
Date: Tue,  6 Oct 2020 14:55:55 +0200
Message-Id: <20201006125602.2311423-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006125602.2311423-1-philmd@redhat.com>
References: <20201006125602.2311423-1-philmd@redhat.com>
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 meson.build | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/meson.build b/meson.build
index 4101620777..60497f5615 100644
--- a/meson.build
+++ b/meson.build
@@ -1059,19 +1059,19 @@ sphinx_extn_depends = [ meson.source_root() / 'docs/sphinx/depfile.py',
 
 # Collect sourcesets.
 
-util_ss = ss.source_set()
+blockdev_ss = ss.source_set()
+block_ss = ss.source_set()
+bsd_user_ss = ss.source_set()
+common_ss = ss.source_set()
+linux_user_ss = ss.source_set()
+qmp_ss = ss.source_set()
+softmmu_ss = ss.source_set()
+specific_fuzz_ss = ss.source_set()
+specific_ss = ss.source_set()
 stub_ss = ss.source_set()
 trace_ss = ss.source_set()
-block_ss = ss.source_set()
-blockdev_ss = ss.source_set()
-qmp_ss = ss.source_set()
-common_ss = ss.source_set()
-softmmu_ss = ss.source_set()
 user_ss = ss.source_set()
-bsd_user_ss = ss.source_set()
-linux_user_ss = ss.source_set()
-specific_ss = ss.source_set()
-specific_fuzz_ss = ss.source_set()
+util_ss = ss.source_set()
 
 modules = {}
 hw_arch = {}
-- 
2.26.2


