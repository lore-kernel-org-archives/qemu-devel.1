Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3D9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47BA82074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjHKl7D3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BA82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGcz-0006BE-HS
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGc3-0004ue-Qs
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48956
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jhGc2-00008w-2s
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591379916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtJmtocw2IGT4rTQV0Vyr4ITlgqv00JqAGkfWOLTkcE=;
 b=RjHKl7D37hZLtxHBeamP+yluc7UPBjDNE4ILEjSB/ts6e+kswX9k13OHxF1vQ4RWn6E7EZ
 OsTLVsPxSTX+qySInTVgnyeXP8cWE7bWoApfNHCveSpQLIYxHeLhEphqNkp4dFTwbXeRgu
 uR1bZnbBL8wvQepgobgL65DPZopmml8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-goGX1li7N7WOpohgn8RjFg-1; Fri, 05 Jun 2020 13:58:35 -0400
X-MC-Unique: goGX1li7N7WOpohgn8RjFg-1
Received: by mail-wr1-f71.google.com with SMTP id d6so4069706wrn.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CtJmtocw2IGT4rTQV0Vyr4ITlgqv00JqAGkfWOLTkcE=;
 b=NW0FAkHLSUkuzvjY1sHjAf+/yCwtFl5bElvbMluk/KnrJxPJ95N9LfbHbSsMt12hDO
 2f4frEkkze2r/66Tfor5Y797wKsdcaCrI94XoVoERTwYzgS1OY1nLpJ87qIrLSmP3OVD
 moJy6ws/jkZCcVtCCuDrkRK3ik+5oD6xDYtFoANnYlonl8Tnd89I8SvVrK30oNvJDfqD
 24outLdjx2Xgp1Cm5RYB1XHC1j8h0Pj8X7BRhvnaq1hEnKQeO0pTd5iyHKasM2vGAyVC
 te1Zc1ZTljTF332ucdv2kUIQ+skjRTYG1TCOq+/39wprYh1P0QSdcG3DEJB//wMrijX9
 kitg==
X-Gm-Message-State: AOAM530RX9aUffUTdRMDSfWm+pfe3E4noO8Mmtp+rwbZXdCtZWAUSlp0
 wxh6C7Nb+mgMlN0NC234DEV3LMLo+FFLkriWiH1HDDvMwhIELbI7qzGQkuT/Kn+eA3EnV/Kh3ML
 3tu5wZn1N1epMfxQ=
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr3841612wme.84.1591379913941; 
 Fri, 05 Jun 2020 10:58:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvMdL4NwgwbMjZgQ86aDXxAL2tKI4/NhktSCdBDfrfglvrV+Q+lwxdGhC5RJxYDYTFHuWwhA==
X-Received: by 2002:a1c:9e52:: with SMTP id h79mr3841601wme.84.1591379913786; 
 Fri, 05 Jun 2020 10:58:33 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y37sm15285774wrd.55.2020.06.05.10.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 10:58:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/11] MAINTAINERS: Add an 'overall' entry for accelerators
Date: Fri,  5 Jun 2020 19:58:12 +0200
Message-Id: <20200605175821.20926-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605175821.20926-1-philmd@redhat.com>
References: <20200605175821.20926-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 948790b433..f725c12161 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -415,6 +415,17 @@ S: Supported
 F: target/i386/kvm.c
 F: scripts/kvm/vmxcap
 
+Guest CPU Cores (other accelerators)
+------------------------------------
+Overall
+M: Richard Henderson <rth@twiddle.net>
+R: Paolo Bonzini <pbonzini@redhat.com>
+S: Maintained
+F: include/sysemu/accel.h
+F: accel/accel.c
+F: accel/Makefile.objs
+F: accel/stubs/Makefile.objs
+
 X86 HVF CPUs
 M: Roman Bolshakov <r.bolshakov@yadro.com>
 S: Maintained
-- 
2.21.3


