Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81332C55186
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4A220857
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+F64rmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4A220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3tY-0005Ty-A7
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sJ-0003OL-1y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sI-00041a-79
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59454
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jS3sH-00040V-QM
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587756032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fPqpkxxLrbq0kguWObFH1O9VfmQgBJD9g6Yq4vveSMg=;
 b=L+F64rmfk+eKNO+AoVVdJI4VuUpFcEvp63A3DmrzNRMzls2a/RXxCnujlH2qcGn7v8wSC7
 2g2EP/KpelGudYXVpcgCMC/JwqcXp3dDZqBSvWL4v5zcPV/9P3x/VbHP9IOg21JA5wvylI
 vGCk6JO+nmhQzdF2d2FEAUw4bZGLT5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-3ESpcJOSNAy2_HQQJaicQg-1; Fri, 24 Apr 2020 15:20:30 -0400
X-MC-Unique: 3ESpcJOSNAy2_HQQJaicQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF1021800D42
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 19:20:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8780E10002AA
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 19:20:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 222D311358BC; Fri, 24 Apr 2020 21:20:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] More miscellaneous error handling fixes
Date: Fri, 24 Apr 2020 21:20:16 +0200
Message-Id: <20200424192027.11404-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 15:11:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Markus Armbruster (11):
  nvdimm: Plug memory leak in uuid property setter
  xen: Fix and improve handling of device_add usb-host errors
  s390x/cpumodel: Fix harmless misuse of visit_check_struct()
  s390x/pci: Fix harmless mistake in zpci's property fid's setter
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
 hw/s390x/s390-pci-bus.c      |  4 +++-
 hw/sd/pxa2xx_mmci.c          |  4 ++--
 hw/sd/sd.c                   |  4 ++--
 hw/usb/dev-mtp.c             |  9 +++++----
 hw/usb/xen-usb.c             | 18 ++++++++----------
 qemu-nbd.c                   |  7 +++----
 scsi/qemu-pr-helper.c        |  4 ++--
 target/i386/cpu.c            | 25 ++++++++++++++++---------
 target/s390x/cpu_models.c    |  2 +-
 tests/qtest/migration-test.c |  4 ++--
 15 files changed, 61 insertions(+), 65 deletions(-)

--=20
2.21.1


