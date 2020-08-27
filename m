Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB411C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CE5B20737
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNi94mNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE5B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBLHU-0007T9-IQ
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 13:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBLFy-0005pQ-6D
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:00:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBLFw-0005Mn-00
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598547605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0cU2pKxq8BAQpdJNYqHz0FvSzVLfYh0AUYliRmr3zg=;
 b=FNi94mNV8YqaGC9W3i6uWPw+56zugzIO9LL46sIxeFBHsRgz2WAE1efESKxZffOGMOrlGr
 XiJFiDc9teWLzz1qQAE9ZqkCV8PSkPfctQxdNjfknRYdzZcgX9jiap1lBPrK5I4fWHjUhf
 PS8H3Wgj9aBwlfAfdvR2SDHNT4PVOc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-yv4aXGMfOW6jhEfQ5wlI9g-1; Thu, 27 Aug 2020 13:00:02 -0400
X-MC-Unique: yv4aXGMfOW6jhEfQ5wlI9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC1D1074655;
 Thu, 27 Aug 2020 17:00:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A49CB7843F;
 Thu, 27 Aug 2020 16:59:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/17] trace: fix creation of systemtap files
Date: Thu, 27 Aug 2020 12:59:40 -0400
Message-Id: <20200827165956.12925-2-pbonzini@redhat.com>
In-Reply-To: <20200827165956.12925-1-pbonzini@redhat.com>
References: <20200827165956.12925-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The "exe_name" variable was renamed to exe['name'], so systemtap
files fail to build.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index f0fe5f8799..f2aa5a7700 100644
--- a/meson.build
+++ b/meson.build
@@ -1029,14 +1029,14 @@ foreach target : target_dirs
 
     if 'CONFIG_TRACE_SYSTEMTAP' in config_host
       foreach stp: [
-        {'ext': '.stp-build', 'fmt': 'stap', 'bin': meson.current_build_dir() / exe_name, 'install': false},
-        {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') / get_option('bindir') / exe_name, 'install': true},
+        {'ext': '.stp-build', 'fmt': 'stap', 'bin': meson.current_build_dir() / exe['name'], 'install': false},
+        {'ext': '.stp', 'fmt': 'stap', 'bin': get_option('prefix') / get_option('bindir') / exe['name'], 'install': true},
         {'ext': '-simpletrace.stp', 'fmt': 'simpletrace-stap', 'bin': '', 'install': true},
         {'ext': '-log.stp', 'fmt': 'log-stap', 'bin': '', 'install': true},
       ]
-        custom_target(exe_name + stp['ext'],
+        custom_target(exe['name'] + stp['ext'],
                       input: trace_events_all,
-                      output: exe_name + stp['ext'],
+                      output: exe['name'] + stp['ext'],
                       capture: true,
                       install: stp['install'],
                       install_dir: config_host['qemu_datadir'] / '../systemtap/tapset',
-- 
2.26.2



