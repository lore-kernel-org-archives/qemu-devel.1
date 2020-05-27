Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC90C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:03:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9BE20787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZvmYmZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9BE20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdpAA-00081m-Dm
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6Y-0002aC-Iy
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:59:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6W-0004DK-9T
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590559190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=462/QREtzFFIR1nDX9Omk/7JrD8QV1sgq5OEwYoD5i8=;
 b=AZvmYmZJg3p+/5a4pIVWQaaX/cRgINl6AOT3QRYl7lOGPM38uBV3kSDhY5wczoW3RTJV5/
 iklt14gJlrRV9W5ksdqJm/s0VSW85dprZ7zZWaFGN7knaqfwLW3kjRQ5E9Vb/toTx9nD3/
 PxiUMOr7yBELaWLnZ8rowg1OBhFZ8OQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-O-VtEQ2_NCWjE26s-17DzA-1; Wed, 27 May 2020 01:59:48 -0400
X-MC-Unique: O-VtEQ2_NCWjE26s-17DzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D2B7107ACCA
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 05:59:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71A975D9E7
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 05:59:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DEAC1113864A; Wed, 27 May 2020 07:59:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] Error reporting patches for 2020-05-27
Date: Wed, 27 May 2020 07:59:35 +0200
Message-Id: <20200527055945.6774-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac63510:

  Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' into staging (2020-05-26 14:05:53 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-05-27

for you to fetch changes up to 49e2fa85ff04a9be89ed15f922c7d8dae2be9e74:

  i386: Fix x86_cpu_load_model() error API violation (2020-05-27 07:45:45 +0200)

----------------------------------------------------------------
Error reporting patches for 2020-05-27

----------------------------------------------------------------
Markus Armbruster (10):
      nvdimm: Plug memory leak in uuid property setter
      xen: Fix and improve handling of device_add usb-host errors
      s390x/cpumodel: Fix harmless misuse of visit_check_struct()
      tests/migration: Tighten error checking
      error: Use error_reportf_err() where appropriate
      mips/malta: Fix create_cps() error handling
      mips/boston: Fix boston_mach_init() error handling
      mips/boston: Plug memory leak in boston_mach_init()
      arm/sabrelite: Consistently use &error_fatal in sabrelite_init()
      i386: Fix x86_cpu_load_model() error API violation

 chardev/char-socket.c        |  5 +++--
 hw/arm/sabrelite.c           |  7 +------
 hw/mem/nvdimm.c              |  1 -
 hw/mips/boston.c             | 17 +++++++----------
 hw/mips/mips_malta.c         | 15 ++++++---------
 hw/sd/pxa2xx_mmci.c          |  4 ++--
 hw/sd/sd.c                   |  4 ++--
 hw/usb/dev-mtp.c             |  9 +++++----
 hw/usb/xen-usb.c             | 19 +++++++++----------
 qemu-nbd.c                   |  7 +++----
 scsi/qemu-pr-helper.c        |  4 ++--
 target/i386/cpu.c            | 25 ++++++++++++++++---------
 target/s390x/cpu_models.c    |  2 +-
 tests/qtest/migration-test.c |  4 ++--
 14 files changed, 59 insertions(+), 64 deletions(-)

-- 
2.21.3


