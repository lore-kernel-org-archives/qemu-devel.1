Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7F3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE24623D9B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+xXbKhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE24623D9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpuV3-0007Ij-6z
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jpuTs-0005xk-Ln
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:09:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jpuTp-0004Z6-PF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593439792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Yv4UQAjVGHdERU/SehR0R0a8d5LcgwzEb1dg48NaHzY=;
 b=L+xXbKhPY8rC8pz0YNb3yuQpt59UeTuesqauw6s1pG0kTGLw2TSSdissxqrKtEeFpq3agU
 sNC6RXerijy4RkdZy/9MIALIKnI9doUSyj6cypeCanDEJimImW+JJAwONgjhXjk2gpRWkP
 LYuxS88QM5iWGFB5Kp48B6DqC/V1GHs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-lvYdyOI2M7GJ028_Ukln7Q-1; Mon, 29 Jun 2020 10:09:50 -0400
X-MC-Unique: lvYdyOI2M7GJ028_Ukln7Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A2F5107ACCD;
 Mon, 29 Jun 2020 14:09:49 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.195.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 260632B4A6;
 Mon, 29 Jun 2020 14:09:39 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH 0/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
Date: Mon, 29 Jun 2020 16:09:34 +0200
Message-Id: <20200629140938.17566-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, mst@redhat.com, philmd@redhat.com,
 shannon.zhaosl@gmail.com, ard.biesheuvel@arm.com, imammedo@redhat.com,
 lersek@redhat.com, eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The flash device is exclusively for the host-controlled firmware, so
we should not expose it to the OS. Exposing it risks the OS messing
with it, which could break firmware runtime services and surprise the
OS when all its changes disappear after reboot.

This change was suggested by Ard and Laszlo.

Patch 3/4 is the meat. The other patches deal with updating qtest.

Thanks,
drew

Andrew Jones (4):
  tests/acpi: remove stale allowed tables
  tests/acpi: virt: allow DSDT acpi table changes
  hw/arm/virt-acpi-build: Only expose flash on older machine types
  tests/acpi: virt: update golden masters for DSDT

 hw/arm/virt-acpi-build.c                    |   5 ++++-
 hw/arm/virt.c                               |   3 +++
 include/hw/arm/virt.h                       |   1 +
 tests/data/acpi/virt/DSDT                   | Bin 5307 -> 5205 bytes
 tests/data/acpi/virt/DSDT.memhp             | Bin 6668 -> 6566 bytes
 tests/data/acpi/virt/DSDT.numamem           | Bin 5307 -> 5205 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |  18 ------------------
 7 files changed, 8 insertions(+), 19 deletions(-)

-- 
2.25.4


