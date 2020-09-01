Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65427C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B592071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sed55K14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B592071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCziC-0005cE-9F
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCzeg-00064A-R3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:20:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33658
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCzee-0000nG-8R
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598941227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gvaoFN39D5fdcn7Vhz80mBwdQvKtXadSQT2O8g1yk60=;
 b=Sed55K14+QOdO8D/jmH/7EvtOOQ8t/5Q6GdaWZXyqs3k5BaookEPIevDutG/3Y0LpxX5gG
 YTFEWUwl8CKkMNKU39Gx3yEuA2vO2OYdk/ApBmCoj/AewSX4xlU4gycflI/L2qmGCx087D
 HkgMuInRswX5msItoewzRHG/dcAyqbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-6WEkXainNFqdjdcFLpAK7Q-1; Tue, 01 Sep 2020 02:20:22 -0400
X-MC-Unique: 6WEkXainNFqdjdcFLpAK7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28D1310066FC;
 Tue,  1 Sep 2020 06:20:21 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A26171002D4E;
 Tue,  1 Sep 2020 06:20:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/13] Make QEMU installation relocatable
Date: Tue,  1 Sep 2020 02:20:07 -0400
Message-Id: <20200901062020.26660-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Right now, the installation of QEMU is not relocatable; there is
a local hack in os_find_datadir() so that Windows binaries look
for ROMs in the executable directory, but that has several limitations:

- it does not extend to configuration files, icons, etc.

- it does not allow changing the data directory in any way

- it does not apply to POSIX platforms

This series fixes that by making all paths within the installation
prefix relative to the executable.  This in practice means all paths
will be relocatable, except for /etc and /var if they're moved
outside the prefix.

Here is an example of relocatability; before:

  $ make DESTDIR=$PWD/test install
  $ cd test/usr/local/bin
  $ ./qemu-system-ppc -L help
  /usr/local/share/qemu-firmware
  /usr/local/share/qemu

After:

  $ make DESTDIR=$PWD/test install
  $ cd test/usr/local/bin
  $ ./qemu-system-ppc -L help
  /home/pbonzini/work/upstream/qemu/+build/test/usr/local/bin/../share/qemu-firmware
  /home/pbonzini/work/upstream/qemu/+build/test/usr/local/bin/../share/qemu

The main benefit of this is on Windows, as mentioned above; but it also
makes behavior more consistent across platforms and allows the removal
of the hack that hides the "c:/Program Files/QEMU" prefix from Meson
during cross compilation.

Paolo

Paolo Bonzini (13):
  fuzz: use qemu_get_exec_dir
  oslib: do not call g_strdup from qemu_get_exec_dir
  oslib-posix: default exec_dir to bindir
  cutils: introduce get_relocated_path
  oslib-posix: relocate path to /var
  module: relocate path to modules
  net: relocate paths to helpers and scripts
  vl: relocate paths to data directories
  vl: relocate path to configuration file
  qemu-bridge-helper: relocate path to default ACL
  qga: relocate path to default configuration and hook
  ui: relocate paths to icons and translations
  configure: use a platform-neutral prefix

 configure               | 30 ++++++++------------
 include/net/net.h       |  4 +--
 include/qemu-common.h   |  1 -
 include/qemu/cutils.h   | 12 ++++++++
 include/qemu/osdep.h    |  8 ++----
 include/sysemu/sysemu.h |  2 +-
 meson.build             |  4 +--
 net/tap.c               | 28 ++++++++++++++-----
 os-posix.c              | 24 ----------------
 os-win32.c              | 11 --------
 qemu-bridge-helper.c    |  9 ++++--
 qga/main.c              |  8 ++++--
 softmmu/vl.c            | 43 ++++++++++++++++++++---------
 tests/qtest/fuzz/fuzz.c | 12 ++++----
 ui/gtk.c                | 10 +++++--
 ui/sdl2.c               |  9 ++++--
 util/cutils.c           | 61 +++++++++++++++++++++++++++++++++++++++++
 util/module.c           | 10 ++-----
 util/oslib-posix.c      | 35 +++++++++++------------
 util/oslib-win32.c      | 14 +++++++---
 20 files changed, 205 insertions(+), 130 deletions(-)

-- 
2.26.2


