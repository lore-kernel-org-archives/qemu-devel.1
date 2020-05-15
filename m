Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DD9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D498206C0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 17:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MY3C7FUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D498206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdrv-0005J1-D9
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 13:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdp4-0007i2-Rz
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:08:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37716
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZdp3-0002yR-5C
 for qemu-devel@nongnu.org; Fri, 15 May 2020 13:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589562512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AfdJ0fb3pUn/q8r2VJ/7T43bIwJswLi3uwi/HIViWEU=;
 b=MY3C7FUbGfqVsl/pd4R3KXkXOzkJyvO+TAn+NJSux5G2OyTq/B3V90LfBNL5AC3iDcpbp9
 oKQrXDzpk6z1SL9+Ym2cH9oYzhkpu7lcM+tF/xz79fj72XAFGAzjMp58yPSN2XBHFeh+LR
 cU8gs5vp3vqngDe54nIjamQoEDqdOzA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-tw_tN07ONESYKsvvAbfyPw-1; Fri, 15 May 2020 13:08:31 -0400
X-MC-Unique: tw_tN07ONESYKsvvAbfyPw-1
Received: by mail-wr1-f69.google.com with SMTP id 37so1488388wrc.4
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 10:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AfdJ0fb3pUn/q8r2VJ/7T43bIwJswLi3uwi/HIViWEU=;
 b=fovcCH+F5wkiZaw0deP0xy9JkSsZylcAZAeQeYCSwv+uGKSz9czmrMFERUpm5Sc0Wk
 61eFSLTrXmuh+FZgZRY0J58tk9mdQCREjBBhs6C26Ck3mQ92m7dwjmBmn3kp+RQaQosa
 VJgwwKMjQeZ9FiBMUFa9gVe3y/OYFqQWjEFV8a5wmHbzZ6i0K0gNXT284ij2iK6OjLjc
 E7v9sjKlwAFByhQUmllSG+s2UdcY0N5XJwtkwuOmA+AxwejM/9Nxy4kxsXIHdsNIkv35
 o8qSjkjf1F+KwtBMua+MxYoiGWXywAGXzbqkUbFiW4x1GMc3CVY3/wZxKGDb2qfgXEUe
 QFFg==
X-Gm-Message-State: AOAM531RBM187YaJ30qzy+TDXTn+g5fISGqagHX8He3gY4xZc7bLQI71
 /heIPdxRuuJmCXUHxlf0dRdVf87SsimK5b/CdCETKpfmXquFDAF4ZoxQspds3XG3A0nDhE+0W+X
 Zxo79LUqVXJ+1V+s=
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr5606794wrh.254.1589562509777; 
 Fri, 15 May 2020 10:08:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAbObSmIItKQqzcQRay2wcjdeHRGWr/x8AnwNFoDgTaqxsJ7xG7Wx6UcpQIJzPgmGLRh9y9Q==
X-Received: by 2002:adf:ca0e:: with SMTP id o14mr5606762wrh.254.1589562509614; 
 Fri, 15 May 2020 10:08:29 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id s67sm4362738wmf.3.2020.05.15.10.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 10:08:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/10] accel/tcg: Add stub for probe_access()
Date: Fri, 15 May 2020 19:07:58 +0200
Message-Id: <20200515170804.5707-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200515170804.5707-1-philmd@redhat.com>
References: <20200515170804.5707-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Marek Vasut <marex@denx.de>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "Emilio G . Cota" <cota@braap.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The TCG helpers where added in b92e5a22ec3 in softmmu_template.h.
probe_write() was added in there in 3b4afc9e75a to be moved out
to accel/tcg/cputlb.c in 3b08f0a9254, and was later refactored
as probe_access() in c25c283df0f.
Since it is a TCG specific helper, add a stub to avoid failures
when building without TCG, such:

  target/arm/helper.o: In function `probe_read':
  include/exec/exec-all.h:362: undefined reference to `probe_access'

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Cc: Richard Henderson <rth@twiddle.net>
Cc: Emilio G. Cota <cota@braap.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
---
 accel/stubs/tcg-stub.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index 677191a69c..e4bbf997aa 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -22,3 +22,10 @@ void tb_flush(CPUState *cpu)
 void tlb_set_dirty(CPUState *cpu, target_ulong vaddr)
 {
 }
+
+void *probe_access(CPUArchState *env, target_ulong addr, int size,
+                   MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+     /* Handled by hardware accelerator. */
+     g_assert_not_reached();
+}
-- 
2.21.3


