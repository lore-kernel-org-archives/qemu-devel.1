Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF365C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D7022453
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 14:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ks+50g+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D7022453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZb6a-000772-G3
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 09:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZb3B-0002Bc-1T
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:43:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kZb39-0005Bl-6E
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 09:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604328189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8c2mx9+kUpRT0512oX5fGgjcKQl0QECZq9U12Mhnx9M=;
 b=Ks+50g+tfAqLy13/NFGANF1FTh5xxIm12FkOUU1ADx86fPwyzMx+KOYkC2B/lTniBRlfBB
 PQyEZiFisQfOIYBWa1OKM3HMv0YOM/sT5WHa7PM+eKhMPZshLzCSCvnKpWiJVcz+9GcrLR
 8usOV3MjBxWyIt07qwbPXDa+MpDCEtc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6--RTO65eXMIqU4RG8XO4DqQ-1; Mon, 02 Nov 2020 09:43:07 -0500
X-MC-Unique: -RTO65eXMIqU4RG8XO4DqQ-1
Received: by mail-wr1-f69.google.com with SMTP id x16so6472282wrg.7
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 06:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8c2mx9+kUpRT0512oX5fGgjcKQl0QECZq9U12Mhnx9M=;
 b=ipqKLPtSkAznf0d1d9I/DLp43ToJvwCJDYQKsEqeGeyssvsNvtubpCqmSsXR/jDdEA
 z22rfCa6tMdcSQL+jxYERqa5LK4mbKeXhVQtwEcxjtLThB6N1kcJA5R4J+YaLMTJjVU6
 I+L8w5fW5n2v+iGfbAe+s9g7Pl6qsSVaS2asxgs+6mn8LEaOyAvNib9MW7JmKDQ82loh
 uGi+8cTqCZ/vnKAXN1vAknVVA2jggp2Ke0TxI7MYVKlPW98iIT0KnrU7zxYdgarvV3y0
 Mqi2hm3QNrhQiw8nSyOHQMo+zIbKmEprFETf4rdbLJ04mKHJ2FRR5o1evReUeA/4GHD4
 jz5Q==
X-Gm-Message-State: AOAM533JmMhNJagpJA6sZYZlBuegCjO9qZdN6lXLdDSUcUvoiaFUEp0p
 DR+GIKRmjUMm9OYsdWWjZXIoxK8kRI0+KO7gksL7VvYRJtw3cO+YzqTaL212FUQjq+ZVEvREO5+
 1EeFvRcuQAEmHJlw=
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr18876536wmi.140.1604328186070; 
 Mon, 02 Nov 2020 06:43:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPz89buT602u6l0DoFSx6IduJRxYDNOdfAh1NT1T+FVGM6fgiGHxH2Gm/hy8KEk4Dn75vm9A==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr18876518wmi.140.1604328185864; 
 Mon, 02 Nov 2020 06:43:05 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id w4sm9067803wrk.28.2020.11.02.06.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 06:43:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH-for-5.2? 3/5] tests/acceptance: Skip incomplete virtio_version
 tests using '@skip'
Date: Mon,  2 Nov 2020 15:42:43 +0100
Message-Id: <20201102144245.2134077-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102144245.2134077-1-philmd@redhat.com>
References: <20201102144245.2134077-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Fabien Chouteau <chouteau@adacore.com>, Aurelien Jarno <aurelien@aurel32.net>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prefer skipping incomplete tests with the "@skip" keyword,
rather than commenting the code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/virtio_version.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
index 33593c29dd0..187bbfa1f42 100644
--- a/tests/acceptance/virtio_version.py
+++ b/tests/acceptance/virtio_version.py
@@ -140,17 +140,20 @@ def check_all_variants(self, qemu_devtype, virtio_devid):
         self.assertIn('conventional-pci-device', trans_ifaces)
         self.assertNotIn('pci-express-device', trans_ifaces)
 
+    @skip("virtio-blk requires 'driver' parameter")
+    def test_conventional_devs_driver(self):
+        self.check_all_variants('virtio-blk-pci', VIRTIO_BLOCK)
+
+    @skip("virtio-9p requires 'fsdev' parameter")
+    def test_conventional_devs_fsdev(self):
+        self.check_all_variants('virtio-9p-pci', VIRTIO_9P)
 
     def test_conventional_devs(self):
         self.check_all_variants('virtio-net-pci', VIRTIO_NET)
-        # virtio-blk requires 'driver' parameter
-        #self.check_all_variants('virtio-blk-pci', VIRTIO_BLOCK)
         self.check_all_variants('virtio-serial-pci', VIRTIO_CONSOLE)
         self.check_all_variants('virtio-rng-pci', VIRTIO_RNG)
         self.check_all_variants('virtio-balloon-pci', VIRTIO_BALLOON)
         self.check_all_variants('virtio-scsi-pci', VIRTIO_SCSI)
-        # virtio-9p requires 'fsdev' parameter
-        #self.check_all_variants('virtio-9p-pci', VIRTIO_9P)
 
     def check_modern_only(self, qemu_devtype, virtio_devid):
         """Check if a modern-only virtio device type behaves as expected"""
-- 
2.26.2


