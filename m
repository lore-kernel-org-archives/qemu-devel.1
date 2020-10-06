Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC86C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55BA02075A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qqy2iBle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BA02075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmXS-0004Q2-80
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmVt-0002hz-P2
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kPmVq-0001sX-0c
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601988973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3byOrKG4yoU+gNrvvNZ8ALCAT6xbaRmzFtpysRfVokw=;
 b=Qqy2iBleHSYN+EXSaCxOoqxk9N8BClfL730qhn3OT11ryIT+6ORW5H44x4PCFIAcbx1OzJ
 DXajy4oO2aC+mP0H34fcU/IFbxBOZv7FiOI+JgT27pbXMSwKPkYpGEEbFX1A91QEQvv2Y7
 +kPB2So1rMdbI/pe4l0LA6uy3fP1sqM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-AavFQc4EO8CVTRdiAsJK-A-1; Tue, 06 Oct 2020 08:56:11 -0400
X-MC-Unique: AavFQc4EO8CVTRdiAsJK-A-1
Received: by mail-wr1-f72.google.com with SMTP id g7so513118wrm.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3byOrKG4yoU+gNrvvNZ8ALCAT6xbaRmzFtpysRfVokw=;
 b=YgNghLSLFv/7XvxY9X+12aTsqHhkAiJhQ+VnUsmZmtd5mlKjWK/CsY1XHfTSEpwq+F
 ukPK+loKnvyIBEjgbgf79Yeo1Lz2LOwPPsTQa7/3+JQJ0RlOrwv+lc4mTYgsL8hnb8Pp
 8Q0QTIU/TeffEkPJnp5Tq+CAe5K0ngEs9wRVCx08XXrX/KHcz6BxHRPS3XEDI6I9WAUb
 dFbP5KvBChh+ozWBABSelvtLGF3k9sYkvhAkZEbMfZHLrvLY4xroBsbOVWw+gIGfA6FW
 fA/DrWZeJsdm5jk3ZurOL8gSvgCDDeSkYgJ2XXPsGoOIUUegOaUo3yRuMpAHPppeCbgz
 3QIA==
X-Gm-Message-State: AOAM532yGHH5UIWC3O/65+kZp69PMZseNQ5Cb/BILsmIpEhNmFXTbN56
 J++iZrrXh3LdZrpHnmEptbw170GiUzi+oaQ1mE8Vmhjzop4NoJaCQL0NC1PKAXC0qcnKqc7AgeF
 Qm8R6bSfopCSSV0g=
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr4829674wrj.1.1601988970228;
 Tue, 06 Oct 2020 05:56:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzLcZlkn6uo2uvxGkfw+8T1ws23uwy2hfnjafpWPvBbmUmIrAN35ZWunoNhYKLY2v1AsoGZg==
X-Received: by 2002:adf:dbc3:: with SMTP id e3mr4829643wrj.1.1601988969996;
 Tue, 06 Oct 2020 05:56:09 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v2sm4202033wme.19.2020.10.06.05.56.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:56:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/9] meson.build: Add comments to clarify code organization
Date: Tue,  6 Oct 2020 14:55:54 +0200
Message-Id: <20201006125602.2311423-2-philmd@redhat.com>
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
 meson.build | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/meson.build b/meson.build
index a02c743794..4101620777 100644
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
@@ -1342,6 +1346,10 @@ libqmp = static_library('qmp', qmp_ss.sources() + genh,
 
 qmp = declare_dependency(link_whole: [libqmp])
 
+###########
+# Targets #
+###########
+
 foreach m : block_mods + softmmu_mods
   shared_module(m.name(),
                 name_prefix: '',
-- 
2.26.2


