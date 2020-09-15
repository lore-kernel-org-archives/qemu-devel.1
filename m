Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314CEC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4DC21D94
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8PXZ7Be"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4DC21D94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIB4z-0007YG-GF
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <otubo@redhat.com>) id 1kI8jB-0005MM-Qh
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:02:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <otubo@redhat.com>) id 1kI8j8-0006eO-GG
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600167741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jja0yAzXrMO1VzbeS7S7TWsqOyTmFI/DHOMiN1efKZ8=;
 b=T8PXZ7BejGO4E4XH6qz1TKfl3vcS/3YFN6IiFcFkC5UJvQiK7H2zLQ1Ls71GHOQpKSnvJB
 GYO6z741kKE9v7snHfIqgKjHCsnGdk6jDnaxcMpP89TAHRF3JwsKv4hDLat5S4YBk99ioA
 DHZBD/fBGsoT2E6gb1xRxcj0imEvaxk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-h0n_UnTrNYSWE8-hDKUYdA-1; Tue, 15 Sep 2020 07:02:17 -0400
X-MC-Unique: h0n_UnTrNYSWE8-hDKUYdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BE2E64086;
 Tue, 15 Sep 2020 11:02:16 +0000 (UTC)
Received: from genji.redhat.com (ovpn-115-97.ams2.redhat.com [10.36.115.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59C0C60E1C;
 Tue, 15 Sep 2020 11:02:15 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 1/1] seccomp: fix killing of whole process instead of thread
Date: Tue, 15 Sep 2020 13:01:55 +0200
Message-Id: <20200915110155.15362-2-otubo@redhat.com>
In-Reply-To: <20200915110155.15362-1-otubo@redhat.com>
References: <20200915110155.15362-1-otubo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=otubo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=otubo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Sep 2020 09:15:38 -0400
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

Back in 2018 we introduced support for killing the whole QEMU process
instead of just one thread, when a seccomp rule is violated:

  commit bda08a5764d470f101fa38635d30b41179a313e1
  Author: Marc-André Lureau <marcandre.lureau@redhat.com>
  Date:   Wed Aug 22 19:02:48 2018 +0200

    seccomp: prefer SCMP_ACT_KILL_PROCESS if available

Fast forward a year and we introduced a patch to avoid killing the
process for resource control syscalls tickled by Mesa.

  commit 9a1565a03b79d80b236bc7cc2dbce52a2ef3a1b8
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Wed Mar 13 09:49:03 2019 +0000

    seccomp: don't kill process for resource control syscalls

Unfortunately a logic bug effectively reverted the first commit
mentioned so that we go back to only killing the thread, not the whole
process.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
---
 qemu-seccomp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index e0a1829b3d..8325ecb766 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -136,8 +136,9 @@ static uint32_t qemu_seccomp_get_action(int set)
 
             if (qemu_seccomp(SECCOMP_GET_ACTION_AVAIL, 0, &action) == 0) {
                 kill_process = 1;
+            } else {
+                kill_process = 0;
             }
-            kill_process = 0;
         }
         if (kill_process == 1) {
             return SCMP_ACT_KILL_PROCESS;
-- 
2.18.1


