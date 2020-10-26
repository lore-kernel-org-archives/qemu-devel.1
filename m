Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85217C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C21207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPXqDozQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C21207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7sa-0004CY-To
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX7qL-0002IN-Ar
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX7qJ-0006pw-IS
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603739262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4NQKTT0N4YaHyuFI7iWRatURDvw2djrZGhLWKYnYYw=;
 b=bPXqDozQu0dgEsA/SMNauTxDvgQYwkTAb/YGjD3SRLMG91kmKeDmvI8rWLu8KStnh5opG7
 Kr5sliPbl7A7QNdF29vrag+fte5uY4wEZlbUjQFK9KhMF4HILKDqQ/TG4ncyNOnvv1erxU
 QO2C4yLBoBvI6jMnmQt7OybyX77RLHo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-qmuHN6VyNSO4MsiYrYLfEQ-1; Mon, 26 Oct 2020 15:07:40 -0400
X-MC-Unique: qmuHN6VyNSO4MsiYrYLfEQ-1
Received: by mail-ed1-f69.google.com with SMTP id dn20so5236945edb.14
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R4NQKTT0N4YaHyuFI7iWRatURDvw2djrZGhLWKYnYYw=;
 b=OOxg6l9wxl1sycLwY33K8MyPzjauAOC5ll2ztZ8+JPywQVnuCKycve5cCYUSBvOZWI
 vZqPauE46ZAg+kmhDw+tmrIKIi44DJ6Nf+OCHUfxAerZZKkhPshDs13WX2ermMHZbm0C
 gmUvk2RTH7XL4EEeEfMbaX4y0qOVLQEP6Ox6Oh4Kq5a0OvkkOBY4bkrskImlomPT/xnP
 ORAjjTjoAKjpyIgyzAa8qTqjy6LxOGT35f2V5+pk5JXN5hAttXMyo2YPC7vMW6Niuj0W
 UPqW1ewasHDDUQsu60KlhEQ66X66xH+ERlRs4AxkA4CJgZVeC3OvqoENOhsjiYy6kB8z
 ABMw==
X-Gm-Message-State: AOAM531XagbMXVyGZcMn0VmmGN5U5nFWFgrqyknXVYzZaXYRYLYXgaI3
 EeTIQd+huR1l5+ljDYlzR4hpnO71npoGfRsnL0E0vbA1VKwYAE9QfExnoHd7+yC7Z8ZgtSooyA9
 eoZ6Yr+4+6kuPBPc=
X-Received: by 2002:a17:906:a149:: with SMTP id
 bu9mr16616410ejb.115.1603739258899; 
 Mon, 26 Oct 2020 12:07:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7JInhPPkFsh1VFBN7oZdYwF/goz23poAPdQGOx0aYSMWpQrfSxWZ1o3lvMldRmSfp/wRE1A==
X-Received: by 2002:a17:906:a149:: with SMTP id
 bu9mr16616392ejb.115.1603739258703; 
 Mon, 26 Oct 2020 12:07:38 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id h13sm5752787edz.43.2020.10.26.12.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 12:07:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] tests/acceptance: Add a 'virt_kvm' test using the GICv3
Date: Mon, 26 Oct 2020 20:07:24 +0100
Message-Id: <20201026190726.19515-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026190726.19515-1-philmd@redhat.com>
References: <20201026190726.19515-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Willian Rampazzo <willianr@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current 'virt_kvm' test is restricted to GICv2, but can also
work with a GICv3. Duplicate it but add a GICv3 test which can be
tested on some hardware.

Noticed while running:

 $ avocado --show=app run -t machine:virt tests/acceptance/
 ...
 (2/6) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_kvm: ERROR: Unexpected empty reply from server (1.82 s)

The job.log content is:

  L0351 DEBUG| Output: 'qemu-system-aarch64: host does not support in-kernel GICv2 emulation\n'

With this patch:

 $ avocado --show=app run -t device:gicv3 tests/acceptance/
 (1/1) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_kvm_gicv3: PASS (55.10 s)

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Message-Id: <20200929224857.1225107-1-philmd@redhat.com>
---
 tests/acceptance/boot_linux.py | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index 0055dc7cee7..c743e231f47 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -182,10 +182,11 @@ def test_virt_tcg(self):
         self.add_common_args()
         self.launch_and_wait()
 
-    def test_virt_kvm(self):
+    def test_virt_kvm_gicv2(self):
         """
         :avocado: tags=accel:kvm
         :avocado: tags=cpu:host
+        :avocado: tags=device:gicv2
         """
         if not kvm_available(self.arch, self.qemu_bin):
             self.cancel(KVM_NOT_AVAILABLE)
@@ -195,6 +196,20 @@ def test_virt_kvm(self):
         self.add_common_args()
         self.launch_and_wait()
 
+    def test_virt_kvm_gicv3(self):
+        """
+        :avocado: tags=accel:kvm
+        :avocado: tags=cpu:host
+        :avocado: tags=device:gicv3
+        """
+        if not kvm_available(self.arch, self.qemu_bin):
+            self.cancel(KVM_NOT_AVAILABLE)
+        self.vm.add_args("-accel", "kvm")
+        self.vm.add_args("-cpu", "host")
+        self.vm.add_args("-machine", "virt,gic-version=3")
+        self.add_common_args()
+        self.launch_and_wait()
+
 
 class BootLinuxPPC64(BootLinux):
     """
-- 
2.26.2


