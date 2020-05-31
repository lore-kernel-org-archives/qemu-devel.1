Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7210DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C172074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL30hmNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C172074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRFz-00026J-Ez
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0x-0003rK-AS
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42147
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0v-0007Ak-97
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KEU6cF8wx9dT9DR4quAwHsy5LYVVtSbv+hQRMIt0K90=;
 b=DL30hmNnw+DbtkdxO6YB852G4ah6lBOdXFixbJOGeV+dU4lh0JU5gVPKnLPossdoqqxFFF
 5z3poLvfMgqYDWMc16XDYCMpZzX/nsZXpkpL7z7A9v+A7V2CkxEZY6vqY9Vo9RXhRsP217
 EVsRB01qU77PeWbwYh85AN2I9k48Kjg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-a-x1-tnYOCOSz5yLSATC-Q-1; Sun, 31 May 2020 12:40:43 -0400
X-MC-Unique: a-x1-tnYOCOSz5yLSATC-Q-1
Received: by mail-wr1-f69.google.com with SMTP id j16so3579728wre.22
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KEU6cF8wx9dT9DR4quAwHsy5LYVVtSbv+hQRMIt0K90=;
 b=V7RJhqmFmszGEcoFUFlyQ7XaxM09gnFGok99AqQaSbsfZ3kp6IDObbN7TAVCxiKsMO
 vKagEp3EtsEjX2juRJSnTUtGzB1sSTiH1Yb2DnnkmhTKtkTRYndQ/oNWZu5r7sex1Gbf
 e/KIyHdNGH8cpFnb2d/liKb3AhBikgJSSsfKrK8g7W81xeeXohq9XhnqmXHVW1ZcutgB
 1GmjBOQRwjYaZcf8nPr5pG3n/CG8VHv6wGu9C4Ru8sCDUtscgoI7BGUTCUwac90j2AIF
 iXcoOxe+ZjExkeUG1MTi+KtA0gGf+zyhyXtgEfxRf1P4JFBmfjDMQ+DE9mrWuCeUcFcF
 304Q==
X-Gm-Message-State: AOAM531Q4wzMRcVNzMo0g/XFqZQZXEKbuHGl3MzdRoh0rmc5gmwZ0x7Q
 2eztNF++yR+q/xcsZ/Sy19qkIvZzzSP/eDCxG1/GaewGgqk9jiKEVYzJGSmlLEszYtZbIPwnLFX
 JIpi5QxYM4WIgqfo=
X-Received: by 2002:adf:8041:: with SMTP id 59mr17259541wrk.278.1590943241715; 
 Sun, 31 May 2020 09:40:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzImNvZeAhhQ1GMFMgecKFJ9XA4/OBogYQBVHGi7VCZ3PzFb8gTmqybziOivHHumywOwku1CA==
X-Received: by 2002:adf:8041:: with SMTP id 59mr17259527wrk.278.1590943241554; 
 Sun, 31 May 2020 09:40:41 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id z25sm8585383wmf.10.2020.05.31.09.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/25] tests/acceptance/migration.py: Wait for both sides
Date: Sun, 31 May 2020 18:38:43 +0200
Message-Id: <20200531163846.25363-23-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:38:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When the source finishes migration the destination will still be
receiving the data sent by the source, so it might not have quite
finished yet, so won't quite have reached 'completed'.
This lead to occasional asserts in the next few checks.

After the source has finished, check the destination as well.
(We can't just switch to checking the destination, because it doesn't
give a status until it has started receiving the migration).

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200528112404.121972-1-dgilbert@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/migration.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index 0365289cda..792639cb69 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -35,6 +35,10 @@ def assert_migration(self, src_vm, dst_vm):
                       timeout=self.timeout,
                       step=0.1,
                       args=(src_vm,))
+        wait.wait_for(self.migration_finished,
+                      timeout=self.timeout,
+                      step=0.1,
+                      args=(dst_vm,))
         self.assertEqual(src_vm.command('query-migrate')['status'], 'completed')
         self.assertEqual(dst_vm.command('query-migrate')['status'], 'completed')
         self.assertEqual(dst_vm.command('query-status')['status'], 'running')
-- 
2.21.3


