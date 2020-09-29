Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0199C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3351520756
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 22:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVZaWTj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3351520756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNOPf-0001XE-5c
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 18:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOM1-000556-LM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNOLz-0004ZY-Vn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 18:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601419451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnVaKlxSjgosYNWUZ3C9BB5KnUFHrX+zW6dbopznvYU=;
 b=MVZaWTj3uuEWiAJX7mnLgvCR1qJdqbNF7Nh0l4y4x/JPJrz8tRNUAuG6j33lDKNGvmWG2G
 daNojlzfhWL7Kmw6Pq3P6/F8zJ90dEURNaiaEeB+rcIrVqXHwbZ7nUxo76h2bXdHpavGdR
 mrDR+0DUrG8Yr5Fo45KvI9Bd2gamV4o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-Bn0Rml5nPHqAneVBULJ8tQ-1; Tue, 29 Sep 2020 18:44:09 -0400
X-MC-Unique: Bn0Rml5nPHqAneVBULJ8tQ-1
Received: by mail-wr1-f69.google.com with SMTP id s8so2338449wrb.15
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 15:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fnVaKlxSjgosYNWUZ3C9BB5KnUFHrX+zW6dbopznvYU=;
 b=hECtpd/exQx+0ZCyPxqB8zQ/XIUzH+d5BuEdoeACFVIA7dXX+DgWD5iqMoX8dIvBsi
 EwnXT/UX33/IEkzNFFiMq8Rl8gmBwk7lCKi4bKgnLUFuZKgHdE4IlI6OdYVQxtjgH2UR
 y2YUJbr8+s3UamAE77bUjjlEWkn0wpAL9qsBqo9R0egP1ZQO8vgRttjQb0r25bQ2rsBB
 7oZtnqN4xXR9ApKthSQ1Wvp0RjT8o/IeOZBG0fDlxphjHYTNOqwxTFtGmPbphumoSB7z
 nnTFxKTV9Dgu6Q48k/I5sBzyYwhI4bvFRjGy0/BUb/ibS78nvoe9HWIu3k9515iFUBNK
 HUwg==
X-Gm-Message-State: AOAM532GAJiivnlZs6UKIQjkhQJ5bRHqp3ORzjl1vaydKj1Ydjy+C05t
 xYfGmacko09A7ctQmyo/PiqTGIqPQJTm4cb1IuZ+PXu6Nz44SoPeGZuhhGdRBQi4UUETOMaiLmD
 wyFpekl05vp6u008=
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr6386597wrp.332.1601419448303; 
 Tue, 29 Sep 2020 15:44:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz32LQg/FraBPNB2aGTQWNffth7R+ByzmBlrprh0rhJbQuVc73LtYh8e6YQu2ibVKmeTxTjoQ==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr6386570wrp.332.1601419448124; 
 Tue, 29 Sep 2020 15:44:08 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id e13sm8276536wre.60.2020.09.29.15.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 15:44:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/12] meson: Allow optional target/${ARCH}/Kconfig
Date: Wed, 30 Sep 2020 00:43:45 +0200
Message-Id: <20200929224355.1224017-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929224355.1224017-1-philmd@redhat.com>
References: <20200929224355.1224017-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extend the generic Meson script to pass optional target Kconfig
file to the minikconf script.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
We could use fs.exists() but is_file() is more specific
(can not be a directory).

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Claudio Fontana <cfontana@suse.de>
---
 meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d36dd085b5..9ab5d514d7 100644
--- a/meson.build
+++ b/meson.build
@@ -529,6 +529,7 @@ kconfig_external_symbols = [
 ]
 ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
 
+fs = import('fs')
 foreach target : target_dirs
   config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak')
 
@@ -569,8 +570,13 @@ foreach target : target_dirs
     endforeach
 
     config_devices_mak = target + '-config-devices.mak'
+    target_kconfig = 'target' / config_target['TARGET_BASE_ARCH'] / 'Kconfig'
+    minikconf_input = ['default-configs' / target + '.mak', 'Kconfig']
+    if fs.is_file(target_kconfig)
+      minikconf_input += [target_kconfig]
+    endif
     config_devices_mak = configure_file(
-      input: ['default-configs' / target + '.mak', 'Kconfig'],
+      input: minikconf_input,
       output: config_devices_mak,
       depfile: config_devices_mak + '.d',
       capture: true,
-- 
2.26.2


