Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5530BC00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB1B2208B6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fbs6Fscn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1B2208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcdR-0004hB-LJ
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZcYo-0007c9-AU
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:19:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kZcYm-0007Yt-JV
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604333995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/aWKbAAhu9frPZQrNWey5VyZKlxANhwMMHb0/A+kqlg=;
 b=Fbs6FscnQkMhG1qoJXZkL635se7BG3sOhW7oVq+vxvxMD1yOU/mQt9Ly39vpHCzdU7ICWK
 ZNrIuGqFSMQLVQBM28bZhnVhldILl9WAUVCbj7TUzOsNDf0tp/P8ekoon1l39LY0bSnBVr
 +WXnmXWBd998ieCbVu2c4eS6J542Pqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-19WoXifrPwizNbeucR3UwQ-1; Mon, 02 Nov 2020 11:19:53 -0500
X-MC-Unique: 19WoXifrPwizNbeucR3UwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2030880403C
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2020 16:19:50 +0000 (UTC)
Received: from localhost (unknown [10.40.194.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A29915C3E0;
 Mon,  2 Nov 2020 16:19:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/7] tests/acceptance/boot_linux: Accept SSH pubkey
Date: Mon,  2 Nov 2020 17:18:58 +0100
Message-Id: <20201102161859.156603-7-mreitz@redhat.com>
In-Reply-To: <20201102161859.156603-1-mreitz@redhat.com>
References: <20201102161859.156603-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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
Cc: Miklos Szeredi <mszeredi@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let download_cloudinit() take an optional pubkey, which subclasses of
BootLinux can pass through setUp().

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Willian Rampazzo <willianr@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/acceptance/boot_linux.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index c743e231f4..1da4a53d6a 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -57,7 +57,7 @@ class BootLinuxBase(Test):
             self.cancel('Failed to download/prepare boot image')
         return boot.path
 
-    def download_cloudinit(self):
+    def download_cloudinit(self, ssh_pubkey=None):
         self.log.info('Preparing cloudinit image')
         try:
             cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
@@ -67,7 +67,8 @@ class BootLinuxBase(Test):
                           password='password',
                           # QEMU's hard coded usermode router address
                           phone_home_host='10.0.2.2',
-                          phone_home_port=self.phone_home_port)
+                          phone_home_port=self.phone_home_port,
+                          authorized_key=ssh_pubkey)
         except Exception:
             self.cancel('Failed to prepared cloudinit image')
         return cloudinit_iso
@@ -80,19 +81,19 @@ class BootLinux(BootLinuxBase):
     timeout = 900
     chksum = None
 
-    def setUp(self):
+    def setUp(self, ssh_pubkey=None):
         super(BootLinux, self).setUp()
         self.vm.add_args('-smp', '2')
         self.vm.add_args('-m', '1024')
         self.prepare_boot()
-        self.prepare_cloudinit()
+        self.prepare_cloudinit(ssh_pubkey)
 
     def prepare_boot(self):
         path = self.download_boot()
         self.vm.add_args('-drive', 'file=%s' % path)
 
-    def prepare_cloudinit(self):
-        cloudinit_iso = self.download_cloudinit()
+    def prepare_cloudinit(self, ssh_pubkey=None):
+        cloudinit_iso = self.download_cloudinit(ssh_pubkey)
         self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
 
     def launch_and_wait(self):
-- 
2.26.2


