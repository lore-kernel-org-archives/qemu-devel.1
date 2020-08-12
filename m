Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AD3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:20:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30DF220656
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIAvpUYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DF220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5qgD-0007u9-Dz
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 09:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5qeO-0005XD-DP
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:18:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5qeM-00020J-ED
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 09:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597238317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4mjxnfhZTEY4W1zUTEY9eiw0fQf0Ihd27/UfIy0lA8=;
 b=gIAvpUYUPw88s0r2KQRJwvLhMKv6LmCeYd+gCf15ZKLsKHBJj9FVFiJMC3syS+FyPSfipd
 6QIEs+ZJOE3Q1l2E/18hkjaZGvZXd0rXgU0DuoI6BtkhU0gWisMm2IAWD8Wklqs3DqXnmO
 +LrPj+h20ZUTXICP4odK7IcdciaLB6Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-mA52fJyGO9GfZTmKHDR-8w-1; Wed, 12 Aug 2020 09:18:35 -0400
X-MC-Unique: mA52fJyGO9GfZTmKHDR-8w-1
Received: by mail-wr1-f72.google.com with SMTP id 5so890491wrc.17
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 06:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O4mjxnfhZTEY4W1zUTEY9eiw0fQf0Ihd27/UfIy0lA8=;
 b=kfrNQ746Z9ALe3qj1dRDDgwptoB+hr6jr3iM6uKSyWVPkCjzQm6Vc0GFfy70eLvBH0
 tAFhtUS4xSS+kDM9qrkBbX29k6D5LzIxscUfmiJno3ND8JaBojEUzkzlw8RM5oT/A6nH
 E3UZ7bTkyCDm25CYvjq/dQcS68RfoIrMwzosjUQS8PzZGgh6NzMTo8FIGa1ZngWMpgyZ
 yy9rXo8BTzY42pzEzEj4F1hIuwUr0vLA3dDv8JdeEcKLxeWGVojq51zOg6WHukF2ieG1
 yTZBuo5Z/F6YR+Qeprn+EIRdrxG5nKc5voKIXorYGFizYelnqc/GmLnS2Gd4LeDm+hG2
 +yMA==
X-Gm-Message-State: AOAM530+z77L55MWxI3B8nCwyXCSdKYOLZfA02C/VN8odkgd4NcHclue
 OnTRKSbma4THCNBNgmGWwZ1Bkt9osg3eAw6axUo+tD2drRMP9gEhbBW4j3TPgq4UTsYVQx3p3QK
 d1fiizScERZ8HI7o=
X-Received: by 2002:a1c:f003:: with SMTP id a3mr8473405wmb.170.1597238314127; 
 Wed, 12 Aug 2020 06:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzuNgB/3lJtpDgX6UNj/Qt0BkB47+eVVsOD6hCDBJrigMtb8BWqaMXYF7gVZtXSZjA0pSOQg==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr8473390wmb.170.1597238313902; 
 Wed, 12 Aug 2020 06:18:33 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h5sm4971790wrc.97.2020.08.12.06.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 06:18:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] acceptance: use stable URLs for the Debian and Ubuntu
 installer
Date: Wed, 12 Aug 2020 15:18:22 +0200
Message-Id: <20200812131822.28162-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812131822.28162-1-philmd@redhat.com>
References: <20200812131822.28162-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

The kernel and initrd hashes seem to have changed for the Bionic
aarch64 installer, causing BootLinuxConsole.test_aarch64_xlnx_versal_virt
to fail.  Correct the paths to use the previous binaries instead of
the latest.  Do the same for the Lenny alpha installer for
consistency, even though those are unlikely to change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200810092941.154911-1-pbonzini@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 2f22eddd0d..aaa781a581 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -337,7 +337,7 @@ def test_aarch64_xlnx_versal_virt(self):
         """
         images_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
                       'bionic-updates/main/installer-arm64/'
-                      'current/images/')
+                      '20101020ubuntu543.15/images/')
         kernel_url = images_url + 'netboot/ubuntu-installer/arm64/linux'
         kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
@@ -821,7 +821,7 @@ def test_alpha_clipper(self):
         :avocado: tags=machine:clipper
         """
         kernel_url = ('http://archive.debian.org/debian/dists/lenny/main/'
-                      'installer-alpha/current/images/cdrom/vmlinuz')
+                      'installer-alpha/20090123lenny10/images/cdrom/vmlinuz')
         kernel_hash = '3a943149335529e2ed3e74d0d787b85fb5671ba3'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
-- 
2.21.3


