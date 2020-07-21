Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7997C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA722068F
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah3dB0Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA722068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnNX-0000a7-G9
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMd-0007RY-UH
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54616
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxnMc-0004JP-7H
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595319061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iVorOSLUQ3X/sRR4QQWS9Cu5VIyqhHak63o0jTSBcQw=;
 b=Ah3dB0HzBV8hPxFVRVLa39g2e4bfi4TlrgKiV46Ua3JJK//k8pGMFBCjdiHKEiFGKKbn2g
 RrWq9Fxv7fdDmUNXdI04fSgrXiF2mj0PMlKN/OieDUaFbMRdqqYM8aQaYEgPQa9oV737K3
 SjC2E/zHcf/46Uc1XrP4htmUJm+fKq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-iE8fcbhIOZ-XDaDYpvBa6w-1; Tue, 21 Jul 2020 04:10:59 -0400
X-MC-Unique: iE8fcbhIOZ-XDaDYpvBa6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80EA218C63C1;
 Tue, 21 Jul 2020 08:10:58 +0000 (UTC)
Received: from thuth.com (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D9E82DE72;
 Tue, 21 Jul 2020 08:10:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/10] qtest / fuzzer patches
Date: Tue, 21 Jul 2020 10:10:45 +0200
Message-Id: <20200721081055.14073-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

 Hi Peter,

the following changes since commit af3d69058e09bede9900f266a618ed11f76f49f3:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200720' into staging (2020-07-20 15:58:07 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-07-21

for you to fetch changes up to 7ad36e2e241bd924f774a1f9fb208c102da58e50:

  hw: Mark nd_table[] misuse in realize methods FIXME (2020-07-21 08:41:15 +0200)

----------------------------------------------------------------
* Fix memory leak in fuzzer
* Fuzzer documentation updates
* Some other minor fuzzer updates
* Fix "make check-qtest SPEED=slow" (bug in msf2 instance_init)
----------------------------------------------------------------

Alexander Bulekov (6):
      fuzz: Fix leak when assembling datadir path string
      gitlab-ci.yml: Add oss-fuzz build tests
      fuzz: build without AddressSanitizer, by default
      docs/fuzz: describe building fuzzers with enable-sanitizers
      docs/fuzz: add information about useful libFuzzer flags
      docs/fuzz: add instructions for generating a coverage report

Markus Armbruster (2):
      msf2: Unbreak device-list-properties for "msf-soc"
      hw: Mark nd_table[] misuse in realize methods FIXME

Thomas Huth (2):
      scripts/oss-fuzz: Limit target list to i386-softmmu
      MAINTAINERS: Extend the device fuzzing section

 .gitlab-ci.yml            | 22 ++++++++---------
 MAINTAINERS               |  2 ++
 configure                 | 10 ++++----
 docs/devel/fuzzing.txt    | 63 +++++++++++++++++++++++++++++++++++++++++++++--
 hw/arm/allwinner-h3.c     |  1 +
 hw/arm/msf2-soc.c         |  9 ++++---
 hw/arm/xlnx-versal.c      |  1 +
 hw/arm/xlnx-zynqmp.c      |  1 +
 hw/dma/sparc32_dma.c      |  1 +
 hw/riscv/sifive_u.c       |  1 +
 scripts/oss-fuzz/build.sh |  2 +-
 tests/qtest/fuzz/fuzz.c   | 12 +++++----
 12 files changed, 96 insertions(+), 29 deletions(-)


