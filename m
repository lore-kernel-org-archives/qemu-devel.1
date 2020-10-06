Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF07C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE7C206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7LdnBG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE7C206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmKa-0006GM-2U
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kPmFX-0000z0-Mo
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54162)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kPmFV-0007tB-LZ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601987960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ugdjlsjWI4cT4tMAuot/nXJB2V0jpNqtIt9fyd+uGBI=;
 b=M7LdnBG8P9tCvRKROlXPBVPvlWer126LCBq6lnaiYJd4YJxzdRpr5XIUOX8+zdHywZv5Fk
 eiR4vYxDFvpHc02ZrY10sCVHJjVTzZFn6/bS79JqrfPh9K6pKNimEpe+8fSufW6t3WsF4m
 Qboq6o39DKcO0fuaK3VoEOaJFDHb2HE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-8uqlmaL1P2Kq0HqL0CqJBA-1; Tue, 06 Oct 2020 08:39:13 -0400
X-MC-Unique: 8uqlmaL1P2Kq0HqL0CqJBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0A8D8030C0;
 Tue,  6 Oct 2020 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.206.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3E895579B;
 Tue,  6 Oct 2020 12:39:05 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 00/13] Fix scsi devices plug/unplug races w.r.t virtio-scsi
 iothread
Date: Tue,  6 Oct 2020 15:38:51 +0300
Message-Id: <20201006123904.610658-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the next version of the patches.=0D
=0D
In this version I implemented Paulo's suggestion of fixing the qtests=0D
to cope with out of order events.=0D
=0D
This resulted in small but nice refactoring.=0D
=0D
Besides that, the only other change from V6 is that I dropped Paulo's=0D
fix to qtest_qmp_device_del since it is fixed now by my qtest patches.=0D
=0D
The iotest 67 still fails with this, something that Paulo=0D
is looking to fix before merging this.=0D
=0D
Best regards,=0D
=09Maxim Levitsky=0D
=0D
Maxim Levitsky (10):=0D
  qtest: rename qtest_qmp_receive to qtest_qmp_receive_dict=0D
  qtest: Reintroduce qtest_qmp_receive=0D
  qtest: switch users back to qtest_qmp_receive=0D
  scsi/scsi_bus: switch search direction in scsi_device_find=0D
  device_core: use drain_call_rcu in in qmp_device_add=0D
  device-core: use RCU for list of children of a bus=0D
  device-core: use atomic_set on .realized property=0D
  scsi/scsi_bus: Add scsi_device_get=0D
  virtio-scsi: use scsi_device_get=0D
  scsi/scsi_bus: fix races in REPORT LUNS=0D
=0D
Paolo Bonzini (3):=0D
  qdev: add "check if address free" callback for buses=0D
  scsi: switch to bus->check_address=0D
  scsi/scsi-bus: scsi_device_find: don't return unrealized devices=0D
=0D
 hw/core/bus.c                   |  28 ++--=0D
 hw/core/qdev.c                  |  73 ++++++---=0D
 hw/net/virtio-net.c             |   2 +-=0D
 hw/scsi/scsi-bus.c              | 262 ++++++++++++++++++++------------=0D
 hw/scsi/virtio-scsi.c           |  27 ++--=0D
 hw/sd/core.c                    |   3 +-=0D
 include/hw/qdev-core.h          |  24 ++-=0D
 include/hw/scsi/scsi.h          |   1 +=0D
 qdev-monitor.c                  |  12 ++=0D
 tests/qtest/drive_del-test.c    |   9 +-=0D
 tests/qtest/libqos/libqtest.h   |  34 +++--=0D
 tests/qtest/libqtest.c          | 110 +++++++-------=0D
 tests/qtest/migration-helpers.c |  25 ++-=0D
 tests/qtest/pvpanic-test.c      |   4 +-=0D
 tests/qtest/qmp-test.c          |  18 +--=0D
 tests/qtest/tpm-util.c          |   8 +-=0D
 16 files changed, 411 insertions(+), 229 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


