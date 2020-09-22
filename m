Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A76C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEAD208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWZvWJ0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEAD208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqlJ-0001HG-L7
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjS-00081k-10
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:25:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjM-0006E4-K8
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600813546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1cFGbK+hjKkjGTy9CaDNp/Me/1GQjJqPLAWZHhwr/iE=;
 b=eWZvWJ0SBcRDXcTxBWWI9n/1vq0DFbRFYHTkzeRJcCO+Bg5hCRv8DX8g3/rNVeUizl5j3g
 pHpfmJx4EAuARURhVtyBrTf40IpR0CP7ycfoYEc+AWX/KPTtq5s9HVlBgFTQQ5f1GIepmG
 sWaMChYAerxsvB4pG0sKHQuxm9Zk6kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-yq4R3vgoNOK32AIflY5AdQ-1; Tue, 22 Sep 2020 18:25:44 -0400
X-MC-Unique: yq4R3vgoNOK32AIflY5AdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC96681CBE7;
 Tue, 22 Sep 2020 22:25:43 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AA9778805;
 Tue, 22 Sep 2020 22:25:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/11] machine + QOM queue, 2020-09-22
Date: Tue, 22 Sep 2020 18:25:31 -0400
Message-Id: <20200922222542.2354748-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 13:33:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 834b9273d5cdab68180dc8c84d641aaa4344b057=
:=0D
=0D
  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-for-5.2=
-pull-request' into staging (2020-09-22 15:42:23 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request=0D
=0D
for you to fetch changes up to 418b473e8f586247475e8adc5d048598e5721361:=0D
=0D
  sifive_u: Register "start-in-flash" as class property (2020-09-22 16:48:2=
9 -0400)=0D
=0D
----------------------------------------------------------------=0D
machine + QOM queue, 2020-09-22=0D
=0D
QOM cleanups:=0D
* Convert instance properties to class properties=0D
  (Eduardo Habkost)=0D
* simplify object_find_property / object_class_find_property=0D
  (Daniel P. Berrang=C3=A9)=0D
=0D
Deprecated feature removal:=0D
* Drop support for invalid topologies (Igor Mammedov)=0D
=0D
----------------------------------------------------------------=0D
=0D
Daniel P. Berrang=C3=A9 (1):=0D
  qom: simplify object_find_property / object_class_find_property=0D
=0D
Eduardo Habkost (9):=0D
  cryptodev-vhost-user: Register "chardev" as class property=0D
  cryptodev-backend: Register "chardev" as class property=0D
  s390x: Register all CPU properties as class properties=0D
  cpu/core: Register core-id and nr-threads as class properties=0D
  xlnx-zcu102: Register properties as class properties=0D
  machine: Register "memory-backend" as class property=0D
  i440fx: Register i440FX-pcihost properties as class properties=0D
  sifive_e: Register "revb" as class property=0D
  sifive_u: Register "start-in-flash" as class property=0D
=0D
Igor Mammedov (1):=0D
  smp: drop support for deprecated (invalid topologies)=0D
=0D
 docs/system/deprecated.rst       | 26 +++++++-------=0D
 include/qom/object.h             | 48 ++++++++++++++++++++++---=0D
 target/s390x/internal.h          |  1 -=0D
 backends/cryptodev-vhost-user.c  | 13 +++----=0D
 backends/cryptodev.c             |  8 ++---=0D
 hw/arm/armv7m.c                  | 10 +++---=0D
 hw/arm/exynos4210.c              |  2 +-=0D
 hw/arm/highbank.c                |  2 +-=0D
 hw/arm/integratorcp.c            |  2 +-=0D
 hw/arm/realview.c                |  2 +-=0D
 hw/arm/sbsa-ref.c                |  2 +-=0D
 hw/arm/versatilepb.c             |  2 +-=0D
 hw/arm/vexpress.c                |  4 +--=0D
 hw/arm/virt.c                    | 10 +++---=0D
 hw/arm/xilinx_zynq.c             |  2 +-=0D
 hw/arm/xlnx-zcu102.c             | 25 ++++++-------=0D
 hw/core/machine.c                | 28 ++++++---------=0D
 hw/core/qdev-properties-system.c |  2 +-=0D
 hw/core/sysbus.c                 |  2 +-=0D
 hw/cpu/a15mpcore.c               |  4 +--=0D
 hw/cpu/a9mpcore.c                |  2 +-=0D
 hw/cpu/core.c                    |  8 ++---=0D
 hw/i386/pc.c                     | 16 +++------=0D
 hw/misc/iotkit-sysctl.c          |  2 +-=0D
 hw/pci-host/i440fx.c             | 32 ++++++++---------=0D
 hw/pci/pci.c                     |  2 +-=0D
 hw/riscv/sifive_e.c              | 11 +++---=0D
 hw/riscv/sifive_u.c              | 16 ++++-----=0D
 hw/scsi/scsi-bus.c               |  4 +--=0D
 qom/object.c                     | 60 +++++++++++++++++++-------------=0D
 target/arm/monitor.c             |  2 +-=0D
 target/i386/cpu.c                |  2 +-=0D
 target/s390x/cpu.c               |  1 -=0D
 target/s390x/cpu_models.c        | 35 +++++++++----------=0D
 target/ppc/translate_init.c.inc  |  2 +-=0D
 35 files changed, 208 insertions(+), 182 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


